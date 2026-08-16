---
name: software-development
description: "Core development methodology skills: systematic debugging, test-driven development, code review, simplification, and throwaway experimentation."
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [development, methodology, debugging, tdd, code-review, refactor, experiment, spike, prototype]
    related_skills: []
---

# Software Development Methodology

A unified skill for the core development loop: **understand the problem, write a test, implement, verify, and simplify**.

## Umbrella Contents

This skill covers three complementary development methodologies:

### [Systematic Debugging](references/systematic-debugging.md)
4-phase root cause debugging: understand bugs before fixing.
- Phase 1: Root Cause Investigation (read errors, reproduce, check changes, trace data flow)
- Phase 2: Pattern Analysis (find working examples, compare)
- Phase 3: Hypothesis and Testing (form theory, test minimally)
- Phase 4: Implementation (create failing test, fix root cause, verify)

Cross-references: `test-driven-development`, `plan`, `subagent-driven-development`

### [Test-Driven Development](references/test-driven-development.md)
TDD: enforce RED-GREEN-REFACTOR, tests before code.
- RED: Write failing test first, watch it fail
- GREEN: Minimal code to pass the test
- REFACTOR: Clean up with tests green
- Core principle: if you didn't watch the test fail, you don't know if it tests the right thing

Cross-references: `systematic-debugging`, `plan`, `subagent-driven-development`

### [Simplify Code](references/simplify-code.md)
Parallel 3-agent cleanup of recent code changes.
- Phase 1: Identify changes (git diff)
- Phase 2: Launch 3 reviewers in parallel (Reuse, Quality, Efficiency)
- Phase 3: Aggregate findings and apply fixes
- Core principle: three narrow reviewers beat one broad reviewer

Cross-references: `requesting-code-review`, `test-driven-development`, `plan`

### [Requesting Code Review](references/requesting-code-review.md)
Pre-commit review: security scan, quality gates, auto-fix.
- What to check before requesting review
- Security-first review workflow
- Quality gates and automated checks

Cross-references: `simplify-code`, `github-code-review`

### [Spike](references/spike.md)
Throwaway experiments to validate an idea before build.
- Decompose → Research → Build → Verdict loop
- Validated / PARTIAL / INVALIDATED verdicts
- Comparison spikes for evaluating alternatives
- Core principle: feel out an idea before committing to a real build

Cross-references: `sketch`, `subagent-driven-development`, `plan`

## When to Use

| Situation | Skill |
|-----------|-------|
| Bug, test failure, unexpected behavior | `systematic-debugging` (read the reference) |
| New feature, behavior change, refactor | `test-driven-development` (read the reference) |
| User asks to review/clean up recent changes | `simplify-code` (read the reference) |
| Pre-commit security/quality gate | `requesting-code-review` (read the reference) |
| Validate feasibility before committing to build | `spike` (read the reference) |
| Quick visual mockups before building | See `claude-design` / `sketch` in `creative/` |

## Relationship to Other Skills

- **With `github-code-review`**: After local review with `requesting-code-review` and `simplify-code`, use `github-code-review` for PR-level review.
- **With `plan`**: For production-path features, use `plan` instead of `spike`. Spike is for feasibility validation only.
- **With `test-driven-development`**: Bug found via `systematic-debugging`? Write a failing test first, then fix.
- **With `claude-design`**: Design exploration before building? Use `sketch` (throwaway mockups) or `claude-design` (polished artifact).
