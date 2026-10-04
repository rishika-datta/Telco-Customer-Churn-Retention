-- 01_data_quality.sql
-- Q1.1 Row count and unique customers
SELECT COUNT(*) AS total_rows, COUNT(DISTINCT customerID) AS unique_customers FROM telco_raw;

-- Q1.2 Blank TotalCharges (stored as text) - which customers and why?
SELECT customerID, tenure, MonthlyCharges, Contract, Churn
FROM telco_raw
WHERE TRIM(TotalCharges) = '';

-- Q1.3 Are all blanks explained by tenure = 0?
SELECT SUM(CASE WHEN TRIM(TotalCharges) = '' THEN 1 ELSE 0 END) AS blank_total_charges,
       SUM(CASE WHEN TRIM(TotalCharges) = '' AND tenure = 0 THEN 1 ELSE 0 END) AS blank_and_tenure_zero
FROM telco_raw;

-- Q1.3b Category check for inconsistent labels (example: payment method)
SELECT PaymentMethod, COUNT(*) AS customers FROM telco_raw GROUP BY PaymentMethod ORDER BY customers DESC;

DROP TABLE IF EXISTS telco_clean;

-- Q1.4 Build the cleaned analysis table with derived fields
CREATE TABLE telco_clean AS
SELECT
    customerID, gender, SeniorCitizen, Partner, Dependents, tenure,
    PhoneService, MultipleLines, InternetService,
    OnlineSecurity, OnlineBackup, DeviceProtection, TechSupport, StreamingTV, StreamingMovies,
    Contract, PaperlessBilling, PaymentMethod, MonthlyCharges,
    CASE WHEN TRIM(TotalCharges) = '' THEN 0.0 ELSE CAST(TotalCharges AS REAL) END AS TotalCharges,
    CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END AS churn_flag,
    CASE WHEN tenure <= 12 THEN '1) 0-12 months'
         WHEN tenure <= 24 THEN '2) 13-24 months'
         WHEN tenure <= 48 THEN '3) 25-48 months'
         ELSE '4) 49+ months' END AS tenure_band,
    CASE WHEN MonthlyCharges < 35 THEN '1) Under 35'
         WHEN MonthlyCharges < 70 THEN '2) 35 to 69.99'
         WHEN MonthlyCharges < 90 THEN '3) 70 to 89.99'
         ELSE '4) 90 and above' END AS charge_band,
    (OnlineSecurity = 'Yes') + (OnlineBackup = 'Yes') + (DeviceProtection = 'Yes')
      + (TechSupport = 'Yes') + (StreamingTV = 'Yes') + (StreamingMovies = 'Yes') AS num_addons
FROM telco_raw;

-- Q1.5 Validate the cleaned table
SELECT COUNT(*) AS rows_clean, SUM(churn_flag) AS churned,
       MIN(TotalCharges) AS min_total_charges, SUM(TotalCharges IS NULL) AS null_total_charges
FROM telco_clean;
