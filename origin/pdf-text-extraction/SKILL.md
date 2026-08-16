---
name: pdf-text-extraction
description: "Bulk PDF-to-text with triage and selective OCR."
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos]
metadata:
  hermes:
    tags: [PDF, Text Extraction, OCR, Documents, Productivity]
    category: productivity
    related_skills: [pdf, ocr-and-documents]
---

# PDF Text Extraction

Convert a library of mixed-source PDFs into plain editable text. Two outcomes matter: (a) text-layered PDFs ship as clean .txt/.md in seconds; (b) scanned PDFs need per-page OCR (slower, lossy). Always triage before deciding.

## When to Use

- "Convert my PDFs to text/Word/markdown"
- "Make these scanned PDFs searchable/copyable"
- "I have 14 textbook PDFs, give me editable versions"
- "Are these scans or digital? Only OCR the ones that need it"

If the user has one PDF and needs layout-preserved extraction with tables preserved, prefer `ocr-and-documents`. If they want to merge/split/encrypt/form-fill, prefer `pdf`.

## When to NOT Use

- The user wants to *edit* PDF text in place → `nano-pdf` skill (NL-driven edits).
- The user wants to *create* a new PDF → `pdf` skill (reportlab).
- The PDF is one short document and they're fine with copy-pasting from a viewer → just do nothing.

## Prerequisites

```bash
which pdftotext pdfinfo pdftoppm || sudo apt install -y poppler-utils
which tesseract || sudo apt install -y tesseract-ocr
sudo apt install -y tesseract-ocr-chi-sim    # for Chinese / bilingual scans
```

That's it — `poppler-utils` + `tesseract` covers 90% of bulk extraction work. No Python deps required for the basic pipeline. Add `pdfplumber`/`pymupdf` only if you need layout-preserving extraction or table parsing.

## Triage-First Workflow

**Never start by OCRing everything.** Triage every PDF first:

1. **Count pages** with `pdfinfo` (single call per file)
2. **Extract text once** with `pdftotext -layout` (single call per file)
3. **Compute chars-per-page** for each file
4. **OCR only the files (or pages) where chars-per-page < ~50**

Files with avg >500 chars/page = healthy text-layer, skip OCR entirely.
Files with avg 50-500 chars/page = mixed (some text, some image pages).
Files with avg <50 chars/page = pure scan, needs OCR.

This is the workflow that distinguishes "extract a few text-layer PDFs in 5 seconds" from "spin up Tesseract for an hour for no reason." See [`references/triage-recipe.md`](references/triage-recipe.md) for copy-pasteable shell recipes and a complete triage script.

## Per-File Pipeline

```bash
PDF="input.pdf"
OUT="output_dir"

mkdir -p "$OUT"

# Step 1: Page count (also surfaces encrypted PDFs early)
pdfinfo "$PDF" | grep -E "^(Pages|Encrypted):"

# Step 2: Bulk extract everything; pages separated by form-feed (\f)
pdftotext -layout "$PDF" "$OUT/text.txt"

# Step 3: Inspect for image-only pages — split on \f
python3 -c "
pages = open('$OUT/text.txt', encoding='utf-8').read().split('\f')
for i, p in enumerate(pages, 1):
    n = len(p.strip())
    head = p.strip().split(chr(10))[0][:70]
    print(f'P{i:>4}  {n:>6}c  {head}')
"
# Note page numbers with n < ~30 → these need OCR.

# Step 4: OCR only the flagged pages (skip if all pages have text)
for n in 7 8 24; do   # ← replace with flagged page numbers
    pdftoppm -r 300 -f "$n" -l "$n" "$PDF" "$OUT/page"
    tesseract "$OUT/page-${n}-*.png" "$OUT/page_${n}" -l eng
done

# Step 5: Stitch back together (optional)
python3 -c "
pages = open('$OUT/text.txt', encoding='utf-8').read().split('\f')
ocr = {int(k.split('_')[1].split('.')[0]): open(f'$OUT/{k}', encoding='utf-8').read()
        for k in __import__('os').listdir('$OUT') if k.startswith('page_') and k.endswith('.txt')}
for i, p in enumerate(pages, 1):
    if len(p.strip()) < 30 and i in ocr:
        pages[i-1] = ocr[i]
print('\f'.join(pages), file=open('$OUT/combined.txt', 'w', encoding='utf-8'))
"
```

