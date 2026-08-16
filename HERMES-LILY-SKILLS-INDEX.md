# Hermes Agent Skills — Lily Profile

> Lily profile（`~/.hermes/profiles/lily/skills/`）已激活的 skill 索引。生成时间：2026-08-16。
> 统计：60 个 skill，14 个功能域。
> 与 default profile 的差异对照表见末尾。

---

## 1. 核心 / 元（3）

| Skill | 用途 |
|---|---|
| `mcp/native-mcp` | MCP 客户端配置（stdio/HTTP），连接外部工具服务器 |
| `hermes-desktop-plugins` | 写桌面应用插件：UI 面板 + 命令 |
| `autonomous-ai-agents/hermes-agent` | 配置、扩展或贡献 Hermes Agent 自身 |

## 2. 软件工程 / 开发流程（6）

| Skill | 用途 |
|---|---|
| `software-development` | 核心开发方法学：debug/TDD/code review/simplify/spike |
| `software-development/writing-plans` | 写实施计划：bite-sized 任务 + 路径 + 代码；/plan 命令 |
| `software-development/subagent-driven-development` | 用 delegate_task 子代理执行计划（2 阶段 review） |
| `software-development/inspecting-hermes-desktop-dom` | 用 CDP 读 Hermes 桌面 DOM/CSS |
| `software-development/debugging-hermes-tui-commands` | 调试 Hermes TUI slash 命令：Python/gateway/Ink UI |
| `software-development/dogfood` | Web app 探索性 QA：找 bug、留证据、出报告 |
| `devops/sdlc-review` | SDLC 看板 handoff 评审 + 路由验证结果 |
| `devops/github` | GitHub 工作流套件：auth/repo/PR/review/issue |
| `devops/webhook-subscriptions` | Webhook 订阅：事件驱动触发 agent |

## 3. 自治 Agent（4）

| Skill | 用途 |
|---|---|
| `autonomous-ai-agents/claude-code` | 委派编码给 Claude Code CLI（顺带 Codex/OpenCode） |
| `autonomous-ai-agents/computer-use` | 后台驱动桌面，不抢焦点 |
| `autonomous-ai-agents/merge-reconciler` | 多 agent 合并冲突的中立仲裁 |
| `productivity/kanban` | 多 agent Kanban：orchestrator 拆解 + worker 模式 |

## 4. ML / LLM 工程（8）

### 训练

| Skill | 用途 |
|---|---|
| `mlops/training/axolotl` | Axolotl：YAML LLM 微调（LoRA/DPO/GRPO） |
| `mlops/training/trl-fine-tuning` | TRL：SFT/DPO/PPO/GRPO/奖励建模 |
| `mlops/training/unsloth` | Unsloth：2-5× 加速 LoRA/QLoRA，显存更省 |

### 推理 / 评估

| Skill | 用途 |
|---|---|
| `mlops/inference/outlines` | Outlines：结构化 JSON/regex/Pydantic 生成 |
| `mlops/inference/obliteratus` | OBLITERATUS：用 diff-in-means 去 LLM 拒绝 |
| `mlops/mlops-inference` | LLM 推理服务：llama.cpp（本地 GGUF）/ vLLM（高吞吐）/ lm-evaluation-harness |

### 基础设施

| Skill | 用途 |
|---|---|
| `mlops-infrastructure` | HuggingFace Hub（模型/数据集上传、Spaces、Endpoints）+ W&B（实验跟踪、sweep、模型注册） |

### 研究

| Skill | 用途 |
|---|---|
| `mlops/research/dspy` | DSPy：声明式 LM 程序，自动优化 prompt 和 RAG |

## 5. 创意 / 视觉 / 设计（9）

| Skill | 用途 |
|---|---|
| `audio-music` | AI 音乐/音频统一入口：Suno-like (HeartMuLa)、AudioCraft/MusicGen、歌词优先创作 |
| `creative/creative-design` | 视觉设计统一入口：架构图/手绘图/sketch/设计系统/ASCII |
| `creative/creative-tools` | 创意媒体生成统一入口：ComfyUI/SD/Flux（图像）+ Manim（数学动画）+ SAM（分割）+ TouchDesigner（实时视觉） |
| `creative/ideation` | 创意构思：基于约束的项目生成 |
| `creative/claude-design` | 单次 HTML artifact 设计（落地页、deck、原型） |
| `creative/ascii-art` | ASCII 艺术：pyfiglet/cowsay/boxes/image-to-ascii |
| `creative/p5js` | p5.js：生成式艺术、shader、交互、3D |
| `creative/pixel-art` | 像素艺术：复古调色板（NES/Game Boy/PICO-8） |
| `creative/pretext` | DOM-free 文本布局的创意浏览器 demo |
| `creative/touchdesigner-mcp` | 用 twozero MCP 控制 TouchDesigner |

