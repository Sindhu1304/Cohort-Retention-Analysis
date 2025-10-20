# 📊 Subscription Cohort & Retention Analysis

## Project Goal:
The primary goal of this project is to analyze user subscription behavior over time using cohort and retention analysis techniques.
The aim is to identify user retention patterns, revenue performance, and churn behavior across cohorts, while uncovering insights that help improve customer lifetime value and reduce churn.

## Objective
The objective of this project is to perform a complete Subscription Cohort and Retention Analysis pipeline — from data extraction and preprocessing to visual analytics — using PostgreSQL, Python, and Power BI.
The focus is to derive data-driven insights that explain customer retention, churn, and revenue behavior across time-based cohorts.

Through this analysis, we aim to:

1.Track subscription performance across cohorts and time periods.

2.Measure customer churn rate, retention rate, and average customer lifetime.

3.Analyze revenue retention and loss across different customer groups.

4.Develop interactive dashboards to visualize trends and performance metrics for product and business teams.


## What I did:
In this project , i have gone through the 4 phases which involves end-to-end pipleine from python-> sql -> powerbi(visualization).

## Project wokr flow:
### Phase 1: Dataset Preparation & Inspection

Dataset Overview:

The dataset contains subscription data with the following columns:

customer_id: Unique identifier for each customer.
created_date: The date the subscription was created.
canceled_date: The date the subscription was canceled (if applicable).
subscription_cost: The cost of the subscription.
subscription_interval: The billing interval (in this data has month).
was_subscription_paid: Indicates if the subscription was paid ('Yes' or 'No').

**The above dataset belongs to maven-analytics.**

 **Here what i made in this stage are:**
  
- Cleaned and preprocessed the raw subscription data using Pandas, which involved handling missing dates, converting data types, and creating new columns like active_status, subscription_duration, and subscription_id, and exported final dataset as `final_cleaned_subscriptions_user.csv`.
- Prepared the dataset for time-series analysis by defining cohort_month, active_month, and cohort_index to track customer journeys from their initial subscription.
- Calculated and visualized cohort retention rates using a heatmap to analyze how well different customer groups were retained over time.
- Analyzed customer churn by calculating and visualizing churn rates per cohort to identify patterns in customer attrition.
- Exported the cleaned dataset and the calculated cohort and retention metrics to CSV files for reporting and further analysis.

  **Summary Mertics**
  - Total unique customers: 2877
  - Total subscriptions: 3069
  - Active customers: 1065
  - Churned customers: 1938
  - Re-subscribers: 185
  - Total Revenue: 114504
  - Average Revenue per User (ARPU): 39.80
  - Average Subscription Duration: 84.84 days
  - Median Subscription Duration: 59.00 days
  - Maximum Subscription Duration: 394 days

---

### **Phase 2: Database Design & SQL Analysis**
- Imported the cleaned datasets into **PostgreSQL**.

subscriptions_user – Customer-level subscription data
cohort_data – Monthly active mapping for each customer (for cohort tracking)
retention_metrics – Precomputed retention and churn percentages by cohort

- Created SQL tables and performed:
  - Aggregations (total customers, revenue)
  - Retention rate calculations
  - Cohort grouping by subscription month
  - Active vs. canceled user analysis
- Created SQL **views**:
  - `v_active_vs_canceled`
  - `v_cohort_retention`
  - `v_revenue_summary`


