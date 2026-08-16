# Kanban Worker — Pitfalls and Examples

> You're seeing this skill because the Hermes Kanban dispatcher spawned you as a worker
> with `--skills kanban-worker` — it's loaded automatically for every dispatched worker.
> The lifecycle (6 steps: orient → work → heartbeat → block/complete) also lives in the
> `KANBAN_GUIDANCE` block that's auto-injected into your system prompt. This skill is
> the deeper detail: good handoff shapes, retry diagnostics, edge cases.

## Workspace handling

| Kind | What it is | How to work |
|------|------------|-------------|
| `scratch` | Fresh tmp dir, yours alone | Read/write freely; gets GC'd when task is archived |
| `dir:<path>` | Shared persistent directory | Other runs will read what you write. Treat like long-lived state. |
| `worktree` | Git worktree at the resolved path | If `.git` doesn't exist, run `git worktree add <path>` first, then commit work here. |

## Tenant isolation

If `$HERMES_TENANT` is set, prefix memory entries with the tenant:

- Good: `business-a: Acme is our biggest customer`
- Bad (leaks): `Acme is our biggest customer`

## Good summary + metadata shapes

```python
# Coding task
kanban_complete(
    summary="shipped rate limiter — token bucket, keys on user_id with IP fallback, 14 tests pass",
    metadata={
        "changed_files": ["rate_limiter.py", "tests/test_rate_limiter.py"],
        "tests_run": 14,
        "tests_passed": 14,
        "decisions": ["user_id primary, IP fallback for unauthenticated requests"],
    },
)

# Research task
kanban_complete(
    summary="3 competing libraries reviewed; vLLM wins on throughput, SGLang on latency",
    metadata={
        "sources_read": 12,
        "recommendation": "vLLM",
        "benchmarks": {"vllm": 1.0, "sglang": 0.87},
    },
)

# Review task
kanban_complete(
    summary="reviewed PR #123; 2 blocking issues found",
    metadata={
        "pr_number": 123,
        "findings": [
            {"severity": "critical", "file": "api/search.py", "line": 42, "issue": "raw SQL concat"},
        ],
        "approved": False,
    },
)
```

## Coding task needing human review

```python
import json

kanban_comment(
    body="review-required handoff:\n" + json.dumps({
        "changed_files": ["rate_limiter.py"],
        "tests_run": 14,
        "tests_passed": 14,
        "diff_path": "/path/to/worktree",
    }, indent=2),
)
kanban_block(
    reason="review-required: rate limiter shipped, 14/14 tests pass — needs eyes on choices before merging",
)
```

Use `kanban_complete` only when the task is genuinely terminal.

## Claiming cards you actually created

```python
# GOOD — capture return values, then claim them.
c1 = kanban_create(title="remediate SQL injection", assignee="security-worker")
c2 = kanban_create(title="fix CSRF middleware", assignee="web-worker")

kanban_complete(
    summary="Review done; spawned remediations for both findings.",
    metadata={"pr_number": 123, "approved": False},
    created_cards=[c1["task_id"], c2["task_id"]],
)

# BAD — claiming ids you don't have captured return values for.
kanban_complete(
    summary="Created remediation cards t_a1b2c3d4",
    created_cards=["t_a1b2c3d4"],  # → gate rejects
)
```

## Block reasons that get answered fast

Bad: `"stuck"` — the human has no context.

Good: one sentence naming the specific decision you need. Leave longer context as a comment:

```python
kanban_comment(
    task_id=os.environ["HERMES_KANBAN_TASK"],
    body="Full context: I have user IPs from Cloudflare headers but some users are behind NATs...",
)
kanban_block(reason="Rate limit key choice: IP (simple, NAT-unsafe) or user_id (requires auth)?")
```

## Heartbeats worth sending

Good: `"epoch 12/50, loss 0.31"`, `"scanned 1.2M/2.4M rows"`, `"uploaded 47/120 videos"`.

Bad: `"still working"`, empty notes, sub-second intervals.

## Retry scenarios

If `kanban_show` returns `runs: [...]` with closed runs, you're a retry. Check `outcome`:

- `outcome: "timed_out"` — previous attempt hit `max_runtime_seconds`. Chunk the work.
- `outcome: "crashed"` — OOM or segfault. Reduce memory footprint.
- `outcome: "spawn_failed"` — usually profile config issue. Block instead of retry.
- `outcome: "reclaimed"` + `summary: "task archived..."` — operator archived the task; check status.
- `outcome: "blocked"` — previous attempt blocked; unblock comment should be in thread.

## Do NOT

- Call `delegate_task` as a substitute for `kanban_create`. `delegate_task` is for short
  reasoning subtasks inside YOUR run; `kanban_create` is for cross-agent handoffs.
- Call `clarify` to ask the human a question. You are running headless — there is no live
  user. Use `kanban_comment` + `kanban_block(reason=...)` instead.
- Modify files outside `$HERMES_KANBAN_WORKSPACE` unless the task body says to.
- Create follow-up tasks assigned to yourself — assign to the right specialist.
- Complete a task you didn't actually finish. Block it instead.

## Pitfalls

- **Task state can change between dispatch and your startup.** Always `kanban_show` first.
  If it reports `blocked` or `archived`, stop.
- **Workspace may have stale artifacts.** Read the comment thread for context on why you're
  running again.
- **Don't rely on the CLI when the guidance is available.** The `kanban_*` tools work
  across all terminal backends (Docker, Modal, SSH). `hermes kanban <verb>` fails in
  containerized backends. Use the tools instead.

## CLI fallback (for scripting)

Every tool has a CLI equivalent:

- `kanban_show` ↔ `hermes kanban show <id> --json`
- `kanban_complete` ↔ `hermes kanban complete <id> --summary "..."`
- `kanban_block` ↔ `hermes kanban block <id> "reason"`
- `kanban_create` ↔ `hermes kanban create "title" --assignee <profile>`

Use the tools from inside an agent; the CLI exists for the human at the terminal.
