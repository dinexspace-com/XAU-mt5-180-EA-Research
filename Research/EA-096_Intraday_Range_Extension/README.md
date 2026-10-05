# Research - EA-096_Intraday_Range_Extension

## 1. Research Objective

The objective is to determine whether the intraday range-extension concept used by EA-096 can produce a stable and repeatable edge on XAUUSD M1.

The research starts from the supplied baseline configuration:

`EA096-M1-BASELINE-001`

---

## 2. Strategy Hypothesis

The strategy is based on the following hypothesis:

1. An intraday M1 range is established.
2. Price extends materially beyond the range.
3. The extension reaches at least a configurable ATR-based distance.
4. The extension is one-sided.
5. A reversal candle confirms rejection of the extension.
6. The EA enters in the reversal direction.

### BUY hypothesis

Price extends below the intraday low by at least `1.0 ATR`, followed by a bullish recovery candle.

Expected direction:

`BUY`

### SELL hypothesis

Price extends above the intraday high by at least `1.0 ATR`, followed by a bearish rejection candle.

Expected direction:

`SELL`

---

## 3. Baseline Configuration

| Variable           |   Baseline |
| ------------------ | ---------: |
| Symbol             | XAUUSD.PRO |
| Timeframe          |         M1 |
| ATR Period         |         14 |
| Extension ATR      |        1.0 |
| Minimum Range Bars |         30 |
| Stop Loss          | 300 points |
| Take Profit        | 600 points |
| Break-Even Trigger | 150 points |
| Trailing Start     | 200 points |
| Trailing Distance  | 100 points |
| Lot Size           |       0.01 |

---

## 4. Baseline Result

Test period:

`2026.01.02 – 2026.03.31`

Result:

* Net Profit: `+$30.80`
* Profit Factor: `1.37`
* Total Trades: `86`
* Win Rate: `53.49%`
* Maximum Equity Drawdown: `1.44%`
* Recovery Factor: `2.11`

The result is encouraging, but the number of trades is still small for a strong statistical conclusion.

---

## 5. Research Status

| Research Item            | Status       |
| ------------------------ | ------------ |
| EA implementation        | COMPLETE     |
| Baseline backtest        | COMPLETE     |
| Baseline result          | POSITIVE     |
| Larger historical sample | REQUIRED     |
| Parameter robustness     | REQUIRED     |
| Out-of-sample test       | REQUIRED     |
| Walk-forward test        | REQUIRED     |
| Forward test             | REQUIRED     |
| Production validation    | NOT COMPLETE |

---

## 6. Recommended Research Sequence

### Phase 1 — Historical Sample

First increase the test period.

Goal:

Determine whether the positive result remains when the EA is exposed to a substantially larger number of market conditions and trades.

---

### Phase 2 — Extension ATR

Test the effect of:

* `0.5 ATR`
* `0.75 ATR`
* `1.0 ATR`
* `1.25 ATR`
* `1.5 ATR`
* `2.0 ATR`

Do not optimize dozens of variables simultaneously.

The purpose is to determine whether the strategy genuinely depends on a particular extension threshold.

---

### Phase 3 — Minimum Range Bars

Test different minimum range sizes.

Example research values:

* 15
* 30
* 45
* 60
* 90

The objective is to determine whether the range definition is stable or whether the baseline value of 30 is over-specialized.

---

### Phase 4 — Entry Confirmation

Study the confirmation candle separately.

Potential variables:

* bullish/bearish body requirement
* close relative to extension candle
* candle size
* shadow size
* minimum recovery distance

Only introduce one major confirmation variable per experiment.

---

### Phase 5 — Exit Management

Evaluate separately:

* Stop Loss
* Take Profit
* Break-Even
* Trailing Stop

The entry logic should remain unchanged while studying exit management.

---

### Phase 6 — Directional Analysis

Separate BUY and SELL performance.

Compare:

* number of trades
* win rate
* average profit
* average loss
* Profit Factor
* drawdown

The supplied baseline already shows:

* Short win rate: 52.17%
* Long win rate: 55.00%

Therefore both directions should initially remain enabled.

---

### Phase 7 — Session Analysis

Study whether the edge changes by trading session.

Do not assume a session filter is beneficial until the data demonstrates it.

---

### Phase 8 — Out-of-Sample Validation

After identifying promising configurations:

1. Freeze the parameters.
2. Select unseen historical data.
3. Run the strategy without further optimization.
4. Compare against the baseline.

---

### Phase 9 — Walk-Forward / Robustness

Test whether nearby parameter values produce similar results.

A robust strategy should not depend on one extremely narrow parameter combination.

---

## 7. Research Rules

### Rule 1 — Preserve Baseline

Never modify:

`EA096-M1-BASELINE-001`

Use a new experiment ID for every meaningful variation.

### Rule 2 — One Major Variable

Change one major strategic variable at a time whenever possible.

### Rule 3 — Record Everything

Every experiment should record:

* parameter values
* test period
* symbol
* timeframe
* total trades
* net profit
* Profit Factor
* drawdown
* win rate
* average win
* average loss

### Rule 4 — Do Not Optimize for Net Profit Alone

A configuration with higher profit is not automatically better.

Evaluate profit together with:

* drawdown
* trade count
* Profit Factor
* consistency
* robustness
* out-of-sample performance

### Rule 5 — Avoid Premature Production

The current baseline is promising but has only 86 trades.

It must not be considered production-ready based on this test alone.

---

## 8. Current Research Conclusion

EA-096 produces a positive result in the supplied M1 test.

The important finding is:

`Positive result + low reported drawdown + limited trade sample`

Therefore the correct research decision is:

**CONTINUE RESEARCH**

The next priority is not aggressive optimization.

The next priority is to determine whether the observed edge survives a larger historical sample and out-of-sample validation.
