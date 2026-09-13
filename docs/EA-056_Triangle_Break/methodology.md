# EA-056 Triangle Break — Research Methodology

## 1. Purpose

This document defines the research, implementation, testing, and evaluation methodology used for:

`EA-056_Triangle_Break`

The purpose of the methodology is to ensure that the strategy is evaluated as a reproducible experiment rather than judged from isolated trades or subjective chart observations.

The workflow is:

**Trading Hypothesis → Deterministic Rules → MQL5 Implementation → MT5 Backtest → Evidence → PASS/FAIL Decision**

The baseline experiment resulted in:

**FAIL**

The failed result is retained as part of the research record.

---

## 2. Research Principle

EA-056 follows a simple-first research process.

The first version intentionally avoids unnecessary complexity.

The baseline strategy contains only the components required to test the central hypothesis:

1. Detect price contraction.
2. Define a measurable convergence zone.
3. Wait for a confirmed breakout.
4. Enter in the breakout direction.
5. Apply deterministic position management.
6. Backtest using historical tick data.
7. evaluate the resulting performance.

No strategy should be considered successful simply because its trading logic appears reasonable.

The final decision must be based on reproducible test results.

---

## 3. Research Hypothesis

The central hypothesis is:

> A period of price contraction may precede price expansion. If XAUUSD breaks out of a sufficiently compressed price range and the breakout is confirmed by a completed candle, the resulting directional movement may provide a systematic trading opportunity.

The strategy therefore attempts to identify the sequence:

**Expansion → Contraction → Breakout → Directional Movement**

EA-056 is named `Triangle Break`, but the baseline implementation does not attempt to geometrically detect a classical triangle using manually drawn trendlines.

Instead, triangle-style compression is represented by a quantitative **convergence zone**.

This makes the setup deterministic and suitable for automated testing.

---

## 4. Target Market

The baseline research targets:

| Item | Definition |
|---|---|
| Market | Gold |
| Instrument | XAUUSD |
| Platform | MetaTrader 5 |
| Implementation | MQL5 Expert Advisor |
| Trading Style | Short-term / Intraday |
| Direction | BUY and SELL |
| Primary Tested Timeframe | M1 |
| Position Sizing | Fixed Lot |

The actual broker symbol used in the baseline test was:

`XAUUSD.PRO`

---

## 5. Strategy Formalization

The original trading concept must be converted into rules that can be evaluated without discretionary human interpretation.

The baseline model divides recent price history into three functional areas:

**Older Comparison Window → Recent Convergence Window → Breakout Confirmation Candle**

The older window establishes a reference range.

The recent window determines whether price has contracted.

The latest completed candle determines whether a valid breakout occurred.

---

## 6. Recent Convergence Zone

The recent convergence zone uses:

`InpZoneBars`

Baseline value:

`10 bars`

The breakout confirmation candle is excluded from the zone calculation.

The recent zone therefore uses completed candles before the breakout candle.

The EA calculates:

`Zone High = Highest High of Recent Zone`

and:

`Zone Low = Lowest Low of Recent Zone`

The resulting range is:

`Recent Range = Zone High - Zone Low`

This produces a measurable price-compression area.

---

## 7. Comparison Window

A second group of older candles is used as the reference range.

The number of candles is controlled by:

`InpCompareBars`

Baseline value:

`10 bars`

The EA calculates:

`Older Range = Older High - Older Low`

The older range is then compared with the recent range.

---

## 8. Convergence Requirement

The baseline contraction threshold is:

`InpConvergenceRatio = 0.70`

A setup qualifies only when:

`Recent Range <= Older Range × 0.70`

Therefore, the recent range must contract to no more than 70% of the older comparison range.

This converts the general idea of market compression into a deterministic condition.

---

## 9. Zone Size Filter

Not every contracted range is accepted.

The convergence zone must also satisfy:

`Minimum Zone Size <= Recent Zone <= Maximum Zone Size`

Baseline values:

| Parameter | Value |
|---|---:|
| Minimum Zone | 30 points |
| Maximum Zone | 500 points |

The purpose is to reject convergence zones that are outside the configured size range.

---

## 10. Breakout Buffer

A breakout buffer is placed outside the convergence zone.

Baseline:

`InpBreakoutBuffer = 5 points`

The breakout levels are therefore:

`Upper Breakout = Zone High + 5 points`

`Lower Breakout = Zone Low - 5 points`

Price touching the original zone boundary alone is not sufficient to trigger an entry.