## 6. 媒体 / 影音（2）

| Skill | 用途 |
|---|---|
| `media/spotify-playback` | Spotify：播放/搜索/队列/播放列表/设备管理 |
| `media/youtube-content` | YouTube 字幕转摘要、推文串、博客 |

## 7. 游戏（2）

| Skill | 用途 |
|---|---|
| `gaming/minecraft-modpack-server` | 跑 modded MC 服务端（CurseForge、Modrinth） |
| `gaming/pokemon-player` | 头less 模拟器 + RAM 读取自动打口袋妖怪 |

## 8. 文档 / 笔记 / 知识库（7）

| Skill | 用途 |
|---|---|
| `note-taking/obsidian` | Obsidian vault：读/搜/建/编辑笔记 |
| `productivity/docx` | Word .docx 创建/读取/编辑/模板/审阅 |
| `productivity/xlsx` | Excel .xlsx 创建/读取/编辑 + CSV |
| `productivity/pdf` | PDF 创建/读取/合并/填表/加密 |
| `productivity/pdf-text-extraction` | 批量 PDF→文本，带分诊和选择性 OCR |
| `productivity/google-workspace` | Gmail/Calendar/Drive/Docs/Sheets（gws CLI 或 Python） |
| `productivity/document-to-action-items` | 从文档里提取带引用的责任/截止/任务 |
| `productivity/meeting-action-items` | 会议笔记 → 带引用的决策/owner/ticket |

## 9. 调研 / 检索（5）

| Skill | 用途 |
|---|---|
| `research/blocked-page-recovery` | 翻被 WAF/付费墙/封禁的网页 |
| `research/competitor-news-monitor` | 监控指定公司动态，出带引用的简报 |
| `research/grounded-citations` | 用可验证来源支撑回答和文档 |
| `research/polymarket` | 查 Polymarket：市场、价格、订单簿、历史 |
| `research/research-paper-writing` | ML 论文写作 pipeline（NeurIPS/ICML/ICLR） |

## 10. 邮件（2）

| Skill | 用途 |
|---|---|
| `email/email-inbox-triage` | 邮件分诊：优先级、起草回复草稿 |
| `email/himalaya` | Himalaya CLI：终端 IMAP/SMTP 收发 |

## 11. 生产力 / 办公（6）

| Skill | 用途 |
|---|---|
| `productivity/box` | Box 云文件管理、共享、搜索、元数据 |
| `productivity/petdex` | 安装/切换 Hermes 动画小宠物 |
| `productivity/product-price-monitor` | 商品/机票/挂牌价监控，阈值告警 |
| `productivity/session-librarian` | 按 prompt 整理会话：找/重命名/归档 |
| `productivity/weekly-review-planning` | 周复盘：承诺、卡住、下周计划 |

## 12. 安全 / 红队（1）

| Skill | 用途 |
|---|---|
| `red-teaming/godmode` | 越狱 API LLM：Parseltongue/GODMODE/ULTRAPLINIAN |

---

## 常用入口速查（按场景）

| 场景 | 推荐 skill |
|---|---|
| 写代码前做计划 | `software-development/writing-plans` |
| 多 agent 协同任务 | `productivity/kanban` + `autonomous-ai-agents/subagent-driven-development` |
| 跑 LLM 训练 | `mlops/training/unsloth`（最快）或 `axolotl`（最灵活） |
| 部署 LLM 推理 | `mlops/mlops-inference` |
| 去 LLM 拒绝 | `mlops/inference/obliteratus` |
| 写 ML 论文 | `research/research-paper-writing` |
| 出音乐/音频 | `audio-music` |
| 出视觉/设计 | `creative/creative-tools` 或 `creative/creative-design` |
| 用 Spotify | `media/spotify-playback` |
| 翻被封网页 | `research/blocked-page-recovery` |
| 监控竞品新闻 | `research/competitor-news-monitor` |
| 处理 Word/Excel/PDF | `productivity/docx` / `xlsx` / `pdf` |
| 调试 Hermes TUI 命令 | `software-development/debugging-hermes-tui-commands` |

---

## Lily vs Default：差异对照

下表只列**不同**的 skill。Lily 60 个，Default 53 个，**重叠 33 个**，差 27 个。

### Lily 独有（默认 profile 没有）

