# vLLM — High-Performance LLM Serving

Full skill content for `serving-llms-vllm`.

## When to use

- Deploying production LLM APIs (100+ req/sec)
- Serving OpenAI-compatible endpoints
- Limited GPU memory but need large models
- Multi-user applications (chatbots, assistants)
- Need low latency with high throughput

## Quick Start

```bash
pip install vllm

# Basic offline inference
python -c "
from vllm import LLM, SamplingParams
llm = LLM(model='meta-llama/Llama-3-8B-Instruct')
outputs = llm.generate(['Explain quantum computing'], SamplingParams(temperature=0.7, max_tokens=256))
print(outputs[0].outputs[0].text)
"

# OpenAI-compatible server
vllm serve meta-llama/Llama-3-8B-Instruct --port 8000

# Query
python -c "
from openai import OpenAI
client = OpenAI(base_url='http://localhost:8000/v1', api_key='EMPTY')
print(client.chat.completions.create(
    model='meta-llama/Llama-3-8B-Instruct',
    messages=[{'role': 'user', 'content': 'Hello!'}]
).choices[0].message.content)
"
```

## Production Deployment

```bash
# Single GPU (7B-13B models)
vllm serve meta-llama/Llama-3-8B-Instruct \
  --gpu-memory-utilization 0.9 \
  --max-model-len 8192 \
  --port 8000

# Multi-GPU (30B-70B models)
vllm serve meta-llama/Llama-2-70b-hf \
  --tensor-parallel-size 4 \
  --gpu-memory-utilization 0.9 \
  --quantization awq \
  --port 8000

# Production with caching and metrics
vllm serve meta-llama/Llama-3-8B-Instruct \
  --enable-prefix-caching \
  --enable-metrics \
  --metrics-port 9090 \
  --port 8000
```

## Quantization Serving

```bash
# AWQ for 70B models
vllm serve TheBloke/Llama-2-70B-AWQ \
  --quantization awq \
  --tensor-parallel-size 1 \
  --gpu-memory-utilization 0.95
```

## Troubleshooting

**Out of memory:**
```bash
vllm serve MODEL --gpu-memory-utilization 0.7 --max-model-len 4096
# Or use quantization
vllm serve MODEL --quantization awq
```

**Slow first token:**
```bash
vllm serve MODEL --enable-prefix-caching
# For long prompts
vllm serve MODEL --enable-chunked-prefill
```

**Low throughput (<50 req/sec):**
```bash
vllm serve MODEL --max-num-seqs 512
# Check GPU utilization: nvidia-smi should be >80%
```

## When to use vs alternatives

| Use Case | Choice |
|----------|--------|
| Production API, high throughput | **vLLM** |
| CPU/edge inference, single-user | **llama.cpp** |
| Research, prototyping | **HuggingFace transformers** |
| NVIDIA-only, max performance | **TensorRT-LLM** |

## References

- `references/server-deployment.md` — Docker, Kubernetes, load balancing
- `references/optimization.md` — PagedAttention tuning, continuous batching
- `references/quantization.md` — AWQ/GPTQ/FP8 setup
- `references/troubleshooting.md` — detailed error messages, debugging

## Hardware Requirements

| Model Size | GPU |
|------------|-----|
| 7B-13B | 1x A10 (24GB) or A100 (40GB) |
| 30B-40B | 2x A100 (40GB) with tensor parallelism |
| 70B+ | 4x A100 (40GB) or 2x A100 (80GB), use AWQ/GPTQ |
