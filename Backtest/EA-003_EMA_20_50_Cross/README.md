# Backtest Report: EA-003TrendEMA_20_50_Cross

## 1. Summary Overview
- **EA Name:** EA-003_EMA_20_50_Cross
- **Symbol:** XAUUSD.PRO
- **Timeframe:** M1
- **Period:** 2026.01.02 - 2026.08.01
- **Initial Deposit:** $1,000.00
- **Modelling Quality:** 100% real ticks (87,255,913 ticks / 205,636 bars)
- **Leverage:** 1:500

---

## 2. Key Performance Metrics

| Metric | Value |
| :--- | :--- |
| **Total Net Profit** | $4.18 |
| **Gross Profit** | $96.73 |
| **Gross Loss** | -$92.55 |
| **Profit Factor** | 1.05 |
| **Expected Payoff** | $0.60 |
| **Recovery Factor** | 0.06 |
| **Sharpe Ratio** | 0.05 |
| **Balance Drawdown Maximal** | $37.17 (3.61%) |
| **Equity Drawdown Maximal** | $66.60 (6.38%) |
| **Total Trades** | 7 |
| **Win Rate (%)** | 57.14% |
| **Profit Trades** | 4 (57.14%) |
| **Loss Trades** | 3 (42.86%) |
| **Long Trades (Won %)** | 4 (50.00%) |
| **Short Trades (Won %)** | 3 (66.67%) |
| **Largest Profit Trade** | $60.76 |
| **Largest Loss Trade** | -$31.33 |
| **Average Profit Trade** | $24.18 |
| **Average Loss Trade** | -$30.85 |
| **Average Position Holding Time** | 5 hours 47 mins |

---

## 3. Backtest Files & Artifacts
- `report.htm`: ReportTester-953688 (ACCMIntl-Real Build 6090)
- Charts included: Balance Curve, Trades Distribution, MFE/MAE Analysis, Holding Time Correlation.

---

## 4. Observations & Notes
- **Low Trade Frequency:** Chỉ có 7 lệnh được kích hoạt trong suốt 7 tháng thử nghiệm. Cần kiểm tra lại điều kiện lọc giá/spread hoặc lọc bar trên M1.
- **Risk/Reward Efficiency:** Tỷ lệ thắng đạt 57.14% và Profit Factor dương (1.05), tuy nhiên tổng lợi nhuận còn mỏng do khối lượng mẫu giao dịch chưa đủ lớn.
