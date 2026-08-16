# Triage Recipe — mixed-source PDF folders

Use these recipes when you need to know **which PDFs in a folder are text-layered vs. scans** without OCRing anything. Built around `pdfinfo` + `pdftotext`, no Python deps.

## 1. Single-file sanity check

```bash
PDF="$1"
echo "=== pdfinfo ==="
pdfinfo "$PDF" | grep -E "^(Pages|Encrypted|Producer):"
echo "=== first page text (head) ==="
pdftotext -layout -f 1 -l 1 "$PDF" - | head -20
echo "=== first page text (tail) ==="
pdftotext -layout -f 1 -l 1 "$PDF" - | tail -10
```

If the head shows readable prose, it's text-layered. If it's blank or shows garbage glyphs, run `--listenc` and check for encryption, then run on a later page.

## 2. Per-file report (works on any size folder)

```bash
mkdir -p _triage
for pdf in *.pdf; do
    pages=$(pdfinfo "$pdf" 2>/dev/null | awk '/^Pages:/{print $2}')
    chars=$(pdftotext -layout "$pdf" - 2>/dev/null | wc -c)
    if [ -z "$pages" ] || [ "$pages" -eq 0 ]; then
        printf "???? pages | %6s | %s\n" "${#pdf}" "$pdf"
        continue
    fi
    avg=$((chars / pages))
    flag="TXT"
    [ "$avg" -lt 50 ] && flag="OCR"
    [ "$avg" -lt 500 ] && [ "$avg" -ge 50 ] && flag="MIX"
    printf "%4s pages | %7s chars | %4s avg | %s | %s\n" "$pages" "$chars" "$avg" "$flag" "$pdf"
done
```

## 3. Per-page diagnostic (after bulk extraction)

`pdftotext` separates pages with `\f` (form-feed). One bulk call + one split is faster than N per-page calls:

```bash
pdftotext -layout input.pdf _triage/text.txt

python3 -c "
pages = open('_triage/text.txt', encoding='utf-8').read().split('\f')
for i, p in enumerate(pages, 1):
    n = len(p.strip())
    head = p.strip().split(chr(10))[0][:60] if p.strip() else '(blank/page-image)'
    print(f'P{i:>4}  {n:>6}c  {head}')
" | tee _triage/per-page.txt
```

Look for the column `c` going to ~0 — those page numbers go into the OCR target list.

## 4. Parallel triage for 100+ file folders

```bash
mkdir -p _triage
ls *.pdf | xargs -P 4 -I{} sh -c '
    pdfinfo "{}" 2>/dev/null | awk "/^Pages:/{print \$2}" > _triage/{}.pages
    pdftotext -layout "{}" - 2>/dev/null | wc -c > _triage/{}.chars
'

# Aggregate
for pdf in *.pdf; do
    pages=$(cat _triage/${pdf}.pages 2>/dev/null)
    chars=$(cat _triage/${pdf}.chars 2>/dev/null)
    [ -z "$pages" ] && continue
    avg=$((chars / pages))
    flag="TXT"
    [ "$avg" -lt 50 ] && flag="OCR"
    [ "$avg" -lt 500 ] && [ "$avg" -ge 50 ] && flag="MIX"
    printf "%4s pages | %7s chars | %4s avg | %s | %s\n" "$pages" "$chars" "$avg" "$flag" "$pdf"
done
```

`-P 4` keeps I/O light. Drop the parallel flag if running on a sandbox with strict process accounting.

## 5. OCR only flagged pages, not whole files

After step 3 produces a page-number list, OCR each one individually:

```bash
PDF="input.pdf"
OUT="_ocr"
mkdir -p "$OUT"

# Example: pages 7, 24, 56 are image-only
for n in 7 24 56; do
    pdftoppm -r 300 -f "$n" -l "$n" "$PDF" "$OUT/page"
    tesseract "$OUT/page-${n}-"*.png "$OUT/page_${n}" -l eng
done

# Stitch back
python3 <<'PY'
import os
text_path = "_triage/text.txt"
ocr_dir = "_ocr"
pages = open(text_path, encoding="utf-8").read().split("\f")
ocr = {}
for fn in os.listdir(ocr_dir):
    if fn.startswith("page_") and fn.endswith(".txt"):
        n = int(fn[5:-4])
        ocr[n] = open(f"{ocr_dir}/{fn}", encoding="utf-8").read().strip()
for i, p in enumerate(pages, 1):
    if len(p.strip()) < 30 and i in ocr and ocr[i]:
        pages[i-1] = ocr[i]
open("combined.txt", "w", encoding="utf-8").write("\f".join(pages))
PY
```

## Decision matrix

| chars/page avg | Interpretation | Action |
|---|---|---|
| > 500 | healthy text-layer, possibly with embedded fonts | ship as-is |
| 50-500 | mixed — some pages text, some image | per-page triage, OCR only blanks |
| < 50 | pure scan | OCR whole file (or split + OCR if very long) |
| 0 or blank | encrypted / image-only / corrupt | `pdfinfo` to diagnose |

## Common gotchas

- **`pdfinfo` says `Pages: 0`** → file is image-only or corrupted; try `pdfimages -list` to see what's inside
- **`pdftotext` returns nothing but the PDF opens fine** → the PDF is probably all images, not text
- **Two files same name but different sizes** → likely different versions; check before deleting
- **Tesseract installed but no language packs** → install `tesseract-ocr-chi-sim` for Chinese; check `tesseract --list-langs`
