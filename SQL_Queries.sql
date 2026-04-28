-- iGaming KPI Analysis Project
-- Redshift-style SQL examples for Junior Data Analyst portfolio
-- Data model:
--   players(player_id, signup_date, player_segment, country, acquisition_channel, ab_group, risk_level)
--   transactions(transaction_id, player_id, transaction_datetime, game_type, payment_method, stake_amount, win_amount, deposit_amount, withdrawal_amount, bonus_amount)
--   bonuses(bonus_id, player_id, transaction_id, campaign_name, bonus_date, bonus_amount)
--   ab_test_results(player_id, ab_group, campaign, player_segment, country, deposit_converted, revenue_per_user, transactions)

-- 1. Monthly GGR / NGR trend
SELECT
    DATE_TRUNC('month', transaction_datetime) AS month,
    SUM(stake_amount) AS total_stakes,
    SUM(win_amount) AS total_winnings,
    SUM(stake_amount - win_amount) AS ggr,
    SUM(stake_amount - win_amount - bonus_amount) AS ngr,
    SUM(deposit_amount) AS deposit_volume,
    SUM(withdrawal_amount) AS withdrawal_volume,
    COUNT(DISTINCT player_id) AS active_players
FROM transactions
WHERE transaction_datetime >= '2026-01-01'
  AND transaction_datetime < '2026-04-01'
  AND player_id IS NOT NULL
GROUP BY 1
ORDER BY 1;

-- 2. Revenue and LTV by player segment
WITH player_revenue AS (
    SELECT
        t.player_id,
        SUM(t.stake_amount - t.win_amount) AS ggr,
        SUM(t.stake_amount - t.win_amount - t.bonus_amount) AS ngr,
        SUM(t.deposit_amount) AS deposits,
        SUM(t.withdrawal_amount) AS withdrawals,
        SUM(t.bonus_amount) AS bonus_cost
    FROM transactions t
    WHERE t.transaction_datetime >= '2026-01-01'
      AND t.transaction_datetime < '2026-04-01'
    GROUP BY t.player_id
)
SELECT
    p.player_segment,
    COUNT(DISTINCT p.player_id) AS players,
    SUM(pr.ggr) AS total_ggr,
    SUM(pr.ngr) AS total_ngr,
    SUM(pr.bonus_cost) AS total_bonus_cost,
    SUM(pr.deposits) AS total_deposits,
    SUM(pr.withdrawals) AS total_withdrawals,
    SUM(pr.ngr) / NULLIF(COUNT(DISTINCT p.player_id), 0) AS avg_historical_ltv
FROM players p
LEFT JOIN player_revenue pr
    ON p.player_id = pr.player_id
GROUP BY p.player_segment
ORDER BY total_ngr DESC;

-- 3. Churn risk: no activity in the last 30 days as of 2026-04-01
WITH last_activity AS (
    SELECT
        player_id,
        MAX(transaction_datetime) AS last_activity_datetime
    FROM transactions
    WHERE transaction_datetime < '2026-04-01'
    GROUP BY player_id
)
SELECT
    p.player_segment,
    COUNT(DISTINCT p.player_id) AS total_players,
    SUM(CASE
            WHEN la.last_activity_datetime < DATEADD(day, -30, '2026-04-01')
              OR la.last_activity_datetime IS NULL
            THEN 1 ELSE 0
        END) AS churned_players,
    1.0 * SUM(CASE
            WHEN la.last_activity_datetime < DATEADD(day, -30, '2026-04-01')
              OR la.last_activity_datetime IS NULL
            THEN 1 ELSE 0
        END) / NULLIF(COUNT(DISTINCT p.player_id), 0) AS churn_rate
FROM players p
LEFT JOIN last_activity la
    ON p.player_id = la.player_id
GROUP BY p.player_segment
ORDER BY churn_rate DESC;

-- 4. Potential bonus abuse flag
WITH player_bonus_metrics AS (
    SELECT
        player_id,
        SUM(bonus_amount) AS total_bonus,
        SUM(deposit_amount) AS total_deposits,
        SUM(stake_amount - win_amount - bonus_amount) AS ngr,
        COUNT(*) AS transactions
    FROM transactions
    WHERE transaction_datetime >= '2026-01-01'
      AND transaction_datetime < '2026-04-01'
    GROUP BY player_id
)
SELECT
    player_id,
    transactions,
    total_bonus,
    total_deposits,
    ngr,
    total_bonus / NULLIF(total_deposits, 0) AS bonus_to_deposit_ratio,
    CASE
        WHEN total_bonus > 50
         AND total_bonus / NULLIF(total_deposits, 0) > 0.75
         AND ngr < 0
        THEN 'Potential Bonus Abuse'
        ELSE 'Normal'
    END AS bonus_abuse_flag
FROM player_bonus_metrics
ORDER BY bonus_abuse_flag DESC, total_bonus DESC;

-- 5. A/B test conversion summary
SELECT
    ab_group,
    COUNT(*) AS players,
    SUM(deposit_converted) AS conversions,
    1.0 * SUM(deposit_converted) / NULLIF(COUNT(*), 0) AS conversion_rate,
    AVG(revenue_per_user) AS avg_revenue_per_user,
    SUM(revenue_per_user) AS total_revenue
FROM ab_test_results
WHERE campaign = 'Spring Deposit Promo'
GROUP BY ab_group;

-- 6. Data quality checks
SELECT 'Duplicate transaction IDs' AS check_name, COUNT(*) AS issue_count
FROM (
    SELECT transaction_id
    FROM transactions
    GROUP BY transaction_id
    HAVING COUNT(*) > 1
) dups

UNION ALL

SELECT 'Missing player IDs', COUNT(*)
FROM transactions
WHERE player_id IS NULL OR player_id = ''

UNION ALL

SELECT 'Negative monetary values', COUNT(*)
FROM transactions
WHERE stake_amount < 0
   OR win_amount < 0
   OR deposit_amount < 0
   OR withdrawal_amount < 0
   OR bonus_amount < 0

UNION ALL

SELECT 'Transactions outside Q1 2026', COUNT(*)
FROM transactions
WHERE transaction_datetime < '2026-01-01'
   OR transaction_datetime >= '2026-04-01';
