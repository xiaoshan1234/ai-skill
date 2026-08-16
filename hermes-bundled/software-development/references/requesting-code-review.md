# Requesting Code Review

Pre-commit review: security scan, quality gates, auto-fix.

## When to Use

Use before opening a PR or merging any significant code change. The goal is to catch issues before they reach the repository's main branch.

## Pre-Commit Checklist

### 1. Security Scan

Run before any review request:

```bash
# Scan for secrets/credentials accidentally committed
git diff --staged | grep -i "password\|secret\|api_key\|token" || echo "No secrets found"
git diff --staged | grep -E "[A-Za-z0-9+/]{40,}" || echo "No long tokens found"

# Run security linter if available (e.g., bandit for Python)
bandit -r src/ || true
```

### 2. Quality Gates

```bash
# Type check (if applicable)
mypy src/ || true

# Lint
ruff check src/ || ruff check --fix src/ || true

# Format check
black --check src/ || black src/ || true
isort --check src/ || isort src/ || true

# Tests (at minimum for changed files)
pytest tests/changed_files/ -q || true
```

### 3. Auto-fix

Apply automated fixes for common issues:

```bash
# Fix common style issues
ruff check --fix src/
isort src/
black src/
```

### 4. Review Checklist

Before requesting review, verify:
- [ ] Tests pass locally
- [ ] No new lint/type errors introduced
- [ ] No secrets/credentials in diff
- [ ] Diff is focused (not mixed concerns)
- [ ] Commit messages are clear
- [ ] Documentation updated if needed

## When to Skip Pre-Commit Review

- Trivial one-line fixes (typos, comments)
- Automated dependency updates
- Documentation-only changes
- Rollback commits

## After Auto-fix

Always re-run tests after automated fixes to ensure no regressions were introduced.
