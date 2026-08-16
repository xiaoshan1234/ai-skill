# GitHub PR Workflow

Full skill content for `github-pr-workflow`.

## Branch Creation

Pure `git` — identical either way:

```bash
git fetch origin
git checkout main && git pull origin main
git checkout -b feat/add-user-authentication
```

Branch naming conventions:
- `feat/description` — new features
- `fix/description` — bug fixes
- `refactor/description` — code restructuring
- `docs/description` — documentation

## Making Commits

```bash
git add src/auth.py src/models/user.py tests/test_auth.py
git commit -m "feat: add JWT-based user authentication

- Add login/register endpoints
- Add User model with password hashing
- Add auth middleware for protected routes"
```

Commit message format (Conventional Commits):
```
type(scope): short description
```
Types: `feat`, `fix`, `refactor`, `docs`, `test`, `ci`, `chore`, `perf`

## Pushing and Creating a PR

```bash
git push -u origin HEAD
```

**With gh:**
```bash
gh pr create \
  --title "feat: add JWT-based user authentication" \
  --body "## Summary
- Adds login and register API endpoints
- JWT token generation and validation

Closes #42"
```

**With git + curl:**
```bash
BRANCH=$(git branch --show-current)
curl -s -X POST \
  -H "Authorization: token $GITHUB_TOKEN" \
  https://api.github.com/repos/$OWNER/$REPO/pulls \
  -d "{
    \"title\": \"feat: add JWT-based user authentication\",
    \"body\": \"Closes #42\",
    \"head\": \"$BRANCH\",
    \"base\": \"main\"
  }"
```

---

## Monitoring CI Status

**With gh:**
```bash
gh pr checks
gh pr checks --watch  # watch until all checks finish
```

**With git + curl:**
```bash
SHA=$(git rev-parse HEAD)
curl -s -H "Authorization: token $GITHUB_TOKEN" \
  https://api.github.com/repos/$OWNER/$REPO/commits/$SHA/status \
  | python3 -c "
import sys, json
data = json.load(sys.stdin)
print(f\"Overall: {data['state']}\")
for s in data.get('statuses', []):
    print(f\"  {s['context']}: {s['state']}\")"
```

### Poll Until Complete
```bash
for i in $(seq 1 20); do
  STATUS=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
    https://api.github.com/repos/$OWNER/$REPO/commits/$SHA/status \
    | python3 -c "import sys,json; print(json.load(sys.stdin)['state'])")
  echo "Check $i: $STATUS"
  [ "$STATUS" = "success" ] || [ "$STATUS" = "failure" ] && break
  sleep 30
done
```

---

## Auto-Fixing CI Failures

### Step 1: Get Failure Details

**With gh:**
```bash
gh run list --branch $(git branch --show-current) --limit 5
gh run view <RUN_ID> --log-failed
```

**With git + curl:**
```bash
BRANCH=$(git branch --show-current)
curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/repos/$OWNER/$REPO/actions/runs?branch=$BRANCH&per_page=5"

# Get failed job logs
curl -s -L -H "Authorization: token $GITHUB_TOKEN" \
  https://api.github.com/repos/$OWNER/$REPO/actions/runs/$RUN_ID/logs \
  -o /tmp/ci-logs.zip
cd /tmp && unzip -o ci-logs.zip -d ci-logs && cat ci-logs/*.txt
```

### Auto-Fix Loop Pattern

1. Check CI status → identify failures
2. Read failure logs → understand the error
3. Fix with `read_file` + `patch`/`write_file`
4. `git add . && git commit -m "fix: ..." && git push`
5. Wait for CI → re-check status
6. Repeat if still failing (up to 3 attempts, then ask the user)

---

## Merging

**With gh:**
```bash
# Squash merge + delete branch
gh pr merge --squash --delete-branch

# Enable auto-merge (merges when all checks pass)
gh pr merge --auto --squash --delete-branch
```

**With git + curl:**
```bash
PR_NUMBER=<number>
curl -s -X PUT \
  -H "Authorization: token $GITHUB_TOKEN" \
  https://api.github.com/repos/$OWNER/$REPO/pulls/$PR_NUMBER/merge \
  -d "{
    \"merge_method\": \"squash\",
    \"commit_title\": \"feat: add user authentication (#$PR_NUMBER)\"
  }"

# Delete the remote branch after merge
git push origin --delete $BRANCH
git checkout main && git pull origin main
```

Merge methods: `"merge"`, `"squash"`, `"rebase"`

---

## Complete Workflow Example

```bash
# 1. Start from clean main
git checkout main && git pull origin main

# 2. Branch
git checkout -b fix/login-redirect-bug

# 3. Agent makes code changes with file tools

# 4. Commit
git add src/auth/login.py tests/test_login.py
git commit -m "fix: correct redirect URL after login"

# 5. Push
git push -u origin HEAD

# 6. Create PR

# 7. Monitor CI

# 8. Merge when green
```

## Useful PR Commands Reference

| Action | gh | git + curl |
|--------|-----|-----------|
| List my PRs | `gh pr list --author @me` | `curl ... /pulls?state=open` |
| View PR diff | `gh pr diff` | `git diff main...HEAD` |
| Add comment | `gh pr comment N --body "..."` | `curl ... /issues/N/comments` |
| Request review | `gh pr edit N --add-reviewer user` | `curl ... /pulls/N/requested_reviewers` |
| Close PR | `gh pr close N` | `curl ... /pulls/N -d '{"state":"closed"}'` |
| Check out PR | `gh pr checkout N` | `git fetch origin pull/N/head:pr-N && git checkout pr-N` |