---

## 11. Breakout Confirmation Method

EA-056 uses a completed candle for breakout confirmation.

The confirmation candle is the most recently closed candle.

### BUY Condition

A BUY signal requires:

`Previous Close > Upper Breakout`

AND:

`Previous Open <= Upper Breakout`

This means the completed candle must cross the upper breakout level and close above it.

### SELL Condition

A SELL signal requires:

`Previous Close < Lower Breakout`

AND:

`Previous Open >= Lower Breakout`

This means the completed candle must cross the lower breakout level and close below it.

This method avoids using an unfinished candle as the primary entry signal.

---

## 12. Signal Evaluation Frequency

Baseline configuration:

`InpUseNewBarOnly = true`

Entry conditions are therefore evaluated once when a new bar appears.

This is consistent with the strategy because the breakout decision depends on a completed candle.

Position-management functions such as Break Even and Trailing Stop can continue operating during the life of an open position.

---

## 13. Spread Filter

Before opening a position, the EA checks the current spread.

Baseline:

`InpMaxSpread = 30 points`

The spread is calculated from the current Ask and Bid prices.

If:

`Current Spread > Maximum Allowed Spread`

the trade is rejected.

This prevents entries when the spread exceeds the configured threshold.

---

## 14. Position Sizing

The baseline experiment uses fixed position sizing.

`InpLotSize = 0.01`

The purpose of the baseline is to test the strategy logic without introducing dynamic risk-sizing behaviour.

The EA normalizes the requested lot size according to the broker's permitted volume settings.

---

## 15. Position Limit

The baseline permits:

`Maximum Positions = 1`

The EA counts positions associated with the current symbol and EA Magic Number.

The strategy therefore avoids stacking multiple EA positions under the baseline configuration.

---

## 16. Initial Stop Loss

Baseline Stop Loss:

`300 points`

For BUY:

`SL = Entry Price - 300 points`

For SELL:

`SL = Entry Price + 300 points`

The EA also respects the broker's minimum permitted stop distance.

---

## 17. Initial Take Profit

Baseline Take Profit:

`600 points`

For BUY:

`TP = Entry Price + 600 points`

For SELL:

`TP = Entry Price - 600 points`

The nominal initial reward-to-risk relationship is therefore:

`600 / 300 = 2.0`

or approximately:

`2 : 1`

before considering actual execution and subsequent position-management behaviour.

---

## 18. Break-Even Method

Break Even is enabled in the baseline.

| Parameter | Value |
|---|---:|
| Break Even | true |
| Trigger | 150 points |
| Offset | 5 points |

When the configured profit threshold is reached, the EA can move Stop Loss toward the entry price plus or minus the configured offset.

For BUY:

`Target BE SL = Entry + 5 points`

For SELL:

`Target BE SL = Entry - 5 points`

Because Break Even can close a position before the original Take Profit is reached, the realized average winning trade does not necessarily reflect the original 2:1 SL/TP relationship.

---

## 19. Trailing Stop Method

Trailing Stop is also enabled.

| Parameter | Value |
|---|---:|
| Trailing Stop | true |
| Start | 200 points |
| Distance | 150 points |
| Step | 20 points |

Trailing begins after the configured profit threshold is reached.

For BUY, the stop follows below the current Bid.

For SELL, the stop follows above the current Ask.

The stop is modified only when the new level provides sufficient improvement according to the configured trailing step.

---

## 20. Baseline Parameter Set

The baseline experiment uses:

| Parameter | Value |
|---|---:|
| InpLotSize | 0.01 |
| InpStopLoss | 300 |
| InpTakeProfit | 600 |
| InpMagicNumber | 123456 |
| InpSlippage | 10 |
| InpMaxSpread | 30 |
| InpMaxPositions | 1 |
| InpZoneBars | 10 |
| InpCompareBars | 10 |
| InpConvergenceRatio | 0.70 |
| InpMinZonePoints | 30 |
| InpMaxZonePoints | 500 |
| InpBreakoutBuffer | 5 |
| InpUseNewBarOnly | true |
| InpUseBreakEven | true |
| InpBreakEvenTrigger | 150 |
| InpBreakEvenOffset | 5 |
| InpUseTrailingStop | true |
| InpTrailingStart | 200 |
| InpTrailingDistance | 150 |
| InpTrailingStep | 20 |

These values define the baseline experiment.

Changing them creates a different experiment and the resulting performance should not be represented as the original baseline.

---

## 21. Backtest Method

