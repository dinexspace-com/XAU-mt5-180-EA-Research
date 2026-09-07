# EA-045 — Trend Pullback Structure — Backtest

## Backtest Status

**Result: FAIL**

This backtest does not demonstrate a profitable or production-ready configuration for `EA-045_Trend_Pullback_Structure`.

The tested configuration lost approximately the entire initial account balance, produced a Profit Factor below 1.0, negative expected payoff, negative Sharpe Ratio, and approximately 99% drawdown.

This result should be retained as research evidence rather than removed or hidden.

> A failed backtest is useful evidence. It identifies a parameter/configuration set that should not be deployed without modification and further validation.

## Test Identification

| Field | Value |
|---|---|
| Expert Advisor | `EA-045_Trend_Pullback_Structure` |
| Platform | MetaTrader 5 Strategy Tester |
| Server | ACCMIntl-Real |
| MT5 Build | 6182 |
| Broker / Company | ACCM Intl Limited |
| Symbol | `XAUUSD.PRO` |
| Timeframe | `M1` |
| Test Start | `2026.01.02` |
| Test End | `2026.04.01` |
| Account Currency | USD |
| Initial Deposit | `$1,000.00` |
| Leverage | `1:500` |
| History Quality | `100% real ticks` |
| Bars | `86,539` |
| Ticks | `40,346,891` |
| Symbols | `1` |

## Tested Parameters

### Lot & Risk

| Parameter | Value |
|---|---:|
| `InpLotSize` | `0.01` |
| `InpStopLoss` | `300` |
| `InpTakeProfit` | `600` |
| `InpMaxSpread` | `35` |

### Order Management

| Parameter | Value |
|---|---:|
| `InpMagicNumber` | `123456` |
| `InpSlippage` | `10` |

### Break Even & Trailing

| Parameter | Value |
|---|---:|
| `InpUseBreakEven` | `false` |
| `InpBreakEvenTrigger` | `150` |
| `InpUseTrailing` | `false` |
| `InpTrailingStart` | `200` |
| `InpTrailingStep` | `10` |

### Indicator Parameters

| Parameter | Value |
|---|---:|
| `InpEmaFastPeriod` | `20` |
| `InpEmaSlowPeriod` | `50` |
| `InpSwingBars` | `5` |

### Important Configuration Note

Break Even and Trailing Stop were both **disabled** in this backtest.

Therefore, this test evaluates the base EMA + pullback + structure entry logic together with fixed Stop Loss and Take Profit behavior.

It does **not** validate the performance contribution of Break Even or Trailing Stop.

## Main Results

| Metric | Result |
|---|---:|
| Initial Deposit | `$1,000.00` |
| Total Net Profit | **`-$991.65`** |
| Gross Profit | `$7,196.56` |
| Gross Loss | `-$8,188.21` |
| Profit Factor | **`0.88`** |
| Expected Payoff | **`-$0.26`** |
| Recovery Factor | **`-0.99`** |
| Sharpe Ratio | **`-5.00`** |
| AHPR | `0.9994 (-0.06%)` |
| GHPR | `0.9987 (-0.13%)` |
| LR Correlation | **`-0.99`** |
| LR Standard Error | `49.38` |
| Margin Level | `107.49%` |
| Z-Score | `2.32 (97.91%)` |

The principal result is:

```text
Initial Deposit : $1,000.00
Net Profit      : -$991.65
Remaining       : approximately $8.35
```

The tested configuration therefore lost approximately:

```text
99.17% of the account
```

## Drawdown

### Balance Drawdown

| Metric | Result |
|---|---:|
| Absolute Drawdown | `$991.65` |
| Maximal Drawdown | `$1,000.15 (99.17%)` |
| Relative Drawdown | `99.17% ($1,000.15)` |

### Equity Drawdown

| Metric | Result |
|---|---:|
| Absolute Drawdown | `$991.65` |
| Maximal Drawdown | `$1,000.34 (99.17%)` |
| Relative Drawdown | `99.17% ($1,000.34)` |

