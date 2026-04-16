---
name: organize-docs
description: Consolidates multiple fragmented technical documents into a systematic knowledge base. Redacts passwords and tokens with equal-length asterisks, resolves conflicts via web search, establishes references to avoid duplication, respects chronological order for logs and record folder, respects hierarchy for note folder, supplements incomplete docs, removes duplicate or wrong content, and commits after each batch of 1-5 file changes. Merges highly related files when appropriate. Uses num-module-desc naming for note docs. For empty or placeholder files, deletes or supplements based on structural completeness. Use when the user says "整理文档" or asks to organize or merge technical documents.
---

# 整理文档

将多篇琐碎技术文档整理为系统化知识库时，按本技能执行。

## 输入与工作流

- **输入**：多篇技术文档（当前打开的文件、用户指定的路径或选区）。
- **输出**：单份或多文件结构化知识库（含目录、按主题分节、统一术语）；修改采用「每 1～5 个文件一批，每批自动 git commit」。

**工作流**：收集文档 → 脱敏 → 引用去重 → **高关联可合并** → 冲突处理 → 按目录特性整理（note 体系、**note 命名 num-module-desc**、**空文件删除或补充**、record/日志顺序）→ 补充与删减 → 每 1～5 文件 commit → 输出。

## 规则 1：敏感信息脱敏

- 识别：密码、token、API key、密钥等。
- 处理：用**等数量**的 `*` 替换原内容（如 8 位密码 → `********`）。

## 规则 2：冲突处理

多篇文档对同一事实描述不一致时：

1. 标出冲突点。
2. 使用联网搜索查证。
3. 采纳可靠来源结论，在知识库中注明依据或出处（如「以 X 为准」或附来源链接）。

## 规则 3：重复知识的引用关系

若有重复知识内容，建立引用关系（如「详见 [某文档](path)」），尽量减少原文重复。

## 规则 4：日志与 record 文件夹

- 日志类文件及 `record` 文件夹下的内容：注重**前后顺序**（时间线、操作顺序）。
- 整理时保持或显式标出顺序。

## 规则 5：note 文件夹

- `note` 文件夹：注重**体系结构**，理解分层（如按主题/层级分目录与章节）。
- 整理时保持或强化层次关系。

## 规则 6：不完善文档的补充

对不够完善的文档，在理解上下文与目的的前提下自行补充内容，使知识库完整可用。

## 规则 7：重复与错误内容的删除

对重复、错误的文档或段落，可以删除相关内容；若整篇冗余可删除或改为引用。

## 规则 8：分批修改与自动 commit

逐步修改文档，**每修改 1～5 个文件后自动执行一次 git commit**，便于回溯与审查。

## 规则 9：高关联文件的合并

- 对于**关联较大**的多个文件（主题紧密、常一起阅读、引用交叉多），可**合并为一个文档**。
- 合并后保留清晰的小节结构（如二级标题分节），原文件名或主题在合并文档中可作小节标题或目录项。
- 合并后删除原文件，并在其它引用处更新链接；若仅部分合并，保留的独立文件可与合并文档建立引用关系。

## 规则 10：note 类文档命名格式

- 对 **note** 目录下的文档，统一采用 **num-module-desc** 命名格式（示例：`1-docker-容器.md`、`2-docker-镜像.md`）。
- `num`：数字编号，便于顺序与层级；`module`：模块/主题；`desc`：简短描述。
- 整理时对不符合该格式的 note 文档可重命名；若已有大量引用，重命名后需更新引用或做重定向说明。

## 规则 11：空文件处理

- 对于**空文件**或仅有占位符、几乎无实质内容的文件，根据**结构完整性**决定：
  - **删除**：若该主题在其它文档中已覆盖，或该文件在体系中没有明确位置，可删除并在需要处改为引用。
  - **补充内容**：若该文件在目录/体系中占位明确（如某系列缺一篇），则按规则 6 在理解上下文与目的的前提下补充内容，使知识库完整。

## 自检清单

执行时可按此清单自检：

```
- [ ] 收集并确认待整理文档范围
- [ ] 脱敏：密码、token 等已用等长 * 替换
- [ ] 引用去重：重复知识已建立引用，减少重复
- [ ] 冲突查证：不一致处已联网查证并注明出处
- [ ] note 体系 / record 顺序：已按目录特性整理
- [ ] 补充与删减：不完善处已补充，重复/错误已删除
- [ ] 高关联文件：已评估，需合并的已合并并更新引用
- [ ] note 命名：已按 num-module-desc 检查或重命名
- [ ] 空文件：已按结构完整性决定删除或补充
- [ ] 每 1～5 文件已执行一次 commit
- [ ] 输出为结构化知识库（目录、分节、统一术语）
```

## 术语

全文统一使用：文档、知识库、脱敏、冲突、引用、record、note。避免混用「文章」「笔记」「打码」等。
