# Business Requirements Document (BRD)

## Telco Customer Churn & Retention Business Case

## 1. Document Purpose

Defines what the churn analysis and retention business case must deliver, and how success is judged.

## 2. Business Problem

> **Business problem.** Our telecom company is losing customers at a rate that, in the data available, stands at 26.54% (1,869 of 7,043 customers). Churned customers were paying 139,130.85 CU per month, which is 30.5% of the monthly billing in the dataset. We do not know which customers are most at risk, which of them are worth the most, or where a retention budget would earn a return.
>
> **Why it matters.** Customers who leave take recurring revenue with them. Retention spend is limited, so it must go to the segments where churn is highest and the revenue exposure largest, not be spread across all customers.
>
> **Who is affected.** Customer Retention and Marketing (who run campaigns), Finance (who sign off the budget), Product (who own the plans and services), and Customer Success (who talk to customers).
>
> **Decision to be made.** Which customer segments should receive a targeted retention programme, what should be offered, and how much budget is justified?
>
> **Analysis required.** Measure churn, break it down by contract, tenure, price, services and payment method, size the revenue at stake per segment, and test retention scenarios with clearly labelled assumptions.
>
> **Expected outcome.** A ranked list of segments to target, an estimated financial case with break-even conditions, and a plan to test the programme before scaling it.

## 3. Business Objectives

### Business Objectives

| ID | Objective |
|---|---|
| BO-1 | Reduce churn in the segments where the revenue exposure is greatest |
| BO-2 | Spend the retention budget only where the expected return justifies it |
| BO-3 | Decide which segments are worth a pilot before a full rollout |

### Analytical Objectives

| ID | Objective | Answered in |
|---|---|---|
| AO-1 | Measure overall churn | `02_kpi_analysis.sql` |
| AO-2 | Identify major churn drivers (contract, tenure, price, services, payment) | `02_kpi_analysis.sql`, `03_churn_drivers.sql` |
| AO-3 | Identify high-risk segments with enough customers to trust | `03_churn_drivers.sql`, `04_customer_segmentation.sql` |
| AO-4 | Understand churn across tenure | `02_kpi_analysis.sql` |
| AO-5 | Quantify revenue exposure | `05_revenue_risk.sql`, Excel `Segments` |
| AO-6 | Identify segments suitable for targeted retention | Excel `Segments`, `Focused` |
| AO-7 | Estimate the financial impact of retention actions | Excel `Scenarios`, `Sensitivity` |

## 4. Stakeholders

| Stakeholder | Role | Interest | Decisions They Make | Information They Need |
|---|---|---|---|---|
| Head of Customer Retention | Owns the churn target | Lower churn at acceptable cost | Which segments to target, programme go/no-go | Churn by segment, revenue at risk, break-even save rate |
| Marketing Manager | Runs campaigns and offers | Efficient campaign targeting | Offer design, audience lists | Segment definitions and sizes, payment/contract profiles |
| Customer Success Manager | Contacts customers | Onboarding and proactive outreach | Outreach timing and scripts | Early-tenure risk, which add-ons relate to retention |
| Product Manager | Owns plans and services | Product fit and pricing | Bundles, plan changes | Fiber vs DSL churn, add-on associations, price bands |
| Finance Manager | Controls budget | Return on spend | Retention budget approval | Scenario ROI, assumptions, cost per target |
| Sales Manager | Owns contract sales | Contract mix | Contract migration incentives | Month-to-month vs longer contract churn |
| Business Analyst (you) | Defines requirements and the business case | Clear, defensible recommendations | Scope, KPI definitions, prioritisation | All of the above |
| Data Analyst | Builds queries and models | Correct, reproducible numbers | Data cleaning rules | Data dictionary, SQL scripts |

**Primary stakeholder for the dashboard:** Head of Customer Retention. Finance is the key approver for the scenario model.

## 5. Scope

### In Scope

Customer churn, tenure, contract type, services, monthly charges, payment method, customer segmentation, revenue at risk, assumption-based CLV, retention scenarios.

### Out of Scope

The following cannot be reliably evaluated with this dataset:

| Item | Why It Is Out |
|---|---|
| Churn prediction model (machine learning) | Not a BA/business-case deliverable here, and would shift the project toward data science |
| Proving what causes churn | Observational data, no experiment |
| Reasons customers left | No exit survey or complaint data |
| Churn trend over time | No dates |
| Actual retention costs, margins, offer effectiveness | Not in the data; modelled as assumptions |
| Network quality, competitor pricing, geography | Not in the data |

