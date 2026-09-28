# Research & Backtest Methodology

## 1. Purpose

This document defines the methodology used to document, backtest and research MetaTrader 5 Expert Advisors in the XAUUSD EA research repository.

The objective is to keep EA implementations, backtest evidence and research conclusions separated and traceable.

## 2. EA Version

Each EA is stored in its own directory:

```text
EAs/
└── EA-XXX_StrategyName/
    ├── EA-XXX_StrategyName.mq5
    └── README.md
```

The source code in the EA directory represents the implementation being tested.

Changes to trading logic should result in a clearly identifiable EA version or documented code change.

## 3. Backtest Documentation

Each EA has a dedicated backtest directory:

```text
Backtest/
└── EA-XXX_StrategyName/
    ├── Strategy Tester report
    └── README.md
```

The backtest README records:

* Symbol
* Timeframe
* Test period
* Initial deposit
* History quality
* EA parameters
* Net profit
* Gross profit
* Gross loss
* Profit factor
* Drawdown
* Number of trades
* Win/loss statistics
* Position holding statistics

The original Strategy Tester report should be preserved together with the summarized README.

## 4. Baseline Test

The first documented test of an EA is treated as its baseline.

A baseline must identify:

```text
EA
Symbol
Timeframe
Period
Initial Deposit
Execution parameters
Strategy parameters
Position management parameters
```

The baseline should not be overwritten when later experiments are performed.

## 5. Parameter Research

Parameter research must preserve the relationship between a test result and the exact parameters used.

A research experiment should document:

```text
Experiment ID
EA version
Test period
Parameters changed
Parameters unchanged
Result
Observation
```

Changing several parameters simultaneously should be explicitly recorded.

## 6. Result Metrics

The following metrics are recorded where available:

### Return

```text
Net Profit
Gross Profit
Gross Loss
Expected Payoff
```

### Risk

```text
Balance Drawdown
Equity Drawdown
Relative Drawdown
Recovery Factor
```

### Trade Statistics

```text
Total Trades
Profit Trades
Loss Trades
Long Trades
Short Trades
Average Profit Trade
Average Loss Trade
Largest Profit Trade
Largest Loss Trade
```

### Stability / Distribution

```text
Maximum Consecutive Wins
Maximum Consecutive Losses
Average Consecutive Wins
Average Consecutive Losses
Position Holding Time
```

## 7. Test Reproducibility

A result should only be compared with another result when the relevant test conditions are known.

At minimum, comparisons should identify:

```text
Symbol
Timeframe
Test period
Initial deposit
EA version
Relevant parameters
History quality
```

Results from different environments should not be treated as directly equivalent without documenting the environmental difference.

## 8. Out-of-Sample Testing

An in-sample or parameter-development result should not be treated as sufficient evidence of robustness.

Where parameter optimization is performed, a separate period should be reserved for out-of-sample evaluation.

The out-of-sample configuration and period must be recorded separately from the development test.

## 9. Research Interpretation

Research documents should distinguish between:

### Observed result

A numerical result directly reported by the Strategy Tester.

### Observation

A description of a pattern visible in the documented results.

### Hypothesis

A proposed explanation that has not yet been established by testing.

### Conclusion

A statement supported by the completed research evidence.

These categories should not be mixed.

## 10. EA-086_RSI_40_60 Baseline

The current documented baseline for EA-086_RSI_40_60 is:

```text
Symbol:          XAUUSD.PRO
Timeframe:       M1
Test Period:     2026.01.02 – 2026.03.31
Initial Deposit: USD 1,000
History Quality: 100% real ticks
RSI Period:      14
RSI Lower:       40
RSI Upper:       60
Lot Size:        0.01
Stop Loss:       300
Take Profit:     600
Break Even:      Enabled
Trailing Stop:   Enabled
```

The documented baseline produced:

```text
Net Profit:       -995.01 USD
Profit Factor:     0.88
Max Equity DD:     99.51%
Total Trades:      6,575
```

These values belong specifically to the documented baseline test and should not be generalized to other periods, symbols, brokers or parameter configurations.

## 11. File Traceability

For each EA:

```text
EAs/
    source implementation

Backtest/
    test evidence

Research/
    experiment records and observations

docs/
    methodology used across the repository
```

The purpose of this separation is to keep implementation, evidence, research and methodology independently traceable.
