# Case Study: EA-125_Breakout_Momentum

## 1. Strategy Classification

EA-125_Breakout_Momentum is a price-breakout and momentum-confirmation strategy developed in MQL5 for MetaTrader 5.

The strategy combines a historical high/low breakout with RSI thresholds and MACD directional confirmation.

It evaluates entry signals once per new candle and manages open positions on every tick.

## 2. Technical Indicators

### RSI Configuration

| Parameter | Value |
|---|---:|
| RSI Period | 14 |
| Applied Price | Close |
| Buy Threshold | 55.0 |
| Sell Threshold | 45.0 |

### MACD Configuration

| Parameter | Value |
|---|---:|
| Fast EMA | 12 |
| Slow EMA | 26 |
| Signal Period | 9 |
| Applied Price | Close |

### Breakout Configuration

| Parameter | Value |
|---|---:|
| Breakout Lookback | 10 candles |
| Signal Candle | Shift 1 |
| Historical Range | Shifts 2–11 |

## 3. Entry Methodology

### Historical Range Calculation

For `N = InpBreakoutBars`:

`BreakoutHigh = max(High[2] ... High[N+1])`

`BreakoutLow = min(Low[2] ... Low[N+1])`

The signal candle is excluded from the historical breakout range.

### Buy Entry

A Buy position may be opened when:

`Close[1] > BreakoutHigh`

AND

`RSI[1] >= InpBuyRSI`

AND

`MACD_Main[1] > MACD_Signal[1]`

### Sell Entry

A Sell position may be opened when:

`Close[1] < BreakoutLow`

AND

`RSI[1] <= InpSellRSI`

AND

`MACD_Main[1] < MACD_Signal[1]`

### Additional Entry Requirements

- Trading permissions must be enabled.
- A new candle must be detected.
- No matching position may already exist for the same symbol and Magic Number.
- The spread must be within the configured limit.
- The breakout lookback must be at least two candles.
- RSI and MACD buffer reads must succeed.
- The EA must obtain the historical candle prices required for the breakout calculation.

The source code explicitly validates the indicator buffer reads but does not separately validate each historical high/low read inside the breakout loop.

## 4. Position Management

The EA uses fixed lot sizing.

Initial Stop Loss and Take Profit distances are configured in points and adjusted upward when necessary to meet the broker's minimum initial stop-distance requirement.

Optional Break Even and Trailing Stop logic may modify Stop Loss levels as price moves in the position's favor.

Position management is evaluated on every tick.

The EA does not implement martingale, grid trading, or percentage-based equity risk sizing.

## 5. Backtest Methodology

| Setting | Value |
|---|---|
| Platform | MetaTrader 5 |
| Broker Server | ACCMIntl-Real |
| MT5 Build | 6230 |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 to 2026-04-01 |
| History Quality | 100% real ticks |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| Fixed Lot | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Break Even | Enabled |
| Break Even Trigger | 150 points |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 200 points |
| Maximum Spread | 30 points |
| RSI Period | 14 |
| Buy RSI | 55.0 |
| Sell RSI | 45.0 |
| MACD | 12 / 26 / 9 |
| Breakout Lookback | 10 candles |

## 6. Performance Evaluation

| Metric | Result |
|---|---:|
| Net Profit | -$992.17 |
| Profit Factor | 0.81 |
| Equity Drawdown Relative | 99.22% |
| Recovery Factor | -1.00 |
| Total Trades | 3,707 |
| Win Rate | 44.73% |
| Expected Payoff | -$0.27 |

The Profit Factor below 1 indicates that gross losses exceeded gross profits.

Negative Expected Payoff indicates unfavorable average trade performance.

The relative equity drawdown of 99.22% indicates extreme capital risk under the tested configuration.

## 7. Research Assessment

The initial backtest failed to demonstrate a profitable strategy.

The results do not establish whether the breakout rule, RSI filter, MACD confirmation, or exit-management logic contributed positively or negatively on an individual basis.

The available evidence is insufficient to establish strategy robustness.

## 8. Validation Requirements

Additional research should include:

1. Independent evaluation of the breakout signal.
2. RSI filter contribution analysis.
3. MACD confirmation contribution analysis.
4. Breakout lookback sensitivity testing.
5. Alternative RSI threshold experiments.
6. Break Even and Trailing Stop comparisons.
7. Spread and transaction-cost sensitivity analysis.
8. Out-of-sample and forward validation.
9. Reproducible reporting of all tested configurations.

## 9. Final Classification

**Research Status: FAILED BACKTEST**

The tested configuration does not meet basic profitability or capital-preservation expectations.

The original source code, settings, and backtest results should be preserved for research transparency.

## 10. Disclaimer

This case study is provided for research and educational purposes.

Historical backtest results do not guarantee future performance. Automated trading involves substantial financial risk.