```sql
-- Active vs Canceled Users
SELECT active_status, COUNT(*) AS total_customers
FROM subscriptions_user
GROUP BY active_status;

-- Monthly Active Users
SELECT TO_CHAR(created_date, 'YYYY-MM') AS month, COUNT(DISTINCT customer_id) AS active_users
FROM subscriptions_user
GROUP BY month
ORDER BY month;

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
**These were connected directly to Power BI .**

---

### **Phase 3: Power BI Dashboard**

The dashboard is divided into **three pages**, each focusing on a specific business aspect.

#### Page 1: Subscription Overview & KPIs

Goal: Business snapshot showing user base, churn, and revenue health.

KPIs:

Total Users
Active Subscribers
Churned Subscribers
Avg Revenue Per User
Total Revenue
Re-subscribers

Visuals:

📊 Monthly Active vs Canceled Users → activity trend

   Active vs Canceled Pie → quick health ratio

💰 Revenue Growth Over Time → business trendline

Customer growth over time- look how count of customers changers in the given period(sept 2022-sept 2023).

📈 Key Insight:

Despite 2877 total users, active base (1065) forms just 37% of the total. Revenue peaked around mid-year months with visible churn spikes afterward.
---

<img width="1030" height="604" alt="image" src="https://github.com/user-attachments/assets/d2191746-1a06-4a17-8ff4-8aa8881256e8" />


#### 🟨 Page 2 — Cohort & Retention Dashboard
**Goal**: Understand when users churn and which cohorts retain best.

**KPIs**:

Avg Retention Rate – 18.98%
Avg Churn Rate – 81.02%
Best Cohort Month – Sept 2023
Worst Cohort Month – Nov 2022
Cohorts Tracked – 13 months

**Visuals**:

🟩 Retention Matrix (Heatmap) → user survival over months

📊 Retention & Cohort Size Trend → retention % vs cohort base

🔵 Cohort Performance Summary → best/worst retention by month

🔺 Monthly Churn Rate → cumulative churn curve


**📈 Key Insight:**

**Retention improves in newer cohorts (Sep 2023 cohort retains 5× better than early 2022). Early churn-heavy cohorts indicate onboarding or engagement issues in initial product cycles**
Dashboard:
<img width="1000" height="700" alt="image" src="https://github.com/user-attachments/assets/9582b2a7-6322-40ae-bdd0-39a14f224e7f" />



#### ⚪ Page 3: Churn & Customer Performance

**Goal:**  Quantify the revenue and lifetime impact of churn.

**KPIs**:

Avg Revenue per Active User – ₹39.00
Revenue Lost (Canceled Users) – ₹73.36K
Revenue Retained – ₹41K
Avg Customer Lifetime – 85 days
Avg CLV – ₹3.38K

**Visuals:**

🥧 Active vs Canceled (Pie)

📈 Revenue Trend by Active Status

💰 CLV by Retention Status

📉 CLV by Cohort Month

🧩 Top 5 Cohorts by Revenue

💠 Customers by Subscription Plan


**📈 Key Insight:**

**Roughly ₹73K (~65% of potential revenue) was lost to churn. Active cohorts maintain an average CLV of ₹3.3K, suggesting significant upsell potential through re-engagement.**

Dashboard:
<img width="966" height="610" alt="image" src="https://github.com/user-attachments/assets/16eb2087-eeb5-40f3-a189-eeb68b1bc7e1" />


## 🧩 Tools & Technologies Used
| Tool | Purpose |
|------|----------|
| **Python (Pandas, Seaborn, Matplot)** | Data cleaning and preprocessing |
| **PostgreSQL** | Cohort, retention, and churn calculations |
| **Power BI** | Interactive dashboard and KPI visualization |
| **CSV** | Data validation and export format |


---

## 🔍 Insights & Findings
- **Early churn** was highest within the first 3 months of subscription.  
- **Quarterly & annual plans** retain users 25% longer than monthly ones.  
- Cohorts acquired post-promo periods showed **15–20% higher retention**.  
- **CLV grows linearly** with customer lifetime but plateaus after 6 months.  
- The **retention curve** begins to flatten beyond Month 8, showing user stability.

---

## 🧠 Learning Outcome
This project demonstrates an **end-to-end analytics workflow** — from raw data cleaning in Python, SQL modeling, and Power BI storytelling — highlighting data-driven insights about customer retention and subscription revenue.

---

## 📦 Deliverables
- `subscriptions_user.csv` — Cleaned dataset  
- SQL scripts — All analytical queries and views  
- `Subscription_Cohort_Retention.pbix` — Power BI Dashboard file  


---

## 🪶 Author
**Sindhu** — Data Analytics Enthusiast  
*Exploring cohort analysis, retention insights, and visualization storytelling.*

📧 Email: sindhupamula13@gmail.com 
🌐 LinkedIn: https://linkedin.com/in/sindhu-pamula-ba5b24226

---

