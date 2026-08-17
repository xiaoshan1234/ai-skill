# Jupyter Live Kernel 装机笔记

基于 hamelnb skill 在 Linux 装 JupyterLab + Live Kernel Session 的全过程，含踩过的坑。

## 安装命令

```bash
# 1. 克隆 hamelnb skill
git clone https://github.com/hamelsmu/hamelnb.git ~/.agent-skills/hamelnb

# 2. 装 JupyterLab（需要 uv）
uv tool install jupyterlab

# 3. 准备 notebook 目录
mkdir -p ~/notebooks
```

## 启动 JupyterLab

**⚠️ 必加 `--ServerApp.disable_check_xsrf=True`**，否则 XSRF 拦截 POST：

```bash
jupyter-lab --no-browser --port=8888 \
  --notebook-dir=$HOME/notebooks \
  --IdentityProvider.token='' \
  --ServerApp.password='' \
  --ServerApp.allow_origin='*' \
  --ServerApp.disable_check_xsrf=True \
  > /tmp/jupyter.log 2>&1 &
```

后台运行用 `terminal(background=true)`，别用 shell 的 `&`（会被误判）。

## 创建 Notebook + Session

最小 notebook 文件：

```json
{
 "cells": [{"cell_type": "code", "execution_count": null, "id": "init", "metadata": {}, "outputs": [], "source": []}],
 "metadata": {"kernelspec": {"display_name": "Python 3", "language": "python", "name": "python3"}},
 "nbformat": 4, "nbformat_minor": 5
}
```

保存为 `~/notebooks/scratch.ipynb`。

**⚠️ 必须用相对路径 `scratch.ipynb` 创建 session，不能用绝对路径**——后续 `jupyter_live_kernel.py execute --path` 用的就是相对路径，绝对路径注册的会找不到：

```bash
# 相对路径 ✅
curl -s -X POST "http://127.0.0.1:8888/api/sessions" \
  -H "Content-Type: application/json" \
  -d '{"path":"scratch.ipynb","type":"notebook","name":"scratch.ipynb","kernel":{"name":"python3"}}'

# 绝对路径 ❌ 后续 execute 会找不到
# -d '{"path":"/home/loner/notebooks/scratch.ipynb",...}'
```

## 测试 execute

```bash
cd ~/.agent-skills/hamelnb
uv run skills/jupyter-live-kernel/scripts/jupyter_live_kernel.py execute \
  --path scratch.ipynb \
  --code $'x = 41\nx + 1' \
  --compact --timeout 60
```

预期输出：`{"reply":{"status":"ok",...}, "events":[{"data":{"text/plain":"42"},...}]}`

## 已知坑

1. **首次 execute 超时** — kernel 启动慢，第一次可能需要 60s+。传 `--timeout 60`，或者失败重试。
2. **session 创建失败报错 `'_xsrf' argument missing`** — 没加 `disable_check_xsrf=True`，重启 server。
3. **session 找不到** — path 不匹配，确保创建 session 和 execute 用同样的相对路径。
4. **kill jupyter-lab 被阻止** — 用 `process(action='kill', session_id=...)`，不要用 `pkill`（被当作破坏性命令拦截）。
5. **不同 venv 的包不可见** — `jupyter-lab` 用的是 `~/.local/share/uv/tools/jupyterlab/` 的 Python，独立 venv（比如 `/tmp/usstock_env/`）装的包**用不到**。要让 jupyter 能用 yfinance，需要：

   ```bash
   uv pip install yfinance --python ~/.local/share/uv/tools/jupyterlab/bin/python
   ```

   或者把独立 venv 注册成 jupyter kernel：

   ```bash
   /tmp/usstock_env/bin/python -m ipykernel install --user --name=usstock --display-name="Stock Env"
   ```

## Health Check

启动后验证：

```bash
sleep 6
curl -s http://127.0.0.1:8888/api/status
# 期望：{"connections": 0, "kernels": 0, "last_activity": "...", "started": "..."}
```

log 在 `/tmp/jupyter.log`，看 `ServerApp is running at:` 确认启动成功。

## 配合 yfinance 跑海外股票

```python
# 在 jupyter cell 里
import yfinance as yf
t = yf.Ticker("000660.KS")  # SK海力士
hist = t.history(period="1y")
print(f"一年涨幅: {(hist['Close'].iloc[-1] / hist['Close'].iloc[0] - 1)*100:.2f}%")
```

如果报 `ModuleNotFoundError: yfinance`，参考上面坑 5 装到 jupyter 自己的 Python 环境。
