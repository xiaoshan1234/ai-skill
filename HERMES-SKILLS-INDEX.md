# Hermes Agent Skills 总览

> 本机已激活的 Hermes skill 索引。生成时间：2026-08-16，来源：`~/.hermes/skills/`（排除 `.archive/` `.curator_backups/` `.hub/`）。
> 统计：53 个 skill，13 个功能域。

---

## 1. 核心 / 元（5）

用于配置 Hermes 自身行为、调度自动化、扩展能力。

| Skill | 用途 |
|---|---|
| `automation` | 自动化总览：cron job 调度 |
| `mcp/native-mcp` | MCP 客户端配置，连接外部工具服务器 |
| `hermes/hermes-vision-config` | 视觉（图片分析）配置与测试 |
| `hermes-desktop-plugins` | 写桌面应用插件：UI 面板 + 命令 |
| `software-development` | 软开实践总览（plan/TDD/debug/…） |

---

## 2. 软件工程 / 开发流程（7）

让模型按规范执行多步开发任务、跨机维护、桌面控制。

| Skill | 用途 |
|---|---|
| `software-development/plan` | Plan 模式：写 markdown 行动计划 |
| `software-development/writing-plans` | 接到 spec 后拆多步计划 |
| `software-development/inspecting-hermes-desktop-dom` | 用 CDP 读 Hermes 桌面 DOM/CSS |
| `devops/sdlc-review` | SDLC 各阶段评审检查表 |
| `devops/multi-machine-environment-maintenance` | 跨多 PC 维护软件环境（SSH） |
| `devops/opencode-oh-my-openagent-setup` | 装 OpenCode + OMO |
| `devops/wsl-browser-debugging` | WSL 环境下调试浏览器自动化 |
| `autonomous-ai-agents/autonomous-coding-agents` | 委派任务给 CLI agent（Claude Code 等） |
| `autonomous-ai-agents/merge-reconciler` | 多 agent 合并冲突的中立仲裁 |
| `autonomous-ai-agents/computer-use` | 后台驱动桌面，不抢焦点 |

---

## 3. ML / LLM 工程（8）

模型训练、微调、推理、优化的全链路工具。

### 3.1 训练

| Skill | 用途 |
|---|---|
| `mlops/training/axolotl` | 用 Axolotl 微调 LLM 的 YAML 配置 |
| `mlops/training/trl-fine-tuning` | 用 TRL 做 SFT/DPO/GRPO |
| `mlops/training/unsloth` | Unsloth 微调（2-5× 加速 + 显存省） |

### 3.2 推理

| Skill | 用途 |
|---|---|
| `mlops/inference/outlines` | 生成时强制 JSON/XML/代码结构合法 |
| `mlops/inference/obliteratus` | 用 OBLITERATUS 移除开源 LLM 拒绝行为 |

### 3.3 研究 / 总览

| Skill | 用途 |
|---|---|
| `mlops/research/dspy` | 用声明式编程构建复杂 AI 系统 |
| `mlops/mlops-model-lifecycle` | 训练-微调-部署-优化 全流程工具 |

---

## 4. 数据科学 / 安全研究（2）

| Skill | 用途 |
|---|---|
| `data-science-and-ml` | Jupyter live kernel + DS/ML 工作流 |
| `red-teaming/godmode` | 用 G0DM0D3 越狱 API LLM |

---

## 5. GitHub 工作流（2）

| Skill | 用途 |
|---|---|
| `github/github-workflows` | 端到端：auth / 仓库 / issue / PR / CI |
| `github/github-issue-to-pr` | 把 issue 带到带真 CI 状态的 PR |

---

## 6. 文档 / 笔记 / 知识库（7）

| Skill | 用途 |
|---|---|
| `note-taking` | 笔记 wiki 工具总览（Obsidian 等） |
| `productivity/document-processing` | 提取/编辑/转换 PDF + 文档 |
| `productivity/document-to-action-items` | 从文档里摘责任、截止、任务 |
| `productivity/meeting-action-items` | 会议笔记 → 引用过的决策/owner/ticket |
| `productivity/pdf` | PDF 创建/读取/合并/加密 |
| `productivity/docx` | Word .docx 创建/读取/编辑/审阅 |
| `productivity/xlsx` | Excel .xlsx 创建/读取/编辑 |
| `productivity-tools` | 产品力工具总览 |

