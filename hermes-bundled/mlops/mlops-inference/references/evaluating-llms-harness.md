# lm-Evaluation-Harness — LLM Benchmarking

Full skill content for `evaluating-llms-harness`.

## What's inside

Evaluates LLMs across 60+ academic benchmarks (MMLU, HumanEval, GSM8K, TruthfulQA, HellaSwag).
Use when benchmarking model quality, comparing models, reporting academic results, or tracking training
progress. Industry standard used by EleutherAI, HuggingFace, and major labs.

## Quick start

```bash
pip install lm-eval

# Evaluate any HuggingFace model
lm_eval --model hf \
  --model_args pretrained=meta-llama/Llama-2-7b-hf \
  --tasks mmlu,gsm8k,hellaswag \
  --device cuda:0 \
  --batch_size 8

# View available tasks
lm_eval --tasks list
```

## Common workflows

### Standard benchmark evaluation

Evaluate model on core benchmarks (MMLU, GSM8K, HumanEval).

**Step 1: Choose benchmark suite**

| Type | Benchmarks |
|------|-----------|
| Core reasoning | MMLU, GSM8K, HellaSwag, TruthfulQA, ARC |
| Code | HumanEval, MBPP |
| Standard suite | `--tasks mmlu,gsm8k,hellaswag,truthfulqa,arc_challenge` |

**Step 2: Configure model**

```bash
# HuggingFace model
lm_eval --model hf \
  --model_args pretrained=meta-llama/Llama-2-7b-hf,dtype=bfloat16 \
  --tasks mmlu --device cuda:0 --batch_size auto

# Quantized model (4-bit/8-bit)
lm_eval --model hf \
  --model_args pretrained=meta-llama/Llama-2-7b-hf,load_in_4bit=True \
  --tasks mmlu --device cuda:0
```

**Step 3: Run evaluation**

```bash
lm_eval --model hf \
  --model_args pretrained=meta-llama/Llama-2-7b-hf \
  --tasks mmlu,gsm8k,hellaswag,truthfulqa,arc_challenge \
  --num_fewshot 5 --batch_size 8 \
  --output_path results/llama2-7b-eval.json \
  --log_samples
```

**Step 4: Analyze results**

Results in `results/llama2-7b-eval.json`:

```json
{
  "results": {
    "mmlu": {"acc": 0.459, "acc_stderr": 0.004},
    "gsm8k": {"exact_match": 0.142, "exact_match_stderr": 0.006}
  }
}
```

### Track training progress

Evaluate checkpoints during training with quick benchmarks (HellaSwag ~10min, GSM8K ~5min on 1 GPU).

```bash
./eval_checkpoint.sh checkpoints step-{step}
```

Avoid MMLU for frequent eval (2 hours); use PIQA (~2min) or HellaSwag instead.

### Compare multiple models

Benchmark suite for model comparison. Run each model, collect results, generate comparison table.

### vLLM backend (5-10x faster)

```bash
pip install vllm

lm_eval --model vllm \
  --model_args pretrained=meta-llama/Llama-2-7b-hf,tensor_parallel_size=2 \
  --tasks mmlu --batch_size auto
```

## When to use vs alternatives

| Use Case | Choice |
|----------|--------|
| Academic benchmarks | **lm-eval-harness** |
| Instruction-following | AlpacaEval |
| Conversational | MT-Bench |
| Broader evaluation (fairness, efficiency) | HELM (Stanford) |

## Common issues

**Evaluation too slow:** Use vLLM backend or reduce `--num_fewshot 0`.

**Out of memory:** `--batch_size 1` or `--model_args load_in_8bit=True`.

**HumanEval not executing:** Install `human-eval` and pass `--allow_code_execution`.

## Hardware requirements

| Model | VRAM | Time (A100) |
|-------|------|-------------|
| 7B | 16GB (bf16) / 8GB (8-bit) | HellaSwag 10min, MMLU 2hr |
| 13B | 28GB (bf16) / 14GB (8-bit) | |
| 70B | Multi-GPU or quantization | |

## References

- GitHub: https://github.com/EleutherAI/lm-evaluation-harness
- Task library: 60+ benchmarks
- Leaderboard: https://huggingface.co/spaces/HuggingFaceH4/open_llm_leaderboard
