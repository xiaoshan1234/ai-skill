# 本地词库扩展（仅本地分支）

本文件不在上游 Jobo16/ielts-all-in-one-skills 仓库，是为本地使用添加的扩展说明。

## 数据源

上游 IELTS Buddy MCP 服务是默认数据源（见 `references/setup.md`）。
**当 MCP 不可用时**，可回退到本地 `data/` 词库。

## 本地数据获取

```bash
cd origin/ielts-vocabulary-coach
bash scripts/fetch_vocab_data.sh
```

脚本会从 `https://github.com/zhenghaoyang24/english-vocabulary` 下载约 65MB 数据到 `data/`（gitignored）。

## 数据内容

6 本词书：

| bookid | 名称 | 词数 |
|---|---|---|
| 1 | 四级词汇乱序便携版 | 3,173 |
| 2 | 考研词汇便携版 | 6,357 |
| 3 | 星火四级词汇必背乱序版 | 2,219 |
| 4 | 雅思词汇念念不忘乱序版 | 5,382 |
| 5 | 托福高频词汇精讲 | 2,760 |
| 6 | 考研英语(二)词汇乱序版 | 6,080 |

## 与 MCP 的关系

| 能力 | MCP (IELTS Buddy) | 本地 data/ |
|---|---|---|
| 雅思词汇（bookid 4） | ✓ 完整 | ✓ 完整 |
| 托福词汇（bookid 5） | ✓ 完整 | ✓ 完整 |
| 用户学习进度同步 | ✓ 云端 | ✗ 仅本地 |
| 题库元数据 | ✓ 官方题库 | ✗ |
| 模考浏览器链接 | ✓ browser-first | ✗ |

## 版权

上游 `zhenghaoyang24/english-vocabulary` **无 LICENSE**。
本扩展仅做"本地下载使用"，**不重新分发**——`data/` 在 `.gitignore` 中排除。
如需重新分发，需联系原作者取得授权。

## 关联 skill

- `vocabulary-tiering-tool`（education-agent-skills）— 给本地词标 Tier 1/2/3 分级
- `language-demand-analyser`（education-agent-skills）— 分析素材语言难度
- `fluent-vocab`（fluent）— 通用间隔重复工具，可结合本地词库