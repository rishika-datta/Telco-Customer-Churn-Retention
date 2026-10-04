-- 02_kpi_analysis.sql
-- Q2.1 Overall churn KPIs
SELECT COUNT(*) AS total_customers,
       SUM(churn_flag) AS churned_customers,
       COUNT(*) - SUM(churn_flag) AS retained_customers,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct
FROM telco_clean;

-- Q2.2 Churn by contract type (window function gives each contract's share of all churners)
SELECT Contract,
       COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct,
       ROUND(100.0 * SUM(churn_flag) / SUM(SUM(churn_flag)) OVER (), 1) AS share_of_all_churners_pct
FROM telco_clean
GROUP BY Contract
ORDER BY churn_rate_pct DESC;

-- Q2.3 Churn by tenure band
SELECT tenure_band,
       COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct,
       ROUND(100.0 * SUM(churn_flag) / SUM(SUM(churn_flag)) OVER (), 1) AS share_of_all_churners_pct
FROM telco_clean
GROUP BY tenure_band
ORDER BY tenure_band;

-- Q2.4 Churn by monthly charge band
SELECT charge_band,
       COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct,
       ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges
FROM telco_clean
GROUP BY charge_band
ORDER BY charge_band;

-- Q2.5 HAVING: which contract + tenure groups churn above the overall rate (and are big enough to trust)?
SELECT Contract, tenure_band,
       COUNT(*) AS customers,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct
FROM telco_clean
GROUP BY Contract, tenure_band
HAVING COUNT(*) >= 100
   AND 100.0 * SUM(churn_flag) / COUNT(*) > (SELECT 100.0 * SUM(churn_flag) / COUNT(*) FROM telco_clean)
ORDER BY churn_rate_pct DESC;
