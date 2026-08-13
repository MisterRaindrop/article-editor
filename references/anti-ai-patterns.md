# Anti-AI Pattern Guide

Use this guide to diagnose AI-heavy prose. Treat patterns as evidence, not banned tokens. A phrase is a problem when it replaces meaning, hides the logical relation, or repeats often enough to flatten the voice.

## Contents

- Phrase patterns
- Structural patterns
- Reasoning and credibility patterns
- Repair procedure
- False-positive checks

## Empty framing and trend openings

Common Chinese patterns:

- `随着……的不断发展`
- `在数字化转型的大背景下`
- `在当今快速变化的时代`
- `近年来，……受到了广泛关注`
- `众所周知`

Common English equivalents:

- `In today's rapidly evolving landscape`
- `As technology continues to advance`
- `In the modern era`
- `It is widely recognized that`

Repair: begin at the first concrete pressure, failure, user action, measurement, or design conflict. Keep trend context only if the source provides evidence and the trend changes the technical decision.

## Empty emphasis and transitions

Watch for:

- `值得注意的是`
- `需要强调的是`
- `显而易见`
- `不难发现`
- `可以看出`
- `事实上`
- `It is worth noting that`
- `Importantly`
- `Needless to say`

Repair: delete the lead-in and test the sentence. If meaning is unchanged, keep it deleted. If the sentence contains a warning, exception, or consequence, name that relation directly:

- Empty: `值得注意的是，Checkpoint 会影响恢复时间。`
- Specific: `Checkpoint 决定恢复需要回看的 WAL 范围，因此间隔过长会增加崩溃后的重放工作。`

## Inflated importance and marketing language

Watch for:

- `发挥着至关重要的作用`
- `具有十分重要的意义`
- `提供了强有力的保障`
- `全面赋能`
- `助力……迈上新台阶`
- `构建全新范式`
- `plays a crucial/pivotal role`
- `game-changing`, `revolutionary`, `seamless`, `robust` without evidence

Repair: state the mechanism and consequence. Replace praise adjectives with the dimension being improved and the condition under which it improves.

## Mechanical signposting

Watch for:

- repeated `首先 / 其次 / 再次 / 最后` across unrelated ideas;
- `接下来，让我们深入了解……`;
- `本文将从以下几个方面展开……` followed by the same headings;
- `综上所述 / 总而言之` before a conclusion that repeats the introduction;
- `Let's delve into`, `In this comprehensive guide`, `In conclusion` used by habit.

Repair: let the causal path signal progression. Use numbered steps only for an actual sequence. End by resolving the opening problem, naming the decision, or stating the boundary.

## Formulaic contrast and cadence

Watch for repeated constructions such as:

- `不是……而是……` in multiple consecutive sections;
- `既……又……更……` used to pile up benefits;
- three-item lists in nearly every paragraph;
- every section opening with a rhetorical question;
- every paragraph ending with a slogan-like one-sentence takeaway;
- repeated em dashes, colons, or bold labels used as artificial rhythm.

Repair: retain the construction where it expresses a real contrast; rewrite the rest according to their actual relation. Vary form because reasoning varies, not because a style checker demands variety.

## Structural tells

AI-heavy articles often have one or more of these shapes:

- encyclopedia sequence: definition A → definition B → definition C;
- symmetric but unearned sections with identical length and syntax;
- introduction and conclusion that say the topic is important without making a claim;
- headings that are only nouns and can be reordered freely;
- multiple summaries: paragraph recap, section recap, final recap;
- generic “challenges and future outlook” added without source material;
- exhaustive lists that do not help a reader decide or understand a mechanism.

Repair structure before sentences. Choose one reader question, one thesis, and a causal or decision path. Delete completeness theater.

## Credibility tells

Flag these as editorial risks, not merely style issues:

- precise numbers with no source or experiment context;
- fake quotations, unnamed experts, or vague `业内普遍认为`;
- invented first-person production experience;
- universal claims from one example;
- alternatives dismissed with adjectives rather than criteria;
- citations that do not support the nearby claim;
- version-sensitive behavior written as timeless fact.

Move unsupported claims into Author queries. Do not soften fabrication into plausibility.

## Repair procedure

For each suspected pattern:

1. Identify its intended function: context, emphasis, transition, judgment, summary, or rhythm.
2. Delete it temporarily.
3. If no information is lost, leave it deleted.
4. If information is lost, restore the function with a specific fact or logical relation.
5. Check whether the rewrite changed the strength or scope of the claim.
6. Scan the surrounding paragraphs for repeated syntax and repeated conclusions.
7. Read the repaired passage aloud for natural cadence.

Example:

```text
Before:
随着数据规模的不断增长，元数据管理变得越来越重要。值得注意的是，Iceberg 在其中发挥着至关重要的作用。

After:
当一个表对应数万个数据文件时，目录扫描已经不能可靠地回答“这次查询应该读哪些文件”。Iceberg 把这个问题交给表元数据和快照来处理。
```

The after version is valid only if the supplied sources support the stated behavior.

## False-positive checks

- A conventional phrase may be appropriate in an academic or organizational style guide. Respect the requested channel.
- Repetition may be necessary for exact technical terminology. Do not rotate component names into ambiguous synonyms.
- A summary is useful when it compresses a long derivation into a decision; it is weak when it restates headings.
- Formal prose is not automatically AI-like. Empty abstraction and mechanical structure are the real targets.
- Short paragraphs are suitable for mobile reading, but a page of isolated one-sentence paragraphs feels synthetic.
