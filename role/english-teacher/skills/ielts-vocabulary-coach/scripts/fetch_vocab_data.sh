#!/bin/bash
# 下载 zhenghaoyang24/english-vocabulary 词库到 data/
#
# 数据规模：~65M（10万+ 单词 + 14万+ 例句）
# 版权：上游仓库无 LICENSE，本脚本仅做"已下载数据的本地使用"，不重新分发
# 使用：
#   bash scripts/fetch_vocab_data.sh
#
# 词书内容（CET-4 / 考研 / 雅思 / 托福 / 考研英语二）见 data/INDEX.md

set -e

VOCAB_DIR="$(cd "$(dirname "$0")/.." && pwd)/data"
mkdir -p "$VOCAB_DIR"

REPO_URL="https://github.com/zhenghaoyang24/english-vocabulary.git"
WORK_DIR="$(mktemp -d)"

echo "→ 临时 clone（depth=1，~5s）..."
git clone --depth 1 "$REPO_URL" "$WORK_DIR/english-vocabulary" 2>&1 | tail -1

echo "→ 复制数据文件..."
cp "$WORK_DIR/english-vocabulary/tb_book.json" "$VOCAB_DIR/"
cp "$WORK_DIR/english-vocabulary/tb_vocabulary.json" "$VOCAB_DIR/"
cp "$WORK_DIR/english-vocabulary/tb_voc_book.json" "$VOCAB_DIR/"
cp "$WORK_DIR/english-vocabulary/tb_voc_examples.json" "$VOCAB_DIR/"

# 元数据
cat > "$VOCAB_DIR/SOURCE.md" <<'EOF'
# 词库来源

**上游仓库**：https://github.com/zhenghaoyang24/english-vocabulary

## 版权声明

上游仓库**未提供 LICENSE 文件**。本目录数据为本地使用目的下载，**不得再分发**。
本目录已在仓库 `.gitignore` 中排除，仅保存在本地 `data/`，不进 git 提交。

## 文件清单

| 文件 | 大小 | 内容 |
|---|---|---|
| `tb_book.json` | 814 B | 词书列表（6 本） |
| `tb_vocabulary.json` | ~25 MB | 10万+ 单词（spelling + IPA + 中文释义 + 词频） |
| `tb_voc_book.json` | ~2.1 MB | 单词-词书关联表 |
| `tb_voc_examples.json` | ~38 MB | 14万+ 例句（中英 + 例句热度） |

## 词书列表（6 本）

| bookid | 名称 | 词数 |
|---|---|---|
| 1 | 四级词汇乱序便携版 | 3,173 |
| 2 | 考研词汇便携版 | 6,357 |
| 3 | 星火四级词汇必背乱序版 | 2,219 |
| 4 | 雅思词汇念念不忘乱序版 | 5,382 |
| 5 | 托福高频词汇精讲 | 2,760 |
| 6 | 考研英语(二)词汇乱序版 | 6,080 |

## 使用场景

`ielts-vocabulary-coach` skill 在没有 IELTS Buddy MCP 服务时，可回退到本目录数据：
- 雅思词汇（bookid=4）：5,382 词
- 托福词汇（bookid=5）：2,760 词
- 四级 / 考研词书可扩展为高考 / 四六级 / 考研 skill

## 重新下载

```bash
bash scripts/fetch_vocab_data.sh
```
EOF

# README
cat > "$VOCAB_DIR/README.md" <<'EOF'
# data/

词库数据目录（gitignored，不进版本库）。

- 来源：https://github.com/zhenghaoyang24/english-vocabulary （无 LICENSE）
- 用途：本地词汇查询 / 离线 IELTS / CET 词汇复习
- 下载：`bash scripts/fetch_vocab_data.sh`
EOF

rm -rf "$WORK_DIR"
echo ""
echo "✓ 词库下载完成：$VOCAB_DIR"
echo "  总大小: $(du -sh "$VOCAB_DIR" | cut -f1)"
echo ""
echo "下一步：把 data/ 加进 .gitignore（仓库级别）"