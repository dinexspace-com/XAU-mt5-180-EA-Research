# Case Study: EA-122_DI_Cross

## 1. Strategy Classification

EA-122_DI_Cross is a directional crossover strategy developed in MQL5 for MetaTrader 5.

The strategy combines Directional Indicator crossovers with an Exponential Moving Average trend filter.

## 2. Technical Indicators

### Directional Indicators

The strategy uses the +DI and -DI buffers from the Average Directional Index (ADX) indicator.

A bullish crossover occurs when +DI crosses above -DI.

A bearish crossover occurs when -DI crosses above +DI.

### Exponential Moving Average

The EMA is used as a directional price filter.

Buy signals require the latest closed candle's closing price to be above the EMA.

Sell signals require the latest closed candle's closing price to be below the EMA.

## 3. Entry Methodology

Trading signals are evaluated once per new candle using indicator values from completed candles.

The EA requires a valid DI crossover, EMA confirmation, acceptable spread, and no existing matching position before opening a trade.

## 4. Position Management

The EA uses fixed lot sizing.

Initial Stop Loss and Take Profit distances are configured in points and adjusted to respect the broker's minimum stop level.

Break Even and Trailing Stop functions are available to manage open positions.

The EA does not use martingale, grid trading, or percentage-based position sizing.

## 5. Backtest Methodology

| Setting | Value |
|---|---|
| Platform | MetaTrader 5 |
| Broker Server | ACCMIntl-Real |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Testing Period | 2026-01-02 to 2026-04-01 |
| Modeling Quality | 100% real ticks |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| Fixed Lot | 0.01 |
| DI Period | 14 |
| EMA Period | 20 |

## 6. Performance Evaluation

The backtest produced:

- Net Profit: -$992.57
- Profit Factor: 0.79
- Equity Drawdown Relative: 99.30%
- Recovery Factor: -0.94
- Total Trades: 3,647
- Win Rate: 45.13%

The Profit Factor below 1 indicates that gross losses exceeded gross profits.

The negative expected payoff indicates an unfavorable average trade outcome.

The extreme equity drawdown demonstrates that the tested configuration did not preserve capital.

## 7. Research Assessment

The initial backtest failed to demonstrate a profitable trading strategy.

The available results are insufficient to establish whether the failure was primarily caused by signal quality, market conditions, execution costs, or position management.

Additional controlled experiments are required to isolate these factors.

## 8. Validation Requirements

Further evaluation should include:

1. Independent out-of-sample testing.
2. DI period sensitivity analysis.
3. EMA filter effectiveness analysis.
4. Spread and execution-cost sensitivity.
5. Alternative exit-management configurations.
6. Forward testing if subsequent research justifies it.

## 9. Final Classification

**Research Status: FAILED BACKTEST**

The tested configuration does not meet basic profitability or capital-preservation expectations.

The original test results should be preserved for research transparency and reproducibility.

## 10. Disclaimer

This case study is provided for research and educational purposes.

Backtest results do not guarantee future performance. Automated trading involves substantial financial risk.
