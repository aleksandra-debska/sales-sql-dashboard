/* PROJECT: Superstore Sales Performance Analysis
PURPOSE: Extracting Key Performance Indicators to support business decisions
DATASET: Superstore Sales (Retail)
*/

-- Set numeric format for consistency
ALTER SESSION SET NLS_NUMERIC_CHARACTERS = '.,';

-- 1. Data Validation and Scope
-- Checking the total volume of transactions and the time period of the analysis
SELECT COUNT(*) AS total_transactions FROM sales;

-- 2. Data Time Range
-- Identifying the time range of the dataset
SELECT 
    MIN(order_date) AS data_start, 
    MAX(order_date) AS data_end 
FROM sales;

-- 3. Global Revenue
-- High-level KPI for management overview
SELECT SUM(sales) AS total_revenue FROM sales;

-- 4. Product Performance Analysis
-- Identifying which product categories drive the most revenue
SELECT 
    category,
    SUM(sales) AS total_sales
FROM sales
GROUP BY category
ORDER BY total_sales DESC;

-- 5. Customer Segmentation
-- Analyzing which customer group is the most valuable (Consumer, Corporate, or Home Office)
SELECT 
    segment,
    SUM(sales) AS total_sales
FROM sales
GROUP BY segment
ORDER BY total_sales DESC;

-- 6. Regional Sales Distribution
-- Analyzing regional sales distribution to identify key geographical markets
SELECT 
    region,
    SUM(sales) AS total_sales
FROM sales
GROUP BY region
ORDER BY total_sales DESC;

-- 7. Top 10 Best-Selling Products
-- Identifying flagship products that generate the highest volume
SELECT * FROM (
    SELECT 
        product_name,
        SUM(sales) AS total_sales
    FROM sales
    GROUP BY product_name
    ORDER BY total_sales DESC
) WHERE ROWNUM <= 10;

-- 8. Sales Trend Analysis by Year
-- Analyzing annual revenue trends to evaluate business growth over time
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    SUM(sales) AS total_sales
FROM sales
GROUP BY EXTRACT(YEAR FROM order_date)
ORDER BY year;

ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY';
SELECT * FROM sales