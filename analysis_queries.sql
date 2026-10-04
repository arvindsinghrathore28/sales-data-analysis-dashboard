-- HaystackAnalytics-style Sales Data Analysis Project
-- Database: MySQL / PostgreSQL compatible with minor date-function changes

CREATE TABLE sales_data (
    Order_ID VARCHAR(20),
    Order_Date DATE,
    Product VARCHAR(50),
    Region VARCHAR(30),
    Sales_Channel VARCHAR(30),
    Units INT,
    Unit_Price DECIMAL(10,2),
    Discount_Pct DECIMAL(5,2),
    Revenue DECIMAL(12,2)
);

-- 1. Total revenue and units
SELECT
    SUM(Revenue) AS total_revenue,
    SUM(Units) AS total_units,
    COUNT(*) AS total_orders
FROM sales_data;

-- 2. Revenue by product
SELECT
    Product,
    SUM(Revenue) AS revenue,
    SUM(Units) AS units,
    COUNT(*) AS orders
FROM sales_data
GROUP BY Product
ORDER BY revenue DESC;

-- 3. Revenue by region
SELECT
    Region,
    SUM(Revenue) AS revenue,
    SUM(Units) AS units,
    COUNT(*) AS orders
FROM sales_data
GROUP BY Region
ORDER BY revenue DESC;

-- 4. Monthly revenue
SELECT
    EXTRACT(YEAR FROM Order_Date) AS year,
    EXTRACT(MONTH FROM Order_Date) AS month,
    SUM(Revenue) AS revenue
FROM sales_data
GROUP BY EXTRACT(YEAR FROM Order_Date), EXTRACT(MONTH FROM Order_Date)
ORDER BY year, month;

-- 5. Average order value
SELECT
    AVG(Revenue) AS average_order_value
FROM sales_data;

-- 6. Sales channel performance
SELECT
    Sales_Channel,
    SUM(Revenue) AS revenue,
    COUNT(*) AS orders
FROM sales_data
GROUP BY Sales_Channel
ORDER BY revenue DESC;

-- 7. Top products by revenue
SELECT Product, SUM(Revenue) AS revenue
FROM sales_data
GROUP BY Product
ORDER BY revenue DESC
LIMIT 5;
