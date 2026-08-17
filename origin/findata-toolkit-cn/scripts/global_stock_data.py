#!/usr/bin/env python3
"""海外股票 / 外汇 / 全球指数 数据查询

通过 yfinance 获取美股、港股、韩股、日股、外汇、商品、ETF、指数。
免费，无需 API key。

Ticker 命名规范：
  美股       AAPL / NVDA / TSLA
  港股       00700.HK / 09988.HK
  韩股       000660.KS / 005930.KS
  日股       7203.T / 6758.T
  指数       ^GSPC (标普500)  ^IXIC (纳指)  ^HSI (恒指)  ^N225 (日经)
  外汇       USDCNY=X  USDJPY=X  EURUSD=X
  商品期货   GC=F (黄金)  CL=F (原油)  SI=F (白银)
  ETF        SPY  QQQ  VOO  510300.SS (沪深300)

用法:
  python3 scripts/global_stock_data.py AAPL
  python3 scripts/global_stock_data.py 000660.KS
  python3 scripts/global_stock_data.py AAPL NVDA TSLA --screen
  python3 scripts/global_stock_data.py AAPL --period 5d
"""

import sys
import json
import argparse

try:
    import yfinance as yf
except ImportError:
    print(json.dumps({
        "error": "yfinance not installed. Run: uv pip install yfinance"
    }))
    sys.exit(1)


QUOTE_KEYS = [
    "currentPrice", "regularMarketPrice", "previousClose",
    "open", "dayLow", "dayHigh",
    "fiftyTwoWeekLow", "fiftyTwoWeekHigh",
    "volume", "marketCap",
    "trailingPE", "forwardPE", "priceToBook",
    "dividendYield", "currency",
]


def quote(symbol: str) -> dict:
    """实时报价 + 关键指标"""
    t = yf.Ticker(symbol)
    info = t.info
    result = {"symbol": symbol}

    for k in QUOTE_KEYS:
        if k in info and info[k] is not None:
            result[k] = info[k]

    return result


def trend(symbol: str, period: str = "1y") -> dict:
    """走势概要：起始/结束/涨跌幅/最高/最低"""
    t = yf.Ticker(symbol)
    hist = t.history(period=period)
    if hist.empty:
        return {"symbol": symbol, "error": "no history"}

    first_close = float(hist["Close"].iloc[0])
    last_close = float(hist["Close"].iloc[-1])
    change_pct = (last_close / first_close - 1) * 100

    return {
        "symbol": symbol,
        "period": period,
        "data_points": len(hist),
        "start_price": round(first_close, 4),
        "end_price": round(last_close, 4),
        "change_pct": round(change_pct, 2),
        "period_high": round(float(hist["High"].max()), 4),
        "period_low": round(float(hist["Low"].min()), 4),
    }


def recent_bars(symbol: str, period: str = "1mo") -> list:
    """最近 N 个交易日 K 线"""
    t = yf.Ticker(symbol)
    hist = t.history(period=period)
    if hist.empty:
        return []

    rows = []
    for date, row in hist.tail(10).iterrows():
        rows.append({
            "date": str(date.date()),
            "open": float(row["Open"]),
            "high": float(row["High"]),
            "low": float(row["Low"]),
            "close": float(row["Close"]),
            "volume": int(row["Volume"]),
        })
    return rows


def batch_screen(symbols: list) -> dict:
    """批量对比多只标的"""
    results = {}
    for sym in symbols:
        try:
            q = quote(sym)
            tr = trend(sym, period="3mo")
            results[sym] = {**q, "trend_3mo": tr}
        except Exception as e:
            results[sym] = {"error": str(e)}
    return results


def main():
    p = argparse.ArgumentParser(
        description="海外股票/外汇/全球指数 查询 (yfinance)"
    )
    p.add_argument("symbols", nargs="+", help="yfinance ticker 代码")
    p.add_argument(
        "--screen", action="store_true",
        help="批量对比多只标的"
    )
    p.add_argument(
        "--period", default="1y",
        help="趋势周期 (1mo/3mo/6mo/1y/2y/5y/max)，默认 1y"
    )

    args = p.parse_args()

    if args.screen:
        out = batch_screen(args.symbols)
    else:
        sym = args.symbols[0]
        out = {
            "quote": quote(sym),
            "trend": trend(sym, args.period),
            "recent_bars": recent_bars(sym),
        }

    print(json.dumps(out, ensure_ascii=False, indent=2, default=str))


if __name__ == "__main__":
    main()
