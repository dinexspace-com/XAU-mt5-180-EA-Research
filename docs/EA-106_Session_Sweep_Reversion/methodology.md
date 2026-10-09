## EA-106 — Session Sweep Reversion

### Baseline Record

* **Baseline ID:** `EA106-M1-BASELINE-001`
* **Symbol:** XAUUSD.PRO
* **Timeframe:** M1
* **Test period:** 2026-01-02 to 2026-04-01
* **Initial deposit:** $1,000
* **Modeling:** 100% real ticks
* **Net Profit:** -$142.71
* **Profit Factor:** 0.81
* **Expected Payoff:** -$0.25
* **Max Equity Drawdown:** 19.06%
* **Total Trades:** 569
* **Baseline Decision:** FAIL

### Strategy Definition

The EA constructs a high-low range from a configured session window.

* SELL: price breaks above the session high and the completed candle closes back below that high.
* BUY: price breaks below the session low and the completed candle closes back above that low.

The EA evaluates signals on a new bar and uses fixed Stop Loss and Take Profit settings, with optional Break-Even and Trailing Stop management.

### Implementation Verification

Before optimization, verify that the session-range calculation and entry window match the intended trading-session definition.

With the baseline inputs `InpSessionStartHour=0` and `InpSessionEndHour=8`, the source constructs the range from 00:00 to 08:00 and permits entry checks from hour 08 through hour 19, using the time of the previous completed candle. Confirm that these times are interpreted in the intended broker server-time zone.

### Controlled Experiment Protocol

1. Preserve the original EA source and baseline report.
2. Verify session-time logic before tuning strategy parameters.
3. Test BUY and SELL directions separately.
4. Change one major variable at a time.
5. Record the full input configuration, test period, modeling mode, trade count, net profit, Profit Factor, expected payoff, and drawdown.
6. Compare every experiment against `EA106-M1-BASELINE-001`.
7. If a configuration is selected, validate it on out-of-sample data before walk-forward and demo forward testing.

### Evaluation Rules

A higher win rate alone does not qualify as an improvement. Evaluation must consider profitability, payoff distribution, drawdown, sample size, and stability across test periods.

The baseline is not approved for live trading. Further research must demonstrate improvement without relying solely on in-sample optimization.
