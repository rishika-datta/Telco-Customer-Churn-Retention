-- 05_revenue_risk.sql
-- Q5.1 Observed revenue of customers who churned (calculated from the data)
SELECT ROUND(SUM(CASE WHEN churn_flag = 1 THEN MonthlyCharges END), 2) AS churned_monthly_revenue,
       ROUND(SUM(CASE WHEN churn_flag = 1 THEN MonthlyCharges END) * 12, 2) AS churned_annualised_revenue,
       ROUND(SUM(MonthlyCharges), 2) AS total_monthly_revenue_all_customers,
       ROUND(100.0 * SUM(CASE WHEN churn_flag = 1 THEN MonthlyCharges END) / SUM(MonthlyCharges), 1) AS churned_share_of_monthly_revenue_pct
FROM telco_clean;

-- Q5.2 Average monthly charge: churned vs retained
SELECT CASE WHEN churn_flag = 1 THEN 'Churned' ELSE 'Retained' END AS status,
       COUNT(*) AS customers, ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges,
       ROUND(AVG(tenure), 1) AS avg_tenure_months
FROM telco_clean GROUP BY churn_flag;

-- Q5.3 Churned revenue by contract (window: share of total churned revenue)
SELECT Contract,
       ROUND(SUM(CASE WHEN churn_flag = 1 THEN MonthlyCharges END), 0) AS churned_monthly_revenue,
       ROUND(100.0 * SUM(CASE WHEN churn_flag = 1 THEN MonthlyCharges END)
             / SUM(SUM(CASE WHEN churn_flag = 1 THEN MonthlyCharges END)) OVER (), 1) AS share_pct
FROM telco_clean GROUP BY Contract ORDER BY churned_monthly_revenue DESC;

-- Q5.4 Inputs for the CLV model (overall)
SELECT ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges_all,
       ROUND(AVG(CASE WHEN churn_flag = 0 THEN MonthlyCharges END), 2) AS avg_monthly_charges_retained,
       ROUND(AVG(tenure), 1) AS avg_tenure_months,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct
FROM telco_clean;
