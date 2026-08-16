---
name: github
description: "Complete GitHub workflow suite: authentication, repository management, PR lifecycle, code review, and issue tracking. All GitHub operations for the agent."
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [github, git, pr, code-review, issues, repository, cli]
    related_skills: [huggingface-hub, gitlab]
---

# GitHub — Complete Workflow Suite

All GitHub operations for the agent: authentication, repository management, PR lifecycle, code review, and issue tracking.

## Skills in this Suite

| Reference | Covers |
|----------|--------|
| `references/auth.md` | HTTPS tokens, SSH keys, gh CLI login |
| `references/repo-management.md` | Clone, create, fork repos; manage remotes, releases |
| `references/pr-workflow.md` | Branch creation, commit, PR creation, review, merge |
| `references/code-review.md` | Review local changes, PR reviews, inline comments |
| `references/issues.md` | List, view, create, close issues; project board management |

## Quick Reference

```bash
# Auth check
gh auth status

# Clone a repo
git clone https://github.com/owner/repo

# Create PR
gh pr create --title "feat: ..." --body "..."

# Review a PR
gh pr review <pr-number> --comment --body "..."
```

## Standalone GitHub Skills

These skills have rich standalone SKILL.md bodies and are NOT absorbed:

- **`codebase-inspection`** — Inspect codebases with pygount: LOC, languages, ratios

## Related Skills

- For codebase analysis: see `codebase-inspection`
- For HuggingFace Hub: see `huggingface-hub`
