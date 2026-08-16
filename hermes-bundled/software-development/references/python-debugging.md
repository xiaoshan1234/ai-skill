# Python Debugging (pdb + debugpy)

Three tools, picked by situation:

| Tool | When |
|---|---|
| **`breakpoint()` + pdb** | Local, interactive, simplest. Add `breakpoint()` in the source, run normally, get a REPL at that line. |
| **`python -m pdb`** | Launch an existing script under pdb with no source edits. Useful for quick poking. |
| **`debugpy`** | Remote / headless / "attach to already-running process." Talks DAP, scriptable from terminal, works for long-lived processes. |

**Start with `breakpoint()`.** It's the cheapest thing that works.

## pdb Quick Reference

Inside any pdb prompt (`(Pdb)`):

| Command | Action |
|---|---|
| `h` / `h cmd` | help |
| `n` | next line (step over) |
| `s` | step into |
| `r` | return from current function |
| `c` | continue |
| `unt N` | continue until line N |
| `l` / `ll` | list source around current line / full function |
| `w` | where (stack trace) |
| `u` / `d` | move up / down in the stack |
| `p expr` / `pp expr` | print / pretty-print expression |
| `interact` | drop into full Python REPL in current scope (Ctrl+D to exit) |
| `q` | quit |

## Recipe 1: Local breakpoint

```python
def compute(x, y):
    result = some_helper(x)
    breakpoint()           # <-- drops into pdb here
    return result + y
```

## Recipe 2: Launch a script under pdb (no source edits)

```bash
python -m pdb path/to/script.py arg1 arg2
```

## Recipe 3: Debug a pytest test

```bash
# Drop to pdb on failure:
scripts/run_tests.sh tests/path/to/test_file.py::test_name --pdb -p no:xdist
# Note: -p no:xdist is REQUIRED — pdb does NOT work under pytest-xdist
```

## Recipe 4: Remote debug with debugpy

For long-lived processes (gateway, daemon, etc.):

```python
import debugpy
debugpy.listen(("127.0.0.1", 5678))
print("debugpy listening on 5678, waiting for client...", flush=True)
debugpy.wait_for_client()
```

Then attach from VS Code / Cursor with a `launch.json`:

```json
{
  "name": "Attach to Hermes",
  "type": "debugpy",
  "request": "attach",
  "connect": { "host": "127.0.0.1", "port": 5678 },
  "justMyCode": false
}
```

**Alternative: `remote-pdb`** (cleanest for terminal agents):

```bash
pip install remote-pdb
```

```python
from remote_pdb import set_trace
set_trace(host="127.0.0.1", port=4444)
```

```bash
nc 127.0.0.1 4444  # Get a (Pdb) prompt
```

## Common Pitfalls

1. **pdb under pytest-xdist silently does nothing.** Always use `-p no:xdist` or `-n 0`.
2. **`breakpoint()` in CI / non-TTY contexts hangs the process.** Never commit it.
3. **`PYTHONBREAKPOINT=0`** disables all `breakpoint()` calls. Check `echo $PYTHONBREAKPOINT`.
4. **`debugpy.listen` blocks only if you also call `wait_for_client()`.**
5. **Attach to PID fails on hardened kernels.** Fix: `echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope`
