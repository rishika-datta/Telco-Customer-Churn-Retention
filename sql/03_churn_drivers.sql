-- 03_churn_drivers.sql
-- Q3.1 Internet service type
SELECT InternetService, COUNT(*) AS customers, SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct
FROM telco_clean GROUP BY InternetService ORDER BY churn_rate_pct DESC;

-- Q3.2 Phone service
SELECT PhoneService, COUNT(*) AS customers, SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct
FROM telco_clean GROUP BY PhoneService;

-- Q3.3 Add-on services: churn with vs without each add-on (internet customers only)
SELECT 'OnlineSecurity' AS service, OnlineSecurity AS has_service, COUNT(*) AS customers,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct
FROM telco_clean WHERE InternetService <> 'No' GROUP BY OnlineSecurity
UNION ALL
SELECT 'TechSupport', TechSupport, COUNT(*), ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1)
FROM telco_clean WHERE InternetService <> 'No' GROUP BY TechSupport
UNION ALL
SELECT 'OnlineBackup', OnlineBackup, COUNT(*), ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1)
FROM telco_clean WHERE InternetService <> 'No' GROUP BY OnlineBackup
UNION ALL
SELECT 'DeviceProtection', DeviceProtection, COUNT(*), ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1)
FROM telco_clean WHERE InternetService <> 'No' GROUP BY DeviceProtection
UNION ALL
SELECT 'StreamingTV', StreamingTV, COUNT(*), ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1)
FROM telco_clean WHERE InternetService <> 'No' GROUP BY StreamingTV
UNION ALL
SELECT 'StreamingMovies', StreamingMovies, COUNT(*), ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1)
FROM telco_clean WHERE InternetService <> 'No' GROUP BY StreamingMovies
ORDER BY service, has_service;

-- Q3.4 Number of add-ons (internet customers only)
SELECT num_addons, COUNT(*) AS customers, ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct
FROM telco_clean WHERE InternetService <> 'No' GROUP BY num_addons ORDER BY num_addons;

-- Q3.5 Payment method
SELECT PaymentMethod, COUNT(*) AS customers, SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct
FROM telco_clean GROUP BY PaymentMethod ORDER BY churn_rate_pct DESC;

-- Q3.6 Other attributes (one query, stacked)
SELECT 'Paperless billing' AS attribute, PaperlessBilling AS value, COUNT(*) AS customers, ROUND(100.0*SUM(churn_flag)/COUNT(*),1) AS churn_rate_pct FROM telco_clean GROUP BY PaperlessBilling
UNION ALL SELECT 'Senior citizen', CAST(SeniorCitizen AS TEXT), COUNT(*), ROUND(100.0*SUM(churn_flag)/COUNT(*),1) FROM telco_clean GROUP BY SeniorCitizen
UNION ALL SELECT 'Dependents', Dependents, COUNT(*), ROUND(100.0*SUM(churn_flag)/COUNT(*),1) FROM telco_clean GROUP BY Dependents
UNION ALL SELECT 'Partner', Partner, COUNT(*), ROUND(100.0*SUM(churn_flag)/COUNT(*),1) FROM telco_clean GROUP BY Partner
UNION ALL SELECT 'Gender', gender, COUNT(*), ROUND(100.0*SUM(churn_flag)/COUNT(*),1) FROM telco_clean GROUP BY gender;

-- Q3.7 Combined: Contract + monthly charge band (RANK compares churn across groups)
SELECT Contract, charge_band, COUNT(*) AS customers,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct,
       RANK() OVER (ORDER BY 1.0 * SUM(churn_flag) / COUNT(*) DESC) AS churn_rank
FROM telco_clean
GROUP BY Contract, charge_band
HAVING COUNT(*) >= 100
ORDER BY churn_rank;

-- Q3.8 Combined: Tenure band + monthly charge band
SELECT tenure_band, charge_band, COUNT(*) AS customers,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct,
       RANK() OVER (ORDER BY 1.0 * SUM(churn_flag) / COUNT(*) DESC) AS churn_rank
FROM telco_clean
GROUP BY tenure_band, charge_band
HAVING COUNT(*) >= 100
ORDER BY churn_rank;

-- Q3.9 Combined: Internet service + contract (separates product effect from contract effect)
SELECT InternetService, Contract, COUNT(*) AS customers,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct,
       RANK() OVER (ORDER BY 1.0 * SUM(churn_flag) / COUNT(*) DESC) AS churn_rank
FROM telco_clean
GROUP BY InternetService, Contract
HAVING COUNT(*) >= 100
ORDER BY churn_rank;

-- Q3.10 Combined: Payment method + contract
SELECT PaymentMethod, Contract, COUNT(*) AS customers,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct,
       RANK() OVER (ORDER BY 1.0 * SUM(churn_flag) / COUNT(*) DESC) AS churn_rank
FROM telco_clean
GROUP BY PaymentMethod, Contract
HAVING COUNT(*) >= 100
ORDER BY churn_rank;

-- Q3.11 Month-to-month customers only: do add-ons still matter? (controls for contract)
SELECT TechSupport, COUNT(*) AS customers, ROUND(100.0 * SUM(churn_flag) / COUNT(*), 1) AS churn_rate_pct
FROM telco_clean
WHERE Contract = 'Month-to-month' AND InternetService <> 'No'
GROUP BY TechSupport;