### Evaluation

```text
Maximum Drawdown ≈ 99.17%
```

This level of drawdown is unacceptable for practical deployment.

Even if other statistics were stronger, a drawdown approaching total account loss would by itself prevent this configuration from passing production validation.

## Trade Statistics

| Metric | Result |
|---|---:|
| Total Trades | `3,757` |
| Total Deals | `7,514` |
| Winning Trades | `1,160 (30.88%)` |
| Losing Trades | `2,597 (69.12%)` |

### Long Trades

| Metric | Result |
|---|---:|
| Long Trades | `1,828` |
| Long Win Rate | `31.62%` |

### Short Trades

| Metric | Result |
|---|---:|
| Short Trades | `1,929` |
| Short Win Rate | `30.17%` |

The BUY and SELL sides performed similarly poorly.

```text
Long win rate  ≈ 31.62%
Short win rate ≈ 30.17%
```

There is no obvious evidence in this run that restricting the system to only one direction would by itself solve the strategy's performance problem.

## Winner / Loser Distribution

| Metric | Result |
|---|---:|
| Largest Profit Trade | `$14.66` |
| Largest Loss Trade | `-$13.98` |
| Average Profit Trade | `$6.20` |
| Average Loss Trade | `-$3.15` |

The average winning trade is substantially larger than the average losing trade:

```text
Average Win  = $6.20
Average Loss = $3.15
```

Approximate average payoff ratio:

```text
6.20 / 3.15 ≈ 1.97
```

This is consistent with the EA's intended approximate `2:1` Take Profit / Stop Loss structure.

However, the win rate is too low to make that reward/risk profile profitable under the tested conditions.

A simplified break-even estimate for a true 2:1 reward/risk system is approximately:

```text
Required win rate ≈ 33.3%
Actual win rate   = 30.88%
```

The actual win rate falls below that threshold before considering execution costs and other market effects.

This is consistent with the observed:

```text
Profit Factor = 0.88
Expected Payoff = -$0.26
```

## Consecutive Results

| Metric | Result |
|---|---:|
| Maximum Consecutive Wins | `5 ($31.53)` |
| Maximum Consecutive Losses | `17 (-$54.90)` |
| Maximal Consecutive Profit | `$31.53 (5 trades)` |
| Maximal Consecutive Loss | `-$54.90 (17 trades)` |
| Average Consecutive Wins | `1` |
| Average Consecutive Losses | `3` |

The EA experienced losing sequences substantially longer than winning sequences.

```text
Average winning streak = 1
Average losing streak  = 3

Maximum winning streak = 5
Maximum losing streak  = 17
```

This helps explain the persistent downward balance curve.

## Position Holding Time

| Metric | Result |
|---|---|
| Minimum Holding Time | `00:00:01` |
| Maximum Holding Time | `02:48:02` |
| Average Holding Time | `00:04:23` |

The strategy operates as a high-frequency intraday system on the M1 timeframe, with an average position duration of only about four minutes.

This makes performance particularly sensitive to:

- Spread
- Slippage
- Execution latency
- Broker pricing
- Tick structure
- Entry timing
- XAUUSD short-term volatility

## MFE / MAE Correlation

| Metric | Result |
|---|---:|
| Correlation (Profit, MFE) | `0.84` |
| Correlation (Profit, MAE) | `0.84` |
| Correlation (MFE, MAE) | `0.6949` |

These statistics should be treated as diagnostic data rather than evidence of profitability.

The underlying strategy remains unprofitable in this test despite the reported correlations.

## Balance Curve Analysis

The balance graph shows a persistent long-term downward trajectory.

The account begins near:

```text
$1,000
```

and progressively declines toward almost zero by the end of the test.

The decline is not caused by one isolated catastrophic trade.

Instead, the graph shows repeated cumulative losses across thousands of trades.

