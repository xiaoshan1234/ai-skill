---
name: creative-tools
description: "Unified creative media generation: image synthesis (ComfyUI/SD/Flux), mathematical animation (Manim), zero-shot segmentation (SAM), real-time visuals (TouchDesigner). One skill to rule all visual generation workflows."
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [creative, generative-ai, image-generation, video-generation, image-segmentation, real-time-visuals, manim, comfyui, segment-anything, touchdesigner]
    category: creative
    related_skills: [touchdesigner-mcp]
---

# Creative Tools

Unified skill for all visual/generative content creation: image synthesis, video generation, mathematical animation, zero-shot image segmentation, and real-time visual composition.

This is the **class-level umbrella** for creative media generation. Individual tools have rich subskills below.

## Sub-skills (absorbed — see .archive for full packages)

The following narrow skills have been absorbed into this class-level umbrella.
Each absorbed skill's full package (SKILL.md + scripts + references + workflows) is
preserved at `~/.hermes/skills/.archive/<skill-name>/` and remains functional.

| Absorbed Skill | Category | Archives At |
|----------------|----------|-------------|
| `comfyui` | Image/video/audio via ComfyUI — node-based SD/Flux/Hunyuan workflows | `.archive/comfyui/` |
| `manim-video` | Mathematical animations via Manim CE (3Blue1Brown style) | `.archive/manim-video/` |
| `segment-anything-model` | Zero-shot image segmentation (Meta SAM) | `.archive/segment-anything/` |
| `touchdesigner-mcp` | Real-time visual composition via TouchDesigner | **KEPT AS STANDALONE** — 36 MCP tools, 21 refs; MCP server registration would be lost if archived |

## Quick Decision Tree

```
User wants to generate... → Use this tool:
─────────────────────────────────────────────────────
Stable Diffusion / Flux / SDXL / SD3 images          → ComfyUI (comfyui)
Image-to-image / inpainting / ControlNet              → ComfyUI (comfyui)
Video (AnimateDiff, Wan, Hunyuan)                    → ComfyUI (comfyui)
Audio generation (MusicGen, AudioGen, AudioCraft)    → ComfyUI (comfyui)
Mathematical animation / educational video            → Manim (manim-video)
Zero-shot object segmentation in images               → SAM (segment-anything-model)
Real-time visuals / GLSL / audio-reactive / VJ       → TouchDesigner (touchdesigner-mcp) — standalone skill
Arbitrary image edit with natural language            → ComfyUI + SAM combo
```

## Shared Workflow Patterns

### Combining tools
For tasks requiring multiple tools (e.g., generate → segment → composite):
1. Generate with the appropriate tool
2. Save/load the output artifact
3. Pass to the next tool as input
4. Composite the results

### Output presentation
- Images: save to file, present with `MEDIA:<path>`
- Video: save to file, present with `MEDIA:<path>`
- Animations: save to file, present with `MEDIA:<path>`
- Segmentation masks: save as PNG with alpha, present with `MEDIA:<path>`

---

## ComfyUI Reference (absorbed skill)

For ComfyUI workflows: install, launch, manage nodes/models, run workflows with parameter injection.
Uses the official `comfy-cli` for lifecycle and direct REST/WebSocket API for execution.

**Complete reference:** `references/comfyui-ref.md`

**Quick reference:**
```bash
# Health check
python3 ~/.hermes/skills/creative/comfyui/scripts/health_check.py

# Run a workflow
python3 ~/.hermes/skills/creative/comfyui/scripts/run_workflow.py \
  --workflow workflow_api.json \
  --args '{"prompt": "a beautiful sunset", "seed": -1}' \
  --output-dir ./outputs
```

---

## Manim Reference (absorbed skill)

For mathematical animations via Manim CE (3Blue1Brown style).

**Complete reference:** `references/manim-ref.md`

**Quick reference:**
```bash
# Render a scene
manim -qm -o scene_name SceneClass path/to/script.py

# Preview in browser
manim -apl -o scene_name SceneClass path/to/script.py
```

---

## SAM Reference (absorbed skill)

For zero-shot image segmentation via Meta's Segment Anything Model.

**Complete reference:** `references/sam-ref.md`

**Quick reference:**
```python
from segment_anything import sam_model_registry, SamPredictor
sam = sam_model_registry["vit_h"](checkpoint="sam_vit_h_4b8939.pth")
predictor = SamPredictor(sam)
predictor.set_image(image)
masks, scores, logits = predictor.predict(
    point_coords=points, point_labels=labels, multimask_output=True
)
```
