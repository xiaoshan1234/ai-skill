---
name: kanban
description: "Multi-agent Kanban workflow: orchestrator decomposition playbook and worker pitfalls/patterns. For orchestrator profiles use the orchestrator guide; for worker profiles use the worker guide."
version: 1.0.0
platforms: [linux, macos, windows]
environments: [kanban]
metadata:
  hermes:
    tags: [kanban, multi-agent, orchestration, routing, workflow, collaboration]
---

# Kanban — Multi-Agent Task Board

Complete guide to Hermes Kanban: orchestrator decomposition and worker patterns.

## Skills in this Suite

| Section | Covers |
|---------|--------|
| `references/orchestrator.md` | Decomposition playbook, anti-temptation rules, fan-out patterns |
| `references/worker.md` | Worker lifecycle, handoff shapes, pitfalls, retry diagnostics |

## Quick Reference

```python
# Orchestrator: discover profiles first
"hermes profile list"  # before creating cards

# Worker: orient first
kanban_show()  # check task state on startup
```