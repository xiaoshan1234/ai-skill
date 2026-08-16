---
name: skill-maker
description: >-
  Teaches how to author high-quality Agent Skills (SKILL.md): discovery-oriented
  descriptions, frontmatter, structure, progressive disclosure, and verification.
  Use when creating or refactoring skills for AI agents; when the user asks how
  to write skills, SKILL.md format, or skill naming and permissions.
metadata:
  topic: skill-authoring
  language: zh
---

# 如何创建一个好的 AI Skill

Skill 是**按需加载**的说明文档：元数据用于**被选中**，正文用于**被执行**。下面按顺序做即可。

---

## 1. 先想清楚再写

在写文件前确认：

| 问题 | 说明 |
|------|------|
| **目的与边界** | 解决哪一类任务？不解决什么（避免和 AGENTS.md / 通用能力重复）？ |
| **触发条件** | 用户在什么说法、什么场景下应该加载本 Skill？ |
| **自由度** | 高（原则+审阅）/ 中（模板+变体）/ 低（固定步骤或脚本）？ |
| **存放位置** | 放到当前 Agent 生态约定的 skills 目录；优先项目级目录，其次全局目录。 |

**何时不必做成 Skill：** 一次性对话、仅本项目且应进仓库规范的约定（更适合 `AGENTS.md`）、能用校验器/规则完全机械执行的事。

---

## 2. 目录与命名

- 一个 Skill = **一个目录**，根文件必须是 **`SKILL.md`**（全大写）。
- **`name`（frontmatter）必须与目录名完全一致**，且满足：`^[a-z0-9]+(-[a-z0-9]+)*$`（小写、数字、单连字符、不以 `-` 首尾、无 `--`）。
- 命名要**可检索**：用 `pdf-form-fill`、`api-error-playbook`，避免 `helper`、`utils`。

### 2.1 推荐目录约定（新增规则）

建议统一采用以下结构，便于模型稳定查找资源：

```text
<skill-name>/
├─ SKILL.md
├─ scripts/      # 可执行脚本、校验脚本、辅助工具
├─ examples/     # 示例输入、示例输出、示例对话
└─ reference/    # 长文档、API 速查、补充资料（可选）
```

- **脚本一律放 `scripts/`**：例如 `scripts/validate.py`、`scripts/check.sh`。
- **示例一律放 `examples/`**：例如 `examples/good.md`、`examples/bad.md`、`examples/sample-input.json`。
- **参考资料放 `reference/`**：不要把大段说明堆在 `SKILL.md`。
- `SKILL.md` 中引用这些文件时，使用相对路径（如 `scripts/validate.py`、`examples/review-output.md`）。

---

## 3. Frontmatter（机器先读）

不同 Agent 生态支持字段可能不同，但至少应包含：

- **`name`**（必填）：与目录名一致。
- **`description`**（必填）：1–1024 字符，**决定会不会被选中**。

**好的 `description`：**

- 用**第三人称**（会进系统提示，不是对用户说话）。
- 同时写清 **做什么（WHAT）** 与 **何时用（WHEN）**，并埋 **触发词**（技术名、文件类型、用户常用说法）。
- 避免空泛：不要只写「帮助开发」；要写具体能力与场景。

**差与好示例：**

```yaml
# 差
description: 帮你写代码。

# 好
description: >-
  Defines steps and checklists for reviewing REST handlers for auth, input validation,
  and idempotency. Use when reviewing Go/Node APIs, PRs touching handlers, or when
  the user mentions security review for HTTP endpoints.
```

可选字段常见有：`license`、`compatibility`、`metadata`（字符串键值）。以目标 Agent 的规范为准。

---

## 4. 正文结构（给人与模型一起用）

推荐骨架：

1. **一句话定位**：本 Skill 解决什么问题、依赖什么前提。
2. **何时用 / 何时不用**：列表，与 `description` 对齐，避免误触发。
3. **核心流程**：编号步骤或检查清单；复杂处用「若 A → 分支 1；若 B → 分支 2」。
4. **模板与示例**：输出格式、前后对比示例（比长解释省 token、更稳）。
5. **常见错误与纠正**：反模式 + 简短修复建议。
6. **延伸阅读（可选）**：大段参考放到 `reference/`，**SKILL.md 只一层链接**，避免深嵌套。

---

## 5. 写作原则（质量关键）

### 5.1 默认模型已经聪明

只写**模型不稳定的判断、团队约定、领域步骤、易错 API**。删掉百科式铺垫；每段自问：「缺了这段会做错吗？」

### 5.2 控制长度与渐进披露

- 主文件 **SKILL.md** 保持可扫读；长手册拆到 **`reference/` / `examples/`**，需要时再读。
- 单文件过长会挤占上下文：目标是把「第一次加载」的信息控制在**高信号、短篇幅**。

### 5.3 术语与路径一致

全文统一用语（例如始终叫「端点」或始终叫「API path」）。文档里路径用 **正斜杠**（`scripts/verify.sh`），避免 Windows 反斜杠习惯污染说明。

### 5.4 时间与版本

避免「截至某年某月」的易腐句；若必须保留历史，用「旧版 / 已废弃」小节折叠。

### 5.5 脚本与命令

若附带脚本：写清**是否应执行**、入参出参、失败时如何解读输出；依赖与版本写在脚本旁或简短表格里。

---

## 6. 适配不同 Agent 生态（通用）

- **目录规则**：不同工具对 Skill 目录命名与扫描路径不一样，先看对应文档再落位。
- **权限规则**：有的生态支持 `allow/ask/deny`，有的通过工具开关控制。若有组织级策略，通常优先级更高。
- **元数据规则**：`name`、`description` 常见为必填；其余字段可能被忽略或不支持。

---

## 7. 交付前自检清单

**发现与元数据**

- [ ] `SKILL.md` 文件名全大写；`name` 与目录名一致且符合正则。
- [ ] `description` 含 WHAT + WHEN + 触发词；第三人称；长度在限制内。

**正文**

- [ ] 有明确「何时不用」；步骤可执行；有必要示例或模板。
- [ ] 无冗余科普；术语一致；路径用 `/`。
- [ ] 长内容已拆到邻接文件，且 SKILL.md 只一层引用。

**若可验证**

- [ ] 用真实任务试跑：无 Skill 时易错点是否被本 Skill 覆盖；有 Skill 时是否明显减少跑偏。

---

## 8. 最小可用示例（结构参考）

```markdown
---
name: my-skill
description: >-
  Summarizes git diff into Conventional Commits messages with body text.
  Use when the user asks for commit messages, changelog entries, or staged diff review.
---

# My Skill

## When to use
- …

## Steps
1. …
2. …

## Output template
\`\`\`
type(scope): subject

body
\`\`\`
```

按上述清单迭代，比追求一次写完美更有效。
