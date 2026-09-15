# Backtest — EA-061 ATR Expansion Break

## Test Overview

This directory contains the MetaTrader 5 Strategy Tester results for **EA-061_ATR_Expansion_Break**.

The purpose of this backtest is to evaluate the baseline implementation of the ATR Expansion Break strategy on XAUUSD before further research or optimization.

This result represents a baseline test and should not be interpreted as evidence that the strategy is suitable for live trading.

---

## Test Environment

| Parameter | Value |
|---|---|
| Expert Advisor | EA-061_ATR_Expansion_Break |
| Platform | MetaTrader 5 |
| Broker / Server | ACCMIntl-Real |
| MT5 Build | 6182 |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 → 2026-03-31 |
| Initial Deposit | $100.00 |
| Currency | USD |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 85,161 |
| Ticks | 39,639,179 |

---

## EA Parameters

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 123061 |
| Slippage | 10 points |
| Max Spread | 30 points |
| Timeframe | M1 |
| Breakout Lookback | 20 |
| Breakout Buffer | 0 |
| ATR Period | 14 |
| ATR Multiplier | 1.5 |
| Break Even | Enabled |
| Break Even Trigger | 150 points |
| Break Even Offset | 0 |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 100 points |
| Trailing Step | 10 points |

---

## Main Results

| Metric | Result |
|---|---:|
| Initial Deposit | $100.00 |
| Total Net Profit | **-$92.25** |
| Gross Profit | $504.43 |
| Gross Loss | -$596.68 |
| Profit Factor | **0.85** |
| Expected Payoff | -$0.19 |
| Recovery Factor | -0.83 |
| Sharpe Ratio | -5.00 |
| Total Trades | 494 |
| Total Deals | 988 |
| Winning Trades | 240 (48.58%) |
| Losing Trades | 254 (51.42%) |

The baseline configuration produced a negative total net result.

---

## Drawdown

| Metric | Result |
|---|---:|
| Balance Drawdown Absolute | $92.25 |
| Balance Drawdown Maximal | $110.68 (93.46%) |
| Balance Drawdown Relative | 93.46% |
| Equity Drawdown Absolute | $92.25 |
| Equity Drawdown Maximal | $111.75 (93.51%) |
| Equity Drawdown Relative | **93.51%** |

The observed drawdown is extremely high relative to the initial $100 account balance.

This configuration therefore does not satisfy a reasonable capital-preservation requirement.

---

## Trade Statistics

### Long / Short

| Direction | Trades | Win Rate |
|---|---:|---:|
| Long | 221 | 50.68% |
| Short | 273 | 46.89% |

### Winning / Losing Trades

| Metric | Result |
|---|---:|
| Largest Profit Trade | $11.85 |
| Largest Loss Trade | -$5.34 |
| Average Profit Trade | $2.10 |
| Average Loss Trade | -$2.35 |
| Maximum Consecutive Wins | 8 |
| Maximum Consecutive Losses | 7 |
| Maximum Consecutive Profit | $16.27 |
| Maximum Consecutive Loss | -$23.60 |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 2 |

The win rate is close to 50%, but the average losing trade (-$2.35) is larger than the average winning trade ($2.10).

This combination results in a Profit Factor below 1.0.

---

## Position Holding Time

| Metric | Result |
|---|---|
| Minimum Holding Time | 00:00:02 |
| Maximum Holding Time | 02:08:02 |
| Average Holding Time | 00:04:01 |

The EA therefore behaves as a short-duration trading system under this test configuration.

---

## MFE / MAE Statistics

| Correlation | Result |
|---|---:|
| Profit vs MFE | 0.96 |
| Profit vs MAE | 0.72 |
| MFE vs MAE | 0.6087 |

These statistics are retained as research evidence for later analysis of trade exits, stop placement and profit capture.

---

## Equity / Balance Observation

The balance curve is not stable.

Although the strategy experienced profitable periods during the test, the account subsequently entered a prolonged decline and finished close to depletion of the original $100 deposit.

Combined with:

- Total Net Profit: -$92.25
- Profit Factor: 0.85
- Equity Drawdown: 93.51%
- Expected Payoff: -$0.19
- Sharpe Ratio: -5.00

the baseline configuration does not demonstrate a statistically or financially acceptable trading result.

---

## Baseline Assessment

### Result: FAIL

The current baseline configuration is **not suitable for live trading**.

Primary failure conditions:

1. Total Net Profit is negative.
2. Profit Factor is below 1.0.
3. Expected Payoff is negative.
4. Maximum drawdown exceeds 90%.
5. The balance curve deteriorates substantially during the test.
6. The strategy does not demonstrate sufficient positive expectancy under the tested configuration.

This FAIL result does **not** mean the ATR Expansion Break concept itself is invalid.

It means that this specific implementation and parameter configuration did not produce acceptable results for:

**XAUUSD.PRO / M1 / 2026-01-02 → 2026-03-31**

Further research must be performed separately rather than modifying or hiding this baseline result.

---

## Backtest Evidence

This directory preserves the original MT5 Strategy Tester evidence.

```text
EA-061_ATR_Expansion_Break/
├── README.md
├── ReportTester-952747(20260915-021124).html
├── ReportTester-952747(20260915-021125).png
├── ReportTester-952747-hst(20260915-021123).png
├── ReportTester-952747-mfemae(20260915-021124).png
└── ReportTester-952747-holding(20260915-021124).png
```

The HTML report is the primary backtest evidence.

The PNG files preserve the Strategy Tester visual outputs, including:

- Balance curve
- Entry distribution
- Profit/loss distribution
- MFE/MAE analysis
- Position holding-time analysis

---

## Reproducibility

The backtest should be reproducible using the EA source located at:

```text
EAs/EA-061_ATR_Expansion_Break/EA-061_ATR_Expansion_Break.mq5
```

with the parameters documented above.

Broker-specific symbol properties, spread, tick data, execution rules and historical data may cause results to differ when reproduced in another environment.

---

## Research Status

**Baseline Backtest: FAIL**

**Optimization: Not evaluated in this report**

**Forward Test: Not evaluated in this report**

**Live Trading Approval: NO**

The baseline result is retained as research evidence and as the reference point for subsequent iterations.
