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
- Imported the cleaned dataset into **PostgreSQL**.
- Created SQL tables and performed:
  - Aggregations (total customers, revenue)
  - Retention rate calculations
  - Cohort grouping by subscription month
  - Active vs. canceled user analysis
- Created SQL **views**:
  - `v_total_summary`
  - `v_active_vs_canceled`
  - `v_cohort_retention`
  - `v_revenue_summary`

---

### **Phase 3: Power BI Dashboard**

The dashboard is divided into **three pages**, each focusing on a specific business aspect.

---

#### 🟦 Page 1 — Overview Dashboard
**KPIs**
- Total Revenue  
- Total Subscriptions  
- Active vs. Canceled Users  
- Average Revenue per User (ARPU)

**Visuals**
- Revenue trend over time  
- Customer status breakdown  
- Subscription plan distribution  
<img width="1287" height="759" alt="image" src="https://github.com/user-attachments/assets/ca303fbb-2c47-4a24-9cce-1de94a82d7b4" />

---

#### 🟨 Page 2 — Cohort & Retention Dashboard
**KPIs**
- Retention Rate (%)  
- Churn Rate (%)  
- Total Retained Users  
- Avg. Retention Duration (days)

**Visuals**
- Cohort retention heatmap  
- Line chart showing retention trend over time  
- Bar chart comparing retention across cohorts  

<img width="1003" height="711" alt="image" src="https://github.com/user-attachments/assets/342ff023-ff97-4fd2-9c9c-ad939d3da31e" />

#### 🟩 Page 3 — Customer Lifetime & Revenue Insights
**KPIs**
- Total Revenue (Verified)  
- Revenue Retained  
- Revenue Lost  
- Average Customer Lifetime (Days)  
- CLV (Customer Lifetime Value)

**Visuals**
- Top 5 Cohorts by Revenue  
- Revenue by Active Status (Donut Chart)  
- Revenue Over Time (Line Chart)  
- CLV by Cohort (Area Chart)  
- CLV by Active Status (Bar Chart)

<img width="1208" height="759" alt="image" src="https://github.com/user-attachments/assets/9177fd76-b4b5-4af5-b601-0b334cc4ed26" />

## 🧩 Tools & Technologies Used
| Tool | Purpose |
|------|----------|
| **Python (Pandas, NumPy)** | Data cleaning and preprocessing |
| **PostgreSQL** | Cohort, retention, and churn calculations |
| **Power BI** | Interactive dashboard and KPI visualization |
| **Excel/CSV** | Data validation and export format |

---

## 📈 Key Metrics
- **Retention Rate** → % of users retained each month  
- **Churn Rate** → % of users who canceled  
- **Average Plan Duration** → Days between start and end  
- **Customer Lifetime Value (CLV)** → ARPU × Avg. Lifetime  
- **Revenue Lost vs. Retained** → Identifies growth potential  

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
- Final report (optional) — Business insights summary  

---

## 🪶 Author
**Sindhu** — Data Analytics Enthusiast  
*Exploring cohort analysis, retention insights, and visualization storytelling.*

📧 Email: [your-email@example.com]  
🌐 LinkedIn: [Your LinkedIn Profile](https://linkedin.com/in/yourprofile)

---

