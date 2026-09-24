# XAUUSD MT5 EA Research Methodology

## 1. Purpose

This repository documents the development, backtesting and evaluation of experimental MetaTrader 5 Expert Advisors for XAUUSD.

Each EA is maintained with its source code, strategy documentation, original backtest evidence and research findings.

## 2. Research Workflow

### Step 1 — Define the Strategy

Document:
- Market and timeframe.
- Entry and exit conditions.
- Stop loss and take profit.
- Position sizing.
- Risk-management rules.
- Research hypothesis.

### Step 2 — Implement the EA

Develop the MQL5 source code.

Review order execution, spread restrictions, margin requirements, position management and broker compatibility.

### Step 3 — Baseline Backtest

Use MetaTrader 5 Strategy Tester.

Record:
- Symbol and broker.
- Test period.
- Tester and signal timeframes.
- Initial deposit and leverage.
- Modeling method and history quality.
- Complete input configuration.

Preserve the original HTML report and associated charts.

### Step 4 — Evaluate Performance

Review:
- Total trades.
- Net profit.
- Profit factor.
- Expected payoff.
- Win rate.
- Average profit and loss.
- Maximum balance and equity drawdown.
- Consecutive losses.
- Balance and equity curves.

### Step 5 — Analyze Trade Behavior

Investigate:
- Entry distribution by hour and weekday.
- Winning and losing trade characteristics.
- Maximum Favorable Excursion (MFE).
- Maximum Adverse Excursion (MAE).
- Holding times.
- Consecutive losses.
- Break-even and trailing-stop effects.

Distinguish observations from untested explanations.

### Step 6 — Controlled Experiments

Change one primary variable at a time when testing a hypothesis.

Preserve the baseline and document each experimental configuration.

### Step 7 — Independent Validation

Use out-of-sample or forward testing when suitable data are available.

Evaluate robustness to spread, slippage, execution conditions and changing market regimes.

## 3. Research Acceptance Criteria

For the current EA-077 research target:

| Criterion | Requirement |
|---|---|
| Total trades | More than 200 |
| Net profit | Greater than $0 |
| Maximum equity drawdown | Below 20% |

All three conditions must be satisfied before a configuration becomes a candidate for further validation.

These are research filters, not proof of live profitability.

## 4. EA-077 Baseline Evaluation

| Metric | Result | Status |
|---|---:|---|
| Total trades | 455 | PASS |
| Net profit | -$98.75 | FAIL |
| Maximum equity drawdown | 11.18% | PASS |

Overall baseline status: FAIL.

## 5. Evidence and Versioning

Keep source code, test configuration, HTML reports and charts associated with the correct EA version.

Do not overwrite baseline evidence with later optimized results.

Document the reason for every source-code or parameter change.

## 6. Research Limitations

Historical backtests are sensitive to the test period, broker specifications, spread, execution assumptions and optimization choices.

A configuration passing the research thresholds still requires independent validation.

## 7. Approval

A research configuration should not be marked as validated without:
- The required artifacts.
- Completed checks.
- Supporting evidence.
- Explicit human review.
