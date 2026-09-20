USE retail_sales_analysis;

-- 1. DATA QUALITY & OVERVIEW
SELECT COUNT(*) AS total_transactions,
       COUNT(DISTINCT customer_id) AS unique_customers
FROM sales_data;

SELECT COUNT(*) AS customer_records,
       COUNT(DISTINCT customer_id) AS unique_customer_ids
FROM customer_data;

SELECT COUNT(*) AS missing_customer_ids
FROM sales_data s
LEFT JOIN customer_data c ON s.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- 2. REVENUE PERFORMANCE
SELECT ROUND(SUM(quantity * price), 2) AS total_revenue
FROM sales_data;

SELECT category,
       ROUND(SUM(quantity * price), 2) AS revenue,
       SUM(quantity) AS units_sold
FROM sales_data
GROUP BY category
ORDER BY revenue DESC;

SELECT shopping_mall,
       ROUND(SUM(quantity * price), 2) AS revenue,
       COUNT(*) AS transactions
FROM sales_data
GROUP BY shopping_mall
ORDER BY revenue DESC;

SELECT category,
       ROUND(SUM(quantity * price), 2) AS revenue,
       ROUND(100 * SUM(quantity * price) /
             (SELECT SUM(quantity * price) FROM sales_data), 2) AS revenue_pct
FROM sales_data
GROUP BY category
ORDER BY revenue_pct DESC;

-- 3. CUSTOMER BEHAVIOR
SELECT c.gender,
       COUNT(DISTINCT c.customer_id) AS customers,
       ROUND(SUM(s.quantity * s.price), 2) AS revenue,
       ROUND(AVG(s.quantity * s.price), 2) AS avg_transaction_value
FROM customer_data c
JOIN sales_data s ON c.customer_id = s.customer_id
GROUP BY c.gender
ORDER BY revenue DESC;

SELECT c.payment_method,
       COUNT(*) AS transactions,
       ROUND(SUM(s.quantity * s.price), 2) AS revenue
FROM customer_data c
JOIN sales_data s ON c.customer_id = s.customer_id
GROUP BY c.payment_method
ORDER BY revenue DESC;

SELECT customer_id,
       ROUND(SUM(quantity * price), 2) AS total_spend,
       COUNT(*) AS transaction_count
FROM sales_data
GROUP BY customer_id
ORDER BY total_spend DESC
LIMIT 10;

-- 4. AGE-BASED ANALYSIS
WITH customer_age_groups AS (
    SELECT customer_id,
           CASE
               WHEN age BETWEEN 18 AND 25 THEN '18-25'
               WHEN age BETWEEN 26 AND 35 THEN '26-35'
               WHEN age BETWEEN 36 AND 45 THEN '36-45'
               WHEN age BETWEEN 46 AND 55 THEN '46-55'
               ELSE '56+'
           END AS age_group
    FROM customer_data
)
SELECT a.age_group,
       COUNT(DISTINCT a.customer_id) AS customers,
       ROUND(SUM(s.quantity * s.price), 2) AS revenue
FROM customer_age_groups a
JOIN sales_data s ON a.customer_id = s.customer_id
GROUP BY a.age_group
ORDER BY revenue DESC;

-- 5. MONTHLY SALES TREND
SELECT DATE_FORMAT(invoice_date, '%Y-%m') AS sales_month,
       ROUND(SUM(quantity * price), 2) AS revenue,
       COUNT(*) AS transactions
FROM sales_data
GROUP BY DATE_FORMAT(invoice_date, '%Y-%m')
ORDER BY sales_month;

-- 6. CUSTOMER SEGMENTATION
WITH customer_spend AS (
    SELECT customer_id, SUM(quantity * price) AS total_spend
    FROM sales_data
    GROUP BY customer_id
),
segmented AS (
    SELECT customer_id,
           total_spend,
           CASE
               WHEN total_spend < 1000 THEN 'Low Value'
               WHEN total_spend < 3000 THEN 'Medium Value'
               ELSE 'High Value'
           END AS customer_segment
    FROM customer_spend
)
SELECT customer_segment,
       COUNT(*) AS customers,
       ROUND(SUM(total_spend), 2) AS segment_revenue,
       ROUND(AVG(total_spend), 2) AS avg_customer_spend
FROM segmented
GROUP BY customer_segment
ORDER BY segment_revenue DESC;

-- 7. WINDOW FUNCTION: CATEGORY RANKING
WITH category_sales AS (
    SELECT category, SUM(quantity * price) AS revenue
    FROM sales_data
    GROUP BY category
)
SELECT category,
       ROUND(revenue, 2) AS revenue,
       DENSE_RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
FROM category_sales
ORDER BY revenue_rank;

-- 8. TOP CUSTOMER WITHIN EACH MALL
WITH customer_mall_spend AS (
    SELECT shopping_mall,
           customer_id,
           SUM(quantity * price) AS spend
    FROM sales_data
    GROUP BY shopping_mall, customer_id
),
ranked AS (
    SELECT shopping_mall,
           customer_id,
           spend,
           ROW_NUMBER() OVER (
               PARTITION BY shopping_mall
               ORDER BY spend DESC
           ) AS rn
    FROM customer_mall_spend
)
SELECT shopping_mall,
       customer_id,
       ROUND(spend, 2) AS spend
FROM ranked
WHERE rn = 1
ORDER BY spend DESC;

-- 9. CATEGORY x GENDER ANALYSIS
SELECT c.gender,
       s.category,
       ROUND(SUM(s.quantity * s.price), 2) AS revenue
FROM sales_data s
JOIN customer_data c ON s.customer_id = c.customer_id
GROUP BY c.gender, s.category
ORDER BY c.gender, revenue DESC;

-- 10. AVERAGE ORDER VALUE BY SHOPPING MALL
SELECT shopping_mall,
       ROUND(AVG(quantity * price), 2) AS avg_order_value,
       COUNT(*) AS transactions
FROM sales_data
GROUP BY shopping_mall
ORDER BY avg_order_value DESC;
