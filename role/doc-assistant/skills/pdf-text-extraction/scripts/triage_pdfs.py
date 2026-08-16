#!/usr/bin/env python3
"""Triage a folder of PDFs: report chars-per-page for each so the caller
can decide which need OCR vs. direct text extraction.

Usage:
    python3 triage_pdfs.py <folder> [--json out.json]

Designed to be safe in sandboxed environments: no subprocess timeouts, no
large file reads beyond what's needed, exits cleanly with a summary.
"""
import argparse
import json
import os
import re
import subprocess
import sys
from pathlib import Path


def pdfinfo(path):
    """Return (page_count, encrypted_bool). Both None on parse failure."""
    try:
        out = subprocess.run(
            ["pdfinfo", str(path)],
            capture_output=True, text=True, timeout=30
        ).stdout
    except subprocess.TimeoutExpired:
        return None, None
    pages = None
    enc = False
    m = re.search(r"^Pages:\s+(\d+)", out, re.M)
    if m:
        pages = int(m.group(1))
    if re.search(r"^Encrypted:\s+yes", out, re.M | re.I):
        enc = True
    return pages, enc


def chars_in(path):
    """Bulk extract text and return (char_count, form_feed_count).
    The latter is a reliable proxy for page count from pdftotext output."""
    try:
        out = subprocess.run(
            ["pdftotext", "-layout", str(path), "-"],
            capture_output=True, text=True, timeout=120
        ).stdout
    except subprocess.TimeoutExpired:
        return 0, 0
    return len(out), out.count("\f")


def classify(avg):
    if avg >= 500:
        return "TXT"
    if avg >= 50:
        return "MIX"
    return "OCR"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("folder")
    ap.add_argument("--json", metavar="PATH")
    args = ap.parse_args()

    folder = Path(args.folder)
    if not folder.is_dir():
        sys.exit(f"not a directory: {folder}")

    pdfs = sorted(folder.glob("*.pdf"))
    if not pdfs:
        sys.exit(f"no .pdf files in {folder}")

    results = []
    for p in pdfs:
        pages, enc = pdfinfo(p)
        if enc:
            results.append({"file": p.name, "pages": pages, "encrypted": True,
                            "chars": 0, "avg": 0, "class": "ENCRYPTED"})
            continue
        if not pages:
            results.append({"file": p.name, "pages": None, "encrypted": False,
                            "chars": 0, "avg": 0, "class": "UNKNOWN"})
            continue
        chars, _ = chars_in(p)
        avg = chars // pages
        results.append({"file": p.name, "pages": pages, "encrypted": False,
                        "chars": chars, "avg": avg, "class": classify(avg)})

    # Print a human-readable table
    print(f"{'Pages':>5}  {'Chars':>9}  {'Avg':>6}  Class    File")
    print("-" * 70)
    for r in results:
        pages = r["pages"] if r["pages"] is not None else "?"
        print(f"{str(pages):>5}  {r['chars']:>9}  {r['avg']:>6}  {r['class']:<8}  {r['file']}")

    # Summary
    n_txt = sum(1 for r in results if r["class"] == "TXT")
    n_mix = sum(1 for r in results if r["class"] == "MIX")
    n_ocr = sum(1 for r in results if r["class"] == "OCR")
    print()
    print(f"Summary: {n_txt} text-layered, {n_mix} mixed, {n_ocr} need OCR, "
          f"{len(results) - n_txt - n_mix - n_ocr} unknown")
    print("OCR candidates (text below 50 chars/page):")
    for r in results:
        if r["class"] == "OCR":
            print(f"  - {r['file']}  ({r['pages']} pages)")

    if args.json:
        Path(args.json).write_text(json.dumps(results, indent=2, ensure_ascii=False))
        print(f"\nWrote {args.json}")


if __name__ == "__main__":
    main()