## 6. Assumptions

| ID | Assumption | Label |
|---|---|---|
| A-1 | `TotalCharges` blanks (11 rows, all tenure 0) are treated as 0 | Data decision |
| A-2 | Observed churn proportion is treated as an annual churn probability | [ASSUMPTION] |
| A-3 | Gross margin is 40% | [ASSUMPTION] |
| A-4 | Annual discount rate is 10% | [ASSUMPTION] |
| A-5 | CLV horizon is 5 years | [ASSUMPTION] |
| A-6 | Retention cost is 30 CU per targeted customer | [ASSUMPTION] |
| A-7 | Save rates are 10% / 20% / 30% (conservative / base / optimistic) | [ASSUMPTION] |
| A-8 | A segment needs at least 100 customers to be acted on | Analytical rule |

## 7. Constraints

Public sample dataset; single snapshot; no cost data; currency unspecified; findings show association only.

## 8. Functional Requirements

| ID | Requirement | Priority |
|---|---|---|
| BR-001 | The solution must calculate the overall customer churn rate | Must |
| BR-002 | The solution must provide churn analysis by contract type | Must |
| BR-003 | The solution must provide churn analysis by tenure band | Must |
| BR-004 | The solution must provide churn analysis by monthly charge band | Must |
| BR-005 | The solution must provide churn analysis by internet service and add-on services | Must |
| BR-006 | The solution must provide churn analysis by payment method | Must |
| BR-007 | The solution must analyse combined segments and only report groups of at least 100 customers | Must |
| BR-008 | The solution must segment customers (contract × tenure) and assign a retention priority | Must |
| BR-009 | The solution must calculate estimated revenue at risk with a documented method | Must |
| BR-010 | The solution must estimate customer lifetime value with all assumptions labelled | Should |
| BR-011 | The solution must model conservative, base and optimistic retention scenarios with ROI | Must |
| BR-012 | The solution must provide a 3-page Power BI dashboard (overview, drivers, retention intelligence) | Must |
| BR-013 | The solution must recommend segment-specific retention actions ranked by expected return | Must |

## 9. Non-Functional Requirements

| ID | Requirement |
|---|---|
| NFR-001 | Every data cleaning decision is documented (what, why, how, impact) |
| NFR-002 | Every figure on the dashboard and in the report is traceable to a SQL query or Excel cell |
| NFR-003 | Assumption-based figures are labelled ESTIMATED; assumptions are labelled ASSUMPTION |
| NFR-004 | Dashboard slicers update all applicable visuals consistently |
| NFR-005 | SQL scripts can be re-run from raw data to reproduce all results |

## 10. KPIs

Churn rate, retention rate, churned customers, average monthly charges, churned monthly revenue, estimated annual revenue at risk, CLV per active customer (estimated), break-even save rate, scenario ROI (estimated).

## 11. Reporting Requirements

### Page 1 — Executive Churn Overview

Provides overall churn KPIs, churn by tenure band, churn by contract, and key churner concentration. Slicers include contract, tenure band, charge band, internet service, and payment method.

### Page 2 — Churn Drivers

Provides churn analysis by tenure, contract, monthly charge band, payment method, internet service, technical support, and combined contract × tenure segments. The same five slicers are synchronised with Page 1.

### Page 3 — Retention Intelligence

Provides prioritized retention segments, estimated annual revenue at risk, CLV, break-even save rate, and scenario modelling using Save Rate, Cost per Target, and Gross Margin assumptions. Page 3 uses page-level filters for the pilot population rather than the dashboard slicers used on Pages 1 and 2.

## 12. Expected Deliverables

- Business Requirements Document (BRD)
- KPI tree
- Cleaned dataset and data documentation
- SQL analysis scripts
- Excel retention business case model
- Power BI dashboard
- Requirements traceability matrix
- UAT test cases and results
- UAT pre-verification evidence
- Final business case and recommendations
- README

## 13. Acceptance Criteria

1. Overall KPIs match the verified figures (7,043 / 1,869 / 5,174 / 26.54%).
2. All BR-001 to BR-013 appear in the traceability matrix with a finding.
3. All UAT test cases pass, with any minor presentation limitations transparently documented.
4. Every number in the final report is traceable and correctly labelled.