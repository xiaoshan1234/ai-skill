# Node.js Debugging (node inspect + CDP)

When `console.log` isn't enough, drive Node's built-in V8 inspector programmatically from the terminal.

Two tools:

- **`node inspect`** — built-in, zero install, CLI REPL. Best for quick poking.
- **`ndb` / CDP via `chrome-remote-interface`** — scriptable from Node/Python; best when you want to automate breakpoints or debug non-interactively.

**Prefer `node inspect` first.** It's always available and the REPL is fast.

## Quick Reference: `node inspect` REPL

```bash
node inspect path/to/script.js
```

| Command | Action |
|---|---|
| `c` / `cont` | continue |
| `n` / `next` | step over |
| `s` / `step` | step into |
| `o` / `out` | step out |
| `sb('file.js', 42)` | set breakpoint at file.js line 42 |
| `bt` | backtrace (call stack) |
| `repl` | drop into REPL in current scope |
| `.exit` | quit debugger |

## Attaching to a Running Process

```bash
# 1. Send SIGUSR1 to enable the inspector
kill -SIGUSR1 <pid>

# 2. Attach the debugger CLI
node inspect -p <pid>
```

## Programmatic CDP

For automation, use `chrome-remote-interface`:

```bash
npm i -g chrome-remote-interface
node --inspect-brk=9229 target.js &
```

Driver script (`/tmp/cdp-debug.js`):

```javascript
const CDP = require('chrome-remote-interface');
(async () => {
  const client = await CDP({ port: 9229 });
  const { Debugger, Runtime } = client;
  Debugger.paused(async ({ callFrames }) => {
    const top = callFrames[0];
    console.log(`PAUSED @ ${top.url}:${top.location.lineNumber + 1}`);
    await Debugger.resume();
  });
  await Runtime.enable();
  await Debugger.enable();
})();
```

## Debugging Hermes ui-tui

The TUI is built Ink + tsx:

```bash
# 1. Enable inspector on the Node PID
kill -SIGUSR1 <tui_pid>

# 2. Find WS URL
curl -s http://127.0.0.1:9229/json/list | jq -r '.[0].webSocketDebuggerUrl'

# 3. Attach
node inspect ws://127.0.0.1:9229/<uuid>
```

## Common Pitfalls

1. **Wrong line numbers in TS source.** Breakpoints hit the emitted JS, not the `.ts`. Use built `dist/*.js`.
2. **`--inspect` vs `--inspect-brk`.** `--inspect-brk` pauses on first line; `--inspect` lets it run.
3. **Port collisions.** Default is `9229`. Multiple processes need unique ports.
4. **Background kills.** If you `Ctrl+C` out of `node inspect` while paused, the target stays paused. `cont` first, or `kill` explicitly.
