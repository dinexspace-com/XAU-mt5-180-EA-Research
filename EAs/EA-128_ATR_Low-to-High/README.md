# EA-128_ATR_Low-to-High

## Overview

EA-128_ATR_Low-to-High is a MetaTrader 5 Expert Advisor developed in MQL5.

The strategy attempts to identify transitions from relatively low volatility to expanding volatility using Average True Range (ATR), followed by a price breakout of a recent historical range.

Trade direction is determined by the breakout:

- Buy when the completed signal candle closes above the historical range high.
- Sell when the completed signal candle closes below the historical range low.

The EA includes fixed lot sizing, initial Stop Loss and Take Profit, optional Break Even, optional Trailing Stop, and a maximum spread filter.

## Strategy Concept

The system combines two conditions:

1. **Low-to-high volatility transition:** ATR on the preceding completed candle is low relative to a historical ATR baseline, while the latest completed ATR has expanded sufficiently.
2. **Price breakout:** The latest completed candle closes outside a range calculated from earlier candles.

Both conditions must be satisfied before an entry is submitted.

## ATR Calculation

The ATR indicator is created using:

`iATR(_Symbol, _Period, InpATRPeriod)`

The default ATR period is 14.

All ATR calculations use the current chart timeframe.

### Historical ATR Baseline

The EA calculates:

`AverageATR = mean(ATR[3], ATR[4], ..., ATR[2 + Lookback])`

With the source-code default lookback of 30, the average uses ATR shifts 3 through 32.

### Low-Volatility Condition

The preceding ATR must satisfy:

`ATR[2] < AverageATR * InpLowATRFactor`

### ATR Expansion Condition

The latest completed ATR must satisfy:

`ATR[1] >= ATR[2] * InpExpansionFactor`

Both conditions must hold.

The code uses a strict less-than comparison for the low-volatility condition and a greater-than-or-equal comparison for expansion.

## Breakout Calculation

The EA calculates the historical high and low using candles starting at shift 2.

For a configured range length `N`:

`RangeHigh = max(High[2], ..., High[N+1])`

`RangeLow = min(Low[2], ..., Low[N+1])`

The signal candle at shift 1 is excluded from the reference range.

The breakout signal uses:

`SignalClose = Close[1]`

## Buy Entry Conditions

A Buy order is submitted when:

1. Trading is permitted.
2. A new chart candle has started.
3. No matching position is already open for the symbol and Magic Number.
4. The spread is within the configured maximum.
5. ATR and range lookback parameters are valid.
6. `ATR[2] < AverageATR * InpLowATRFactor`.
7. `ATR[1] >= ATR[2] * InpExpansionFactor`.
8. `Close[1] > RangeHigh`.

## Sell Entry Conditions

A Sell order is submitted when the same trading, volatility, and execution conditions are satisfied, together with:

`Close[1] < RangeLow`

If the completed signal candle closes inside the historical range, no order is submitted.

The EA does not use EMA, RSI, MACD, or ADX as directional filters.

## Entry Timing

New entries are evaluated once per new chart candle.

ATR and breakout calculations use completed candles.

Position management is performed on every tick before the entry checks.

The EA limits matching open positions to one per symbol and Magic Number.

It does not impose a cooldown period after a trade closes.

## Position Management

The EA implements:

- Fixed lot sizing
- Initial Stop Loss
- Initial Take Profit
- Optional Break Even
- Optional Trailing Stop
- Maximum spread filter
- Broker volume normalization
- Broker minimum stop-distance adjustment for initial orders
- Position filtering by symbol and Magic Number

It does not implement martingale, grid trading, or percentage-based risk sizing.

## Default Source-Code Parameters

| Parameter | Default |
|---|---:|
| `InpLotSize` | 0.01 |
| `InpStopLoss` | 300 points |
| `InpTakeProfit` | 600 points |
| `InpMagicNumber` | 128123 |
| `InpSlippage` | 10 points |
| `InpUseBreakEven` | true |
| `InpBreakEvenTrigger` | 150 points |
| `InpBreakEvenOffset` | 0 points |
| `InpUseTrailingStop` | true |
| `InpTrailingStart` | 200 points |
| `InpTrailingDistance` | 200 points |
| `InpMaxSpread` | 30 points |
| `InpATRPeriod` | 14 |
| `InpATRLookback` | 30 |
| `InpLowATRFactor` | 0.7 |
| `InpExpansionFactor` | 1.5 |
| `InpRangeBars` | 10 |

The nominal initial Stop Loss-to-Take Profit distance ratio is 1:2.

Actual realized outcomes depend on market execution and dynamic Stop Loss management.

## Important: Tested Inputs Differ From Defaults

The supplied Strategy Tester report uses:

| Parameter | Source Default | Tested Value |
|---|---:|---:|
| Maximum Spread | 30 | 35 |
| Low ATR Factor | 0.7 | 1.2 |
| Expansion Factor | 1.5 | 1.05 |
| Range Bars | 10 | 3 |

All other listed test inputs match the supplied source defaults.

The test results must therefore be attributed to the tested parameter configuration, not to the untouched source-code defaults.

In particular, the tested low ATR factor of 1.2 permits `ATR[2]` to be above its historical average while still satisfying the code's condition.

Consequently, the tested configuration should not be described as requiring ATR to be below its historical average.

## Supplied Backtest Summary

| Metric | Result |
|---|---:|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 to 2026-04-01 |
| Initial Deposit | $1,000 |
| Net Profit | -$993.34 |
| Profit Factor | 0.75 |
| Equity Drawdown Relative | 99.38% |
| Recovery Factor | -0.93 |
| Total Trades | 2,987 |
| Win Rate | 44.22% |

## Research Status

**FAILED BACKTEST — NOT VALIDATED**

The supplied test produced severe capital loss, negative expectancy, and near-total relative equity drawdown.

The current evidence does not support live deployment or capital scaling.

A separate backtest using the exact source-code defaults is required before drawing conclusions about the default configuration.

## Repository Files

- `EA-128_ATR_Low-to-High.mq5` — canonical source filename recommended for GitHub
- `README.md` — strategy documentation

The supplied source attachment is named `EA-128_ATR_Low-to-High(1).mq5`. The repository may use the canonical filename above after renaming.

## Disclaimer

This Expert Advisor is documented for research and educational purposes.

Historical simulated results do not guarantee future trading performance.
