# Technical Article Template

Adapt this template for mechanism explainers, technical deep dives, tutorials with strong conceptual content, or engineering retrospectives. Remove any section that does not serve the argument. Bracketed text is editorial guidance and must not appear in final copy.

## Editorial brief — do not publish

```text
Topic:
Article type:
Target reader:
Assumed knowledge:
Publication channel:
Desired length:
Core reader question:
One-sentence thesis:
Evidence available:
Factual gaps / author queries:
Voice constraints:
Intended reader action:
```

## Narrative outline — do not publish

```text
Opening tension:
    ↓
Necessary constraint:
    ↓
Mechanism or decision:
    ↓
Concrete walkthrough:
    ↓
Trade-off / boundary:
    ↓
Conclusion:
```

For each planned section:

```text
Reader question:
Section claim:
Evidence / mechanism:
Bridge to next section:
Visual need:
```

---

# [Title: subject + question, mechanism, or consequence]

> [Optional subtitle/deck: audience, scope, or practical payoff. Delete if redundant.]

## 摘要

[In two to four compact sentences, name the real technical problem, the gap in common understanding, and what the article will establish. Do not repeat the title or preview every heading.]

## [Opening: begin with a failure, operation, conflict, or observation]

[Create one concrete information gap. Show why the reader's current mental model is insufficient. State the route through the article without writing “本文将从以下几个方面”.]

> [Optional central claim. Use only if it helps the reader retain the article's thesis.]

## 01 [Why does this problem exist?]

[Describe the system pressure, user action, invariant, or failure mode. Introduce only the context needed for the mechanism.]

[Figure placeholder only if planned: `图 1｜[Interpretive caption]`]

## 02 [What constraint shapes the solution?]

[Explain the constraint that rules out the naive approach. Use a concrete example, state transition, or boundary. Define terms at first need.]

```text
[Optional code, command, trace, or worked example]
```

[Explain what the reader should inspect and what the example establishes.]

## 03 [How does the mechanism work?]

[Walk through actors, state, sequence, invariant, failure behavior, and observable result. Keep names aligned with the diagram and source material.]

### [Local question or phase]

[Mechanism detail.]

### [Local question or phase]

[Mechanism detail.]

## 04 [What changes in a concrete operation?]

[Trace one realistic operation end to end. Make inputs, initial state, steps, and result explicit. Do not invent production observations.]

## 05 [What does this design cost?]

[State trade-offs, performance or operational implications, failure modes, and applicability boundaries. Use a table only if exact dimensions benefit from side-by-side comparison.]

| Dimension | Option / behavior A | Option / behavior B | Implication |
| --- | --- | --- | --- |
| [criterion] | [supported detail] | [supported detail] | [decision consequence] |

## [Conclusion: answer the opening]

[Compress the causal chain. State the technical conclusion, decision, or changed mental model. Name an important boundary or next question. Avoid generic importance claims and unrequested marketing CTAs.]

## 参考资料

[Include only sources actually used. Prefer primary sources and place claim-specific links near relevant claims when the channel permits.]

1. [Source title](https://example.com)

---

## Editorial notes — separate from publication copy

### Author queries

- [Unsupported or ambiguous claim that needs confirmation]

### Visual handoff

- See `visual-plan.md` for figures, source basis, captions, alt text, and verification items.
