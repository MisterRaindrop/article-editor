# Humanize Technical Prose

Use this reference for prose rewrites. Preserve technical meaning while replacing machine-like abstraction and rhythm with specific reasoning and an honest authorial voice.

## Human voice is not casual decoration

Human-authored technical prose usually reveals four things:

- what problem the author thinks matters;
- which detail changes the reader's mental model;
- where the design works and where it stops working;
- how one claim causes, constrains, or contradicts the next.

Do not simulate humanity with fake first-person stories, fabricated conversations, slang, jokes, or excessive rhetorical questions.

## Rewrite meaning before wording

Apply these passes in order.

### 1. Replace abstract importance with a concrete consequence

Before:

> WAL 在数据库可靠性中发挥着至关重要的作用。

After:

> 数据页还没落盘时机器就宕机，刚提交的事务不能因此消失。WAL 解决的是这条持久性约束。

Ask: important to whom, under which failure, and with what observable consequence?

### 2. Replace definitions with the problem that makes them necessary

Before:

> LSN 是日志序列号，用于标识 WAL 中的位置。

After:

> 恢复进程必须知道自己已经重放到哪里，也要能比较两个日志位置的先后。PostgreSQL 用 LSN 表示这个位置。

Keep the definition, but earn it with reader need.

### 3. Replace generic transitions with logical relations

Before:

> 值得注意的是，Checkpoint 也会影响恢复时间。

After:

> WAL 可以重放，但不能无限重放。Checkpoint 把恢复需要回看的日志范围截短，因此它直接影响宕机后的恢复时间。

Name the relation: cause, contrast, precondition, exception, sequence, or consequence.

### 4. Replace feature lists with a decision or walkthrough

Before:

> 该方案支持事务、DDL、统计信息和权限控制。

After:

> 选择这条集成路径的价值不在于接口更“高级”，而在于事务、DDL、统计信息和权限仍然沿用数据库已有的执行路径。代价是实现必须进入更深的内核边界。

Group features by the engineering consequence they create.

### 5. Add judgment only when the source supports it

Weak:

> 方案 A 显然优于方案 B。

Better:

> 如果首要目标是降低接入成本，方案 B 更直接；如果必须复用原生事务语义，方案 A 更符合当前约束。本文讨论的场景属于后者。

State criteria and scope. Do not invent the author's preference.

## Control sentence rhythm

- Mix compact conclusion sentences with longer explanatory sentences.
- Keep tightly related clauses together; do not split every sentence into a one-line paragraph.
- Break a paragraph when the reasoning job changes, not at a fixed sentence count.
- Prefer concrete subjects: `recovery process`, `metadata cache`, `planner`, `operator`.
- Prefer verbs that expose work: `flushes`, `replays`, `rejects`, `copies`, `blocks`, `invalidates`.
- Remove stacked nouns and nominalizations when a verb is clearer.
- Use parallel structure for real comparisons, not to make every paragraph sound polished.

Bad rhythm often looks like this:

```text
一句提问。

一句回答。

一句强调。

连续十次。
```

Combine sentences when they form one reasoning unit.

## Use questions with restraint

A question should open a genuine information gap that the next paragraph answers. Avoid chains of rhetorical questions, questions whose answer is obvious, and headings that repeat the same question in different words.

Useful:

> 数据页和 WAL 都要落盘，为什么一定要先写 WAL？

Not useful:

> WAL 重要吗？当然重要。那么它究竟有多重要呢？让我们继续看下去。

## Preserve an author's actual voice

If samples or a profile are provided, infer observable features only:

- degree of formality;
- preferred paragraph density;
- use of first person;
- strength of claims;
- tolerance for humor, metaphor, and asides;
- preferred balance of code, diagrams, and prose.

Do not caricature surface quirks. Preserve the author's recurring choices about what to explain and how strongly to judge.

Without a profile, use a calm senior-engineer voice: direct, curious, specific, and willing to name uncertainty.

## Keep technical density honest

- Do not delete essential terminology merely because it sounds formal.
- Do not replace precise mechanisms with analogies alone.
- When using an analogy, state where it stops matching the system.
- Do not make a claim stronger, broader, or more certain for rhetorical impact.
- Do not add “we found in production” or “in my experience” unless the source contains that experience.

## Final read

Read the article as a skeptical peer:

1. Can every abstract claim be tied to a system behavior or reader consequence?
2. Does each transition express a real relation?
3. Are questions answered rather than used as decoration?
4. Do paragraphs vary naturally while retaining coherent reasoning units?
5. Does the prose contain judgment with criteria, not confidence theater?
6. Could any “human” detail have been fabricated? Remove or flag it.
