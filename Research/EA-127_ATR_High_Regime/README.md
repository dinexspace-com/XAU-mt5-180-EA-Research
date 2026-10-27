# EA-127_ATR_High_Regime — Research

## Research Objective

Evaluate whether trading in the direction of an EMA-defined trend during elevated ATR conditions can generate positive expectancy in XAUUSD M1 trading.

## Research Hypothesis

Market periods with unusually high volatility may offer stronger directional opportunities than normal-volatility periods.

By requiring recent ATR to exceed a historical ATR baseline, the EA attempts to identify these conditions.

EMA 20 and EMA 50 are then used to determine the direction of each trade.

The hypothesis is that the combination of high volatility and trend direction can produce favorable trade outcomes.

## Strategy Architecture

### Volatility Regime Filter

The EA calculates:

`CurrentATR = ATR_M1[1]`

`AverageATR = mean(ATR_M1[2], ..., ATR_M1[51])`

A qualifying regime exists when:

`CurrentATR >= 1.3 * AverageATR`

The ATR baseline is calculated from 50 historical completed values.

### Trend Direction

The EA reads EMA values at shift 1.

- Buy direction: `EMA20[1] > EMA50[1]`
- Sell direction: `EMA20[1] < EMA50[1]`
- No direction: EMA values are equal

Unlike an EMA crossover strategy, the EA does not require the EMAs to cross during the current signal period.

### Entry Frequency

Signals are evaluated once per new chart candle.

The EA prevents a new entry while a position with the same symbol and Magic Number is open.

However, the volatility condition may remain valid across many consecutive candles.

Consequently, repeated trades are possible within the same high-volatility regime.

## Initial Research Results

| Metric | Result |
|---|---:|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 to 2026-04-01 |
| Initial Deposit | $1,000 |
| Total Trades | 6,698 |
| Winning Trades | 3,092 |
| Win Rate | 46.16% |
| Net Profit | -$904.38 |
| Profit Factor | 0.90 |
| Expected Payoff | -$0.14 |
| Equity Drawdown Relative | 92.25% |
| Recovery Factor | -0.98 |

## Key Research Findings

### 1. The Tested Strategy Was Unprofitable

Gross losses exceeded gross profits.

The Profit Factor of 0.90 does not support a positive-expectancy conclusion.

### 2. Drawdown Was Severe

The maximum relative equity drawdown reached 92.25%.

This indicates that the tested strategy exposed the initial capital to very substantial losses.

### 3. Trade Frequency Was High

The EA completed 6,698 trades.

The combination of persistent regime conditions and one-entry-per-new-bar logic may contribute to frequent trading.

This is a code-based mechanism, not proof that trade frequency caused the observed losses.

### 4. Short Trades Were More Frequent

The report recorded:

- 4,437 short trades
- 2,261 long trades

Short trades had a lower winning percentage than long trades.

Separate directional profitability requires additional analysis.

### 5. Average Holding Time Was Short

The average holding time was 1 minute and 16 seconds.

This suggests that the strategy's results may be sensitive to execution conditions and the behavior of its Break Even and Trailing Stop rules.

That sensitivity has not been quantified in the supplied materials.

## Research Limitations

- Only one parameter configuration is supplied.
- The test covers approximately three months.
- No independent out-of-sample results are supplied.
- No EA-127 live-trading results are supplied.
- No parameter sensitivity analysis is supplied.
- No separate long/short net-profit analysis is supplied.
- No controlled comparison against a strategy without the ATR filter is supplied.
- No Break Even or Trailing Stop ablation tests are supplied.
- No transaction-cost sensitivity study is supplied.
- No analysis by trading session or volatility regime is supplied.

## Proposed Research Experiments

### Experiment A — ATR Threshold Sensitivity

Compare high-volatility factors such as:

- 1.1
- 1.3
- 1.5
- 2.0

Evaluate trade count, Profit Factor, drawdown, and out-of-sample performance.

### Experiment B — ATR Baseline Sensitivity

Compare different ATR lookback lengths, including 20, 50, and 100.

Determine whether regime classification remains stable across different baseline lengths.

### Experiment C — EMA Configuration

Compare EMA pairs such as 10/30, 20/50, and 50/100.

Evaluate whether the direction filter contributes measurable predictive value.

### Experiment D — Regime Entry Control

Compare the existing repeated-entry behavior against:

- One entry per qualifying regime
- Entry only when ATR first crosses above its threshold
- A cooldown after a closed trade

These experiments would require source-code changes.

### Experiment E — Exit Management

Compare:

- Initial SL/TP only
- SL/TP with Break Even
- SL/TP with Trailing Stop
- SL/TP with both Break Even and Trailing Stop

The purpose is to isolate the contribution of each exit-management component.

### Experiment F — Robustness

Perform:

- Out-of-sample testing
- Walk-forward testing
- Spread sensitivity testing
- Slippage sensitivity testing
- Trading-session analysis
- Forward testing under documented conditions

These are proposed research activities, not validated improvements.

## Research Conclusion

**Status: FAILED BACKTEST — Further Research Required**

The high-ATR regime hypothesis was not validated by the supplied test.

The strategy produced negative expectancy and severe drawdown despite completing 6,698 trades.

The EA should remain a research experiment until independently validated improvements demonstrate acceptable profitability and risk.

## Research Artifacts

- `EAs/EA-127_ATR_High_Regime/EA-127_ATR_High_Regime.mq5`
- `EAs/EA-127_ATR_High_Regime/README.md`
- `Backtest/EA-127_ATR_High_Regime/README.md`
- `Backtest/EA-127_ATR_High_Regime/ReportTester-952747(20261027-070125).html`
