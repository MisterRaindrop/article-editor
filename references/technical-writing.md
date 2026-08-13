# Technical Writing Rules

Use this reference when diagnosing structure, selecting a narrative, or rewriting technical explanations.

## Contents

- Editorial thesis and narrative spine
- Article archetypes
- Structure audit rubric
- Section and explanation design
- Evidence, judgment, and trade-offs
- Editing sequence

## Start with a thesis, not a topic

A topic names the territory. A thesis tells the reader what the article will establish.

- Topic: `PostgreSQL WAL`
- Thesis: `WAL makes crash recovery possible by changing the order in which durability is established; checkpoints bound replay work but do not replace WAL.`

Derive a single reader question from the thesis. Every major section must either answer part of that question or create the need for the next answer.

Write a one-line narrative spine before rewriting prose:

```text
failure risk → ordering constraint → WAL write path → recovery → checkpoint trade-off
```

If the spine reads like a list of nouns, the article is still organized as a glossary.

## Match the structure to the material

| Article type | Useful narrative | Reader expectation |
| --- | --- | --- |
| Mechanism explainer | problem → constraint → mechanism → walkthrough → consequence → boundary | “How does this actually work?” |
| Design decision | context → constraints → options → decision → architecture → trade-offs → consequences | “Why this design and not the alternatives?” |
| Incident/postmortem | symptom → impact → investigation → root cause → repair → prevention | “What failed, why, and what changed?” |
| Tutorial | outcome → mental model → prerequisites → steps → verification → failure modes | “Can I reproduce and understand this?” |
| Comparison | decision context → criteria → options → evidence → recommendation → exceptions | “Which option fits my constraints?” |
| Evolution/history | original pressure → earlier solution → new limit → next design → present trade-off | “Why did the system evolve this way?” |

Do not force a chronological story when a decision story is clearer. Do not force a tutorial when the material lacks reproducible steps.

## Audit structure with evidence

In Audit mode, score each dimension from 0 to 5. Cite specific headings, paragraphs, or omissions that justify the score. Sum to 30 only as a compact signal; the diagnosis matters more than the number.

| Dimension | 0–1 | 2–3 | 4–5 |
| --- | --- | --- | --- |
| Core question and thesis | Missing or contradictory | Implied but diffuse | Explicit, useful, and sustained |
| Narrative and section order | Topic inventory | Some logic, with jumps or repetition | Each section creates the need for the next |
| Reader orientation | Assumes or explains the wrong knowledge | Mixed calibration | Terms and context arrive when needed |
| Mechanism and evidence | Assertions or definitions only | Partial mechanism/examples | Claims are explained, traced, and bounded |
| Decisions and trade-offs | Slogans or one-sided claims | Alternatives named but weakly compared | Constraints, costs, and exceptions are explicit |
| Opening and closure | Generic opening; summary-only ending | One side works | Opening tension is resolved with a clear conclusion |

After scoring, identify:

1. the highest-impact reader failure;
2. the structural change that fixes it;
3. what source evidence is needed;
4. which existing material can be removed or moved.

## Give every section a contract

Before drafting a section, define four lines:

```text
Reader question:
Section claim:
Evidence or mechanism:
Bridge to next section:
```

A section has failed if its heading can be swapped with another heading without changing the argument.

Prefer headings that carry a question or claim:

- Weak: `WAL Overview`
- Better: `Why can’t PostgreSQL write the data page first?`
- Weak: `Architecture`
- Better: `The design separates the transaction path from file discovery`

Do not make every heading a question. Alternate questions and claims according to the argument.

## Explain mechanisms in the order readers simulate them

For a system path, use this order when applicable:

1. Trigger: what event starts the path?
2. State: what data or invariant exists before it starts?
3. Actors: which components participate?
4. Sequence: what crosses each boundary, and in what order?
5. Invariant: what must be true before the next step?
6. Failure: what happens if the process stops here?
7. Observable result: what can an operator or developer verify?

Introduce a term at the first step where it becomes necessary. A concise definition can follow the problem that gives the term meaning.

Use examples as executable mental models, not decoration. State inputs, relevant initial state, steps, and result. Keep illustrative values clearly illustrative.

## Distinguish evidence from judgment

Use three editorial lanes:

- **Fact**: supported by source material, code, documentation, data, or a cited observation.
- **Inference**: follows from facts but is not directly stated. Signal it with calibrated language such as “这意味着” or “从这条路径可以推断”.
- **Judgment**: the author's evaluation or recommendation. State the criteria: “在需要复用原生事务语义的前提下，我们更倾向于……”

Never strengthen “may” into “will,” a local measurement into a universal benchmark, or a design intention into proven behavior.

## Make trade-offs operational

Do not write only `A is more flexible than B`. Compare along decision-relevant dimensions:

| Dimension | Questions to answer |
| --- | --- |
| Correctness | Which invariants or semantics does each option preserve? |
| Integration | Which existing planner, executor, transaction, or tooling paths can be reused? |
| Performance | Which hot paths, copies, remote calls, or metadata operations change? |
| Complexity | Where does implementation and operational complexity move? |
| Compatibility | Which users, formats, APIs, or versions are constrained? |
| Failure and recovery | How does each option fail, retry, recover, and expose partial state? |
| Evolution | Which future changes become easier or harder? |

State the chosen option's cost. A decision without a cost reads like advocacy, not engineering.

## Edit in passes

1. **Factual boundary** — Inventory supported claims, gaps, and author judgments.
2. **Argument** — Write the thesis, reader question, and narrative spine.
3. **Structure** — Reorder, merge, or remove sections; assign a contract to each.
4. **Mechanism** — Add missing actors, state changes, invariants, failure behavior, and examples using only supported material.
5. **Trade-offs** — Add criteria, alternatives, cost, boundary, and recommendation.
6. **Language** — Humanize phrasing and rhythm without changing truth conditions.
7. **Layout and visuals** — Add only elements that help readers navigate or reason.
8. **Adversarial read** — Ask where an informed reader would say “why?”, “how do you know?”, or “under what conditions?”.

## Final technical checks

- Expand acronyms at first meaningful use unless the target reader certainly knows them.
- Keep terminology stable; do not rotate synonyms for technical entities merely for variety.
- Ensure diagrams, prose, code, and tables use the same component names and direction of flow.
- Put caveats next to the claim they constrain, not in a generic disclaimer at the end.
- Verify that code and commands are complete enough for their stated purpose, or label them as pseudocode.
- Cite primary sources where claims depend on external behavior or version-specific facts.