This is significant because it suggests the problem is structural in the tested configuration rather than being explained by a single outlier.

The approximate pattern is:

```text
$1,000
   ↓
$800
   ↓
$600
   ↓
$400
   ↓
$200
   ↓
Near $0
```

The linear-regression correlation of:

```text
LR Correlation = -0.99
```

is consistent with the strongly declining balance trajectory.

## Trade Frequency

The EA generated:

```text
3,757 trades
```

during approximately three months of M1 testing.

This represents substantial trading activity.

The high sample size is useful because the negative result is not based on only a handful of trades.

The tested configuration repeatedly failed to generate positive expectancy over a large number of trade observations.

## Entry Distribution

The Strategy Tester report includes trade-entry distributions by:

- Hour
- Weekday
- Month

Entries occur across most active trading hours.

The weekday chart shows substantial activity from Monday through Friday, with much lower activity on Sunday and no meaningful Saturday trading.

The tested date range covers:

```text
January 2026
February 2026
March 2026
```

No later months are included because the backtest ended on `2026.04.01`.

These distributions should be used later to investigate whether specific trading sessions or hours are responsible for disproportionate losses.

## Example Trade Behavior

The report confirms that both BUY and SELL signals were executed.

Examples include order comments:

```text
EMA Pullback BUY
EMA Pullback SELL
```

Positions were subsequently closed by mechanisms including:

```text
sl
tp
```

This confirms that the basic signal → entry → SL/TP execution path operated during the Strategy Tester run.

## Backtest Interpretation

### What This Test Demonstrates

This test provides evidence that:

- The EA generated both BUY and SELL trades.
- The EA executed thousands of trades.
- Fixed SL and TP logic operated during testing.
- The strategy could be tested using real-tick historical data.
- The current M1 configuration is not profitable.
- The current configuration generates excessive drawdown.
- The current configuration is unsuitable for live deployment.

### What This Test Does NOT Demonstrate

This test does not prove that:

- The strategy concept itself can never work.
- Other timeframes will produce the same result.
- Other EMA periods will produce the same result.
- Other swing settings will produce the same result.
- Break Even will improve or worsen results.
- Trailing Stop will improve or worsen results.
- Session filters will improve or worsen results.
- Alternative spread limits will improve performance.
- The EA is robust across brokers.
- The EA is production ready.

Only the tested configuration should be rejected from this evidence.

## PASS / FAIL Evaluation

### Technical Backtest Execution

| Check | Status |
|---|---|
| EA generated trades | PASS |
| BUY trades executed | PASS |
| SELL trades executed | PASS |
| SL exits observed | PASS |
| TP exits observed | PASS |
| Real-tick history used | PASS |
| Sufficient trade sample generated | PASS |

### Strategy Performance

| Check | Requirement | Result | Status |
|---|---|---|---|
| Net Profit | `> 0` | `-$991.65` | **FAIL** |
| Profit Factor | `> 1.0` | `0.88` | **FAIL** |
| Expected Payoff | `> 0` | `-$0.26` | **FAIL** |
| Recovery Factor | `> 0` | `-0.99` | **FAIL** |
| Sharpe Ratio | `> 0` | `-5.00` | **FAIL** |
| Max Drawdown | Acceptable | `99.17%` | **FAIL** |
| Equity Preservation | Required | Almost total loss | **FAIL** |

### Overall Verdict

```text
BACKTEST RESULT: FAIL
```

Reason:

```text
Net Profit      = -$991.65
Profit Factor   = 0.88
Expected Payoff = -$0.26
Sharpe Ratio    = -5.00
Max Drawdown    = 99.17%
Win Rate        = 30.88%
```

This parameter set must **not** be treated as a validated trading configuration.

## Primary Research Finding

The most important finding from this run is:

> The approximately 2:1 average winner-to-loser relationship is not sufficient to compensate for the strategy's approximately 30.88% win rate under the tested M1 configuration.

