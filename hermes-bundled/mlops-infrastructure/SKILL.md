---
name: mlops-infrastructure
description: "Unified MLOps infrastructure skill: HuggingFace Hub (model/dataset upload/download, Spaces, Inference Endpoints) and Weights & Biases (experiment tracking, sweeps, model registry, artifact management)."
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [mlops, huggingface, weights-and-biases, wandb, experiment-tracking, model-registry, hub, infrastructure]
    category: mlops
---

# MLOps Infrastructure

Unified class-level umbrella for MLOps infrastructure tooling: model hosting, experiment tracking, and artifact management.

## Absorbed Skills (see .archive for full packages)

| Skill | What it covers | Archived at |
|-------|---------------|-------------|
| `huggingface-hub` | HF Hub: `hf` CLI, model/dataset upload/download, Spaces, Inference Endpoints, Discussions | `.archive/huggingface-hub/` |
| `weights-and-biases` | W&B: experiment tracking, hyperparameter sweeps, model registry, artifacts | `.archive/weights-and-biases/` |

## Quick Decision Tree

```
User wants to... → Use this tool:
───────────────────────────────────────────────────────
Upload/download models or datasets to HuggingFace       → `hf` CLI (from `.archive/huggingface-hub/`)
Manage HF Spaces, webhooks, collections                 → `hf` CLI (from `.archive/huggingface-hub/`)
Deploy Inference Endpoints                              → `hf` CLI (from `.archive/huggingface-hub/`)
Log ML experiments / training metrics                   → W&B (from `.archive/weights-and-biases/`)
Hyperparameter optimization (sweeps)                   → W&B sweeps (from `.archive/weights-and-biases/`)
Model versioning and registry                          → W&B Artifacts / Model Registry (from `.archive/weights-and-biases/`)
Track datasets and model lineage                       → W&B Artifacts (from `.archive/weights-and-biases/`)
```

## Quick Reference

### HuggingFace `hf` CLI (from archived skill)
```bash
# Download a model
hf download <repo_id>

# Upload files
hf upload <repo_id> <file>

# List models/datasets
hf models list
hf datasets list

# Inference Endpoints
hf deploy <model> --name my-endpoint

# Spaces management
hf spaces list
hf spaces restart <space>
```

### W&B (from archived skill)
```python
import wandb

# Initialize run
wandb.init(project="my-project", config={"lr": 0.001, "epochs": 10})

# Log metrics
wandb.log({"loss": 0.5, "accuracy": 0.92})

# Sweep
sweep_config = {
    'method': 'bayes',
    'metric': {'name': 'val/accuracy', 'goal': 'maximize'},
    'parameters': {'lr': {'distribution': 'log_uniform', 'min': 1e-5, 'max': 1e-1}}
}
wandb.sweep(sweep_config, project="my-project")
```

## Archived Skill Packages

The full packages for both absorbed skills are preserved at:
- `~/.hermes/skills/.archive/huggingface-hub/`
- `~/.hermes/skills/.archive/weights-and-biases/`
