# Demo: From Topic Inventory to Engineering Narrative

This synthetic example demonstrates the editing method. It is a style and structure calibration artifact, not a factual reference for PostgreSQL or any specific version. A real article must be checked against primary documentation and source material.

## Editing request

```text
Turn the draft into a Chinese WeChat article for backend engineers.
Keep the scope focused on the relationship among WAL, LSN, checkpoints, and crash recovery.
Do not invent benchmarks or production experience.
Produce a publication-ready excerpt and a visual plan.
```

## Before: raw draft

```markdown
# PostgreSQL WAL 介绍

随着数据库技术的不断发展，数据可靠性变得越来越重要。WAL 在 PostgreSQL 中发挥着至关重要的作用。

## WAL

WAL 是 Write-Ahead Logging 的缩写，是一种预写式日志机制。它会记录数据库的修改。

## LSN

LSN 是 Log Sequence Number 的缩写，用于标识 WAL 日志中的位置。值得注意的是，LSN 对数据库恢复非常重要。

## Checkpoint

Checkpoint 会把脏页写入磁盘。Checkpoint 可以提高数据库性能，也可以加快数据库恢复。

## Replication

WAL 还可以用于数据库复制，在数据库高可用中具有重要意义。

## 总结

综上所述，WAL、LSN、Checkpoint 和 Replication 都是 PostgreSQL 中非常重要的概念，值得我们深入学习。
```

## Editorial audit

### Editorial brief

- Topic: WAL durability and recovery path
- Target reader: backend engineers who know transactions but not database internals
- Core reader question: Why can a committed update survive before its data page is written?
- Thesis: WAL changes the required persistence order; LSN identifies progress in that ordered log, while checkpoints bound how much recovery must replay.
- Scope decision: remove replication from this excerpt because the raw draft provides no bridge or detail, and it does not help answer the central question.
- Factual boundary: the excerpt may explain only the relationships stated or safely implied by the supplied draft; version-specific internals need sources.

### Structure score

| Dimension | Score | Evidence |
| --- | ---: | --- |
| Core question and thesis | 1/5 | The opening says reliability is important but does not pose a concrete durability problem. |
| Narrative and section order | 1/5 | Sections are independent definitions; `Replication` can move anywhere without affecting the argument. |
| Reader orientation | 2/5 | Acronyms are expanded, but readers are not told why each term becomes necessary. |
| Mechanism and evidence | 1/5 | The draft says what each concept is but not the ordering or recovery path connecting them. |
| Decisions and trade-offs | 1/5 | `Checkpoint can improve performance` is unqualified and its costs are absent. |
| Opening and closure | 0/5 | The opening and ending contain generic importance claims and do not establish or resolve a question. |
| **Total** | **6/30** | The material is a glossary, not yet an article. |

### Highest-priority repairs

1. Anchor the article in one committed `UPDATE` and the failure window before the data page reaches disk.
2. Reorder concepts by dependency: persistence order → WAL → LSN → recovery → checkpoint.
3. Replace unsupported performance praise with the narrower statement that checkpoints bound recovery work; request sources before making tuning claims.

### New narrative spine

```text
COMMIT durability problem
    ↓
WAL must become durable before the changed data page
    ↓
LSN identifies ordering and replay progress
    ↓
recovery replays the durable log
    ↓
checkpoint limits where replay needs to begin
```

## After: publication-ready excerpt

```markdown
# PostgreSQL WAL：一次 UPDATE 背后，数据如何安全落盘？

> 很多人知道 WAL 是日志，却很难把日志、数据页、LSN 和 Checkpoint 连成一条恢复路径。

## 摘要

一条 `UPDATE` 已经提交，但修改过的数据页可能还留在内存里。此时机器突然断电，数据库凭什么承诺这次提交不会丢？

答案不在于让数据页立刻落盘，而在于先保存一份可以重放的修改记录。理解了这个顺序，WAL、LSN 和 Checkpoint 就不再是三个孤立概念。

## 01 COMMIT 返回时，数据页可能还没落盘

先看最容易混淆的一点：事务提交，并不等于所有被修改的数据页都已经写回磁盘。

如果每次 `COMMIT` 都要等待所有相关数据页完成随机写，事务延迟会直接受制于这批写入。PostgreSQL 选择保存另一种更适合顺序追加的东西：描述这次修改的 WAL 记录。

真正需要保证的是落盘顺序：**相关 WAL 必须先于对应的数据页持久化。** 机器即使在数据页写回前宕机，恢复过程仍然能从已经落盘的 WAL 重建修改。

这也是 Write-Ahead Logging 中 “Ahead” 的含义。重点不只是“有一份日志”，而是日志和数据页之间存在先后约束。

## 02 LSN 让日志位置可以比较

有了可重放的日志，下一个问题是：恢复进程怎样描述“已经重放到哪里”？

PostgreSQL 使用 LSN（Log Sequence Number）表示 WAL 中的位置。它让系统能够比较日志位置的先后，也让数据页和恢复进度可以指向一段确定的日志历史。

因此，LSN 不是附加在 WAL 旁边的另一个知识点。只要系统要按顺序写入、定位和重放日志，就需要一种方式表达这个顺序。

## 03 Checkpoint 缩短的是恢复要回看的距离

WAL 可以重放，但数据库不能在每次启动时都从很久以前开始扫描日志。

Checkpoint 会推进一个已知的恢复起点，并促使相关脏页逐步写回持久化存储。这样一来，崩溃恢复不必无边界地回看全部 WAL，而是从受控的位置继续。

这并不意味着 Checkpoint 越频繁越好。更频繁的 Checkpoint 可以缩短潜在的恢复区间，却也会改变后台写入压力。具体间隔应结合工作负载和版本行为分析，不能从“恢复更快”直接推导出一个通用配置。

## 从一次 UPDATE 看完整条链路

现在可以把三个概念连起来：

1. `UPDATE` 改变内存中的数据页，并产生描述修改的 WAL。
2. 提交路径先确保必要的 WAL 持久化，而不是等待所有数据页立即落盘。
3. LSN 表示 WAL 的位置和先后关系，供写入与恢复过程定位进度。
4. 数据页随后可以由后台写入路径刷盘。
5. 如果中途宕机，恢复过程从受控起点读取 WAL，并重放尚未体现在数据页中的修改。

> WAL 解决的是“先保存什么，才能安全地稍后写数据页”；LSN 解决的是“日志走到哪里”；Checkpoint 解决的是“恢复最远需要从哪里开始”。

## 结语

把 WAL 理解成普通操作日志，很容易记住名词，却看不清数据库的持久性承诺。

从一次 `UPDATE` 出发，关键链路只有一条：先让修改具备可重放的持久记录，再允许数据页延后写回；LSN 标记这条记录的位置，Checkpoint 则限制恢复需要回看的范围。

至于一次更新会产生哪些具体 WAL 记录、页面 LSN 如何参与判断，以及 Checkpoint 的精确写入行为，还需要结合 PostgreSQL 版本、源码和官方文档继续展开。那是下一层问题，不应该靠这篇概念文章猜出来。
```

