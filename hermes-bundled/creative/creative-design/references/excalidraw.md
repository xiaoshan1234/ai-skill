# Excalidraw Diagrams

Full skill content for `excalidraw`.

## When to use

Generate `.excalidraw` files for architecture diagrams, flowcharts, sequence diagrams, concept maps. Files can be opened at excalidraw.com or uploaded for shareable links. No accounts, no API keys, no rendering libraries.

## Workflow

1. **Write the elements JSON** — an array of Excalidraw element objects
2. **Save the file** using `write_file` to create a `.excalidraw` file
3. **Optionally upload** for a shareable link using `scripts/upload.py`

## File Format

```json
{
  "type": "excalidraw",
  "version": 2,
  "source": "hermes-agent",
  "elements": [ ...your elements array here... ],
  "appState": { "viewBackgroundColor": "#ffffff" }
}
```

Save to any path, e.g. `~/diagrams/my_diagram.excalidraw`.

## Element Types

**Rectangle:**
```json
{ "type": "rectangle", "id": "r1", "x": 100, "y": 100, "width": 200, "height": 100 }
```
- `roundness: { "type": 3 }` for rounded corners
- `backgroundColor: "#a5d8ff"` for filled

**Ellipse:**
```json
{ "type": "ellipse", "id": "e1", "x": 100, "y": 100, "width": 150, "height": 150 }
```

**Diamond:**
```json
{ "type": "diamond", "id": "d1", "x": 100, "y": 100, "width": 150, "height": 150 }
```

**Arrow:**
```json
{ "type": "arrow", "id": "a1", "x": 300, "y": 150, "width": 200, "height": 0,
  "points": [[0,0],[200,0]], "endArrowhead": "arrow" }
```

## Labeled Shapes — CRITICAL WARNING

Do NOT use `"label": { "text": "..." }` on shapes. This is silently ignored. You MUST use the container binding approach:

```json
{ "type": "rectangle", "id": "r1", "x": 100, "y": 100, "width": 200, "height": 80,
  "backgroundColor": "#a5d8ff", "fillStyle": "solid",
  "boundElements": [{ "id": "t_r1", "type": "text" }] },
{ "type": "text", "id": "t_r1", "x": 105, "y": 110, "width": 190, "height": 25,
  "text": "Hello", "fontSize": 20, "fontFamily": 1, "strokeColor": "#1e1e1e",
  "textAlign": "center", "verticalAlign": "middle",
  "containerId": "r1", "originalText": "Hello", "autoResize": true }
```

## Drawing Order (z-order)

Array order = z-order. Emit progressively: background → shape → its bound text → its arrows → next shape.

## Sizing Guidelines

- **Font sizes:** minimum 16 for body text, 20 for titles, 14 for secondary annotations only
- **Element sizes:** minimum 120x60 for labeled shapes
- Leave 20-30px gaps between elements

## Color Palette

| Use | Fill Color | Hex |
|-----|-----------|-----|
| Primary / Input | Light Blue | `#a5d8ff` |
| Success / Output | Light Green | `#b2f2bb` |
| Warning / External | Light Orange | `#ffd8a8` |
| Processing / Special | Light Purple | `#d0bfff` |
| Error / Critical | Light Red | `#ffc9c9` |
| Notes / Decisions | Light Yellow | `#fff3bf` |
| Storage / Data | Light Teal | `#c3fae8` |

## Tips

- Text contrast is CRITICAL — never use light gray on white backgrounds. Minimum text color on white: `#757575`
- Do NOT use emoji in text — they don't render in Excalidraw's font
- For dark mode diagrams: see `references/dark-mode.md`
- For larger examples: see `references/examples.md`
