# Requirements Traceability Matrix

| Req ID | Business requirement | Analysis / dashboard | KPI | Finding | Business decision | Status |
|---|---|---|---|---|---|---|
| BR-001 | Calculate overall churn rate | SQL Q2.1; Dashboard P1 cards | Churn Rate | 26.54% (1,869 of 7,043) | Sets the baseline for all segments | Verified — SQL + Power BI UAT passed |
| BR-002 | Churn by contract | SQL Q2.2; Dashboard P1, P2 | Churn Rate by Contract | 42.7% / 11.3% / 2.8%; month-to-month holds 88.6% of churners | Focus on month-to-month customers | Verified — SQL + Power BI UAT passed |
| BR-003 | Churn by tenure band | SQL Q2.3; Dashboard P1, P2 | Churn Rate by tenure | 47.4% / 28.7% / 20.4% / 9.5% | Invest in first-year onboarding | Verified — SQL + Power BI UAT passed |
| BR-004 | Churn by monthly charge band | SQL Q2.4; Dashboard P2 | Churn Rate by charge band | 10.9% / 23.6% / 38.0% / 32.9% | Review value for high-bill new customers | Verified — SQL + Power BI UAT passed |
| BR-005 | Churn by internet and add-on services | SQL Q3.1, Q3.3, Q3.4; Dashboard P2 | Churn Rate by service | Fiber 41.9% vs DSL 19.0%; TechSupport 15.2% vs 41.6% | Support-bundle trial; fiber service review | Verified — SQL + Power BI UAT passed |
| BR-006 | Churn by payment method | SQL Q3.5; Dashboard P2 | Churn Rate by payment | Electronic check 45.3% vs 15.2% to 19.1% | Autopay migration offer | Verified — SQL + Power BI UAT passed |
| BR-007 | Combined segments, minimum 100 customers | SQL Q3.7 to Q3.11 (HAVING >= 100); Dashboard P2 matrix | Churn Rate by combination | M2M fiber 54.6%; M2M electronic check 53.7%; one-year, 90+ charge band 75.8% | Target combinations, not single factors | Verified — SQL + Power BI UAT passed |
| BR-008 | Segment customers and assign priority | SQL Q4.1; Excel `Segments`; Dashboard P3 | Churn rate, priority tier | Three M2M segments Priority 1 | Pilot candidates | Verified — SQL + Excel + Power BI UAT passed |
| BR-009 | Estimated revenue at risk | SQL Q5.1 to Q5.3, Q4.1; Excel; DAX; Dashboard P1, P3 | Est. Annual Revenue at Risk | 793,323 CU [ESTIMATED]; 72.8% in three segments | Size the programme | Verified — SQL + Excel + DAX + Power BI UAT passed |
| BR-010 | Assumption-based CLV | Excel `Segments` col K; Dashboard P3 | CLV per active customer | 378.89 CU (M2M 0-12) to 1,152.36 CU (two-year 49+) [ESTIMATED] | Compare offer cost with customer value | Verified — Excel + Power BI UAT passed |
| BR-011 | Retention scenarios with ROI | Excel `Scenarios`, `Sensitivity`, `Focused`; Dashboard P3 | Break-even save rate, ROI | Blanket break-even 25.5%; fiber sub-segment 11.0% [ESTIMATED] | Pilot the focused segment first | Verified — Excel + Power BI UAT passed |
| BR-012 | 3-page dashboard | Power BI dashboard (`Telco_Churn_Dashboard.pbix`) | All | Three completed pages: Executive Churn Overview, Churn Drivers, Retention Intelligence | Used by Retention and Finance | Verified — Power BI dashboard built and UAT passed |
| BR-013 | Ranked recommendations | Recommendations in the business case | Break-even, KPIs per action | R1 to R5 | Approve pilot design | Verified — recommendation delivered |
| NFR-002 | Figures traceable | All SQL files, Excel, Power BI | n/a | Figures traceable to source analysis/model | Supports reproducibility and review | Verified |
| NFR-003 | Assumptions labelled | Excel `Assumptions`, guide labels, Power BI | n/a | Assumption-based figures labelled ESTIMATED | Prevents confusion between observed and modelled values | Verified — UAT passed |