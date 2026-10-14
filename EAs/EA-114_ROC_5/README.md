# EA-114 — ROC 5

## Overview

EA-114 is a MetaTrader 5 Expert Advisor that uses the Rate of Change (ROC) indicator to identify short-term price momentum.

The strategy calculates percentage price change using the latest closed candle and the closing price five bars earlier.

## Strategy Logic

- **BUY:** ROC is greater than `+0.10%`.
- **SELL:** ROC is less than `-0.10%`.
- **No new trade:** ROC remains between or equal to the thresholds.
- Entry evaluation occurs once per new bar.
- Only one position per symbol and Magic Number is allowed.

### ROC Calculation

`ROC = (Close[1] - Close[ROC Period + 1]) / Close[ROC Period + 1] × 100`

Default ROC period: `5`

Default ROC threshold: `0.10%`

## Default Parameters

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 114001 |
| Slippage | 10 points |
| Maximum Spread | 30 points |
| ROC Period | 5 |
| ROC Threshold | 0.10% |
| Break-even | Enabled |
| Break-even Trigger | 150 points |
| Break-even Offset | 0 points |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 200 points |

## Risk Management

- Initial Stop Loss and Take Profit are submitted with market orders.
- Break-even and trailing-stop management run on ticks.
- Trading permission and spread checks are applied before entry.
- Existing positions are filtered by symbol and Magic Number.

## Baseline

- **Baseline ID:** `EA114-M1-BASELINE-001`
- **Symbol:** XAUUSD.PRO
- **Timeframe:** M1
- **Test Period:** 2026-01-02 to 2026-04-01
- **Initial Deposit:** $1,000
- **Leverage:** 1:500
- **History Quality:** 100% real ticks

## Baseline Result

**Classification: FAIL**

- Net Profit: `-$994.73`
- Profit Factor: `0.91`
- Maximum Equity Drawdown: `99.47%`
- Total Trades: `8,823`
- Win Rate: `45.31%`

The baseline shows that the current configuration is not viable. It is not approved for live trading.

## Development Status

- [x] Strategy implementation
- [x] Baseline backtest
- [x] Baseline assessment
- [ ] Signal-edge investigation
- [ ] Controlled parameter research
- [ ] Out-of-sample validation
- [ ] Walk-forward and robustness testing
- [ ] Forward testing

**Current Status:** Research required — broad optimization blocked pending entry-edge assessment.
