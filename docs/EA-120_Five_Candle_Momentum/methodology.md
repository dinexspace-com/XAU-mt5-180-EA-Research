# Backtesting Methodology — EA-120_Five_Candle_Momentum

## 1. Purpose

This document defines the methodology used to test and evaluate `EA-120_Five_Candle_Momentum` in MetaTrader 5.

The purpose is to maintain consistent testing conditions, preserve experiment records, and make performance claims traceable to actual Strategy Tester reports.

## 2. Software and Data

| Item | Baseline configuration |
|---|---|
| Trading platform | MetaTrader 5 |
| Programming language | MQL5 |
| Expert Advisor | EA-120_Five_Candle_Momentum |
| Broker/server shown in report | ACCMIntl-Real |
| Tester build | 6230 |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Historical period | 2026-01-02 to 2026-04-01 |
| Tick model | 100% real ticks |
| Initial deposit | USD 1,000 |
| Account currency | USD |
| Leverage | 1:500 |

The historical test uses the symbol `XAUUSD.PRO`. Results should not be assumed to apply identically to other gold symbols or brokers.

## 3. Baseline EA Parameters

The supplied report records these input values:

| Parameter | Value |
|---|---:|
| `InpLotSize` | 0.01 |
| `InpStopLoss` | 300 |
| `InpTakeProfit` | 600 |
| `InpMagicNumber` | 120001 |
| `InpSlippage` | 10 |
| `InpUseBreakEven` | true |
| `InpBreakEvenStart` | 150 |
| `InpBreakEvenOffset` | 0 |
| `InpUseTrailingStop` | true |
| `InpTrailingStart` | 200 |
| `InpTrailingDistance` | 200 |
| `InpMaxSpread` | 30 |
| `InpSlopePeriod` | 5 |

The report records these parameters as supplied to the tester. Point-based distances depend on the symbol specification and must not be interpreted as dollar amounts without conversion.

## 4. Strategy Logic Under Test

The current source code:

1. Processes position management on incoming ticks.
2. Evaluates new entries only when a new bar is detected.
3. Checks trading permissions and existing positions.
4. Applies the maximum-spread filter.
5. Copies the configured number of recently closed closing prices.
6. Calculates a linear regression slope.
7. Opens a BUY position for a negative slope or a SELL position for a positive slope.
8. Applies initial Stop Loss and Take Profit.
9. Manages eligible open positions using break-even and trailing-stop logic.

The implementation must be distinguished from the intended strategy name. The supplied code does not explicitly check for five consecutive bullish or bearish candles.

Before testing a revised Five Candle Momentum implementation, its candle conditions and entry direction should be specified and documented.

## 5. Baseline Test Procedure

To reproduce the baseline as closely as possible:

1. Open MetaTrader 5 and load the corresponding EA source.
2. Compile the EA and verify that compilation succeeds.
3. Select `XAUUSD.PRO` in Strategy Tester.
4. Select the M1 timeframe.
5. Set the historical interval to 2026-01-02 through 2026-04-01.
6. Use the real-tick model recorded in the original report.
7. Set the initial deposit to USD 1,000 and leverage to 1:500.
8. Enter the baseline parameters listed in Section 3.
9. Run the test and save the complete Strategy Tester report.
10. Record the resulting metrics in the experiment register.

Exact reproduction may depend on historical data availability, broker symbol specifications, platform build, execution settings, and the precise source-code version used.

## 6. Performance Metrics

The following metrics should be recorded for each experiment:

- **Net profit:** Total reported profit or loss after the tester's applicable costs.
- **Profit factor:** Gross profit divided by the absolute gross loss.
- **Maximum drawdown:** Largest reported decline in balance or equity, including its absolute and relative values.
- **Win rate:** Winning trades as a proportion of total trades, using the tester's reported classification.
- **Expected payoff:** Average reported result per trade.
- **Recovery factor:** Net profit relative to maximum drawdown, as calculated by the tester.
- **Trade count:** Total number of completed trades reported by the tester.

Metrics must be copied from the original report and not silently recalculated using a different definition.

## 7. Baseline Results

The supplied report records:

| Metric | Result |
|---|---:|
| Net profit | -992.60 USD |
| Gross profit | 5,037.41 USD |
| Gross loss | -6,030.01 USD |
| Profit factor | 0.84 |
| Maximum balance drawdown | 99.28% |
| Maximum equity drawdown | 99.28% |
| Total trades | 5,012 |
| Win rate | 48.16% |
| Expected payoff | -0.20 USD |
| Sharpe ratio | -5.00 |

These results indicate that the tested configuration lost nearly all of the initial deposit. The baseline should be classified as unsuccessful.

The results do not establish the cause of the losses or demonstrate how the EA would perform in future markets.

## 8. Experimental Controls

When comparing strategy variants:

- Keep the symbol, timeframe, historical interval, initial deposit, and tick model consistent wherever possible.
- Change one primary variable at a time when investigating its effect.
- Record every modified input parameter.
- Identify the exact source-code version used for each run.
- Preserve original reports, including unsuccessful runs.
- Avoid comparing results generated under materially different testing conditions without explicitly noting the differences.

If multiple parameters are optimized together, record the optimization range and selection criteria.

## 9. Robustness and Validation

A single historical test is insufficient to establish strategy robustness.

Further validation should include:

1. Additional historical periods.
2. Testing on data not used to choose parameters.
3. Sensitivity analysis for key parameters.
4. Evaluation under relevant spread and execution assumptions.
5. Comparison of profitability and drawdown across test periods.

Any future validation results must be recorded after the tests have actually been completed.

## 10. Limitations

- Only one baseline report is available in the supplied materials.
- The report does not establish out-of-sample performance.
- The supplied code's entry conditions have not been shown to match an explicit five-consecutive-candle rule.
- The effect of individual trade-management features has not been isolated.
- Historical testing cannot guarantee future performance.

## 11. Reproducibility and File Organization

Store each test report in a dedicated experiment directory:

```text
Backtest/
└── EA-120_Five_Candle_Momentum/
    ├── README.md
    ├── Run-001/
    │   └── ReportTester-952747(1).html
    └── Run-002/
        └── Report.html
```

Keep the EA source under version control and record the source revision associated with each report.

The report filename should identify the actual saved artifact. Do not create placeholder reports that could be mistaken for completed experiments.

## 12. Research Status

**Baseline evaluation: Unsuccessful.**

The current baseline does not support a claim of profitability or readiness for live trading. Additional work should first verify the intended entry rules, then evaluate revised configurations using documented and reproducible experiments.
