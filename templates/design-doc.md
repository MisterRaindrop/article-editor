# Engineering Design Article Template

Adapt this template when the central value is a design choice: architecture proposal, database integration, subsystem redesign, API decision, or “why we chose X over Y” article. It is an article template, not a replacement for the team's formal design document. Remove unused sections and all bracketed guidance before publication.

## Editorial brief — do not publish

```text
System / feature:
Decision owner or source author:
Target reader:
Publication channel:
Decision question:
Chosen approach:
Primary constraints:
Alternatives documented in source:
Evidence available:
Unknowns / author queries:
Sensitive details to omit:
```

## Decision spine — do not publish

```text
existing pressure
    ↓
non-negotiable constraints
    ↓
candidate approaches
    ↓
decision criteria
    ↓
chosen architecture
    ↓
costs and consequences
```

---

# [Title: system + decision conflict]

> [Optional subtitle: chosen approach and the constraint that drove it]

## 摘要

[State the integration or architecture problem, why the obvious solution is insufficient, and the central decision. Do not claim the chosen option is universally best.]

## [Opening: put two legitimate goals in tension]

[Begin with the user operation, system boundary, or engineering conflict that forced a decision. Show why this is not merely an interface choice.]

## 01 [What changed, and why did the old path stop being enough?]

[Describe the existing system, new requirement, and concrete gap. Avoid unrelated product history.]

## 02 [Which constraints are non-negotiable?]

[List only constraints that affect the decision, then explain their consequence.]

| Constraint | Why it matters | How it narrows the design space |
| --- | --- | --- |
| [constraint] | [source-grounded impact] | [excluded or favored behavior] |

## 03 [Which approaches were actually viable?]

[Present alternatives fairly. Explain how each would work before evaluating it. Do not add rejected options absent from the source unless clearly labeled as an editorial question.]

### Option A — [Name]

[Mechanism, advantage under a stated criterion, cost, and applicability.]

### Option B — [Name]

[Mechanism, advantage under a stated criterion, cost, and applicability.]

## 04 [Why did the chosen approach fit these constraints?]

[State the decision and evaluate it against named criteria. Separate facts about the design from the author's judgment.]

| Criterion | Option A | Option B | Decision consequence |
| --- | --- | --- | --- |
| Correctness / semantics | [detail] | [detail] | [why it matters] |
| Integration | [detail] | [detail] | [why it matters] |
| Performance | [detail or unknown] | [detail or unknown] | [why it matters] |
| Complexity | [detail] | [detail] | [where complexity moves] |
| Failure / recovery | [detail] | [detail] | [why it matters] |
| Evolution | [detail] | [detail] | [future consequence] |

## 05 [How does the chosen architecture work?]

[Move from overview to one representative path. Name boundaries and contracts.]

[Figure placeholder: `图 1｜[Architecture conclusion, not just “system architecture”]`]

### Component responsibilities

[Explain responsibilities and what each component deliberately does not own.]

### End-to-end path

[Trace a read, write, metadata, planning, or failure path with state and ordering.]

[Figure placeholder: `图 2｜[Flow conclusion]`]

## 06 [What did we pay for this decision?]

[Describe implementation complexity, performance cost, operational burden, compatibility limits, migration constraints, and remaining risks. A credible design article gives the chosen option a real downside.]

## 07 [Where does this design stop applying?]

[Name workload, scale, feature, version, or organizational assumptions. List open questions only if they are real and source-grounded.]

## [Conclusion: state the decision in conditional form]

[Return to the opening conflict. Explain why the decision is appropriate under these constraints, what it preserves, and what it makes harder.]

## 参考资料

1. [Primary source or design artifact](https://example.com)

---

## Editorial notes — separate from publication copy

### Author queries

- [Missing evidence, unclear component ownership, unsupported comparison, or version question]

### Visual handoff

- Figure 1: architecture and ownership boundaries
- Figure 2: representative end-to-end flow
- Optional figure: comparison matrix, only if it adds more than the article table
- See `visual-plan.md` for exact specifications.
