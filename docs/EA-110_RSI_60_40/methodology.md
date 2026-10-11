## EA-110_RSI_60_40 Research Methodology

### Strategy Overview

EA-110_RSI_60_40 is an MT5 Expert Advisor that uses an RSI indicator with a period of 14 and threshold values of 60 and 40. The EA also implements fixed Stop Loss and Take Profit, Break-Even, Trailing Stop, a maximum-spread filter, and a one-position-per-symbol-and-Magic-Number restriction.

### Baseline Configuration

| Parameter | Value |
|---|---:|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 to 2026-04-01 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| Tick Model | 100% real ticks |
| RSI Period | 14 |
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 123465 |
| Maximum Spread | 30 points |
| Break-Even Start | 150 points |
| Break-Even Offset | 0 points |
| Trailing Start | 200 points |
| Trailing Distance | 200 points |

### Baseline Results

The supplied Strategy Tester report records:

- Net Profit: +$81.46
- Profit Factor: 1.36
- Expected Payoff: $0.40
- Recovery Factor: 2.39
- Sharpe Ratio: 32.22
- Maximum Balance Drawdown: 3.38%
- Maximum Equity Drawdown: 3.40%
- Total Trades: 205
- Winning Trades: 102 (49.76%)
- Losing Trades: 103 (50.24%)

These figures are the baseline reference for subsequent research. They do not establish future profitability or production readiness.

### Signal Implementation Audit

The current source evaluates these conditions:

- BUY: `r[2] <= 60 && r[1] > 60`
- SELL: `r[2] >= 40 && r[1] < 40`

The source obtains RSI data with `CopyBuffer(g_rsi, 0, 0, 3, r)`. Because the code uses a fixed-size array, the relationship between array indexes and bar shifts must be verified before assigning a definitive interpretation to the crossing direction.

Before optimization, document:

1. The bar shift corresponding to each array index.
2. Whether each signal relies on a forming bar or a closed bar.
3. The intended BUY and SELL crossing rules.
4. Any source-code correction and its separate test results.

A corrected implementation must be tracked as a separate version. Its results must not be merged with the original baseline.

### Evaluation Procedure

1. Preserve the original source, input values, and Strategy Tester report.
2. Verify RSI buffer indexing and signal direction.
3. Reproduce the original baseline before making changes.
4. Test one parameter group at a time.
5. Compare net profit, Profit Factor, Expected Payoff, drawdown, trade count, and long/short performance.
6. Test parameter sensitivity to identify results that depend on a narrow configuration.
7. Perform out-of-sample, walk-forward, and forward-demo validation before considering live deployment.

### Research Classification

**Current classification: PASS FOR FURTHER RESEARCH**

The baseline is profitable in the supplied historical test, with a Profit Factor of 1.36 and maximum reported equity drawdown of 3.40%. Further validation is required because the report covers only one configuration and does not establish out-of-sample or live performance.

### Documentation Requirements

For every experiment, record:

- EA version and source-code changes.
- Symbol and timeframe.
- Test period and tick model.
- Initial deposit and input parameters.
- Net profit, Profit Factor, Expected Payoff, and drawdown.
- Trade count and long/short statistics.
- Whether the result is in-sample, out-of-sample, walk-forward, or forward-demo.
- The conclusion and reason for accepting or rejecting the test.

Do not classify an EA as production-ready based on a single backtest.
