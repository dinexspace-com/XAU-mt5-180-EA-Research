# EA-091_VWAP_Deviation Backtest

## 1. Test Identification

**EA:** EA-091_VWAP_Deviation

**Platform:** MetaTrader 5 Strategy Tester

**Tester Build:** 6230

**Symbol:** XAUUSD.PRO

**Timeframe:** M1

**Test Period:** 2026.01.02 – 2026.03.31

**History Quality:** 100% real ticks

**Initial Deposit:** USD 1,000

**Leverage:** 1:500

**Currency:** USD

---

## 2. Tested Inputs

### Execution

| Parameter      |  Value |
| -------------- | -----: |
| InpLotSize     |   0.01 |
| InpStopLoss    |    300 |
| InpTakeProfit  |    600 |
| InpMagicNumber | 123091 |
| InpSlippage    |     10 |
| InpMaxSpread   |     30 |
| InpTimeframe   |     M1 |

### Break Even

| Parameter           | Value |
| ------------------- | ----: |
| InpUseBreakEven     |  true |
| InpBreakEvenTrigger |   150 |
| InpBreakEvenOffset  |     0 |

### Trailing Stop

| Parameter           | Value |
| ------------------- | ----: |
| InpUseTrailingStop  |  true |
| InpTrailingStart    |   200 |
| InpTrailingDistance |   100 |
| InpTrailingStep     |    10 |

### VWAP / ATR

| Parameter           | Value |
| ------------------- | ----: |
| InpVWAPMinBars      |    20 |
| InpATRPeriod        |    14 |
| InpVWAPDeviationATR |   1.0 |

---

## 3. Tester Results

| Metric                     |                Result |
| -------------------------- | --------------------: |
| Total Net Profit           |           -993.41 USD |
| Gross Profit               |         12,367.51 USD |
| Gross Loss                 |        -13,360.92 USD |
| Profit Factor              |                  0.93 |
| Expected Payoff            |             -0.09 USD |
| Total Trades               |                10,893 |
| Total Deals                |                21,786 |
| Profit Trades              |        5,501 (50.50%) |
| Loss Trades                |        5,392 (49.50%) |
| Short Trades               |    6,415 (50.26% won) |
| Long Trades                |    4,478 (50.85% won) |
| Maximum Balance Drawdown   | 1,006.17 USD (99.35%) |
| Maximum Equity Drawdown    | 1,007.42 USD (99.35%) |
| Balance Drawdown Absolute  |            993.41 USD |
| Equity Drawdown Absolute   |            993.41 USD |
| Sharpe Ratio               |                 -5.00 |
| Recovery Factor            |                 -0.99 |
| AHPR                       |       0.9996 (-0.04%) |
| GHPR                       |       0.9995 (-0.05%) |
| LR Correlation             |                 -0.67 |
| Z-Score                    |                  0.78 |
| Largest Profit Trade       |             33.90 USD |
| Largest Loss Trade         |            -38.88 USD |
| Average Profit Trade       |              2.25 USD |
| Average Loss Trade         |             -2.48 USD |
| Maximum Consecutive Wins   |                    16 |
| Maximum Consecutive Losses |                    16 |
| Average Consecutive Wins   |                     2 |
| Average Consecutive Losses |                     2 |
| Minimum Holding Time       |             2 seconds |
| Maximum Holding Time       |               3:31:23 |
| Average Holding Time       |                  2:20 |

## The tester report records these results for the supplied run.

## 4. Execution Observations

The report shows that trades were opened with a volume of 0.01 lots and were closed through Stop Loss, Take Profit, and Stop Loss levels modified during position management.

Example orders in the report show the EA opening positions with the comment `EA-091`, followed by exits marked with `sl` or `tp`.

The report also contains examples where the closing Stop Loss differs from the initial fixed Stop Loss distance, consistent with dynamic position management such as Break Even or Trailing Stop.

---

## 5. Backtest Interpretation

This specific test produced a negative net result:

`-993.41 USD`

from an initial deposit of:

`1,000 USD`

The reported maximum balance and equity drawdown were approximately:

`99.35%`

The Profit Factor was:

`0.93`

and the Expected Payoff was:

`-0.09 USD`.

Therefore, this supplied test should be recorded as a **negative backtest result** for the tested period and configuration.

This result describes this specific historical test only. It does not establish future performance.

---

## 6. Research Status

Status of this test:

`COMPLETED — BASELINE BACKTEST`

Purpose:

* Establish a baseline result.
* Preserve the exact tested configuration.
* Provide a reference for future EA revisions.
* Compare future versions against the same historical period.

No optimization conclusion is made from this single test.