The immediate research target should therefore be improving **entry quality** rather than simply increasing the Take Profit distance.

Potential causes to investigate in later experiments include:

- Weak trend filtering
- Entries during sideways markets
- False structural breakouts
- Swing detection too sensitive for M1
- EMA 20/50 unsuitable for this timeframe
- No volatility filter
- No session filter
- No higher-timeframe confirmation
- Excessive trade frequency

These are research hypotheses only and must be tested individually rather than assumed.

## Baseline Configuration

This backtest should be retained as the **baseline** for future EA-045 experiments.

```text
Baseline ID:
EA045-M1-BASELINE-001
```

Baseline configuration:

```text
Symbol        = XAUUSD.PRO
Timeframe     = M1
Period        = 2026.01.02 - 2026.04.01
Lot           = 0.01
SL            = 300
TP            = 600
Max Spread    = 35
EMA Fast      = 20
EMA Slow      = 50
Swing Bars    = 5
Break Even    = OFF
Trailing Stop = OFF
```

Baseline output:

```text
Trades        = 3,757
Win Rate      = 30.88%
Net Profit    = -$991.65
Profit Factor = 0.88
Max DD        = 99.17%
Sharpe        = -5.00
```

All future modifications should be compared against this baseline using controlled tests.

## Research Rule

Future optimization should change a limited number of variables at a time.

Recommended experimental principle:

```text
Baseline
   ↓
Change ONE major hypothesis
   ↓
Backtest
   ↓
Compare against baseline
   ↓
PASS / FAIL
   ↓
Keep or reject change
```

Avoid optimizing many parameters simultaneously before identifying which modification actually improves the strategy.

## Files

The backtest evidence for this run consists of the MetaTrader 5 Strategy Tester HTML report and its generated charts.

Recommended repository structure:

```text
Backtest/
└── EA-045_Trend_Pullback_Structure/
    ├── README.md
    ├── ReportTester-952747.html
    ├── ReportTester-952747.png
    ├── ReportTester-952747-hst.png
    ├── ReportTester-952747-mfemae.png
    └── ReportTester-952747-holding.png
```

### Report Files

`ReportTester-952747.html`

Full MetaTrader 5 Strategy Tester report containing:

- Test settings
- Input parameters
- Performance metrics
- Orders
- Deals
- Trade statistics
- Drawdown statistics
- MFE / MAE statistics
- Holding-time statistics

`ReportTester-952747.png`

Balance curve.

`ReportTester-952747-hst.png`

Trade distribution and profit/loss statistics by:

- Hour
- Weekday
- Month

`ReportTester-952747-mfemae.png`

MFE / MAE versus profit analysis.

`ReportTester-952747-holding.png`

Position holding-time distribution.

## Validation Record

```text
EA                    : EA-045_Trend_Pullback_Structure
Backtest ID           : EA045-M1-BASELINE-001
Symbol                : XAUUSD.PRO
Timeframe             : M1
Period                : 2026.01.02 - 2026.04.01
History Quality       : 100% real ticks
Trades                : 3,757
Net Profit            : -$991.65
Profit Factor         : 0.88
Max Drawdown          : 99.17%
Performance Validation: FAIL
Production Ready      : NO
```

## Conclusion

`EA-045_Trend_Pullback_Structure` successfully executed its basic trading logic during the MT5 Strategy Tester run, generating 3,757 BUY and SELL trades on XAUUSD.PRO M1 using 100% real-tick history.

However, the tested configuration produced:

```text
-$991.65 net profit
0.88 Profit Factor
30.88% win rate
-5.00 Sharpe Ratio
99.17% maximum drawdown
```

The balance curve shows persistent deterioration across the test period and ends with almost the entire initial deposit lost.

Therefore:

```text
Technical execution : PASS
Trading performance : FAIL
Live deployment      : REJECTED
Research value       : VALID BASELINE
```

The result should be preserved as the baseline failed experiment for subsequent controlled improvements to EA-045.
