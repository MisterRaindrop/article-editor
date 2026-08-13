# Article Editor

> Transform technical drafts into professional human-written engineering articles.

`article-editor` 是一个面向 OpenAI Codex、Claude Code 及其他兼容 Agent Skills 标准的技术编辑 Skill。它不从一个空泛主题凭空写文章，而是把草稿、设计文档、技术笔记和研究材料编辑成有主线、有判断、有视觉规划的专业技术文章。

当前版本：`v0.1`

## 它解决什么问题

普通 AI 写作经常把文章写成知识点目录：概念齐全，却没有问题、因果、取舍和作者判断。Article Editor 把工作重心放在编辑上：

- 从原始材料中提炼读者问题和作者主张；
- 先重建叙事结构，再修改句子；
- 把定义驱动改成问题、机制和取舍驱动；
- 去掉套话和机械节奏，同时避免伪造“个人经验”；
- 规划架构图、流程图、对比图和封面；
- 按公众号或长篇技术博客的阅读场景完成排版。

它是 **AI technical editor**，不是 generic AI writer。

## v0.1 能力

- **Transform**：把已有草稿编辑成可发布文章；
- **Audit**：只诊断结构、叙事、语言、技术解释和视觉缺口；
- **Outline**：先生成编辑简报、故事线、章节结构和视觉方案；
- **Polish**：在不改变结构的前提下做局部去 AI 味和语言润色；
- **Visual planning**：输出独立的 `visual-plan.md`，不把装饰性图片当作技术图；
- **Publication layout**：提供技术博客与设计决策文章模板。

## 设计原则

1. **Source before prose**：原始材料是事实边界，不能为了文章流畅而补造数据、事故、引用或工程经验。
2. **Structure before sentences**：先确定核心问题、论点和阅读路径，再做逐句润色。
3. **Why before what**：先解释为什么有这个问题、为什么这样设计，再介绍概念清单。
4. **Trade-offs over slogans**：技术判断必须交代适用条件、代价和边界。
5. **Visuals answer questions**：图片必须降低理解成本，而不是填满版面。
6. **Progressive disclosure**：`SKILL.md` 保持精简，具体规则按任务从 `references/` 中加载。

## 安装

这个仓库本身就是一个可安装的 Skill 目录。Codex 和 Claude Code 都使用 `SKILL.md`，但本地发现路径不同。

先克隆仓库：

```bash
mkdir -p ~/skills
git clone https://github.com/MisterRaindrop/article-editor.git ~/skills/article-editor
```

### Codex

个人安装：

```bash
mkdir -p ~/.agents/skills
ln -s ~/skills/article-editor ~/.agents/skills/article-editor
```

项目级安装：在使用该 Skill 的项目中创建链接。

```bash
mkdir -p .agents/skills
ln -s /absolute/path/to/article-editor .agents/skills/article-editor
```

调用示例：

```text
$article-editor 把 draft.md 编辑成面向数据库工程师的公众号文章，并输出 visual-plan.md。
```

### Claude Code

个人安装：

```bash
mkdir -p ~/.claude/skills
ln -s ~/skills/article-editor ~/.claude/skills/article-editor
```

项目级安装：

```bash
mkdir -p .claude/skills
ln -s /absolute/path/to/article-editor .claude/skills/article-editor
```

调用示例：

```text
/article-editor 审核 design-notes.md 的故事线，先给结构诊断，不要重写全文。
```

如果新建顶层 Skill 目录后当前会话没有发现它，请重启相应 Agent。更多加载约定可参考 [OpenAI 的 Build skills 文档](https://learn.chatgpt.com/docs/build-skills) 和 [Claude Code Skills 文档](https://code.claude.com/docs/en/skills)。

## 推荐用法

提供的原始材料越具体，编辑结果越可靠。推荐同时给出：

- 草稿、设计文档、笔记或可信来源；
- 目标读者及其技术背景；
- 希望读者理解或接受的核心判断；
- 发布渠道、篇幅和语气；
- 必须保留与必须回避的内容。

例如：

```text
使用 article-editor 编辑 iceberg-design.md。

读者：数据库内核工程师
渠道：微信公众号
核心问题：为什么这里选择 Table AM，而不是 FDW？
要求：保留所有代码和性能数据；缺少来源的结论单独列为 Author queries；输出 article.md 和 visual-plan.md。
```

也可以只做结构审核：

```text
审核 wal-draft.md。给出结构评分、证据、三个最高优先级问题和新的章节大纲，不要改写正文。
```

## 输出

默认编辑任务生成：

- `article.md`：干净的发布稿；
- `visual-plan.md`：每张图的目的、位置、内容、关系、格式、图注、替代文本和待核实项；
- 必要时附加独立的 editorial notes / Author queries，不混入发布稿。

如果用户指定了输出范围或文件名，以用户要求为准。

## 仓库结构

```text
article-editor/
├── SKILL.md
├── README.md
├── agents/
│   └── openai.yaml
├── references/
│   ├── humanize.md
│   ├── technical-writing.md
│   ├── wechat-style.md
│   ├── visual-design.md
│   └── anti-ai-patterns.md
├── templates/
│   ├── technical-blog.md
│   └── design-doc.md
└── examples/
    └── demo-before-after.md
```

`agents/openai.yaml` 只提供 Codex/ChatGPT 的可选界面元数据；核心规则仍全部位于开放格式的 `SKILL.md` 和其引用资源中，Claude Code 可以忽略该文件。

## Roadmap

- **v0.2**：文章检查器，包括 AI 高频表达、标题、段落、图片和引用检查；
- **v0.3**：作者画像与稳定的个人风格偏好；
- **v1.0**：Draft → Structure → Humanize → Visual Design → Layout → Publication 的完整编辑流水线。

## License

Apache License 2.0。详见 [LICENSE](LICENSE)。
