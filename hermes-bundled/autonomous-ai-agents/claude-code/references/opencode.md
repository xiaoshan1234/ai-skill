# OpenCode CLI

[OpenCode](https://opencode.ai) is a provider-agnostic, open-source AI coding agent with both a TUI and CLI. It supports multiple model providers (OpenRouter, Anthropic, OpenAI, etc.).

## Quick Reference

```bash
# One-shot task (no PTY needed)
terminal(command="opencode run 'Add retry logic to API calls'", workdir="~/project")

# Attach context files
terminal(command="opencode run 'Review this config for security issues' -f config.yaml -f .env.example", workdir="~/project")

# Interactive session (requires PTY)
terminal(command="opencode", workdir="~/project", background=true, pty=true)
process(action="submit", session_id="<id>", data="Implement OAuth refresh flow and add tests")
```

## Key Flags

| Flag | Use |
|------|-----|
| `run 'prompt'` | One-shot execution and exit |
| `--continue` / `-c` | Continue the last session |
| `--session <id>` / `-s` | Continue a specific session |
| `--model provider/model` | Force specific model |
| `--format json` | Machine-readable output/events |
| `--file <path>` / `-f` | Attach file(s) to the message |
| `--thinking` | Show model thinking blocks |

## Important Caveats

1. **Interactive `opencode` (TUI) sessions require `pty=true`**
2. **`/exit` is NOT a valid command** — it opens an agent selector. Use Ctrl+C (`\x03`) to exit
3. **Enter may need to be pressed twice** to submit in the TUI

## Binary Resolution

Shell environments may resolve different OpenCode binaries. Check which one is active:

```bash
terminal(command="which -a opencode")
terminal(command="opencode --version")
```

If needed, pin an explicit binary path:

```bash
terminal(command="$HOME/.opencode/bin/opencode run '...'", workdir="~/project")
```

## Related

- `claude-code` — Anthropic's coding agent (this umbrella)
- `codex` — OpenAI's Codex coding agent
