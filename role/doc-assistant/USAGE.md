# Document Assistant 使用

## 触发场景

- "写一份合同 / 报告 / 清单"
- "把 Excel 表转成 Word 报告"
- "把这几个 PDF 合并成一个"
- "把扫描版 PDF 转文字"
- "整理这次会议的纪要"
- "这份合同里有哪些截止日期和负责人？"

## 工作目录建议

- **模板**：`~/templates/docx/`、`~/templates/xlsx/`、`~/templates/pdf/`
- **进行中**：`~/docs/inbox/`（生成后未审）
- **归档**：`~/docs/archive/YYYY/Q<n>/`
- **会议录音/笔记**：`~/meetings/<YYYY-MM-DD>/`
- **提取的行动项**：经 `kanban` 入 `~/kanban/inbox.md`

## 依赖安装

大部分 skill 用了 Python 库，按需安装：

```bash
# docx / xlsx / pdf
pip install python-docx openpyxl pypdf pdfplumber reportlab

# 批量 PDF 处理 + 可选 OCR
pip install pypdf pdfplumber pytesseract pdf2image

# 中文 OCR（Linux）
sudo apt install tesseract-ocr tesseract-ocr-chi-sim
```

## 典型工作流示例

### 例 1：把会议录音整理成纪要

```
1. 录音放在 ~/meetings/2026-08-16/
2. "把这次会议整理成纪要，输出到 ~/meetings/2026-08-16/notes.md"
3. 我会：
   - 加载 meeting-action-items skill
   - 输出三段式（决议 / 行动 / 待定）
   - 把行动项同步到 kanban
```

### 例 2：合并 3 个 PDF 并加目录

```
1. "把这 3 个 PDF 合并，按章节加目录，输出 ~/docs/report.pdf"
2. 我会：
   - pdf-text-extraction 抽每章标题
   - pdf skill 生成合并 + 加 outline
```

### 例 3：从合同抽取行动项

```
1. "这份合同里有哪些截止日期和交付物？输出到 kanban"
2. 我会：
   - pdf-text-extraction 抽文本
   - document-to-action-items 提取（截止、负责人、交付）
   - 每条带引用片段
   - 入 kanban
```

## 输出格式约定

- 文档生成后**返回绝对路径**
- 校验脚本通过后才算"完成"
- 行动项输出用 markdown，可直接复制进 kanban