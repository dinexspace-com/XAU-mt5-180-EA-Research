
# EA-083 — Initial Backtest

## 1. Test Configuration

| Setting | Value |
|---|---|
| Expert | EA-083_Bollinger_Mid_Reversion |
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
| Total Net Profit | -$991.84 |
| Gross Profit | $4,359.55 |
| Gross Loss | -$5,351.39 |
| Profit Factor | 0.81 |
| Expected Payoff | -$0.22 |
| Recovery Factor | -0.98 |
| Sharpe Ratio | -5.00 |
| Maximum Balance DD | 99.20% |
| Maximum Equity DD | 99.20% |
| Total Trades | 4,484 |
| Total Deals | 8,968 |
| Winning Trades | 2,418 |
| Losing Trades | 2,066 |
| Win Rate | 53.93% |
| Long Trades | 2,474 |
| Short Trades | 2,010 |
| Largest Win | $7.76 |
| Largest Loss | -$35.62 |
| Average Win | $1.80 |
| Average Loss | -$2.59 |
| Maximum Consecutive Wins | 11 |
| Maximum Consecutive Losses | 13 |

## 3. Holding Time

| Metric | Duration |
|---|---|
| Minimum | 00:00:01 |
| Maximum | 02:07:02 |
| Average | 00:02:03 |

## 4. Charts

### Balance Curve

![Balance](balance.png)

The balance curve shows a persistent decline during the test period.

### Entry Distribution

![Entries](entries.png)

Trading activity is distributed across multiple sessions.

The chart shows substantial activity during European and US trading hours.

### MFE and MAE

![MFE and MAE](mfe-mae.png)

Several losing trades experienced unusually large adverse excursions.

### Holding Time

![Holding Time](holding-time.png)

Most trades have short holding times, while a small number remain open for substantially longer.

## 5. Original Evidence

[Complete MT5 Strategy Tester Report](report.html)

The original HTML report is the authoritative source for test settings, performance metrics and transaction records.

## 6. Conclusion

BACKTEST: FAIL.

The initial $1,000 deposit was reduced by $991.84.

The strategy produced a Profit Factor of 0.81 and a maximum equity drawdown of 99.20%.

The configuration is not suitable for live deployment.

Preserve all original evidence for subsequent research.
