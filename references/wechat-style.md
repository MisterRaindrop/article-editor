# WeChat Technical Article Style

Use this reference for Chinese WeChat official account articles and similar mobile-first technical publications. Optimize for a narrow screen without turning the article into clickbait or fragmented social copy.

## Design the reading package

A publication-ready package normally contains:

1. one primary title;
2. an optional subtitle or deck;
3. a short abstract that states the reader problem and payoff;
4. an opening that creates technical tension;
5. scannable sections with a clear reading path;
6. figures, tables, code, or callouts only where they help;
7. a conclusion that resolves the opening;
8. references when the article depends on external sources.

Keep alternative titles, structure scores, author questions, and editorial rationale outside the publishable copy.

## Write a title with a real promise

A useful technical title contains a subject plus a question, mechanism, decision, or consequence.

- Weak: `PostgreSQL WAL 介绍`
- Better: `PostgreSQL WAL：一次 UPDATE 背后，数据如何安全落盘？`
- Weak: `深入理解 Iceberg`
- Better: `数据库接入 Iceberg，为什么接口选择比文件读取更难？`

Test the title:

- Does the article fully deliver the promise?
- Is the audience able to recognize the subject quickly?
- Does it avoid unsupported superlatives such as `最全`, `终极`, or `彻底搞懂`?
- Would it still be meaningful without punctuation tricks?

Prefer clarity over keyword stacking. Do not produce a list of title candidates inside the final article unless requested.

## Keep the abstract distinct from the opening

The abstract is a compact contract, usually two to four short sentences:

```text
很多人知道 WAL 是日志，却很难把 WAL、数据页、Checkpoint 和崩溃恢复连成一条路径。

本文从一次 UPDATE 开始，解释 PostgreSQL 如何建立持久性，以及 Checkpoint 真正缩短了什么。
```

The opening then begins the story or problem. Do not repeat the abstract word for word.

## Open with technical tension

Good openings often start with one of these:

- a failure mode: `COMMIT 已返回，机器此时断电会怎样？`;
- a design conflict: `外部表接入更快，但原生表语义还能保留多少？`;
- a concrete operation: `一条 UPDATE 进入执行器后，先变化的并不是磁盘上的数据页。`;
- a counterintuitive observation supported by the source;
- an engineering decision whose alternatives both have real costs.

Avoid industry-history throat clearing, dictionary definitions, fictional dialogue, and a chain of questions with no immediate answer.

## Make section headings carry the argument

Numbered headings such as `01`, `02`, `03` help long mobile articles, but use them only when the order matters.

Prefer:

```text
01 为什么数据页不能先落盘？
02 一次 UPDATE 产生了哪些 WAL？
03 Checkpoint 缩短的不是写入路径，而是恢复路径
```

Avoid:

```text
01 WAL
02 LSN
03 Checkpoint
```

Not every heading needs a question. A claim heading can give the reader a stronger map after the mechanism is established.

## Format for a narrow screen

- Keep one reasoning unit per paragraph. Most paragraphs can be one to four sentences, but vary naturally.
- Use blank lines to separate reasoning units, not every sentence.
- Keep the subject near the verb; long front-loaded clauses are hard to parse on mobile.
- Use bold for a conclusion, invariant, or decision—not for every keyword.
- Use blockquotes for a small number of central judgments. Do not turn all summaries into quote cards.
- Keep nested lists shallow. Convert complex hierarchies into a diagram or compact table.
- Break wide comparison tables into smaller tables or dimension-by-dimension prose.
- Put a short sentence before code explaining what to inspect, and a sentence after code explaining the result.
- Add a caption to every figure and refer to the figure from nearby prose.
- Avoid decorative emoji unless they are part of the author's established voice.

## Use emphasis as hierarchy

Recommended hierarchy:

- title: the article promise;
- subtitle/deck: scope or audience;
- abstract: problem and payoff;
- `##`: major turns in the argument;
- `###`: local questions inside a major turn;
- bold: one decisive phrase inside a paragraph;
- blockquote: a reusable conclusion or author judgment.

Do not use bold, quotes, headings, and numbered lists simultaneously for the same sentence.

## Place visuals where the mental model changes

Introduce a figure immediately before or after the paragraph that creates the need for it:

```markdown
到这里，问题已经从“写了什么”变成“哪个顺序必须先成立”。图 1 把这条持久性顺序画出来。

[图 1：WAL 与数据页的落盘顺序]

> 图 1｜WAL 先建立可重放的持久性，数据页可以随后刷盘。
```

Never write `如下图所示` if the image is not present in the deliverable or visual plan.

## End with a decision or boundary

A strong ending does one or more of the following:

- answers the opening question;
- restates the mechanism in compressed causal form;
- names the design decision and its cost;
- tells readers where the explanation no longer applies;
- gives a concrete next observation, experiment, or source.

Avoid `综上所述，X 非常重要` and generic calls to embrace the future. Add a subscription prompt or marketing CTA only when explicitly requested.

## Publication cleanup

Before delivery:

- remove editing instructions and unused placeholders;
- verify heading levels and numbering;
- verify every figure reference, caption, and alt text;
- verify code fences and tables render correctly;
- normalize Chinese/English spacing consistently;
- keep references readable and tied to claims;
- ensure the final copy contains one title and one clean ending.