## Visual plan

```markdown
# Visual Plan

## Strategy

- Article thesis: durability comes from WAL-before-data ordering; LSN and checkpoints make replay locatable and bounded.
- Main visual burden: readers must see two persistence paths and the required order between them.
- Visual language: simple left-to-right system flow; WAL path emphasized; no decorative icons.

## Figure 1 — 一次 UPDATE 的两条落盘路径

- Type: Flow diagram
- Reader question: Why can COMMIT return before the changed data page is on disk?
- Purpose: Show that the WAL persistence path establishes recoverability before the later data-page flush.
- Placement: After the paragraph that introduces the WAL-before-data ordering constraint.
- Source basis: The edited excerpt's sections 01 and “完整条链路”; verify exact component naming against the target PostgreSQL version.
- Content: UPDATE, buffer/page change, WAL record, WAL persistence, later data-page flush, crash recovery.
- Relationships: UPDATE produces both a dirty page and WAL; WAL persistence precedes commit durability; data page may flush later; recovery replays durable WAL.
- Emphasis: WAL path and the “must happen before” constraint.
- Format: Mermaid for review, SVG for final publication.
- Caption: 图 1｜提交首先保证修改具备可重放的持久记录，数据页可以随后写回。
- Alt text: An UPDATE creates a dirty page and a WAL record. WAL is persisted on the commit path before the dirty page is later flushed; after a crash, recovery replays the durable WAL.
- Verification: Confirm exact commit-path terminology and whether any intermediate component should be shown for the version discussed.

## Figure 2 — Checkpoint 如何限定恢复区间

- Type: Timeline
- Reader question: What does a checkpoint change about crash recovery?
- Purpose: Contrast unbounded historical WAL with a known checkpoint-based recovery starting region.
- Placement: In section 03 after the first explanation of the recovery start point.
- Source basis: The raw draft only states that checkpoints write dirty pages and affect recovery; primary documentation is required before rendering exact start-point semantics.
- Content: earlier WAL, checkpoint marker/region, later WAL, crash, replay interval.
- Relationships: time flows left to right; highlight the interval recovery must inspect according to verified semantics.
- Emphasis: bounded replay work, not “checkpoint replaces WAL.”
- Format: SVG timeline after factual verification.
- Caption: 图 2｜Checkpoint 的价值之一，是限制崩溃后需要处理的日志区间。
- Alt text: A left-to-right WAL timeline marks a checkpoint region, a later crash, and the verified interval considered during recovery.
- Verification: Required. Confirm wording and exact recovery semantics with version-specific primary sources before producing the figure.

## Cover — 日志先于数据

- Type: Conceptual illustration
- Reader question: Not applicable; the cover establishes theme.
- Purpose: Visualize ordering without pretending to be an architecture diagram.
- Placement: Article cover.
- Source basis: Article theme only.
- Content: Two parallel tracks, one lightweight log strip reaching a durable boundary before a heavier data block.
- Relationships: Clear foreground order; no literal PostgreSQL UI or internal labels.
- Emphasis: “record first, page later.”
- Format: AI-generated raster illustration; add title in layout rather than image generation.
- Caption: None on cover.
- Alt text: A conceptual illustration in which a slim log path reaches durable storage before a heavier data-page path.
- Verification: Confirm publication cover dimensions at production time.
```

## Author queries

- Which PostgreSQL major version is in scope?
- Which primary sources support the precise checkpoint and recovery wording?
- Should replication return as a separate follow-up section or article? The raw draft does not contain enough detail to connect it responsibly here.

## What changed

- The edit replaced a definition inventory with a single durability question.
- Each term now appears at the point where the reader needs it.
- Replication was cut rather than superficially attached to an already complete narrative.
- Generic importance claims became mechanisms and consequences.
- The checkpoint claim gained a cost and a version-sensitive boundary.
- Visuals were specified around two mental-model bottlenecks; the uncertain figure is blocked on verification instead of being invented.
