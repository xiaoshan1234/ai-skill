# Codex CLI

[Codex](https://github.com/openai/codex) is OpenAI's autonomous coding agent CLI. It is invoked identically to Claude Code from Hermes — terminal-only, PTY-based, with the same background monitoring patterns.

## Quick Reference

```bash
# One-shot task
terminal(command="codex exec 'Add dark mode toggle to settings'", workdir="~/project", pty=true)

# Background long task
terminal(command="codex exec --full-auto 'Refactor the auth module'", workdir="~/project", background=true, pty=true)

# Parallel issue fixing with worktrees
terminal(command="git worktree add -b fix/issue-78 /tmp/issue-78 main", workdir="~/project")
terminal(command="codex --yolo exec 'Fix issue #78: <description>. Commit when done.'", workdir="/tmp/issue-78", background=true, pty=true)
```

## Key Flags

| Flag | Effect |
|------|--------|
| `exec "prompt"` | One-shot execution, exits when done |
| `--full-auto` | Sandboxed but auto-approves file changes in workspace |
| `--yolo` | No sandbox, no approvals (fastest, most dangerous) |
| `--sandbox danger-full-access` | No bubblewrap sandbox; for gateway/service contexts where sandboxing fails |

## Gateway/Service Context Caveat

When invoking Codex from a Hermes gateway/service context (Telegram-driven sessions, etc.), workspace-write sandboxing may fail with bubblewrap/user-namespace errors (`setting up uid map: Permission denied`). In that context, use:

```
codex exec --sandbox danger-full-access "<task>"
```

## Related

- `claude-code` — Anthropic's coding agent (this umbrella)
- `opencode` — OpenCode provider-agnostic coding agent
