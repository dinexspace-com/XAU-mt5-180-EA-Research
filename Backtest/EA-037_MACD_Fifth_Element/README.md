# EA-037 — MACD Fifth Element — Backtest Report

## Verdict

`BACKTEST RESULT: FAIL / RESEARCH ONLY`

No tested configuration is suitable for deployment. Positive nominal returns in several variants were accompanied by excessive drawdown and risk-compounding effects.

## Test Environment

| Item | Value |
|---|---|
| Symbol | XAUUSD |
| Period | 2026-01-02 to 2026-08-30 |
| Initial deposit | USD 10,000 |
| Model | M1 OHLC technical baseline |
| Reason real ticks were not used | Complete real-tick download was unavailable in the connected MetaQuotes demo environment |

## Results

| Experiment | Timeframe | Stop model | Net profit | Profit Factor | Equity DD | Assessment |
|---|---:|---|---:|---:|---:|---|
| Baseline | M15 | Previous opposite MACD wave | -$1,711.25 | 0.99 | 83.29% | FAIL |
| Variant A | M15 | ATR(14) × 2.0 | +$285,980.94 | 1.17 | 88.72% | FAIL — unacceptable DD / compounding distortion |
| Robustness | H1 | Previous opposite MACD wave | +$470.85 | 1.02 | 52.46% | FAIL — weak edge / excessive DD |
| Robustness | H1 | ATR(14) × 2.0 | +$4,916.80 | 1.06 | 68.34% | FAIL — excessive DD |

## Baseline Detail

- Total trades: 362.
- Win rate: 59.94%.
- Expected payoff: -$4.73.
- Balance relative drawdown: 80.94%.
- Equity relative drawdown: 83.29%.
- Sharpe ratio: -0.15.

## Interpretation

The baseline does not demonstrate positive expectancy. The sensitivity runs show that results depend strongly on stop model and timeframe, while all configurations retain unacceptable drawdown. The large ATR M15 nominal profit must not be treated as evidence of robustness because percentage-of-equity sizing magnifies both gains and losses.

## Required Follow-up

1. Cap risk and normalize exposure across stop models.
2. Repeat with complete real-tick data and realistic costs.
3. Use fixed in-sample, out-of-sample and walk-forward periods.
4. Test parameter neighborhoods rather than selecting a single best run.
5. Reject variants that violate a predefined drawdown ceiling.

## Reproduction Files

- `.ini` files contain Strategy Tester runs.
- `.set` files contain EA inputs.
- HTML files contain the original MT5 reports.
- Raw MT5 terminal/tester logs are intentionally excluded because they may expose account, network or login information.
