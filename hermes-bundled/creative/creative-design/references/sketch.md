# Sketch — HTML Mockups

Full skill content for `sketch`.

## When to use

When the user wants to **see a design direction before committing** — exploring a UI/UX idea as disposable HTML mockups. Generate 2-3 interactive variants for side-by-side comparison.

**Use when:** "sketch this screen", "show me what X could look like", "compare layout A vs B", "give me 2-3 takes on this UI"

**Don't use when:**
- User wants a production component → use `claude-design`
- User wants a polished one-off HTML artifact (landing page, deck) → `claude-design`
- User wants a diagram → `excalidraw` or `architecture-diagram`

## Core Method

```
intake → variants → head-to-head → pick winner (or iterate)
```

### 1. Intake

Before generating variants, get three things — one at a time:
1. **Feel** — "What should this feel like? Adjectives, emotions, a vibe."
2. **References** — "What apps, sites, or products capture the feel you're imagining?"
3. **Core action** — "What's the single most important thing a user does on this screen?"

### 2. Variants (2-3, never 1)

Each variant is a **complete, standalone HTML file**. Each variant should take a **different design stance**:

- **Density:** compact / airy / ultra-dense
- **Emphasis:** content-first / action-first / tool-first
- **Aesthetic:** editorial / utilitarian / playful
- **Layout:** single-column / sidebar / split-pane

Pick one axis and pull apart from it. Variants that differ only in accent color are wasted effort.

### 3. Make them real HTML

Each variant is a single self-contained HTML file:
- Inline `<style>` — no build step, no external CSS
- Tailwind via CDN is fine
- Realistic fake content — not "Lorem ipsum"
- **Interactive**: at least one state transition (open/close, filter, toggle)

**Verify variants visually — use Hermes' browser tools.** Don't just write HTML and hope it renders; load each variant and look at it.

### 4. Variant README

Each variant's `README.md` documents:
```markdown
## Variant: {stance name}

### Design stance
One sentence on the principle driving this variant.

### Key choices
- Layout: ...
- Typography: ...
- Color: ...

### Trade-offs
- Strong at: ...
- Weak at: ...

### Best for
The kind of user or use case this variant actually serves.
```

### 5. Head-to-head

Present as a comparison table:

```markdown
| Dimension | Calm editorial | Utilitarian dense | Playful split |
|-----------|----------------|-------------------|---------------|
| Density   | Low            | High              | Medium        |
| Primary action visibility | Low | High | Medium |
| Feel | Calm, trusted | Sharp, tool-like | Inviting, energetic |
```

## Output Structure

```
sketches/
├── 001-calm-editorial/
│   ├── index.html
│   └── README.md
├── 001-utilitarian-dense/
│   ├── index.html
│   └── README.md
└── 001-playful-split/
    ├── index.html
    └── README.md
```

Tell the user how to open: `open sketches/001-calm-editorial/index.html` (macOS), `xdg-open` (Linux), `start` (Windows).

## Interactivity Bar

A sketch is interactive enough when:
1. **Click a primary action** and something visible happens
2. **See one meaningful state transition** (filter a list, toggle a mode, open/close a panel)
3. **Hover recognizable affordances** (buttons, rows, tabs)

## Typical Tool Sequence

```
terminal("mkdir -p sketches/001-calm-editorial")
write_file("sketches/001-calm-editorial/index.html", "<!doctype html>...")
write_file("sketches/001-calm-editorial/README.md", "## Variant: Calm editorial\n...")
browser_navigate(url="file:///absolute/path/to/sketches/001-calm-editorial/index.html")
```
