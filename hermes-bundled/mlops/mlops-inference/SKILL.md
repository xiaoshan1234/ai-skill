---
name: mlops-inference
description: "LLM inference and serving: llama.cpp local GGUF inference, vLLM high-throughput serving, and lm-evaluation-harness benchmarking. Covers all local/LLM-serving workflows plus model evaluation."
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [llm, inference, serving, llama, vllm, quantization, gguf, gpu, evaluation, benchmarking]
    related_skills: [huggingface-hub, weights-and-biases]
---

# MLOps Inference — LLM Serving & Deployment

Unified skill for all LLM inference, serving, and evaluation workflows.

## Skills in this Suite

| Reference | Covers |
|----------|--------|
| `references/llama-cpp.md` | llama.cpp local GGUF inference + HF Hub model discovery |
| `references/vllm.md` | vLLM: high-throughput LLM serving, OpenAI API, quantization |
| `references/evaluating-llms-harness.md` | lm-eval-harness: benchmark LLMs (MMLU, GSM8K, etc.) |

## Quick Reference

```bash
# For local GGUF inference: read references/llama-cpp.md
# For high-throughput server: read references/vllm.md
# For benchmarking: read references/evaluating-llms-harness.md
```

## Related Skills

- For model downloads from HuggingFace: see `huggingface-hub`
- For experiment tracking and sweeps: see `weights-and-biases`
- For fine-tuning: see `fine-tuning-with-trl` or `axolotl`
