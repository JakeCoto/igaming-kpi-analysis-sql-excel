# iGaming KPI Analysis Project

Simulated iGaming analytics portfolio project using SQL and Excel to analyze player revenue, deposits, withdrawals, churn, bonus abuse risk, and A/B test performance.

This project was built to mirror the type of KPI monitoring, ad-hoc reporting, data validation, and business analysis expected from a Junior Data Analyst in the iGaming industry.

---

## Dashboard Preview

![Dashboard Screenshot](assets/dashboard_screenshot.png)

---

## Project Overview

The goal of this project is to analyze simulated iGaming player and transaction data and turn it into clear business insights.

The analysis focuses on core iGaming KPIs such as:

- GGR
- NGR
- Deposit volume
- Withdrawal volume
- Player LTV
- Churn rate
- Bonus cost
- Bonus abuse risk
- A/B test performance

The project includes raw simulated datasets, SQL analysis queries, an Excel reporting workbook, a dashboard screenshot, a data dictionary, and a one-page case study summary.

---

## Business Questions

This project answers the following business questions:

1. Which player segments generate the highest gross and net gaming revenue?
2. Are bonuses improving player value or creating bonus abuse risk?
3. Which players show signs of churn?
4. Did the promotional A/B test improve deposit conversion?
5. Are there any data quality issues or suspicious anomalies in the dataset?

---

## Tools Used

- SQL
- Excel
- Pivot-style reporting
- KPI calculations
- A/B test analysis
- Data validation checks
- Simulated business reporting workflow

---

## Files Included

| File | Description |
|---|---|
| `iGaming_KPI_Case_Study.pdf` | One-page business summary of the project, findings, and recommendations |
| `iGaming_KPI_Workbook.xlsx` | Excel workbook with KPI reporting, dashboard, analysis tables, and validation checks |
| `SQL_Queries.sql` | SQL queries used for KPI calculations, player analysis, churn logic, bonus abuse flags, and data validation |
| `data_dictionary.md` | Explanation of dataset fields and KPI definitions |
| `assets/dashboard_screenshot.png` | Dashboard preview image |
| `datasets/players.csv` | Simulated player profile dataset |
| `datasets/transactions.csv` | Simulated transaction and betting activity dataset |
| `datasets/bonuses.csv` | Simulated bonus and promotion dataset |
| `datasets/ab_test_results.csv` | Simulated A/B test results dataset |

---

## Dataset Overview

This project uses simulated data representing a fictional iGaming platform.

### Players Dataset

Includes player-level information such as:

- Player ID
- Registration date
- Country or region
- Player segment
- Acquisition channel
- Account status

### Transactions Dataset

Includes simulated activity such as:

- Deposits
- Withdrawals
- Stakes/wagers
- Winnings
- Bonus usage
- Game type
- Transaction date

### Bonuses Dataset

Includes promotional bonus activity such as:

- Bonus amount
- Bonus type
- Player ID
- Campaign ID
- Redemption status

### A/B Test Dataset

Includes simulated control and variant group performance for a promotional campaign.

Metrics include:

- Test group
- Number of users
- Depositors
- Conversion rate
- Revenue per user
- Retention rate

---

## KPIs Analyzed

### GGR — Gross Gaming Revenue

GGR measures gross player revenue before deductions.

```text
GGR = Total Stakes - Total Winnings