| Skill | 功能 |
|---|---|
| `audio-music` | AI 音乐/音频统一入口 |
| `autonomous-ai-agents/claude-code` | 委派给 Claude Code CLI |
| `autonomous-ai-agents/hermes-agent` | 配置/扩展/贡献 Hermes 本身 |
| `creative/ideation` | 基于约束的创意构思 |
| `creative/creative-tools` | ComfyUI/Manim/SAM/TouchDesigner 统一入口 |
| `creative/creative-design` | 视觉设计统一入口 |
| `creative/ascii-art` | ASCII 艺术 |
| `creative/claude-design` | 单次 HTML artifact |
| `creative/p5js` | p5.js 创意编程 |
| `creative/pixel-art` | 复古像素艺术 |
| `creative/pretext` | DOM-free 文本布局 |
| `creative/touchdesigner-mcp` | TouchDesigner MCP 控制 |
| `devops/github` | GitHub 全套工作流（更细粒度） |
| `devops/webhook-subscriptions` | Webhook 事件驱动 |
| `media/spotify-playback` | Spotify 播放控制 |
| `media/youtube-content` | YouTube 字幕转内容 |
| `mlops-infrastructure` | HuggingFace + W&B 统一入口 |
| `mlops/mlops-inference` | llama.cpp + vLLM + lm-eval-harness |
| `note-taking/obsidian` | Obsidian 笔记 |
| `productivity/google-workspace` | Gmail/Drive/Docs/Sheets |
| `productivity/kanban` | 多 agent Kanban |
| `productivity/pdf-text-extraction` | 批量 PDF 转文本 |
| `research/polymarket` | Polymarket 预测市场 |
| `research/research-paper-writing` | ML 论文写作 pipeline |
| `email/himalaya` | Himalaya IMAP/SMTP CLI |
| `software-development/dogfood` | Web app 探索性 QA |
| `software-development/debugging-hermes-tui-commands` | 调试 Hermes TUI |

### Default 独有（lily 没有）

| Skill | 功能 |
|---|---|
| `automation` | cron job 调度总览 |
| `apple/apple-macos-ecosystem` | macOS 笔记/提醒/FindMy/iMessage |
| `creative-toolkit` | 创意工具 umbrella（lily 用 creative/creative-tools 替代） |
| `data-science-and-ml` | Jupyter live kernel |
| `devops/multi-machine-environment-maintenance` | 跨多 PC 维护环境 |
| `devops/opencode-oh-my-openagent-setup` | 装 OpenCode + OMO |
| `devops/wsl-browser-debugging` | WSL 浏览器调试 |
| `github/github-workflows` | GitHub 工作流总览（lily 用 devops/github 替代） |
| `hermes/hermes-vision-config` | 视觉配置 |
| `lifestyle-services` | 智能家居 umbrella |
| `media-toolkit` | 媒体 umbrella（lily 用 media/* 直接调用） |
| `productivity-tools` | 产品力 umbrella |
| `productivity/wsl-windows-interop` | WSL 调 Windows 程序 |
| `software-development/plan` | Plan 模式（lily 用 writing-plans） |
| `software-development/writing-skills` | 写 skill 的元 skill（**lily 缺这个！**） |

### 重叠但 lily 版本更新的

| Skill | Lily | Default |
|---|---|---|
| `autonomous-ai-agents/computer-use` | v2.0.0 | v1.x |
| `github/github-issue-to-pr` | v0.1.0 | v0.x |
| `mlops/inference/obliteratus` | v2.0.0 | v1.x |
| `productivity/pdf` | v1.0.0 | v1.0.0 |
| `productivity/xlsx` | v1.1.0 | v1.x |
| `productivity/docx` | v1.1.0 | v1.x |

---

## 观察

- **lily 偏内容创作 + ML 训练**：11 个 creative/ 技能 vs default 0；MLOPS 8 个 vs default 8
- **lily 缺运维视角**：没有 `automation`、`multi-machine-environment-maintenance`、`opencode-oh-my-openagent-setup`、`wsl-browser-debugging`、`wsl-windows-interop`
- **lily 缺元 skill**：没有 `writing-skills`（写 skill 的 skill）—— 如果想在 lily 里创作新 skill，需要从 default 拷过来
- **lily 缺智能家居 / 苹果生态**：没有 `apple-macos-ecosystem` 和 `lifestyle-services`
- **lily 没有 `plan` 这个独立 skill**，但 `writing-plans` 已涵盖 Plan 模式功能（描述里明确写了 `/plan` 命令）
- **`autonomous-coding-agents` 改名了**：default 里这个名字，lily 里是 `claude-code` + `subagent-driven-development` + `hermes-agent`，粒度更细
- **媒体处理**：default 用 `media-toolkit` umbrella + 各小 skill，lily 直接放 `media/spotify-playback` 和 `media/youtube-content`，结构更扁平

---

## 维护说明

- 本目录 `~/prj/ai-skill/` 用于跟踪你的**本地原创 skill**。
- 本文件统计的是 lily profile 内置的 60 个**激活 skill**，位于 `~/.hermes/profiles/lily/skills/`。
- bundled_manifest 与磁盘活目录可能有偏差，以磁盘为准。
- 如要同步两份 profile 的 skill，从 default 拷过去：`cp -r ~/.hermes/skills/<name> ~/.hermes/profiles/lily/skills/`。