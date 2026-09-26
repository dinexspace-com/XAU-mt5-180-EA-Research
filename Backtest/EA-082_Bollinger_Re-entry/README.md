
# EA-082 — Initial Backtest

## 1. Test Configuration

| Setting | Value |
|---|---|
| Expert | EA-082_Bollinger_Re-entry |
| Platform | MetaTrader 5 |
| Broker Server | ACCMIntl-Real |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Period | 2026-01-02 to 2026-03-31 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| Lot Size | 0.01 |
| Modeling | Every tick based on real ticks |
| History Quality | 100% real ticks |
| Bars | 85,161 |
| Ticks | 39,639,179 |

## 2. Performance

| Metric | Result |
|---|---:|
| Total Net Profit | -$994.17 |
| Gross Profit | $7,206.59 |
| Gross Loss | -$8,200.76 |
| Profit Factor | 0.88 |
| Expected Payoff | -$0.15 |
| Recovery Factor | -0.98 |
| Sharpe Ratio | -5.00 |
| Maximum Balance DD | 99.43% |
| Maximum Equity DD | 99.43% |
| Total Trades | 6,504 |
| Winning Trades | 3,238 |
| Losing Trades | 3,266 |
| Win Rate | 49.78% |
| Long Trades | 3,527 |
| Short Trades | 2,977 |
| Largest Win | $9.25 |
| Largest Loss | -$33.31 |
| Average Win | $2.23 |
| Average Loss | -$2.51 |
| Maximum Consecutive Losses | 16 |

## 3. Holding Time

| Metric | Duration |
|---|---|
| Minimum | 00:00:01 |
| Maximum | 03:36:03 |
| Average | 00:02:24 |

## 4. Charts

### Balance Curve

![Balance](balance.png)

The balance curve shows a persistent decline throughout the test.

### Entry Distribution

![Entries](entries.png)

Trading activity occurs across multiple sessions, with substantial activity during European and US trading hours.

### MFE and MAE

![MFE and MAE](mfe-mae.png)

Several losing trades experienced unusually large adverse excursions.

### Holding Time

![Holding Time](holding-time.png)

Most trades have short holding times, with a small number of unusually long positions.

## 5. Original Evidence

[Complete MT5 Strategy Tester Report](report.html)

The original HTML report is the authoritative source for the test settings, metrics and transaction history.

## 6. Conclusion

BACKTEST: FAIL

The initial $1,000 deposit was reduced by $994.17.

The strategy produced a Profit Factor below 1.0 and a maximum equity drawdown of 99.43%.

This configuration must not be considered production-ready.

Preserve the original report and charts for subsequent controlled research.
