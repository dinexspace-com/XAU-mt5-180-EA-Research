# Backtest

This directory contains MetaTrader 5 Strategy Tester results for the Expert Advisors (EAs) included in this repository.

Backtest data is kept separate from EA source code so that strategy implementation and testing evidence can be reviewed independently.

## Structure

```text
Backtest/
├── README.md
│
├── EA-067_Breakout_EMA_Filter/
│   ├── README.md
│   ├── reports/
│   └── images/
│
└── EA-XXX_Strategy_Name/
    ├── README.md
    ├── reports/
    └── images/
```

Each EA has its own backtest directory using exactly the same EA name as the corresponding directory under `EAs/`.

Example:

```text
EAs/
└── EA-067_Breakout_EMA_Filter/

Backtest/
└── EA-067_Breakout_EMA_Filter/
```

## Purpose

The purpose of this directory is to preserve reproducible evidence of EA performance testing.

Backtest records may include:

- MetaTrader 5 Strategy Tester reports
- Test parameters and EA inputs
- Testing period
- Symbol and timeframe
- Initial deposit and leverage
- Tick modelling quality
- Balance/equity curves
- Trade statistics
- Profit and loss statistics
- Drawdown
- Profit Factor
- Expected Payoff
- Sharpe Ratio
- Win/loss statistics
- MFE/MAE analysis
- Position holding-time analysis

## Reports

Original Strategy Tester reports should be stored under:

```text
Backtest/<EA_NAME>/reports/
```

When available, the original MT5 HTML report should be preserved rather than replacing it with manually copied statistics.

This allows the reported results, settings, orders and deals to be independently inspected.

## Images

Charts exported with the MetaTrader 5 Strategy Tester report should be stored under:

```text
Backtest/<EA_NAME>/images/
```

Typical evidence includes:

```text
balance.png
hst.png
mfemae.png
holding.png
```

Images are supporting evidence only.

The original Strategy Tester report remains the primary source for numerical backtest results.

## Test Documentation

Each EA backtest directory contains its own:

```text
README.md
```

This file documents the tests performed for that EA and should identify at minimum:

- EA name
- Symbol
- Timeframe
- Test period
- Initial deposit
- Leverage
- Lot size
- Important EA parameters
- History quality
- Total trades
- Total net profit
- Profit Factor
- Maximum drawdown
- Win rate
- Test status
- Location of the original evidence

## Reproducibility

A backtest result should not be treated as reproducible unless the repository contains enough information to identify:

1. EA version used
2. Test symbol
3. Test timeframe
4. Test date range
5. EA input parameters
6. Initial deposit
7. Leverage
8. Strategy Tester report

Broker-specific symbol names and trading conditions should also be preserved when they materially affect the test.

## Result Status

Backtest results are historical test results and are not automatically considered validated trading strategies.

A test may be classified inside the EA-specific backtest documentation as:

```text
PASS
FAIL
RESEARCH
```

Where:

- `PASS` — satisfies the predefined acceptance criteria for that test.
- `FAIL` — does not satisfy one or more acceptance criteria.
- `RESEARCH` — experimental result that has not yet received a final validation status.

A profitable backtest alone does not automatically qualify as `PASS`.

## Current Backtests

| EA | Strategy | Platform | Evidence |
|---|---|---|---|
| EA-067_Breakout_EMA_Filter | Breakout + EMA Filter | MetaTrader 5 | MT5 Strategy Tester |

## Source Code

EA source code is stored separately under:

```text
EAs/
```

For example:

```text
EAs/EA-067_Breakout_EMA_Filter/EA-067_Breakout_EMA_Filter.mq5
```

## Research

Research material and strategy-development notes are stored separately under:

```text
Research/
```

The general testing methodology for the repository is documented under:

```text
docs/methodology.md
```

## Disclaimer

Backtest results represent historical simulations under specific market data, broker conditions, parameters and Strategy Tester settings.

They do not guarantee future trading performance.
