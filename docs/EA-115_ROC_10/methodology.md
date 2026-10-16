## EA-115 — ROC 10 Baseline and Research Methodology

### Strategy Definition

EA-115 uses Rate of Change (ROC) to measure the percentage change between the previous closed candle's close and the close `InpROCPeriod` bars earlier.

The EA generates a BUY signal when ROC exceeds the positive threshold and a SELL signal when ROC falls below the negative threshold.

### Baseline Identification

- **Baseline ID:** `EA115-M1-BASELINE-001`
- **Source File:** `EA-115_ROC_10.mq5`
- **Symbol:** `XAUUSD.PRO`
- **Timeframe:** M1
- **Test Period:** 2026-01-02 to 2026-04-01
- **Initial Deposit:** $1,000
- **Modelling Quality:** 100% real ticks

### Baseline Parameters

| Parameter | Baseline |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| ROC Period | 10 |
| ROC Threshold | 0.20% |
| Break-even Trigger | 150 points |
| Trailing Start | 200 points |
| Trailing Distance | 200 points |
| Maximum Spread | 30 points |

### Baseline Assessment

The baseline returned:

- Net Profit: -$991.85
- Profit Factor: 0.88
- Expected Payoff: -$0.16
- Sharpe Ratio: -5.00
- Maximum Equity Drawdown: 99.20%
- Total Trades: 6,185

**Classification: FAIL.**

The results do not support advancing this configuration to live trading. The exceptionally high drawdown is the primary risk concern.

### Research Governance

1. Preserve the original baseline and report.
2. Investigate execution and risk-management behavior before optimizing parameters.
3. Change one variable group at a time.
4. Record all test settings and results.
5. Assess candidates using profitability, drawdown, trade count, and consistency together.
6. Do not use the same data for both parameter selection and independent validation.
7. Require out-of-sample, robustness, walk-forward, and forward testing before considering live deployment.

### Acceptance Principles

A candidate must demonstrate credible profitability, controlled drawdown, and robustness across independent test conditions. A higher net profit alone is not sufficient for acceptance.

### Current Status

- Baseline: COMPLETE
- Baseline Result: FAIL
- Diagnostic Research: PENDING
- Optimization: DIAGNOSTIC RESEARCH ONLY
- Out-of-Sample Validation: NOT STARTED
- Walk-Forward Validation: NOT STARTED
- Forward Testing: NOT STARTED
- Live Trading: NOT APPROVED
