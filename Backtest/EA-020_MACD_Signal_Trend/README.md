# EA-020 — MACD Signal Trend | Backtest

## Backtest Overview

Thư mục này lưu kết quả backtest của:

**EA-020_MACD_Signal_Trend**

Backtest được thực hiện bằng MetaTrader 5 Strategy Tester trên **XAUUSD.PRO**, timeframe **M1**, sử dụng dữ liệu **100% real ticks**.

Mục tiêu của backtest là đánh giá hiệu suất thực tế của logic MACD Signal + Trend Filter trước khi tiếp tục tối ưu hoặc thay đổi chiến lược.

---

## Test Configuration

| Parameter        | Value                      |
| ---------------- | -------------------------- |
| Expert Advisor   | `EA-020_MACD_Signal_Trend` |
| Symbol           | `XAUUSD.PRO`               |
| Timeframe        | `M1`                       |
| Test Period      | `2026.01.02 – 2026.08.01`  |
| History Quality  | `100% real ticks`          |
| Initial Deposit  | `$1,000.00`                |
| Currency         | `USD`                      |
| Leverage         | `1:500`                    |
| Broker / Company | `ACCM Intl Limited`        |
| MT5 Build        | `6140`                     |
| Bars             | `205,636`                  |
| Ticks            | `87,255,913`               |

---

## EA Parameters

| Input                |    Value |
| -------------------- | -------: |
| `InpLotSize`         |   `0.01` |
| `InpStopLoss`        |    `300` |
| `InpTakeProfit`      |    `600` |
| `InpMagicNumber`     | `123456` |
| `InpSlippage`        |     `10` |
| `InpMaxSpread`       |     `30` |
| `InpBreakEven`       |   `true` |
| `InpBreakEvenPoints` |    `150` |
| `InpTrailing`        |   `true` |
| `InpTrailingPoints`  |    `200` |

---

## Main Results

| Metric           |             Result |
| ---------------- | -----------------: |
| Initial Deposit  |        `$1,000.00` |
| Total Net Profit |       **-$993.58** |
| Gross Profit     |        `$5,150.72` |
| Gross Loss       |       `-$6,144.30` |
| Profit Factor    |           **0.84** |
| Expected Payoff  | **-$0.35 / trade** |
| Recovery Factor  |          **-0.97** |
| Sharpe Ratio     |          **-5.00** |
| Total Trades     |          **2,813** |
| Total Deals      |            `5,626` |

---

## Drawdown

| Metric                    |               Result |
| ------------------------- | -------------------: |
| Balance Drawdown Absolute |            `$993.58` |
| Balance Drawdown Maximal  | `$1,023.81 (99.38%)` |
| Balance Drawdown Relative |           **99.38%** |
| Equity Drawdown Absolute  |            `$993.58` |
| Equity Drawdown Maximal   | `$1,023.81 (99.38%)` |
| Equity Drawdown Relative  |           **99.38%** |

The strategy experienced near-total account drawdown during the tested period.

---

## Trade Statistics

### Overall

| Metric               |           Result |
| -------------------- | ---------------: |
| Total Trades         |          `2,813` |
| Winning Trades       |   `833 (29.61%)` |
| Losing Trades        | `1,980 (70.39%)` |
| Average Profit Trade |          `$6.18` |
| Average Loss Trade   |         `-$3.10` |
| Largest Profit Trade |         `$40.02` |
| Largest Loss Trade   |        `-$13.80` |

### BUY vs SELL

| Direction |  Trades | Win Rate |
| --------- | ------: | -------: |
| Short     | `1,444` | `30.75%` |
| Long      | `1,369` | `28.41%` |

SELL trades performed slightly better by win rate, but neither direction achieved sufficient performance to make the overall strategy profitable.

---

## Consecutive Results

| Metric                     |                Result |
| -------------------------- | --------------------: |
| Maximum Consecutive Wins   |          `6 ($35.41)` |
| Maximum Consecutive Losses |        `16 (-$49.34)` |
| Maximal Consecutive Profit |   `$46.71 (2 trades)` |
| Maximal Consecutive Loss   | `-$49.34 (16 trades)` |
| Average Consecutive Wins   |                   `1` |
| Average Consecutive Losses |                   `3` |

