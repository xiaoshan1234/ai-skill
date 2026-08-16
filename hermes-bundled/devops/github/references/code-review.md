# GitHub Code Review

Full skill content for `github-code-review`.

## Reviewing Local Changes (Pre-Push)

This is pure `git` — works everywhere, no API needed.

```bash
# Staged changes (what would be committed)
git diff --staged

# All changes vs main (what a PR would contain)
git diff main...HEAD

# File names only
git diff main...HEAD --name-only

# Stat summary (insertions/deletions per file)
git diff main...HEAD --stat
```

### Review Strategy

1. **Get the big picture first:**
```bash
git diff main...HEAD --stat
git log main..HEAD --oneline
```

2. **Review file by file** — use `read_file` on changed files for full context

3. **Check for common issues:**
```bash
# Debug statements, TODOs, console.logs left behind
git diff main...HEAD | grep -n "print(\|console\.log\|TODO\|FIXME\|HACK\|XXX\|debugger"

# Large files accidentally staged
git diff main...HEAD --stat | sort -t'|' -k2 -rn | head -10

# Secrets or credential patterns
git diff main...HEAD | grep -in "password\|secret\|api_key\|token.*=\|private_key"

# Merge conflict markers
git diff main...HEAD | grep -n "<<<<<<\|>>>>>>\|======="
```

### Review Output Format

```
## Code Review Summary

### Critical
- **src/auth.py:45** — SQL injection: user input passed directly to query.

### Warnings
- **src/models/user.py:23** — Password stored in plaintext. Use bcrypt or argon2.

### Suggestions
- **src/utils/helpers.py:8** — Duplicates logic in `src/core/utils.py:34`. Consolidate.

### Looks Good
- Clean separation of concerns in the middleware layer
```

---

## Reviewing a Pull Request on GitHub

### View PR Details

**With gh:**
```bash
gh pr view 123
gh pr diff 123
gh pr diff 123 --name-only
```

**With git + curl:**
```bash
PR_NUMBER=123
curl -s -H "Authorization: token $GITHUB_TOKEN" \
  https://api.github.com/repos/$OWNER/$REPO/pulls/$PR_NUMBER

curl -s -H "Authorization: token $GITHUB_TOKEN" \
  https://api.github.com/repos/$OWNER/$REPO/pulls/$PR_NUMBER/files
```

### Check Out PR Locally

```bash
# Fetch and checkout PR branch
git fetch origin pull/123/head:pr-123
git checkout pr-123

# View diff against base branch
git diff main...pr-123
```

**With gh:**
```bash
gh pr checkout 123
```

### Leave Comments on a PR

**General comment — gh:**
```bash
gh pr comment 123 --body "Overall looks good, a few suggestions below."
```

**General comment — curl:**
```bash
curl -s -X POST \
  -H "Authorization: token $GITHUB_TOKEN" \
  https://api.github.com/repos/$OWNER/$REPO/issues/$PR_NUMBER/comments \
  -d '{"body": "Overall looks good, a few suggestions below."}'
```

### Submit a Formal Review

**With gh:**
```bash
gh pr review 123 --approve --body "LGTM!"
gh pr review 123 --request-changes --body "See inline comments."
gh pr review 123 --comment --body "Some suggestions, nothing blocking."
```

**With curl — atomic review with inline comments:**
```bash
HEAD_SHA=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
  https://api.github.com/repos/$OWNER/$REPO/pulls/$PR_NUMBER \
  | python3 -c "import sys,json; print(json.load(sys.stdin)['head']['sha'])")

curl -s -X POST \
  -H "Authorization: token $GITHUB_TOKEN" \
  https://api.github.com/repos/$OWNER/$REPO/pulls/$PR_NUMBER/reviews \
  -d "{
    \"commit_id\": \"$HEAD_SHA\",
    \"event\": \"COMMENT\",
    \"body\": \"Code review from Hermes Agent\",
    \"comments\": [
      {\"path\": \"src/auth.py\", \"line\": 45, \"body\": \"Use parameterized queries to prevent SQL injection.\"},
      {\"path\": \"src/models/user.py\", \"line\": 23, \"body\": \"Hash passwords with bcrypt before storing.\"}
    ]
  }"
```

Event values: `"APPROVE"`, `"REQUEST_CHANGES"`, `"COMMENT"`.

---

## Review Checklist

### Correctness
- Does the code do what it claims?
- Edge cases handled (empty inputs, nulls, large data)?
- Error paths handled gracefully?

### Security
- No hardcoded secrets, credentials, or API keys
- Input validation on user-facing inputs
- No SQL injection, XSS, or path traversal

### Code Quality
- Clear naming (variables, functions, classes)
- No unnecessary complexity or premature abstraction
- DRY — no duplicated logic

### Testing
- New code paths tested?
- Happy path and error cases covered?

### Performance
- No N+1 queries or unnecessary loops
- Appropriate caching

---

## PR Review Workflow (End-to-End)

When asked to "review PR #N":

1. **Set up environment** — detect auth method (gh vs curl)
2. **Gather PR context** — metadata, description, changed files
3. **Check out the PR locally** — `git fetch origin pull/$PR_NUMBER/head:pr-$PR_NUMBER`
4. **Read the diff and understand changes** — `git diff main...HEAD`
5. **Run automated checks locally** — pytest, linter, etc.
6. **Apply the review checklist**
7. **Post the review to GitHub** — formal review with inline comments
8. **Post a summary comment**
9. **Clean up** — `git checkout main && git branch -D pr-$PR_NUMBER`

### Decision: Approve vs Request Changes vs Comment

- **Approve** — no critical or warning-level issues
- **Request Changes** — any critical or warning-level issue that should be fixed before merge
- **Comment** — observations and suggestions, nothing blocking (use for drafts or uncertainty)
