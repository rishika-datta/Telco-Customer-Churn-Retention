-- 04_customer_segmentation.sql
-- Segmentation framework: Contract x Tenure band (12 segments).
-- Why these two? Both are known at the start of a retention campaign, both showed the
-- largest churn differences in Phase 10, and a marketing team can act on them (contract migration, onboarding).

-- Q4.1 Segment table with revenue at risk, share of total, and priority tier
WITH segment_base AS (
    SELECT
        Contract || ' / ' || tenure_band AS segment,
        COUNT(*) AS customers,
        SUM(churn_flag) AS churned,
        COUNT(*) - SUM(churn_flag) AS active_customers,
        1.0 * SUM(churn_flag) / COUNT(*) AS churn_rate,
        AVG(MonthlyCharges) AS avg_monthly_all,
        SUM(CASE WHEN churn_flag = 0 THEN MonthlyCharges ELSE 0 END) AS active_monthly_revenue
    FROM telco_clean
    GROUP BY Contract, tenure_band
),
segment_risk AS (
    SELECT *,
           active_monthly_revenue * churn_rate * 12 AS est_annual_revenue_at_risk
    FROM segment_base
),
overall AS (
    SELECT 1.0 * SUM(churn_flag) / COUNT(*) AS overall_churn_rate FROM telco_clean
)
SELECT
    s.segment,
    s.customers,
    s.churned,
    ROUND(100 * s.churn_rate, 1) AS churn_rate_pct,
    ROUND(s.avg_monthly_all, 2) AS avg_monthly_charges,
    s.active_customers,
    ROUND(s.est_annual_revenue_at_risk, 0) AS est_annual_rev_at_risk,
    ROUND(100.0 * s.est_annual_revenue_at_risk / SUM(s.est_annual_revenue_at_risk) OVER (), 1) AS share_of_total_risk_pct,
    RANK() OVER (ORDER BY s.est_annual_revenue_at_risk DESC) AS risk_rank,
    CASE
        WHEN s.customers < 100 THEN 'Too small to act on'
        WHEN s.churn_rate > o.overall_churn_rate
             AND 1.0 * s.est_annual_revenue_at_risk / SUM(s.est_annual_revenue_at_risk) OVER () >= 0.10 THEN 'Priority 1'
        WHEN s.churn_rate > o.overall_churn_rate THEN 'Priority 2'
        ELSE 'Monitor'
    END AS retention_priority
FROM segment_risk s CROSS JOIN overall o
ORDER BY risk_rank;
