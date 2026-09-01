# EA-037 — MACD Fifth Element

## Overview

EA-037 is a MetaTrader 5 research implementation of the MACD “Fifth Element” concept for XAUUSD.

The EA waits for four completed MACD histogram bars of the same sign and evaluates entry at the opening of the fifth bar. A positive sequence produces a BUY signal; a negative sequence produces a SELL signal.

> Status: Research / Backtesting  
> Platform: MetaTrader 5  
> Language: MQL5  
> Strategy type: MACD momentum / wave continuation  
> Version: 1.00

## Strategy Logic

- MACD parameters: 12 / 26 / 9.
- Confirmation: four closed histogram bars with the same sign.
- Entry: beginning of the fifth bar.
- Primary stop model: price extreme of the immediately preceding opposite-sign MACD wave.
- Alternative stop model: ATR(14) × 2.0 for controlled comparison.
- First target: 1R, closing 50% of the position.
- Final target: 2R.
- Remaining position moves to break even after TP1.
- Default sizing: 1% of equity based on the actual stop distance and broker tick value.
- Maximum one managed position per symbol and Magic Number.

## Research Design

The baseline uses the preceding opposite MACD wave as the stop model on M15. ATR-stop and H1 runs are sensitivity checks, not optimized production presets.

The included tests use M1 OHLC because complete real-tick history was unavailable in the connected MetaQuotes demo environment. They are technical research baselines and must not be interpreted as production validation.

## Current Result

The M15 wave-stop baseline failed: net profit -$1,711.25, Profit Factor 0.99, 362 trades and 83.29% relative equity drawdown.

The ATR and H1 variants produced positive net profit in some runs, but relative equity drawdown remained between 52.46% and 88.72%. None of the tested configurations is acceptable for deployment.

Next steps should include risk normalization, real-tick data, in-sample/out-of-sample separation, walk-forward analysis and parameter-stability testing.

## Files

```text
EAs/EA-037_MACD_Fifth_Element/
├── EA-037_MACD_Fifth_Element.mq5
└── README.md

Backtest/EA-037_MACD_Fifth_Element/
├── README.md
├── configs/
└── reports/
```

## Disclaimer

This EA is provided for research, development and backtesting only. Historical or simulated performance does not guarantee future results. Do not treat this EA or its results as financial advice.
