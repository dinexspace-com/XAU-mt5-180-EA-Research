# Research

This directory documents the research process behind the Expert Advisors developed in this repository.

The objective is to evaluate trading ideas through reproducible implementation and backtesting rather than presenting unverified performance claims.

Each strategy follows the research process:

Trading Idea → Strategy Rules → EA Implementation → Baseline Backtest → Result Analysis → PASS / FAIL → Further Research

---

## Current Research

### EA-033 — VWAP Trend

**EA-033_VWAP_Trend** investigates whether a rolling Volume Weighted Average Price (VWAP) can be used as a directional trend signal for XAUUSD.

The implemented hypothesis is:

**BUY**
- Price > VWAP
- VWAP is rising

**SELL**
- Price < VWAP
- VWAP is falling

VWAP is calculated using:

Typical Price = (High + Low + Close) / 3

VWAP = Σ(Typical Price × Tick Volume) / Σ(Tick Volume)

The initial implementation uses a rolling VWAP period of 20 bars.

---

## Baseline Backtest

| Setting | Value |
|---|---|
| EA | EA-033_VWAP_Trend |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 → 2026-04-01 |
| Initial Deposit | $1,000 |
| Lot Size | 0.01 |
| VWAP Period | 20 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Break Even | Disabled |
| Trailing Stop | Disabled |
| History Quality | 100% real ticks |

---

## Baseline Result

**Status: FAIL**

| Metric | Result |
|---|---:|
| Total Trades | 3,490 |
| Winning Trades | 1,068 (30.60%) |
| Losing Trades | 2,422 (69.40%) |
| Net Profit | -$992.07 |
| Gross Profit | $6,583.69 |
| Gross Loss | -$7,575.76 |
| Profit Factor | 0.87 |
| Expected Payoff | -$0.28 |
| Sharpe Ratio | -5.00 |
| Recovery Factor | -0.98 |
| Maximum Drawdown | 99.22% |
| Average Profit Trade | $6.16 |
| Average Loss Trade | -$3.13 |

The baseline configuration did not demonstrate positive historical expectancy during the tested period.

The result is intentionally retained as research evidence rather than discarded.

---

## Initial Observation

The average winning trade ($6.16) was approximately twice the magnitude of the average losing trade ($3.13).

However, only 30.60% of trades were profitable while 69.40% were losing trades.

The resulting Profit Factor of 0.87 and Expected Payoff of -$0.28 indicate that the tested combination of VWAP entry logic and trade configuration did not produce positive expectancy over this sample.

The balance curve also showed a persistent decline, with maximum drawdown reaching 99.22%.

---

## Research Questions

The baseline result creates several questions for further investigation:

1. Does the VWAP signal generate too many entries during non-trending market conditions?
2. Does performance vary materially by trading session?
3. Does changing the VWAP period improve signal quality?
4. Can additional trend confirmation reduce low-quality entries?
5. Are the fixed 300-point Stop Loss and 600-point Take Profit appropriate for XAUUSD volatility?
6. Does Break Even improve the result?
7. Does Trailing Stop improve the result?
8. Does the strategy perform differently on higher timeframes?
9. Is performance stable across different historical periods?

These are research questions only. No improvement is assumed until it is tested.

---

## Research Principle

The repository follows:

**Hypothesis → Code → Test → Evidence → Conclusion**

A strategy is not considered successful because it compiles, executes trades, or produces a profitable isolated backtest.

Failed tests are retained because they provide evidence about which hypotheses and configurations did not work.

Optimization must be compared against the original baseline.

---

## Result Classification

### FAIL

The tested configuration does not demonstrate acceptable performance.

Current example:

- EA: EA-033_VWAP_Trend
- Profit Factor: 0.87
- Maximum Drawdown: 99.22%
- Net Profit: -$992.07
- Result: **FAIL**

### RESEARCH

The strategy contains characteristics worth further investigation, but available evidence is insufficient for validation.

### CANDIDATE

The strategy has passed defined research tests and is ready for additional validation.

### VALIDATED

Reserved for strategies that complete the required validation process.

A profitable backtest alone is not sufficient for VALIDATED status.

---

## Repository Relationship

EAs contain the strategy implementation:

`EAs/EA-033_VWAP_Trend/`

Backtest contains the empirical Strategy Tester evidence:

`Backtest/EA-033_VWAP_Trend/`

Research contains the interpretation of those results:

`Research/README.md`

---

## Current Research Status

| EA | Strategy | Baseline | Status |
|---|---|---|---|
| EA-033 | VWAP Trend | Completed | FAIL |

EA-033 remains a research strategy.

Its baseline result establishes the reference point against which future modifications and tests can be compared.

---

## Disclaimer

This repository is intended for quantitative research, software development, and strategy testing.

Historical and backtested performance does not guarantee future results. No strategy documented here should be considered production-ready solely on the basis of historical simulation.
