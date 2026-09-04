# EA-042 — Three-Bar Continuation
## Research Notes

## Research Status

**Status: BASELINE FAILED — FURTHER RESEARCH REQUIRED**

EA-042 is an experimental XAUUSD continuation strategy based on a simple three-bar directional closing pattern.

The first baseline backtest demonstrated that the current implementation does not contain sufficient filtering to produce a viable standalone trading system.

The purpose of this research stage is to identify why the baseline failed and define the next hypotheses that should be tested.

---

## 1. Original Hypothesis

The original EA assumes that three consecutive closes in the same direction indicate short-term momentum that is likely to continue.

### Bullish Condition

    Close[1] > Close[2] > Close[3]

### Bearish Condition

    Close[1] < Close[2] < Close[3]

The hypothesis is:

> Consecutive directional closes represent momentum, and entering in the same direction may capture continuation of that momentum.

This is intentionally a minimal implementation designed to test whether the raw three-bar signal contains standalone predictive value.

---

## 2. Baseline Test

The initial test was performed using the following configuration:

| Setting | Value |
|---|---|
| Instrument | XAUUSD.PRO |
| Timeframe | M1 |
| Period | 2026-01-02 → 2026-04-01 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Maximum Spread | 35 points |
| Maximum Positions | 1 |
| Break Even | Disabled |
| Trailing Stop | Disabled |
| Data Quality | 100% real ticks |

### Baseline Performance

| Metric | Result |
|---|---:|
| Total Net Profit | -$992.09 |
| Gross Profit | $11,590.64 |
| Gross Loss | -$12,582.73 |
| Profit Factor | 0.92 |
| Expected Payoff | -$0.17 |
| Recovery Factor | -0.91 |
| Sharpe Ratio | -5.00 |
| Maximum Drawdown | 99.28% |
| Total Trades | 5,815 |
| Winning Trades | 1,862 (32.02%) |
| Losing Trades | 3,953 (67.98%) |

### Baseline Conclusion

**FAIL**

The raw three-close continuation signal does not provide an acceptable standalone trading system under the tested configuration.

---

## 3. Main Finding

The primary research finding is:

> Three consecutive directional closes alone are not sufficient to distinguish meaningful momentum from market noise under the tested conditions.

The EA currently treats all valid three-close sequences equally.

It does not determine whether the pattern occurs:

- inside an established trend,
- during consolidation,
- after an impulse,
- after a pullback,
- during high or low volatility,
- during an active or inactive trading session,
- or near a meaningful price structure.

The baseline generated 5,815 trades over the tested period.

This indicates that the raw pattern occurs frequently on XAUUSD M1 and requires further research into market context and signal quality.

---

## 4. Current Strategy Structure

The current implementation can be summarized as:

    Three directional closes
              ↓
       Immediate Entry

The current Three-Bar condition should therefore be treated as a candidate momentum signal rather than assuming that it already represents a complete continuation strategy.

A more structured continuation hypothesis could take the form:

    Market Context
          ↓
       Impulse
          ↓
    Pause / Pullback
          ↓
    Continuation Signal
          ↓
        Entry

These additional components are research hypotheses only.

They must not be assumed to improve performance until independently tested.

---

## 5. Research Hypotheses

The next research stage should test modifications individually rather than adding many conditions simultaneously.

The objective is to determine which modification, if any, produces measurable improvement relative to the baseline.

### H1 — Trend Filter

Hypothesis:

> Three-Bar signals may perform better when they occur in the direction of the prevailing trend.

Possible structure:

    BUY:
    Three-Bar bullish signal
    +
    bullish trend condition

    SELL:
    Three-Bar bearish signal
    +
    bearish trend condition

Candidate trend measurements may include:

- EMA
- higher-timeframe direction
- higher-high / higher-low market structure

Only one trend-filter implementation should be introduced in the first experiment.

---

### H2 — Impulse Strength Filter

Not every sequence of three directional closes represents meaningful momentum.

Hypothesis:

> Continuation expectancy may improve if weak three-bar movements are rejected.

Candidate measurements include:

- candle body size,
- total three-bar range,
- ATR-relative movement,
- range expansion.

The purpose is to distinguish stronger directional movement from ordinary M1 price noise.

---

### H3 — Pullback / Pause Structure

The baseline enters immediately after detecting three directional closes.

An alternative hypothesis is:

> Waiting for a pause or pullback before continuation confirmation may improve entry quality.

Possible structure:

    Momentum Impulse
          ↓
    Pullback / Pause
          ↓
    Continuation Confirmation
          ↓
         Entry

This represents a larger modification to the original entry model and should not be mixed into the first trend-filter experiment.

---

### H4 — Session Filter

The existing backtest shows that trades occur throughout multiple hours of the trading day.

Hypothesis:

