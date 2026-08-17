---
name: findata-toolkit-cn
description: A股金融数据工具包。提供脚本获取A股实时行情、财务指标、董监高增减持、北向资金、宏观经济数据（LPR、CPI/PPI、PMI、社融、M2）。用于需要实时A股市场数据支撑投资分析时。所有数据源免费，无需API密钥。
license: Apache-2.0
---

# 金融数据工具包 — A股市场

自包含的数据工具包，提供A股市场实时金融数据和定量计算。所有数据源**免费**，**无需API密钥**。

## 安装

安装依赖（一次性）：

```bash
pip install -r requirements.txt
```

yfinance 用于海外股票/外汇数据（如未装）：

```bash
uv pip install yfinance --python /path/to/venv/bin/python
```

## 可用工具

所有脚本位于 `scripts/` 目录。从技能根目录运行。部分环境可能未提供 `python` 命令，若执行失败，使用 `python3` 替代。

### 1. A股数据 (`scripts/stock_data.py`)

通过 AKShare 获取A股基本面、行情、财务指标。

| 命令 | 用途 |
|------|------|
| `python3 scripts/stock_data.py 600519` | 基本信息（贵州茅台） |
| `python3 scripts/stock_data.py 600519 --metrics` | 完整财务指标（估值、盈利、杠杆、增长） |
| `python3 scripts/stock_data.py 600519 --history` | 历史OHLCV行情 |
| `python3 scripts/stock_data.py 600519 --financials` | 利润表、资产负债表、现金流量表 |
| `python3 scripts/stock_data.py 600519 --insider` | 董监高增减持数据 |
| `python3 scripts/stock_data.py --northbound` | 北向资金流向（沪股通/深股通） |
| `python3 scripts/stock_data.py 600519 000858 --screen` | 批量筛选 |

### 2. 宏观数据 (`scripts/macro_data.py`)

通过 AKShare 获取中国宏观经济指标。

| 命令 | 用途 |
|------|------|
| `python3 scripts/macro_data.py --dashboard` | 完整宏观仪表盘 |
| `python3 scripts/macro_data.py --rates` | 利率数据（LPR、Shibor） |
| `python3 scripts/macro_data.py --inflation` | CPI/PPI数据 |
| `python3 scripts/macro_data.py --pmi` | PMI数据（制造业/非服务业） |
| `python3 scripts/macro_data.py --social-financing` | 社会融资规模 + M2 |
| `python3 scripts/macro_data.py --cycle` | 经济周期阶段判断 |

### 3. 海外股票 / 外汇 (`scripts/global_stock_data.py`)

通过 yfinance 获取美股、港股、韩股、外汇、全球指数。**免费，无需 API key**。

| 命令 | 用途 |
|------|------|
| `python3 scripts/global_stock_data.py AAPL` | 苹果公司实时 + 历史 |
| `python3 scripts/global_stock_data.py 000660.KS` | SK海力士（KRX） |
| `python3 scripts/global_stock_data.py 00700.HK` | 腾讯（HKEX） |
| `python3 scripts/global_stock_data.py USDCNY=X` | 美元人民币汇率 |
| `python3 scripts/global_stock_data.py ^GSPC` | 标普500指数 |
| `python3 scripts/global_stock_data.py TSM NVDA --screen` | 多标的批量对比 |

**Ticker 命名规范（yfinance）**：
- 美股：`AAPL`、`NVDA`、`TSLA`（直接）
- 港股：`00700.HK`（5位代码 + `.HK`）
- 韩股：`000660.KS`（6位代码 + `.KS`）
- 日股：`7203.T`（4位代码 + `.T`）
- 指数：`^GSPC`（标普）、`^IXIC`（纳指）、`^HSI`（恒指）
- 外汇：`USDCNY=X`（美元人民币）
- 商品：`GC=F`（黄金期货）

**常见误区**：
- 数量级混淆：SK海力士等韩股价格单位是 **韩元（KRW）**，不是美元
- 货币对的隐含汇率：1 USD = 当前 KRW 价 ÷ 当前 USD 价

## 进阶：Live Kernel 持续分析

需要持续分析、保留状态、跨调用做研究时，配合 Jupyter Live Kernel 使用：

```
参考: references/jupyter-live-kernel-setup.md
```

那个引用文档记录了 JupyterLab 装机坑（XSRF、路径匹配、首次超时、venv 包不可见等）。

## 数据来源

| 来源 | 数据内容 | API密钥 |
|------|----------|---------|
| AKShare | A股行情、财务数据、董监高交易、北向资金、宏观指标 | 无需 |
| yfinance | 美股/港股/韩股/全球指数/外汇/ETF/期货 | 无需 |

## 何时使用哪个工具

- **需要 A 股实时行情/批量对比/板块强弱**：优先使用 `cn-stock` MCP 工具（`stock_quote`、`stock_batch_quotes`），响应快、稳定性高。
- **需要 A 股财务指标、估值、ROE、宏观数据**：使用本工具包的 `scripts/stock_data.py --metrics` 或 `scripts/macro_data.py`。
- **需要美股/港股/韩股/外汇/全球指数**：使用 `scripts/global_stock_data.py`（yfinance）。
- **AKShare 实时全市场行情（`stock_zh_a_spot_em`）偶有网络超时**：失败时优先降级到 `cn-stock` 批量查询，而非反复重试。

## 重要工作流规则

### 判断走势前先看实际 K 线，不要纯理论推演

用户偏好**实证主义**：判断趋势、汇率方向、市场情绪时，必须先拉实际走势图（K 线、月度变化）作为依据，**不能用纯宏观理论（利差、关税、央行政策）空推**。

判断错误时的修正模板：

> "我之前判断错了。你提醒我看实际走势图是对的——从 [时间范围] 图看，[标的] 实际处于 [实际走势]，不是 [我之前的判断]。我之前过度看重了 [宏观变量]，忽略了 [实际数据]。"

**教训**：趋势图告诉你市场在做什么，理论只是解释为什么。趋势已成时，跟趋势走更稳。

## 输出格式

所有脚本以 **JSON** 输出到标准输出，便于解析。错误信息输出到标准错误。

## 配置

可选：编辑 `config/data_sources.yaml` 自定义速率限制或添加付费数据源API密钥。