The baseline strategy was tested using MetaTrader 5 Strategy Tester.

Test configuration:

| Item | Value |
|---|---|
| Expert Advisor | EA-056_Triangle_Break |
| Broker / Server | ACCMIntl-Real |
| MT5 Build | 6182 |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Period | 2026-01-02 → 2026-04-01 |
| Initial Deposit | $1,000 |
| Currency | USD |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |

The objective of this test is to evaluate the baseline implementation before introducing additional filters or optimization.

---

## 22. Evaluation Metrics

The strategy is not evaluated using Net Profit alone.

The baseline review includes:

- Total Net Profit
- Gross Profit
- Gross Loss
- Profit Factor
- Expected Payoff
- Recovery Factor
- Sharpe Ratio
- Maximum Balance Drawdown
- Maximum Equity Drawdown
- Total Trades
- Win Rate
- Average Profit Trade
- Average Loss Trade
- Long/Short performance
- Balance curve behaviour

A strategy with a high win rate can still fail if its average losses are sufficiently larger than its average wins.

EA-056 demonstrates this issue in the baseline experiment.

---

## 23. Baseline Results

The baseline test produced:

| Metric | Result |
|---|---:|
| Initial Deposit | $1,000.00 |
| Total Net Profit | -$263.23 |
| Gross Profit | $928.47 |
| Gross Loss | -$1,191.70 |
| Profit Factor | 0.78 |
| Expected Payoff | -$0.28 |
| Recovery Factor | -0.93 |
| Sharpe Ratio | -5.00 |
| Total Trades | 932 |
| Profit Trades | 494 (53.00%) |
| Loss Trades | 438 (47.00%) |
| Maximum Equity Drawdown | 27.78% |

Directional performance:

| Direction | Trades | Win Rate |
|---|---:|---:|
| BUY | 467 | 51.61% |
| SELL | 465 | 54.41% |

Trade outcome:

| Metric | Result |
|---|---:|
| Average Profit Trade | $1.88 |
| Average Loss Trade | -$2.72 |
| Largest Profit Trade | $34.29 |
| Largest Loss Trade | -$27.58 |

---

## 24. Result Interpretation

The strategy generated a winning-trade rate above 50%:

`Win Rate = 53.00%`

However:

`Average Winner = $1.88`

while:

`Average Loser = -$2.72`

Therefore, the average loss was materially larger than the average profit.

The result was:

`Profit Factor = 0.78`

`Expected Payoff = -$0.28`

`Total Net Profit = -$263.23`

This means that the baseline system did not demonstrate positive expectancy despite winning more trades than it lost.

---

## 25. Balance and Drawdown Assessment

The test began with:

`$1,000.00`

and generated:

`-$263.23`

in net profit.

The approximate ending balance was therefore:

`$736.77`

Maximum equity drawdown reached:

`27.78%`

The balance curve showed a persistent overall decline rather than a stable upward progression.

This behaviour is inconsistent with a validated profitable baseline.

---

## 26. PASS / FAIL Method

A strategy is not marked PASS simply because:

- the EA compiles;
- orders execute correctly;
- the strategy produces many trades;
- win rate exceeds 50%;
- isolated profitable trades exist;
- or the trading concept appears logically attractive.

Technical execution and trading performance are separate questions.

For the baseline to demonstrate a positive trading edge, the resulting evidence must at minimum support positive expectancy rather than contradict it.

The following baseline observations directly indicate failure:

- Net Profit < 0
- Profit Factor < 1.0
- Expected Payoff < 0
- Recovery Factor < 0
- Sharpe Ratio < 0
- Maximum Equity Drawdown = 27.78%
- Balance curve trends downward

Therefore:

**EA-056 BASELINE = FAIL**

---

## 27. Meaning of FAIL

FAIL applies only to the tested baseline experiment.

It means:

> The current implementation and parameter configuration did not demonstrate a profitable trading edge on XAUUSD.PRO M1 during the tested period.

It does **not** mean:

> Every possible Triangle Breakout strategy is invalid.

The experiment does not independently determine whether the weakness originates from:

- convergence detection;
- breakout confirmation;
- false breakouts;
- market regime;
- BUY/SELL asymmetry;
- trading session;
- Stop Loss;
- Take Profit;
- Break Even;
- Trailing Stop;
- or interactions between these components.

Those require separate controlled experiments.

---

## 28. Reproducibility

A baseline experiment should be reproducible from the repository artifacts.

Required artifacts include:

