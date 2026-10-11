# EA-110_RSI_60_40

## 1. Overview

**EA-110_RSI_60_40** is an Expert Advisor for MetaTrader 5 that uses RSI threshold conditions at 60 and 40 to generate trading signals on XAUUSD.

The EA includes fixed Stop Loss and Take Profit, Break-Even, Trailing Stop, and a maximum-spread filter.

## 2. Strategy Parameters

| Parameter | Value |
|---|---:|
| Symbol tested | XAUUSD.PRO |
| Timeframe tested | M1 |
| RSI Period | 14 |
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 123465 |
| Maximum Spread | 30 points |
| Break-Even | Enabled |
| Break-Even Start | 150 points |
| Break-Even Offset | 0 points |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 200 points |
| Slippage | 10 points |

## 3. Entry Logic

The current source code reads RSI values using `CopyBuffer()` and evaluates the following conditions:

- **BUY:** `r[2] <= 60 && r[1] > 60`
- **SELL:** `r[2] >= 40 && r[1] < 40`

The EA evaluates entry conditions once per new bar. It will not open another position if a position with the same symbol and Magic Number is already open.

**Important implementation note:** The RSI buffer indexing and the direction of the threshold-crossing conditions must be verified. With a normal fixed-size array, `CopyBuffer()` stores the oldest copied value at the beginning of physical memory. The current conditions may therefore represent the opposite crossing direction from the conventional interpretation of an RSI 60/40 momentum strategy.

## 4. Risk and Position Management

- Fixed lot size.
- Initial Stop Loss and Take Profit.
- Break-Even adjustment after the configured profit threshold.
- Trailing Stop adjustment after the configured start threshold.
- Maximum-spread filter.
- Trading-permission checks.
- Broker stop-level validation.
- Position management restricted to the current symbol and configured Magic Number.

## 5. Baseline Backtest

| Metric | Result |
|---|---:|
| Initial Deposit | $1,000 |
| Net Profit | +$81.46 |
| Gross Profit | $308.93 |
| Gross Loss | -$227.47 |
| Profit Factor | 1.36 |
| Expected Payoff | $0.40 |
| Recovery Factor | 2.39 |
| Sharpe Ratio | 32.22 |
| Max Balance Drawdown | 3.38% |
| Max Equity Drawdown | 3.40% |
| Total Trades | 205 |
| Winning Trades | 102 (49.76%) |
| Losing Trades | 103 (50.24%) |

## 6. Current Research Status

**Status: PASS FOR FURTHER RESEARCH**

The baseline test produced positive net profit and a Profit Factor above 1, with reported maximum equity drawdown of 3.40%.

This result is preliminary. The RSI buffer indexing and signal direction should be audited before parameter optimization or further performance comparisons.

## 7. Limitations

- Only one reported test configuration is documented here.
- Out-of-sample and walk-forward validation have not been established by the supplied report.
- The reported results do not demonstrate live-trading performance.
- Results may vary with broker conditions, spread, execution, and market regime.

## 8. Disclaimer

This EA is an experimental research project. Backtest results are historical simulations and do not guarantee future performance. Do not treat the baseline result as evidence of production readiness.