> The expectancy of Three-Bar signals may vary by trading hour or trading session.

Future analysis can separate performance into:

- Asian session
- London session
- New York session
- London / New York overlap

The objective is to measure session performance rather than assume beforehand that a particular session is superior.

---

### H5 — Volatility Filter

XAUUSD M1 can operate under substantially different volatility conditions.

Hypothesis:

> Three-Bar signals may have different expectancy across volatility regimes.

A candidate measurement is ATR.

A possible research question is:

> Does the Three-Bar signal perform differently when current volatility is above or below its recent normal range?

Thresholds must be determined through controlled testing rather than selected solely from the most profitable historical result.

---

### H6 — Exit Logic

The baseline uses:

    Stop Loss  = 300 points
    Take Profit = 600 points

This represents a nominal risk-to-reward relationship of:

    Risk : Reward = 1 : 2

However, fixed distances do not adapt to changing XAUUSD volatility.

Future research may compare:

    Fixed SL/TP

    versus

    ATR-based SL/TP

    versus

    market-structure-based exits

Exit optimization should not be used to hide a fundamentally weak entry signal.

The entry hypothesis should first demonstrate evidence of useful expectancy.

---

## 6. Research Priorities

Research should proceed one major variable at a time.

### Experiment 01 — Baseline

Strategy:

    Three directional closes
              ↓
       Immediate Entry

Result:

**FAIL**

This experiment is preserved as the control baseline.

---

### Experiment 02 — Trend Filter

Test:

    Baseline
       +
    One Trend Filter

Objective:

Determine whether trading only in the direction of the prevailing trend improves performance relative to Experiment 01.

Compare:

- Total Net Profit
- Profit Factor
- Expected Payoff
- Maximum Drawdown
- Sharpe Ratio
- Win Rate
- Number of Trades

No other major entry modification should be introduced during this experiment.

---

### Experiment 03 — Momentum / Volatility Filter

After Experiment 02 has been evaluated, test whether rejecting weak Three-Bar movements improves signal quality.

The new result must again be compared with the baseline and previous experiment.

---

### Experiment 04 — Session Filter

Analyze expectancy by trading hour and session.

Determine whether specific time periods materially improve or degrade the strategy.

A session restriction should only be introduced if the test results support it.

---

### Experiment 05 — Pullback Confirmation

Test whether changing the structure from immediate continuation entry to:

    Impulse
       ↓
    Pullback
       ↓
    Confirmation
       ↓
    Entry

improves performance.

Because this materially changes the entry model, it should be treated as a separate experiment rather than a minor parameter adjustment.

---

## 7. Research Rules

To reduce overfitting and preserve reproducibility:

1. Preserve the original baseline.
2. Never overwrite failed backtest evidence.
3. Change one major strategy variable at a time.
4. Record the exact EA version and parameters used for every experiment.
5. Compare every new experiment against the baseline.
6. Record both successful and failed experiments.
7. Do not select parameters solely because they maximize historical profit.
8. Do not declare an EA successful from a single backtest period.
9. Keep development and later validation data logically separated.
10. Include spread and execution conditions in strategy evaluation.
11. Treat optimization results as research candidates rather than proof of robustness.
12. Do not proceed to live trading until the strategy passes subsequent validation stages.

---

## 8. Current Research Conclusion

Experiment 01 produced an important negative result.

Under the tested configuration:

    Three consecutive directional closes
                    ↓
          Immediate Entry

did not provide sufficient standalone edge for XAUUSD M1.

The baseline produced:

    Profit Factor     = 0.92
    Expected Payoff   = -$0.17
    Net Profit        = -$992.09
    Maximum Drawdown  = 99.28%
    Win Rate          = 32.02%

Therefore, EA-042 should remain in the research stage.

The next objective is not broad parameter optimization.

The next objective is to determine whether adding a single market-context condition improves the quality of the underlying signal.

The research direction is:

    Raw Three-Bar Signal
             ↓
       Market Context
             ↓
       Signal Quality
             ↓
        Entry Trigger
             ↓
       Risk Management
             ↓
         Validation

---

## 9. Next Experiment

### EA-042 Experiment 02 — Trend Filter

**Objective**

Determine whether restricting Three-Bar signals to the direction of the prevailing trend improves expectancy relative to the original baseline.

**Control**

Experiment 01 — original Three-Bar signal.

**Variable**

One trend filter only.

**Metrics**

- Net Profit
- Profit Factor
- Expected Payoff
- Maximum Drawdown
- Sharpe Ratio
- Win Rate
- Total Trades

**Current Status**

    NOT TESTED

No conclusion should be made until the modified EA has been implemented and independently backtested.

---

## Research Decision

**EA-042 Research Status: CONTINUE**

Baseline:

**FAIL**

Next action:

**Test one simple trend filter against the original baseline.**
