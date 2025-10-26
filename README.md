# 📊 Subscription Cohort & Retention Analysis

## 🎯 Project Goal
The goal of this project is to analyze **user subscription behavior** using cohort and retention analysis techniques.  
It identifies **retention patterns**, **revenue performance**, and **churn behavior** across customer cohorts to improve **Customer Lifetime Value (CLV)** and reduce **churn rate**.

---

## 🎯 Objective
This project performs an end-to-end **Subscription Cohort & Retention Analysis pipeline** — from **data cleaning in Python** to **data modeling in Power BI** using **PostgreSQL** as the data source.

Key objectives include:
- Tracking subscription performance across cohorts and time.
- Measuring churn and retention rates.
- Analyzing revenue retention and customer lifetime.
- Building interactive dashboards for business decision-making.

---

## 🔧 Project Workflow

### **Phase 1 — Data Preparation & Inspection (Python)**
**Dataset Source:** Maven Analytics — Subscription Dataset  

**Columns:**
`customer_id`, `created_date`, `canceled_date`, `subscription_cost`, `subscription_interval`, `was_subscription_paid`

**Steps:**
- Cleaned and standardized data using **Pandas**.
- Created derived columns:
  - `active_status`
  - `subscription_duration`
  - `cohort_month`
  - `active_month`
  - `cohort_index`
- Calculated retention and churn metrics per cohort.
- Exported clean files:
  - `final_cleaned_subscriptions_user.csv`
  - `cohort_data.csv`
  - `retention_metrics.csv`

**Summary Stats:**
| Metric | Value |
|--------|-------|
| Total Customers | 2,877 |
| Total Subscriptions | 3,069 |
| Active Customers | 1,065 |
| Churned Customers | 1,938 |
| Re-subscribers | 185 |
| Total Revenue | ₹1,14,504 |
| ARPU | ₹39.80 |
| Avg Subscription Duration | 84.84 days |
| Max Duration | 394 days |

---

### **Phase 2 — SQL Analysis (PostgreSQL)**

Cleaned data imported into PostgreSQL for cohort and retention analysis.

**Schema Tables:**
- `subscriptions_user`
- `cohort_data`
- `retention_metrics`

**Key SQL Queries:**
```sql
-- Active vs Canceled Users
SELECT active_status, COUNT(*) AS total_customers
FROM subscriptions_user
GROUP BY active_status;

-- Cohort Retention Summary
CREATE OR REPLACE VIEW v_retention_summary AS
SELECT cohort_month,
       ROUND(AVG(retention_rate)*100, 2) AS avg_retention_percent,
       MAX(cohort_size) AS cohort_size
FROM retention_metrics
GROUP BY cohort_month
ORDER BY cohort_month;

-- Revenue by Cohort
CREATE OR REPLACE VIEW v_revenue_by_cohort AS
SELECT cohort_month,
       SUM(subscription_cost) AS total_revenue,
       ROUND(AVG(subscription_cost), 2) AS avg_revenue_per_user,
       COUNT(DISTINCT customer_id) AS total_customers
FROM subscriptions_user
GROUP BY cohort_month
ORDER BY cohort_month;
```

These SQL views were later connected to Power BI for dashboard building.

### **Phase 3 — Data Modeling (Power BI Model View)**
Before visualization, data modeling was done to define proper relationships.

Model Components:

Fact Tables:

subscriptions_user

cohort_data

retention_metrics

SQL Views: v_revenue_by_cohort, v_retention_summary

Dimension Tables:

Cohort_Dim

Customer_Dim

Relationships:

One-to-many between Customer_Dim.customer_id → subscription tables.

One-to-many between Cohort_Dim.cohort_month → cohort tables.

Bi-directional filtering enabled for accurate monthly aggregation.

📘 Model Screenshot: <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/74383a34-eec4-43b8-a69d-faccbeeb4689" />



### **Phase 4 — Power BI Dashboard**
#### 🟩 Page 1 — Subscription Overview & KPIs
KPIs:

Total Users

Active Subscribers

Churned Subscribers

Re-subscribers

ARPU

Total Revenue

Visuals:

Monthly Active vs Canceled

Revenue Growth Over Time

Active vs Canceled Pie

Customer Growth Trend

📈 Insight: 37% customers are active; churn spikes mid-year after revenue peak.

Dashboard:
<img width="1030" height="604" alt="image" src="https://github.com/user-attachments/assets/d2191746-1a06-4a17-8ff4-8aa8881256e8" />



#### 🟨 Page 2 — Cohort & Retention Dashboard
KPIs:

Metric	Value
Avg Retention Rate	18.98%
Avg Churn Rate	81.02%
Best Cohort	Sept 2023
Worst Cohort	Nov 2022
Cohorts Tracked	13 Months

Visuals:

Retention Heatmap

Monthly Churn Trend

Cohort Size vs Retention

📈 Insight: Retention improved 5× in later cohorts, showing product improvements.

Dashboard:
<img width="1000" height="700" alt="image" src="https://github.com/user-attachments/assets/9582b2a7-6322-40ae-bdd0-39a14f224e7f" />

**Customer Retention Matrix**:
<img width="1129" height="642" alt="image" src="https://github.com/user-attachments/assets/6e7e9ae5-215f-4538-93a2-2a117139b999" />



#### ⚪ Page 3 — Churn & Customer Performance
KPIs:

Metric	Value
Avg Revenue per Active User	₹39.00
Revenue Lost (Churned)	₹73.36K
Revenue Retained	₹41K
Avg Customer Lifetime	85 days
Avg CLV	₹3.38K

Visuals:

CLV by Cohort

Revenue by Retention Status

Top 5 Cohorts by Revenue

📈 Insight: ~65% of potential revenue (~₹73K) lost to churn; re-engagement can recover value.
Dashboard:
<img width="966" height="610" alt="image" src="https://github.com/user-attachments/assets/16eb2087-eeb5-40f3-a189-eeb68b1bc7e1" />


### Tools & Technologies Used
Tool	Purpose
Python (Pandas, Matplotlib, Seaborn)	Data cleaning & preprocessing
PostgreSQL	Retention, churn, and cohort SQL analysis
Power BI	Data modeling & interactive dashboards
CSV Files	Exported intermediate data

### Key Insights
Most churn occurs within the first 3 months.

Annual/Quarterly plans retain 25% more users.

Later cohorts (post promotions) show 15–20% higher retention.

Retention stabilizes beyond Month 8 — indicates loyal users.

CLV growth stabilizes after 6 months.

###  Learning Outcomes
Gained understanding of Cohort & Retention Analysis using SQL + Power BI.

Learned data modeling and relationship creation in Power BI.

Enhanced storytelling through visual trends in churn and revenue behavior.

Strengthened SQL view creation and integration with BI tools.

###  Deliverables
subscriptions_user.csv — Cleaned dataset

cohort_data.csv — Cohort level data

retention_metrics.csv — Retention metrics

SQL scripts (.sql)

Power BI dashboard (.pbix)

### Author
Sindhu Pamula — Data Analytics Enthusiast
Exploring cohort retention, churn metrics, and visualization storytelling.

📧 Email: sindhupamula13@gmail.com
🌐 LinkedIn: linkedin.com/in/sindhu-pamula-ba5b24226