- EA source code;
- exact parameter configuration;
- symbol;
- timeframe;
- test period;
- initial deposit;
- leverage;
- original MT5 Strategy Tester report;
- visual backtest evidence;
- research interpretation.

To reproduce the baseline:

1. Open MetaTrader 5 Strategy Tester.
2. Load `EA-056_Triangle_Break`.
3. Select `XAUUSD.PRO`.
4. Select `M1`.
5. Set the test period to `2026-01-02 → 2026-04-01`.
6. Set initial deposit to `$1,000`.
7. Set leverage to `1:500`.
8. Apply the documented baseline inputs.
9. Run the test using real tick history.
10. Compare the resulting metrics with the stored Strategy Tester report.

---

## 29. Evidence Hierarchy

For EA-056, evidence should be interpreted in the following order:

**1. Original MT5 Strategy Tester HTML Report**

Primary numerical evidence.

**2. MT5 Backtest Charts / Images**

Visual evidence for balance, MFE/MAE, holding time, and trade distribution.

**3. Backtest README**

Human-readable summary of the test.

**4. Research README**

Interpretation of the experiment and research conclusion.

**5. methodology.md**

Definition of how the strategy was formalized, tested, and evaluated.

The original MT5 report remains the primary source for numerical backtest results.

---

## 30. Repository Structure

The research artifacts are organized as:

    xauusd-mt5-ea-research/
    │
    ├── EAs/
    │   └── EA-056_Triangle_Break/
    │       ├── EA-056_Triangle_Break.mq5
    │       └── README.md
    │
    ├── Backtest/
    │   └── EA-056_Triangle_Break/
    │       ├── README.md
    │       ├── ReportTester-952747.html
    │       ├── ReportTester-952747.png
    │       ├── ReportTester-952747-hst.png
    │       ├── ReportTester-952747-mfemae.png
    │       └── ReportTester-952747-holding.png
    │
    ├── Research/
    │   └── README.md
    │
    └── docs/
        └── methodology.md

---

## 31. Research Integrity

Negative results must be retained.

A failed strategy should not be removed simply because it reduces the apparent success rate of the repository.

Preserving failed experiments provides useful information:

- which hypotheses were tested;
- which implementation was used;
- which parameters were evaluated;
- what evidence was produced;
- why the experiment failed;
- and which baseline should not be repeated without a justified modification.

The objective of the repository is reproducible strategy research, not selection of only profitable-looking backtests.

---

## 32. Modification Rule

Any future modification to EA-056 should be treated as a new experimental version when it materially changes the strategy.

Examples include changes to:

- convergence definition;
- breakout confirmation;
- trend filters;
- volatility filters;
- session filters;
- Stop Loss;
- Take Profit;
- Break Even;
- Trailing Stop;
- BUY/SELL rules;
- timeframe;
- or other entry/exit logic.

The baseline result must remain unchanged.

Future results should be compared against the baseline rather than overwriting it.

---

## 33. Optimization Rule

Parameter optimization should not be used to retroactively convert the failed baseline into a successful result.

The correct sequence is:

**Baseline → Diagnose → Define Modification → Retest → Compare**

not:

**Baseline FAIL → Search many parameter combinations → Select best historical result → Declare PASS**

If optimization is performed later, the optimization process and validation dataset should be documented separately.

---

## 34. Current Methodology Decision

The baseline implementation successfully passed the technical objective of converting the Triangle / Convergence Breakout concept into deterministic MQL5 rules that can be backtested.

However, the trading hypothesis failed the baseline performance test.

Final baseline classification:

**EA-056_Triangle_Break — FAIL**

Supporting evidence:

- 932 trades
- 53.00% winning trades
- -$263.23 Total Net Profit
- 0.78 Profit Factor
- -$0.28 Expected Payoff
- -0.93 Recovery Factor
- -5.00 Sharpe Ratio
- 27.78% Maximum Equity Drawdown

The baseline is therefore preserved as a reproducible negative research result.

---

## 35. Final Research Workflow

The methodology used for EA-056 can be summarized as:

**Hypothesis**

↓

**Define deterministic trading rules**

↓

**Implement rules in MQL5**

↓

**Compile and verify technical execution**

↓

**Run MT5 real-tick baseline backtest**

↓

**Preserve original evidence**

↓

**Evaluate profitability, expectancy and drawdown**

↓

**Compare evidence against PASS/FAIL criteria**

↓

**Document result**

↓

**EA-056 Baseline: FAIL**
