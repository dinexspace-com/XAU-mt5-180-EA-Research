
# EA-082 — Technical Documentation

## 1. Project Information

Project ID: EA-082

Name: Bollinger Re-entry

Platform: MetaTrader 5

Language: MQL5

Version: 1.00

Instrument: XAUUSD

Primary timeframe: M1

Development status: Research

Baseline backtest: FAILED

## 2. Strategy Description

EA-082 implements a Bollinger Bands mean-reversion strategy.

The trading hypothesis is that price may reverse after temporarily moving outside the Bollinger Bands and returning inside them.

The current implementation uses Bollinger Bands with a period of 20 and standard deviation of 2.0.

The signal is evaluated using completed candles.

## 3. Risk Management

Initial Stop Loss: 300 points.

Initial Take Profit: 600 points.

Break Even and Trailing Stop are enabled in the baseline configuration.

The strategy uses fixed lot sizing rather than a percentage-of-equity position-sizing model.

## 4. Known Limitations

- No dedicated trend filter.
- No dedicated volatility-regime filter.
- No trading-session filter.
- Breakout Buffer is declared but unused in signal generation.
- Fixed lot size.
- Baseline results show severe capital loss.
- No documented out-of-sample validation.
- No documented forward-test results.

## 5. Development Rules

Preserve the original EA source and Strategy Tester report.

Create a separate version for every experimental change.

Document all parameter modifications.

Do not combine multiple untested changes in one experiment.

Do not overwrite baseline evidence.

## 6. Required Evidence

Before any production approval:

1. Successful compilation log.
2. Source code review.
3. Reproduced baseline backtest.
4. Execution and risk audit.
5. Controlled research results.
6. Out-of-sample testing.
7. Forward-test evidence.
8. Authorized human approval.

## 7. Current Decision

The initial backtest does not meet acceptable risk and profitability requirements.

The EA is retained for research only.

No live deployment is authorized by this documentation.
