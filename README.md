# iGaming KPI Analysis Project

## Project Overview

I built this project as a Junior Data Analyst portfolio project using a simulated iGaming dataset. My goal was to mirror the type of work I would be expected to do in a real analyst role: writing SQL, working in Excel, tracking KPIs, supporting A/B test analysis, checking data quality, and turning raw data into business-friendly insights.

The project analyzes fictional player, transaction, bonus, and A/B test data for Q1 2026.

<p align="center">
  <img src="./dashboard_screenshot.png" alt="Dashboard Preview" width="850">
</p>

## Business Questions

For this project, I focused on answering five main business questions:

1. Which player segments generate the highest gross and net gaming revenue?
2. Are bonuses improving player value, or are they creating bonus abuse risk?
3. Which players show signs of churn?
4. Did the promotional A/B test improve deposit conversion?
5. Are there any data quality issues or suspicious anomalies in the data?

## Tools and Skills Used

This project demonstrates:

- SQL analysis using joins, aggregations, CASE logic, CTEs, date filtering, and validation checks
- Excel dashboarding and KPI reporting
- Pivot-style summaries and ad-hoc reporting logic
- iGaming KPI definitions and calculations
- A/B test interpretation using conversion rate, lift, and p-value
- Data quality checks for duplicates, nulls, negative values, and out-of-range dates
- Business-friendly written communication

## KPIs Analyzed

| KPI | Definition Used |
|---|---|
| GGR | Stakes - Winnings |
| NGR | GGR - Bonus Costs |
| Deposit Volume | Total player deposits |
| Withdrawal Volume | Total player withdrawals |
| Active Players | Players with Q1 transaction activity |
| Churn Rate | Players with no activity in the last 30 days as of 2026-04-01 |
| Player LTV | Historical NGR per player during the observation window |
| Bonus Cost | Total bonus value awarded |
| Bonus Abuse Flag | High bonus-to-deposit ratio + negative NGR + meaningful bonus amount |
| Conversion Rate | A/B test players with deposit conversion / total players |

## Key Findings

Based on the simulated data, I found the following:

- VIP and Regular players produced the strongest net revenue, but higher bonus costs showed why it is important to evaluate promotions by NGR instead of only GGR.
- Several players were flagged for potential bonus abuse because they had high bonus usage, low deposit behavior, and negative NGR.
- The promotional A/B test showed a higher deposit conversion rate for the Variant group compared to the Control group.
- Even though the Variant group performed better on conversion, I would still evaluate the campaign by net revenue impact before making a final recommendation.
- The data quality checks identified intentionally inserted issues, including duplicate transaction IDs, missing player IDs, negative monetary values, and out-of-range dates.

## Files Included

| File | Purpose |
|---|---|
| `iGaming_KPI_Workbook.xlsx` | Main Excel workbook with dashboard, KPI summaries, data quality checks, and source data |
| `SQL_Queries.sql` | Redshift-style SQL queries for KPI calculations and validation |
| `iGaming_KPI_Case_Study.pdf` | One-page business case study for recruiter or hiring-manager review |
| `data_dictionary.md` | Dataset fields and KPI definitions |
| `dashboard_screenshot.png` | Visual preview of the dashboard |
| `datasets/players.csv` | Simulated player dimension table |
| `datasets/transactions.csv` | Simulated transaction fact table |
| `datasets/bonuses.csv` | Simulated bonus campaign data |
| `datasets/ab_test_results.csv` | Simulated A/B test result data |

## How I Would Explain This Project in an Interview

I built this project to demonstrate the same type of work described in Junior Data Analyst job postings, especially roles involving SQL, Excel, KPI reporting, A/B testing, and data quality validation.

The project uses simulated iGaming data to calculate metrics like GGR, NGR, deposits, withdrawals, churn, player LTV, bonus cost, and bonus abuse indicators. I also included an A/B test summary to compare a Control group against a Variant group using conversion rate, lift, p-value, and business impact.

The biggest focus for me was not just calculating numbers, but checking whether the numbers made sense. I included validation checks for duplicate transaction IDs, missing player IDs, negative values, and out-of-range transaction dates. That was important because a report can look clean but still be wrong if the underlying data has issues.

If I were presenting this in an interview, I would explain that the project shows my ability to take raw data, apply business logic, validate the results, and summarize the findings in a way that a non-technical stakeholder could understand.

## SQL Work Included

The SQL file includes examples of:

- Joining player, transaction, and bonus data
- Calculating GGR and NGR
- Summarizing deposits and withdrawals
- Segmenting revenue by player group
- Identifying churn risk
- Flagging potential bonus abuse
- Checking for duplicate transaction IDs
- Checking for missing player IDs
- Checking for negative or out-of-range values

## Excel Work Included

The Excel workbook includes:

- A dashboard-style summary
- KPI reporting tables
- Player and transaction analysis
- A/B test summary
- Data quality checks
- Source data tabs
- Business-friendly formatting

## Resume Bullet Version

This is how I would summarize the project on my resume:

- Built a simulated iGaming analytics project using SQL and Excel to calculate GGR, NGR, deposit volume, withdrawal volume, player LTV, churn rate, bonus cost, and bonus abuse indicators.
- Wrote Redshift-style SQL queries using JOINs, GROUP BY, CASE WHEN, CTEs, date filtering, and aggregations to analyze player and transaction behavior.
- Created an Excel reporting workbook with KPI summaries, dashboard visuals, data validation checks, and A/B test analysis.
- Flagged potential data quality issues including duplicate transaction IDs, missing player IDs, negative values, and unusual date patterns.
- Summarized findings in a one-page business case study for non-technical stakeholders.

## Disclaimer

All data in this project is simulated and fictional. No real gambling, customer, financial, or company data is included.
