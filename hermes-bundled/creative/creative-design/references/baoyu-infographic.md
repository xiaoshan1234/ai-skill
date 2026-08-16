# Infographic Generator — Absorbed from baoyu-infographic

Archived skill content for baoyu-infographic (21 layouts × 21 styles for infographics).

## Core trigger
Load when user says: "信息图", "可视化", "高密度信息大图", infographic, visual summary, information graphic.

## Two dimensions
- **Layout** (information structure) × **Style** (visual aesthetics)
- Default: bento-grid + craft-handmade

## 21 Layouts
linear-progression, binary-comparison, comparison-matrix, hierarchical-layers, tree-branching, hub-spoke, structural-breakdown, bento-grid, iceberg, bridge, funnel, isometric-map, dashboard, periodic-table, comic-strip, story-mountain, jigsaw, venn-diagram, winding-roadmap, circular-flow, dense-modules.

## 21 Styles
craft-handmade, claymation, kawaii, storybook-watercolor, chalkboard, cyberpunk-neon, bold-graphic, aged-academia, corporate-memphis, technical-schematic, origami, pixel-art, ui-wireframe, subway-map, ikea-manual, knolling, lego-brick, pop-laboratory, morandi-journal, retro-pop-grid, hand-drawn-edu.

## Keyword shortcuts
- "高密度信息大图" / "high-density-info" → dense-modules + morandi-journal/pop-laboratory/retro-pop-grid, portrait
- "信息图" / "infographic" → bento-grid + craft-handmade, landscape (minimalist)

## Output structure
`infographic/{topic-slug}/` containing: source, analysis, structured-content, prompts/infographic, infographic.png.

## Key constraints
- Data integrity: preserve statistics verbatim, never summarize/paraphrase
- Strip credentials from source before including in outputs
- Confirm layout×style + aspect + language before generating (clarify tool)
- image_generate aspect: 16:9→landscape, 9:16→portrait, 1:1→square

## Full reference files
- `references/baoyu-infographic/analysis-framework.md`
- `references/baoyu-infographic/structured-content-template.md`
- `references/baoyu-infographic/base-prompt.md`
- `references/baoyu-infographic/layouts/` (21 layout defs)
- `references/baoyu-infographic/styles/` (21 style defs)
