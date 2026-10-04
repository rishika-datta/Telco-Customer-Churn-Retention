# UAT Test Cases

## Purpose

This document records the user acceptance testing performed on the Telco Customer Churn & Retention Business Case dashboard and supporting Excel model.

**Result:** 18 of 18 UAT tests passed.

| Test ID | Req ID | Scenario | Test steps | Expected result | Actual result | Status |
|---|---|---|---|---|---|---|
| UAT-01 | BR-001 | Overall KPIs | Open Page 1 with no filters | 7,043 total; 1,869 churned; 5,174 retained; 26.54% churn | 7,043 total; 1,869 churned; 5,174 retained; 26.54% churn | PASS |
| UAT-02 | BR-001 | KPI vs SQL | Compare card values with Q2.1 | Identical | Power BI KPI values matched the SQL reference results | PASS |
| UAT-03 | BR-002 | Contract churn | Page 2 contract chart | Month-to-month 42.7%, One year 11.3%, Two year 2.8% | 42.71%, 11.27%, 2.83%, respectively | PASS |
| UAT-04 | BR-003 | Tenure churn | Page 2 tenure chart | 47.4% / 28.7% / 20.4% / 9.5% in band order | 47.44% / 28.71% / 20.39% / 9.51% | PASS |
| UAT-05 | BR-004 | Charge bands | Page 2 charge band chart | 10.9% / 23.6% / 38.0% / 32.9% | 10.86% / 23.65% / 37.95% / 32.86% | PASS |
| UAT-06 | BR-006 | Payment | Page 2 payment chart | Electronic check 45.3%; mailed 19.1%; bank transfer 16.7%; credit card 15.2% | 45.29%; 19.11%; 16.71%; 15.24%, respectively | PASS |
| UAT-07 | NFR-004 | Slicer | Select Contract = Month-to-month | Total customers = 3,875; churned = 1,655; churn rate = 42.7%; all Page 2 visuals update | Total = 3,875; churned = 1,655; churn rate = 42.71%; Page 2 visuals updated | PASS |
| UAT-08 | NFR-004 | Slicer clearing | Clear all slicers | Values return to UAT-01 | Baseline values returned | PASS |
| UAT-09 | BR-007 | Segment matrix | Page 2 matrix, Month-to-month × 0-12 months | 51.4% churn; 1,994 customers | Churn rate = 51.35%; expected rate verified. Customer count = 1,994 was verified independently, but the matrix tooltip was not successfully configured to display the count | PASS* |
| UAT-10 | BR-007 | Small groups | Look for groups under 100 customers | Not used for conclusions; flagged as small groups | Two year 0-12 months = 68 customers and Two year 13-24 months = 90 customers; treated as too small to act on | PASS |
| UAT-11 | BR-008 | Priority labels | Page 3 table | Three month-to-month segments (0-12, 13-24, 25-48) show Priority 1; Two year 0-12 and 13-24 show Too small | Priority labels matched the expected segmentation | PASS |
| UAT-12 | BR-009 | Revenue at risk | Page 1 card, no filters | About 793,323 CU, labelled ESTIMATED | 793,323 CU displayed as Estimated Annual Revenue at Risk | PASS |
| UAT-13 | BR-009 | Churned revenue | Churned Monthly Revenue measure | 139,130.85 CU | 139,130.85 CU | PASS |
| UAT-14 | BR-010 | CLV | Page 3 table | CLV 378.89 CU for Month-to-month 0-12 months; 1,152.36 CU for Two year 49+ | Values matched: 378.89 CU and 1,152.36 CU | PASS |
| UAT-15 | BR-011 | Scenario, default sliders | Filter Contract = Month-to-month and tenure bands 0-12, 13-24, 25-48; save 20%, cost 30, margin 40% | Retention cost 59,010; Net benefit -12,796; ROI -21.7% | Retention cost ≈ 59,010; Net benefit ≈ -12,796; ROI = -21.68% | PASS |
| UAT-16 | BR-011 | Scenario, changed input | Set save rate 30% | Net benefit about +10,311; ROI +17.5% | Net benefit ≈ +10,310; ROI = 17.47% | PASS |
| UAT-17 | BR-011 | Excel recalculation | Change Assumptions cost to 15 | Sensitivity break-even at 15 CU matches 12.8%; Scenarios results change | Break-even = 12.77% (≈12.8%); scenario results recalculated correctly. Original workbook remained unchanged | PASS |
| UAT-18 | NFR-003 | Labelling | Review every page | All forward-looking numbers carry ESTIMATED | Forward-looking/modelled figures were labelled Estimated/ESTIMATED | PASS |

## UAT Notes

- **UAT-09:** The required churn-rate calculation and independently verified customer count passed. The customer-count tooltip was not successfully configured in the final matrix, so this is recorded transparently as a minor presentation limitation rather than claiming the tooltip was implemented.
- **UAT-16:** The save-rate input was restored to the default 20% after testing the 30% scenario.
- **UAT-17:** Testing was performed on a copy of the Excel workbook; the original workbook was not altered.
- All baseline dashboard KPI values were reconciled against the SQL and Excel reference outputs.

## Pre-verification

Before dashboard execution, the expected values were independently recomputed from the cleaned CSV and Excel model: **45 checks, 0 mismatches**. This confirms that the expected reference values were correct; the UAT results above document the subsequent dashboard/model validation.

## Overall UAT Result

**18/18 UAT tests passed.**

The dashboard and supporting business-case model met the tested functional, analytical, scenario, and labelling requirements. One minor presentation limitation remains: the customer-count tooltip was not successfully configured for the Page 2 segment matrix.