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

## productivity/*（Hermes Agent 文档工具集，MIT）

- **来源**：`~/.hermes/profiles/lily/skills/productivity/`（lily profile 内置）
- **LICENSE**：MIT（docx/xlsx/pdf 三件带 LICENSE 文件，其他仅 frontmatter 声明）
- **作者**：Nous Research / Ben Barclay (benbarclay) / Hermes Agent
- **复制时间**：2026-08-17

涉及 skill（6 个）：

| skill | 用途 | LICENSE 文件 |
|---|---|---|
| `origin/docx/` | Word 创建/读取/编辑/模板/审阅 | ✅ 有 |
| `origin/xlsx/` | Excel 创建/读取/编辑 + CSV | ✅ 有 |
| `origin/pdf/` | PDF 创建/读取/合并/填表/加密 | ✅ 有 |
| `origin/pdf-text-extraction/` | 批量 PDF→文本 + 分诊 + 可选 OCR | ❌ frontmatter |
| `origin/meeting-action-items/` | 会议笔记 → 决议/行动/ticket | ❌ frontmatter |
| `origin/document-to-action-items/` | 文档抽取带引用的责任/截止/任务 | ❌ frontmatter |

> 注：仅 `frontmatter` 声明 license 字段而无独立 LICENSE 文件的 skill，依据各 SKILL.md 内声明的 MIT 条款再分发（保留版权声明）。如未来升级上游版本需重新核对 LICENSE 状态。

## amg profile A 股炒股 skill（Apache-2.0）

- **来源**：`xp.xiaoshan12138.top`（SSH `loner@xp.xiaoshan12138.top`，profile `~/.hermes/profiles/amg/skills/`）
- **LICENSE**：Apache-2.0（15 个有独立 LICENSE.txt；1 个**无 LICENSE**：`stock-watcher`）
- **作者**：amg profile 上游贡献者
- **复制时间**：2026-08-17

涉及 skill（16 个）：

| skill | 用途 | LICENSE |
|---|---|---|
| `origin/findata-toolkit-cn/` | A 股金融数据工具包（实时行情、财务、宏观） | ✅ Apache-2.0 |
| `origin/financial-statement-analyzer/` | 单公司财报深度分析 | ✅ Apache-2.0 |
| `origin/undervalued-stock-screener/` | 低估值股票筛选 | ✅ Apache-2.0 |
| `origin/portfolio-health-check/` | 组合诊断 | ✅ Apache-2.0 |
| `origin/high-dividend-strategy/` | A 股高股息策略 | ✅ Apache-2.0 |
| `origin/insider-trading-analyzer/` | A 股董监高增减持 | ✅ Apache-2.0 |
| `origin/esg-screener/` | ESG 评分 | ✅ Apache-2.0 |
| `origin/event-driven-detector/` | 事件驱动（并购/重组/回购） | ✅ Apache-2.0 |
| `origin/quant-factor-screener/` | 多因子筛选 | ✅ Apache-2.0 |
| `origin/risk-adjusted-return-optimizer/` | 风险调整后收益组合 | ✅ Apache-2.0 |
| `origin/sector-rotation-detector/` | 行业轮动 | ✅ Apache-2.0 |
| `origin/sentiment-reality-gap/` | 逆向投资 | ✅ Apache-2.0 |
| `origin/small-cap-growth-identifier/` | 小盘成长 | ✅ Apache-2.0 |
| `origin/suitability-report-generator/` | 适当性报告 | ✅ Apache-2.0 |
| `origin/tech-hype-vs-fundamentals/` | 科技股估值 vs 基本面 | ✅ Apache-2.0 |
| `origin/stock-watcher/` | 自选股行情（10jqka 同花顺） | ❌ **无 LICENSE，本地使用** |

> ⚠️ **stock-watcher 无 LICENSE**：已复制到本地 `origin/stock-watcher/`（仅本机使用），但**已加入 `.gitignore` 排除**，不 commit 到 git 仓库。

## InvestSkill（美股分析，MIT）

- **来源**：`https://github.com/yennanliu/InvestSkill`
- **LICENSE**：MIT
- **作者**：yennanliu
- **复制时间**：2026-08-17

涉及 skill（6 个）：

| skill | 用途 |
|---|---|
| `origin/fundamental-analysis/` | 美股基本面分析 |
| `origin/dcf-valuation/` | DCF 估值 + 敏感度 |
| `origin/earnings-call-analysis/` | 财报电话会议情绪/管理层语气 |
| `origin/stock-eval/` | 美股综合评估 |
| `origin/technical-analysis/` | 技术分析 |
| `origin/insider-trading/` | 美股 SEC Form 4 内部人交易 |

> 与 amg profile 的 `insider-trading-analyzer`（A 股董监高）功能互补——前者 A 股、后者美股。

## 后续维护

- 如上游更新，从对应 git 仓库 `git pull` 后，将 skill 目录重新覆盖到 `origin/<name>/` 即可
- LICENSE 文本在 `LICENSE` 文件中保留