---

## 7. 调研 / 检索（4）

| Skill | 用途 |
|---|---|
| `research` | 调研工作流总览（外部数据源） |
| `research/blocked-page-recovery` | 翻 WAF/付费墙/被封页 |
| `research/competitor-news-monitor` | 监控公司动态，出引用过的简报 |
| `research/grounded-citations` | 用可验证来源支撑回答/文档 |

---

## 8. 邮件 / 社交（2）

| Skill | 用途 |
|---|---|
| `email/email-inbox-triage` | 邮件分诊：优先级、起草回复草稿 |
| `social-messaging` | X/QQ/Telegram/Discord/IM 总览 |

---

## 9. 生活服务 / 苹果生态（2）

| Skill | 用途 |
|---|---|
| `lifestyle-services` | Hue 灯/Todoist/Himalaya 等总览 |
| `apple/apple-macos-ecosystem` | macOS 笔记/提醒/FindMy/iMessage |

---

## 10. 媒体 / 影音 / 创意（3）

| Skill | 用途 |
|---|---|
| `media-toolkit` | 媒体操作总览（下载/整理/剪辑） |
| `media/audio-and-music-tools` | AI 音乐生成 + 音频分析 |
| `creative-toolkit` | 生成视觉/视频/动画的工具 |

---

## 11. 游戏（2）

| Skill | 用途 |
|---|---|
| `gaming/minecraft-modpack-server` | 用 Modrinth/CurseForge 装 MC 整合包服 |
| `gaming/pokemon-player` | 头less 模拟器自动打口袋妖怪 |

---

## 12. 生产力 / 办公（7）

| Skill | 用途 |
|---|---|
| `productivity/box` | 云文件管理 + 共享 + 搜索 |
| `productivity/linear` | Linear 走 GraphQL 管 issue/project/team |
| `productivity/petdex` | 安装/切换 Hermes 动画小宠物 |
| `productivity/product-price-monitor` | 商品/机票/挂牌价监控 + 阈值告警 |
| `productivity/session-librarian` | 按 prompt 整理会话：找/重命名/归档 |
| `productivity/weekly-review-planning` | 周复盘：承诺、卡住、下周计划 |
| `productivity/wsl-windows-interop` | WSL 里启 Windows 程序 + 截屏 |

---

## 常用入口速查（按场景）

| 场景 | 推荐 skill |
|---|---|
| 写代码前先做计划 | `software-development/plan` |
| 提交 PR 并保持 CI 绿 | `github/github-issue-to-pr` |
| 处理 Word/Excel/PDF | `productivity/docx` / `xlsx` / `pdf` |
| 找带引用的调研答案 | `research/grounded-citations` |
| 翻被 WAF 挡的网页 | `research/blocked-page-recovery` |
| 把会话整理归档 | `productivity/session-librarian` |
| 多 agent 冲突合并 | `autonomous-ai-agents/merge-reconciler` |
| 给 QQ/Telegram 写 bot | `social-messaging` |
| 周复盘 | `productivity/weekly-review-planning` |
| 微调开源 LLM | `mlops/training/unsloth` 或 `axolotl` |

---

## 维护说明

- 本目录 `~/prj/ai-skill/` 用于跟踪你的**本地原创 skill**（`skill-maker`、`browser-control`、`nas-manage` 等）。
- 本文件统计的是 Hermes 内置的 53 个**激活 skill**，位于 `~/.hermes/skills/`。
- bundled_manifest 列出 80+，多出的部分在 `~/.hermes/skills/.archive/`（旧版本备份），未计入"激活"。
- 如需新增/删除 skill，用 `hermes skills` 命令或编辑本目录的 SKILL.md 后 `hermes reload`。