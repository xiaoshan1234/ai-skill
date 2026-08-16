# llama.cpp — Local GGUF Inference

Full skill content for `llama-cpp`.

## When to use

- Run local models on CPU, Apple Silicon, CUDA, ROCm, or Intel GPUs
- Find the right GGUF for a specific Hugging Face repo
- Build a `llama-server` or `llama-cli` command from the Hub

## Quick Start

### Install llama.cpp

```bash
# macOS / Linux
brew install llama.cpp

# Windows
winget install llama.cpp

# From source
git clone https://github.com/ggml-org/llama.cpp
cd llama.cpp && cmake -B build && cmake --build build --config Release
```

### Run from Hugging Face Hub

```bash
llama-cli -hf bartowski/Llama-3.2-3B-Instruct-GGUF:Q8_0
llama-server -hf bartowski/Llama-3.2-3B-Instruct-GGUF:Q8_0
```

### Run an exact GGUF file from the Hub

```bash
llama-server \
    --hf-repo microsoft/Phi-3-mini-4k-instruct-gguf \
    --hf-file Phi-3-mini-4k-instruct-q4.gguf \
    -c 4096
```

## Model Discovery Workflow

Prefer URL workflows before asking for `hf`, Python, or custom scripts.

1. Search for candidate repos: `https://huggingface.co/models?apps=llama.cpp&sort=trending`
2. Open the repo with the llama.cpp local-app view: `https://huggingface.co/<repo>?local-app=llama.cpp`
3. Query the tree API to confirm what exists: `https://huggingface.co/api/models/<repo>/tree/main?recursive=true`

## Python Bindings

```python
from llama_cpp import Llama

llm = Llama(
    model_path="./model-q4_k_m.gguf",
    n_ctx=4096,
    n_gpu_layers=35,
)

out = llm("What is machine learning?", max_tokens=256, temperature=0.7)
print(out["choices"][0]["text"])
```

### Chat + Streaming

```python
llm = Llama(
    model_path="./model-q4_k_m.gguf",
    n_ctx=4096,
    n_gpu_layers=35,
    chat_format="llama-3",
)

resp = llm.create_chat_completion(
    messages=[
        {"role": "system", "content": "You are a helpful assistant."},
        {"role": "user", "content": "What is Python?"},
    ],
)
# Streaming
for chunk in llm("Explain quantum computing:", stream=True):
    print(chunk["choices"][0]["text"], end="", flush=True)
```

## Choosing a Quant

- For general chat: start with `Q4_K_M`
- For code or technical work: prefer `Q5_K_M` or `Q6_K`
- For tight RAM budgets: `Q3_K_M`, `IQ` variants, or `Q2`
- For multimodal repos: mention `mmproj-*.gguf` separately (projector, not main model)

## References

- `references/hub-discovery.md` — URL-only HF workflows, search patterns, GGUF extraction
- `references/advanced-usage.md` — speculative decoding, batched inference, grammar-constrained generation, LoRA, multi-GPU
- `references/quantization.md` — quant quality tradeoffs, when to use Q4/Q5/Q6/IQ
- `references/server.md` — direct-from-Hub server launch, OpenAI API endpoints, Docker deployment
- `references/optimization.md` — CPU threading, BLAS, GPU offload, batch tuning
- `references/troubleshooting.md` — install/convert/quantize/inference/server issues
