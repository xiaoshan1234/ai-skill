# Architecture Diagrams

Full skill content for `architecture-diagram`.

## When to use

Generate professional, dark-themed technical architecture diagrams as standalone HTML files with inline SVG graphics. No external tools, no API keys, no rendering libraries.

**Best suited for:**
- Software system architecture (frontend / backend / database layers)
- Cloud infrastructure (VPC, regions, subnets, managed services)
- Microservice / service-mesh topology
- Database + API map, deployment diagrams

**Look elsewhere first for:**
- Hand-drawn whiteboard sketches → use `excalidraw`
- Physics, chemistry, math, biology, or scientific subjects
- Animated explainers

## Workflow

1. User describes their system architecture (components, connections, technologies)
2. Generate the HTML file following the design system below
3. Save with `write_file` to a `.html` file (e.g. `~/architecture-diagram.html`)
4. User opens in any browser — works offline

## Design System

### Color Palette (Semantic Mapping)

| Component Type | Fill (rgba) | Stroke (Hex) |
| :--- | :--- | :--- |
| **Frontend** | `rgba(8, 51, 68, 0.4)` | `#22d3ee` (cyan-400) |
| **Backend** | `rgba(6, 78, 59, 0.4)` | `#34d399` (emerald-400) |
| **Database** | `rgba(76, 29, 149, 0.4)` | `#a78bfa` (violet-400) |
| **AWS/Cloud** | `rgba(120, 53, 15, 0.3)` | `#fbbf24` (amber-400) |
| **Security** | `rgba(136, 19, 55, 0.4)` | `#fb7185` (rose-400) |
| **Message Bus** | `rgba(251, 146, 60, 0.3)` | `#fb923c` (orange-400) |
| **External** | `rgba(30, 41, 59, 0.5)` | `#94a3b8` (slate-400) |

### Typography & Background
- **Font:** JetBrains Mono (Monospace), loaded from Google Fonts
- **Sizes:** 12px (Names), 9px (Sublabels), 8px (Annotations), 7px (Tiny labels)
- **Background:** Slate-950 (`#020617`) with a subtle 40px grid pattern

### Technical Implementation

**Component Rendering:** Use a double-rect masking technique:
1. Draw an opaque background rect (`#0f172a`)
2. Draw the semi-transparent styled rect on top

**Connection Rules:**
- Draw arrows early in the SVG so they render behind component boxes
- Security Flows: dashed lines in rose color (`#fb7185`)
- Security Groups: dashed (`4,4`), rose color
- Regions: large dashed (`8,4`), amber color, `rx="12"`

**Spacing:**
- Standard Height: 60px (Services); 80-120px (Large components)
- Vertical Gap: Minimum 40px between components
- Message Buses: must be placed *in the gap* between services, not overlapping them
- **Legend:** Must be placed outside all boundary boxes

## Output Requirements
- Single File: One self-contained `.html` file
- No External Dependencies: All CSS and SVG inline (except Google Fonts)
- No JavaScript: Pure CSS animations only
- Must render correctly in any modern web browser
