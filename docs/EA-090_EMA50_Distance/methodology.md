# EA Research Methodology

## Purpose

This repository separates Expert Advisor source code, backtest results, research observations, and methodology.

The purpose is to maintain a reproducible record of each XAUUSD MT5 EA without mixing source-code facts with backtest observations or unsupported conclusions.

## Repository Structure

Each EA follows the repository structure:

```text
EAs/
└── EA-XXX_StrategyName/
    ├── EA-XXX_StrategyName.mq5
    └── README.md

Backtest/
└── EA-XXX_StrategyName/
    ├── README.md
    └── ReportTester-*.html

Research/
└── README.md

docs/
└── methodology.md
```

## EA Documentation

The EA folder documents the implementation itself.

The documentation should record:

* EA name
* Strategy concept
* Entry conditions
* Indicators
* Input parameters
* Stop Loss
* Take Profit
* Break Even
* Trailing Stop
* Position restrictions
* Execution safeguards
* Timeframe
* Magic Number

The EA README should describe what the code does rather than what the backtest proves.

## Backtest Documentation

The Backtest folder records the actual Strategy Tester configuration and results.

Each backtest record should preserve:

* Expert Advisor
* Symbol
* Timeframe
* Test period
* Initial deposit
* Leverage
* History quality
* Number of bars
* Number of ticks
* Input parameters
* Net profit
* Gross profit
* Gross loss
* Profit Factor
* Drawdown
* Trade statistics
* Consecutive results
* Holding time
* MFE / MAE statistics

The original tester report should remain stored alongside the backtest documentation.

## Research Documentation

The Research folder interprets the recorded backtest results.

Research should distinguish between:

### Direct Observations

Values directly reported by the Strategy Tester, such as:

```text
Net Profit
Profit Factor
Drawdown
Total Trades
Win Rate
Average Profit
Average Loss
Holding Time
```

### Derived Observations

Simple relationships calculated directly from reported values.

For example:

* Average loss is larger than average profit in absolute value.
* Profit Factor is below 1.
* Maximum drawdown is large relative to initial deposit.

### Unsupported Conclusions

The repository should not automatically claim:

* Future profitability
* Live-market performance
* Robustness
* Strategy superiority
* Guaranteed behavior
* Optimal parameters

unless supported by an appropriate research process.

## Interpretation Rules

A single backtest is treated as a historical simulation under a specific configuration.

Its result should therefore be described using the exact:

```text
Symbol
Timeframe
Date Range
Initial Deposit
Execution Model
Parameters
```

Changing any of these conditions creates a different test configuration.

## Parameter Recording

Parameters should be preserved exactly as tested.

For example, EA-090 records:

```text
InpLotSize          = 0.01
InpStopLoss         = 300
InpTakeProfit       = 600
InpMagicNumber      = 123090
InpMaxSpread        = 30

InpUseBreakEven     = true
InpBreakEvenTrigger = 150
InpBreakEvenOffset  = 0

InpUseTrailingStop  = true
InpTrailingStart    = 200
InpTrailingDistance = 100
InpTrailingStep     = 10

InpEMAPeriod        = 50
InpATRPeriod        = 14
InpDistanceATR      = 1.5
```

The Strategy Tester report should be considered the authoritative record of the parameters actually used for that specific test.

## Reproducibility

A backtest should be reproducible by retaining:

1. The exact EA source file.
2. The original Strategy Tester report.
3. The symbol.
4. The timeframe.
5. The test period.
6. The initial deposit.
7. The leverage.
8. The historical-data model.
9. The complete input configuration.

The repository should avoid replacing original reports with manually edited summaries.

## Versioning

When the EA logic changes materially, a new EA version or research record should be created.

Changes may include:

* Entry conditions
* Exit conditions
* Indicator parameters
* Risk management
* Position management
* Execution logic
* Timeframe
* Symbol handling

The research result of one version should not be silently attributed to another version.

## Research Principle

The repository follows a simple separation:

```text
Source Code
    ↓
Backtest
    ↓
Observed Results
    ↓
Research Interpretation
```

The source code defines what was tested.

The Strategy Tester report records what happened in that simulation.

The Research documentation describes the observations.

The methodology defines how these records are maintained.

No single backtest should be treated as proof of future trading performance.
