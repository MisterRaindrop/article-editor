#!/usr/bin/env bash

set -euo pipefail

repository_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
lock_file="${repository_root}/integrations/baoyu-post-to-wechat.lock"

read_lock_value() {
  local key="$1"
  awk -F ': ' -v requested_key="${key}" '$1 == requested_key { print $2; exit }' "${lock_file}"
}

source_repository="$(read_lock_value source_repository)"
fork_repository="$(read_lock_value fork_repository)"
upstream_branch="$(read_lock_value upstream_branch)"
stable_branch="$(read_lock_value stable_branch)"
pinned_ref="$(read_lock_value ref)"

for required_value in \
  "${source_repository}" \
  "${fork_repository}" \
  "${upstream_branch}" \
  "${stable_branch}" \
  "${pinned_ref}"; do
  if [[ -z "${required_value}" ]]; then
    echo "Invalid lock file: ${lock_file}" >&2
    exit 2
  fi
done

upstream_url="https://github.com/${source_repository}.git"
fork_url="https://github.com/${fork_repository}.git"
upstream_ref="refs/heads/${upstream_branch}"
fork_main_ref="refs/heads/${upstream_branch}"
stable_ref="refs/heads/${stable_branch}"

resolve_remote_ref() {
  local repository_url="$1"
  local reference="$2"
  git ls-remote "${repository_url}" "${reference}" | awk 'NR == 1 { print $1 }'
}

upstream_sha="$(resolve_remote_ref "${upstream_url}" "${upstream_ref}")"
fork_main_sha="$(resolve_remote_ref "${fork_url}" "${fork_main_ref}")"
stable_sha="$(resolve_remote_ref "${fork_url}" "${stable_ref}")"

if [[ -z "${upstream_sha}" || -z "${fork_main_sha}" || -z "${stable_sha}" ]]; then
  echo "Could not resolve one or more publisher branches." >&2
  exit 2
fi

status=0

if [[ "${upstream_sha}" != "${fork_main_sha}" ]]; then
  echo "Fork main is behind or diverged from upstream main." >&2
  echo "Run: gh repo sync ${fork_repository} --branch ${upstream_branch}" >&2
  status=1
fi

if [[ "${stable_sha}" != "${pinned_ref}" ]]; then
  echo "Stable branch moved without updating ${lock_file}." >&2
  echo "Expected ${pinned_ref}; found ${stable_sha}." >&2
  status=1
fi

ancestry_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-publisher-check.XXXXXX")"
trap 'rm -rf "${ancestry_dir}"' EXIT

git -C "${ancestry_dir}" init --quiet
git -C "${ancestry_dir}" remote add fork "${fork_url}"
git -C "${ancestry_dir}" fetch --quiet --filter=blob:none fork \
  "+${fork_main_ref}:refs/remotes/fork/${upstream_branch}" \
  "+${stable_ref}:refs/remotes/fork/${stable_branch}"

if ! git -C "${ancestry_dir}" merge-base --is-ancestor \
  "refs/remotes/fork/${upstream_branch}" \
  "refs/remotes/fork/${stable_branch}"; then
  echo "Stable branch does not contain the current fork main." >&2
  echo "Review and merge ${upstream_branch} into ${stable_branch}." >&2
  status=1
fi

if [[ "${status}" -eq 0 ]]; then
  echo "WeChat publisher fork is synchronized and pinned at ${pinned_ref}."
fi

exit "${status}"
