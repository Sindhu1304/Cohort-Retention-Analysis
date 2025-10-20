CREATE TABLE subscriptions_user (
    customer_id BIGINT,
    created_date DATE,
    canceled_date DATE,
    subscription_cost INT,
    subscription_interval VARCHAR(20),
    was_subscription_paid VARCHAR(10),
    active_status VARCHAR(20),
    subscription_duration INT,
    cohort_month VARCHAR(10),
    subscription_id INT
);

CREATE TABLE cohort_data (
    customer_id BIGINT,
    created_date DATE,
    canceled_date DATE,
    subscription_cost INT,
    subscription_interval VARCHAR(20),
    was_subscription_paid VARCHAR(10),
    active_status VARCHAR(20),
    subscription_duration INT,
    cohort_month VARCHAR(10),
    subscription_id INT,
    active_month VARCHAR(10),
    cohort_index INT
);


CREATE TABLE retention_metrics (
    cohort_month VARCHAR(10),
    active_month VARCHAR(10),
    active_users INT,
    cohort_size INT,
    retention_rate NUMERIC,
    cohort_index INT
);

SELECT COUNT(*) FROM subscriptions_user;
SELECT COUNT(*) FROM cohort_data;
SELECT COUNT(*) FROM retention_metrics;

SELECT * FROM subscriptions_user LIMIT 5;


----- BASIC EXPLORATION (DATA QUALITY CHECKS)
-- 1. Total records and unique customers
SELECT 
    COUNT(*) AS total_records,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM subscriptions_user;

-- 2. Check active vs canceled subscriptions
SELECT 
    active_status,
    COUNT(*) AS total_customers
FROM subscriptions_user
GROUP BY active_status;

-- 3. Monthly new subscribers trend
SELECT 
    TO_CHAR(created_date, 'YYYY-MM') AS month,
    COUNT(DISTINCT customer_id) AS new_subscribers
FROM subscriptions_user
GROUP BY month
ORDER BY month;

------ SUBSCRIPTION INSIGHTS


-- 4. Total revenue generated 
SELECT 
    SUM(subscription_cost) AS total_revenue,
    AVG(subscription_cost) AS avg_revenue_per_user
FROM subscriptions_user
WHERE was_subscription_paid = 'Yes';

-- 5. Average subscription duration by status
SELECT 
    active_status,
    ROUND(AVG(subscription_duration), 2) AS avg_duration_days
FROM subscriptions_user
GROUP BY active_status;

-- 6. Churn rate calculation (based on active vs canceled)
SELECT 
    (SUM(CASE WHEN active_status = 'Canceled' THEN 1 ELSE 0 END)::FLOAT /
     COUNT(*)) * 100 AS churn_rate_percent
FROM subscriptions_user;



----- COHORT & RETENTION ANALYTICS
-- 7. Retention trend by cohort (directly from retention_metrics table)
SELECT 
    cohort_month,
    ROUND(AVG(retention_rate)*100, 2) AS avg_retention_percent
FROM retention_metrics
GROUP BY cohort_month
ORDER BY cohort_month;

-- 8. Cohort size overview
SELECT 
    cohort_month,
    MAX(cohort_size) AS cohort_size,
    COUNT(DISTINCT active_month) AS months_tracked
FROM retention_metrics
GROUP BY cohort_month
ORDER BY cohort_month;

-- 9. Monthly active users from cohort_data
SELECT 
    active_month,
    COUNT(DISTINCT customer_id) AS active_users
FROM cohort_data
GROUP BY active_month
ORDER BY active_month;


------ PERFORMANCE SUMMARY VIEWS
-- 10. View: retention summary by cohort
CREATE OR REPLACE VIEW v_retention_summary AS
SELECT 
    cohort_month,
    ROUND(AVG(retention_rate)*100, 2) AS avg_retention_percent,
    MAX(cohort_size) AS cohort_size,
    COUNT(DISTINCT active_month) AS months_tracked
FROM retention_metrics
GROUP BY cohort_month
ORDER BY cohort_month;

-- 11. View: monthly active vs churned
CREATE OR REPLACE VIEW v_monthly_status AS
SELECT 
    TO_CHAR(created_date, 'YYYY-MM') AS month,
    SUM(CASE WHEN active_status = 'Active' THEN 1 ELSE 0 END) AS active_users,
    SUM(CASE WHEN active_status = 'Canceled' THEN 1 ELSE 0 END) AS churned_users
FROM subscriptions_user
GROUP BY month
ORDER BY month;

-- 12. View: revenue by cohort
CREATE OR REPLACE VIEW v_revenue_by_cohort AS
SELECT 
    s.cohort_month,
    SUM(s.subscription_cost) AS total_revenue,
    ROUND(AVG(s.subscription_cost), 2) AS avg_revenue_per_user,
    COUNT(DISTINCT s.customer_id) AS total_customers
FROM subscriptions_user s
GROUP BY s.cohort_month
ORDER BY s.cohort_month;