For Chinese or bilingual content, swap `-l eng` with `-l eng+chi_sim` (requires `tesseract-ocr-chi-sim`).

## Pitfalls

- **Per-page `pdftotext -f N -l N` loops are slow** and re-parse the PDF N times. Always do one bulk extraction and split on `\f`. Bulk extraction is also what keeps execution time predictable inside sandboxed environments that block long-running scripts.
- **Never OCR entire files** if the diagnostic shows most pages have text. Per-page OCR is 10-100× faster on text-layer-with-few-images PDFs.
- **`pdftotext -layout` is the default.** Without `-layout`, columns get jumbled and reading order breaks. For exam layouts (column A / column B question paper), `-layout` is essential.
- **Sample before bulk-extracting 100+ files.** Run steps 1-2 on one file first to check that the layout is what you expect. PDFs from Chinese mirrors often pass `pdfinfo` but a few internal pages are pure images (answer keys, listening maps).
- **`tesseract` works better on whole-page images than on cropped regions.** For structured exam paper layouts, OCR the whole page (`-l eng`) rather than per-question crops.
- **Tesseract can't read handwriting.** If the user has handwritten answer keys, you'll get garbage. Tell them upfront; don't pretend the OCR is correct.
- **Tesseract silently skips empty pages** — if the diagnostic says "5 image-only pages" but OCR returns 3 outputs, two pages produced empty strings (true blanks, not failures). Always check OCR output count vs. expected count.
- **PDftotext strips glyphs the source font lacked** (some boxed question marks in old scans render as `?` blocks). Don't try to "fix" these in post — the underlying PDF simply doesn't have the data.
- **Dedupe before bulk processing.** Many study-material downloads have the same book under multiple filenames (e.g., 剑桥雅思10 高清原版.pdf × 2). Use `pdfinfo` to fingerprint by `(Pages, file_size)` tuple before spending compute on duplicates.
- **Ask before long scripts.** Bulk operations on 100+ PDFs may be auto-blocked by sandbox policies that watch for unconfirmed long-running compute. After triage, surface the plan (which files need OCR, expected time) and get explicit consent before kicking off the batch.

## Verification

After extraction:

1. **Page-count parity**: `pdfinfo` page count vs. text-page count from split. Mismatch usually means an OCR failure on a problematic page.
2. **Spot-check one rendered page**: `pdftoppm -jpeg -r 100 file.pdf sample` then `vision_analyze` to compare the rendered image against your text output.
3. **Word-count sanity**: a typical Cambridge IELTS book's text output should be ~30-50k words. If it's <5k, OCR likely failed silently for many pages.
4. **Head-to-head on one full Test page**: extract page N from source PDF, OCR page N, diff them. If they match, the whole pipeline is good; if they diverge, fix OCR parameters before scaling.

## When to Hand Off

If mid-pipeline you discover the user actually wants:
- **Tables preserved** as Excel → switch to `ocr-and-documents` (marker-pdf) for that batch
- **Edited PDF text in place** → switch to `nano-pdf`
- **Just a search/copyable view** without true extraction → `pdftotext` alone, no OCR
- **Audio transcription** of any embedded audio (e.g., IELTS listening MP3s) → out of scope; tell the user explicitly

## Related Skills

- `pdf` — single-file PDF manipulation
- `ocr-and-documents` — heavy structured extraction (marker-pdf, pymupdf)
- `nano-pdf` — NL-driven in-place PDF text edits
