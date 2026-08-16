---
name: creative-design
description: "Visual design and creative tools: architecture diagrams, hand-drawn diagrams, sketch mockups, design system references, and ASCII art. Covers all visual design output modes."
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [design, visual, diagrams, mockups, sketch, architecture, creative, ascii-art, excalidraw]
    related_skills: [claude-design, p5js, pretext, popular-web-designs, design-md]
---

# Creative Design — Visual Output Tools

Unified skill for all visual design and diagram output. These skills share a common purpose:
producing visual artifacts for communication, documentation, and UI/UX design.

## Skills in this Suite

| Reference | Covers |
|----------|--------|
| `references/excalidraw.md` | Hand-drawn style diagrams (flowcharts, architectures, sequence diagrams) |
| `references/architecture-diagram.md` | Dark-themed SVG architecture/cloud/infra diagrams as HTML |
| `references/sketch.md` | Throwaway HTML mockups: 2-3 design variants to compare |

## Quick Reference

```bash
# For architecture diagrams: use references/architecture-diagram.md
# For hand-drawn diagrams: use references/excalidraw.md
# For quick HTML mockups: use references/sketch.md
```

## Standalone Visual Design Skills

These skills have rich standalone SKILL.md bodies and are NOT absorbed — use them directly:

- **`claude-design`** — Design one-off HTML artifacts (landing, deck, prototype)
- **`popular-web-designs`** — 54 real design systems (Stripe, Linear, Vercel) as HTML/CSS with `templates/` directory
- **`design-md`** — Author/validate/export Google's DESIGN.md token spec files
- **`ascii-art`** — ASCII art: pyfiglet, cowsay, boxes, image-to-ascii
- **`p5js`** — p5.js sketches: gen art, shaders, interactive, 3D
- **`pretext`** — DOM-free text layout for kinetic typography and creative demos
## Absorbed into This Skill

The following skills are archived and their content lives under `references/` here:

### Knowledge Comics — `references/baoyu-comic.md`
Archived skill: `baoyu-comic` (knowledge/educational comics, 知识漫画, biography, tutorial). All reference files (art-style definitions, tone definitions, preset guides, workflow steps, character templates, storyboard templates) are preserved at `references/baoyu-comic/` and summarized in `references/baoyu-comic.md`.

Trigger keywords: "知识漫画", "教育漫画", "Logicomix-style", knowledge comic, biography comic, tutorial comic.

### Infographic Generator — `references/baoyu-infographic.md`
Archived skill: `baoyu-infographic` (21 layouts × 21 styles for infographics). All layout definitions (bento-grid, funnel, dashboard, etc.) and style definitions (craft-handmade, corporate-memphis, etc.) are preserved at `references/baoyu-infographic/` and summarized in `references/baoyu-infographic.md`.

Trigger keywords: "信息图", "可视化", "高密度信息大图", infographic, visual summary, information graphic.

### Pixel Art — `references/pixel-art.md`
Pixel art with era palettes (NES, Game Boy, PICO-8). Full reference preserved at `references/pixel-art.md`.
- **`manim-video`** — Manim CE animations for math/algo visualization
- **`comfyui`** — Generate images, video, audio with ComfyUI
- **`touchdesigner-mcp`** — Control TouchDesigner for real-time visuals

## When to Use Each

- **Need an architecture/infra diagram?** → `architecture-diagram` (dark-themed SVG cloud diagrams)
- **Need a hand-drawn style diagram for a blog or presentation?** → `excalidraw` (flowcharts, sequences, ERDs)
- **Need quick UI mockups to compare design directions?** → `sketch` (HTML prototypes, 2-3 variants)
- **Need to reference Stripe/Linear/Vercel design patterns?** → `popular-web-designs` (real design system CSS)
- **Need a design token spec (DESIGN.md)?** → `design-md`
- **Need ASCII art for terminal output or documentation?** → `ascii-art`
- **Need a polished one-off HTML page (landing, deck, prototype)?** → `claude-design`
- **Need generative/interactive browser art?** → `p5js`
- **Need creative coding and shaders?** → `p5js`
- **Need kinetic typography demos?** → `pretext`
