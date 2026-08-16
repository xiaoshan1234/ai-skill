# 上游来源 (Attribution)

本仓库中以下 skill 来自第三方开源项目，遵循各自 LICENSE：

## education-agent-skills

- **来源**：`https://github.com/GarethManning/education-agent-skills`
- **LICENSE**：Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
- **作者**：Gareth Manning
- **复制时间**：2026-08-16

涉及 skill（7 个）：
- `origin/sheltered-instruction-lesson-modifier/`
- `origin/academic-language-sentence-frame-generator/`
- `origin/vocabulary-tiering-tool/`
- `origin/language-demand-analyser/`
- `origin/scaffolded-task-modifier/`
- `origin/ai-hallucination-fact-check-protocol/`
- `origin/ai-socratic-dialogue-designer/`

> ⚠️ **CC BY-SA 传染条款**：上述 skill 的衍生作品（包括 `role/english-teacher/` 中复制后的版本）必须同样以 CC BY-SA 4.0 发布。本仓库整体保持 Apache/MIT 风格，但包含上述 skill 的部分（如 `role/english-teacher/`）需视为 CC BY-SA 兼容。

## fluent

- **来源**：`https://github.com/m98/fluent`
- **LICENSE**：MIT
- **作者**：Fluent Contributors
- **复制时间**：2026-08-16

涉及 skill（12 个，命名 `fluent-*`）：
- `origin/fluent-setup/`
- `origin/fluent-learn/`
- `origin/fluent-vocab/`
- `origin/fluent-speaking/`
- `origin/fluent-reading/`
- `origin/fluent-writing/`
- `origin/fluent-review/`
- `origin/fluent-progress/`
- `origin/fluent-sm2-calculator/`
- `origin/fluent-session-analyzer/`
- `origin/fluent-feedback-formatter/`
- `origin/fluent-db-updater/`

> MIT 允许任意复制、再发布、修改，仅要求保留版权声明和许可声明。

## ielts-all-in-one-skills

- **来源**：`https://github.com/Jobo16/ielts-all-in-one-skills`
- **LICENSE**：MIT
- **作者**：Jobo16
- **复制时间**：2026-08-17

涉及 skill（8 个，命名 `ielts-*`）：
- `origin/ielts-study-plan/` — 备考计划
- `origin/ielts-vocabulary-coach/` — 词汇辅导
- `origin/ielts-writing-review/` — 写作四项评分
- `origin/ielts-speaking-coach/` — 口语模拟
- `origin/ielts-reading-review/` — 阅读复盘
- `origin/ielts-listening-review/` — 听力复盘
- `origin/ielts-practice/` — 练习
- `origin/ielts-mock-review/` — 模考复盘

> ⚠️ **依赖外部服务**：上述 skill 默认通过 OAuth 连接到 IELTS Buddy MCP（`https://ieltsbuddy.igocn.cn/mcp`）。本仓库不托管该服务，使用前需自行注册。无 MCP 时按 SKILL.md 内置的本地工作流 fallback 仍可工作。

## english-vocabulary（无 LICENSE 数据源）

- **来源**：`https://github.com/zhenghaoyang24/english-vocabulary`
- **LICENSE**：**未声明**（默认保留所有权利）
- **作者**：zhenghaoyang24
- **本仓库使用方式**：**不复制数据**。仅 `origin/ielts-vocabulary-coach/scripts/fetch_vocab_data.sh` 提供下载脚本，用户执行后数据落到本地 `origin/ielts-vocabulary-coach/data/`（gitignored）。
- **复制时间**：脚本于 2026-08-17 写入

数据规模（脚本会下载到本地，不进 git）：
- `tb_book.json` 814 B（6 本词书索引）
- `tb_vocabulary.json` ~25 MB（10万+ 单词）
- `tb_voc_book.json` ~2.1 MB（单词-词书映射）
- `tb_voc_examples.json` ~38 MB（14万+ 例句）

> ⚠️ **版权风险**：上游无 LICENSE，**不得将 `data/` 目录提交到任何 git 仓库或再分发**。`.gitignore` 已显式排除。

## 后续维护

- 如上游更新，从对应 git 仓库 `git pull` 后，将 skill 目录重新覆盖到 `origin/<name>/` 即可
- LICENSE 文本在 `LICENSE` 文件中保留