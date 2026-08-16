# GitHub Repository Management

Full skill content for `github-repo-management`.

## Cloning Repositories

Pure `git` — works identically either way:

```bash
git clone https://github.com/owner/repo-name.git
git clone --depth 1 https://github.com/owner/repo-name.git
git clone --branch develop https://github.com/owner/repo-name.git
```

**With gh:**
```bash
gh repo clone owner/repo-name
```

---

## Creating Repositories

**With gh:**
```bash
gh repo create my-new-project --public --clone
gh repo create my-new-project --private --description "A useful tool" --license MIT --clone
```

**With git + curl:**
```bash
curl -s -X POST \
  -H "Authorization: token $GITHUB_TOKEN" \
  https://api.github.com/user/repos \
  -d '{"name": "my-new-project", "description": "A useful tool", "private": false}'
git clone https://github.com/$GH_USER/my-new-project.git
```

---

## Forking Repositories

**With gh:**
```bash
gh repo fork owner/repo-name --clone
```

**With git + curl:**
```bash
curl -s -X POST -H "Authorization: token $GITHUB_TOKEN" \
  https://api.github.com/repos/owner/repo-name/forks
sleep 3
git clone https://github.com/$GH_USER/repo-name.git
git remote add upstream https://github.com/owner/repo-name.git
```

### Keeping a Fork in Sync
```bash
git fetch upstream
git checkout main
git merge upstream/main
git push origin main
```

---

## Repository Information

**With gh:**
```bash
gh repo view owner/repo-name
gh repo list --limit 20
```

**With curl:**
```bash
curl -s -H "Authorization: token $GITHUB_TOKEN" \
  https://api.github.com/repos/$OWNER/$REPO
curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/user/repos?per_page=20&sort=updated"
```

---

## Repository Settings

**With gh:**
```bash
gh repo edit --description "Updated description" --visibility public
gh repo edit --enable-auto-merge
```

**With curl:**
```bash
curl -s -X PATCH -H "Authorization: token $GITHUB_TOKEN" \
  https://api.github.com/repos/$OWNER/$REPO \
  -d '{"description": "Updated description", "allow_auto_merge": true}'
```

---

## Branch Protection

```bash
# Set up branch protection
curl -s -X PUT -H "Authorization: token $GITHUB_TOKEN" \
  https://api.github.com/repos/$OWNER/$REPO/branches/main/protection \
  -d '{
    "required_status_checks": {"strict": true, "contexts": ["ci/test"]},
    "enforce_admins": false,
    "required_pull_request_reviews": {"required_approving_review_count": 1}
  }'
```

---

## Secrets Management (GitHub Actions)

**With gh:**
```bash
gh secret set API_KEY --body "your-secret-value"
gh secret list
gh secret delete API_KEY
```

**With curl** (requires PyNaCl encryption):
```bash
# Get repo's public key for encryption
curl -s -H "Authorization: token $GITHUB_TOKEN" \
  https://api.github.com/repos/$OWNER/$REPO/actions/secrets/public-key
# Then encrypt and PUT the secret (gh secret set is dramatically simpler)
```

---

## Releases

**With gh:**
```bash
gh release create v1.0.0 --title "v1.0.0" --generate-notes
gh release list
gh release download v1.0.0 --dir ./downloads
```

**With curl:**
```bash
curl -s -X POST -H "Authorization: token $GITHUB_TOKEN" \
  https://api.github.com/repos/$OWNER/$REPO/releases \
  -d '{"tag_name": "v1.0.0", "name": "v1.0.0", "draft": false}'
```

---

## GitHub Actions Workflows

**With gh:**
```bash
gh workflow list
gh run list --limit 10
gh run view <RUN_ID> --log-failed
gh run rerun <RUN_ID>
gh workflow run ci.yml --ref main
```

**With curl:**
```bash
# List workflow runs
curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/repos/$OWNER/$REPO/actions/runs?per_page=10"

# Trigger workflow_dispatch
curl -s -X POST -H "Authorization: token $GITHUB_TOKEN" \
  https://api.github.com/repos/$OWNER/$REPO/actions/workflows/$WORKFLOW_ID/dispatches \
  -d '{"ref": "main"}'
```