The strategy experiences substantially longer losing sequences than winning sequences.

---

## Position Holding Time

| Metric  |     Result |
| ------- | ---------: |
| Minimum | `00:00:02` |
| Maximum | `03:22:53` |
| Average | `00:09:00` |

The strategy therefore behaves as a relatively high-frequency intraday system on the tested M1 timeframe.

---

## MFE / MAE Analysis

MT5 reported:

| Correlation   |    Value |
| ------------- | -------: |
| Profit vs MFE |   `0.81` |
| Profit vs MAE |   `0.75` |
| MFE vs MAE    | `0.5284` |

These statistics and the associated MFE/MAE charts are retained as research evidence for later analysis of entry quality and exit behavior.

---

## Equity / Balance Curve

The balance curve shows a clear long-term decline across the backtest.

Although temporary recovery periods exist, they do not reverse the overall negative trajectory.

The test finishes with approximately:

```text
Initial Balance : $1,000.00
Net Result      : -$993.58
Remaining       : ~$6.42
```

This is consistent with the reported **99.38% relative drawdown**.

---

## Backtest Assessment

### Result: FAIL

EA-020 in its current configuration does **not** pass the baseline backtest.

Primary evidence:

```text
Profit Factor       = 0.84       FAIL
Expected Payoff     = -$0.35     FAIL
Net Profit          = -$993.58   FAIL
Relative Drawdown   = 99.38%     FAIL
Winning Trades      = 29.61%
Losing Trades       = 70.39%
Sharpe Ratio        = -5.00      FAIL
```

The failure is supported by a substantial sample of **2,813 trades** using **100% real tick history**.

---

## Key Finding

The fixed reward/risk structure produces:

```text
Average Winner = +$6.18
Average Loser  = -$3.10
```

Average winning trades are therefore approximately twice the size of average losing trades.

However:

```text
Win Rate  = 29.61%
Loss Rate = 70.39%
```

The win rate is too low to compensate for the frequency of losing trades under this tested configuration.

The resulting Profit Factor is:

```text
0.84
```

which confirms that gross losses exceed gross profits.

---

## Research Conclusion

The baseline MACD Signal + Trend Filter configuration is **not profitable on XAUUSD.PRO M1 for the tested period**.

This backtest should therefore be treated as a **negative research result**, not discarded.

It establishes a baseline showing that the current combination of:

```text
MACD crossover
+
MACD zero-line trend filter
+
300-point SL
+
600-point TP
```

does not provide sufficient edge under the tested conditions.

### Decision

**Status: FAIL — BASELINE**

Do not use this version for live trading based on this backtest.

The result should be retained as the baseline for comparison with future modifications of EA-020.

---

## Evidence

The backtest package should retain the original MetaTrader 5 report and associated charts.

Recommended structure:

```text
Backtest/
└── EA-020_MACD_Signal_Trend/
    ├── README.md
    ├── ReportTester-953688.html
    ├── ReportTester-953688.png
    ├── ReportTester-953688-hst.png
    ├── ReportTester-953688-mfemae.png
    └── ReportTester-953688-holding.png
```

These files provide the evidence used for the metrics and conclusions documented in this README.

---

## Reproducibility

To reproduce this baseline test, use:

```text
EA:              EA-020_MACD_Signal_Trend
Symbol:          XAUUSD.PRO
Timeframe:       M1
Period:          2026.01.02 – 2026.08.01
Initial Deposit: $1,000
Leverage:        1:500
History Quality: 100% real ticks
Lot Size:        0.01
Stop Loss:       300
Take Profit:     600
Max Spread:      30
Break Even:      Enabled / 150
Trailing:        Enabled / 200
```

Results can vary if broker specifications, spread, execution conditions, tick history or symbol specifications differ.

---

## Disclaimer

This backtest is maintained for **research and educational purposes**.

Backtest results do not guarantee future trading performance and should not be interpreted as financial advice.
