# Knowledge Comics — Absorbed from baoyu-comic

Archived skill content for baoyu-comic (knowledge/educational comics, 知识漫画, biography, tutorial).

## Core trigger
Load when user says: "知识漫画", "教育漫画", "Logicomix-style", knowledge comic, biography comic, tutorial comic.

## Options
- Art: ligne-claire, manga, realistic, ink-brush, chalk, minimalist
- Tone: neutral, warm, dramatic, romantic, energetic, vintage, action
- Layout: standard, cinematic, dense, splash, mixed, webtoon, four-panel
- Aspect: 3:4 (portrait), 4:3 (landscape), 16:9 (widescreen)

## Presets (with special rules beyond art+tone)
- `ohmsha` — manga + neutral: visual metaphors, no talking heads, gadget reveals
- `wuxia` — ink-brush + action: qi effects, combat visuals, atmospheric
- `shoujo` — manga + romantic: decorative elements, eye details, romantic beats
- `concept-story` — manga + warm: visual symbol system, growth arc, dialogue+action balance
- `four-panel` — minimalist + neutral: 起承转合 structure, B&W + spot color, stick-figure characters

## Output directory
`comic/{topic-slug}/` containing: source, analysis, storyboard, characters/, prompts/, images.

## Key constraints
- Reference images: prompt-only image_generate — extract traits as TEXT and embed inline in prompts
- Absolute paths for curl -o (never relative)
- Character consistency via text descriptions embedded in prompts, not PNG sheets
- Confirm style+tone before proceeding (clarify tool)
- Partial workflows: storyboard-only, prompts-only, images-only, regenerate N

## Full reference files
- `references/baoyu-comic/analysis-framework.md`
- `references/baoyu-comic/character-template.md`
- `references/baoyu-comic/storyboard-template.md`
- `references/baoyu-comic/workflow.md`
- `references/baoyu-comic/ohmsha-guide.md`
- `references/baoyu-comic/auto-selection.md`
- `references/baoyu-comic/partial-workflows.md`
- `references/baoyu-comic/base-prompt.md`
- `references/baoyu-comic/art-styles/` (6 style defs)
- `references/baoyu-comic/tones/` (7 tone defs)
- `references/baoyu-comic/presets/` (5 preset defs)
- `references/baoyu-comic/layouts/` (7 layout defs)
