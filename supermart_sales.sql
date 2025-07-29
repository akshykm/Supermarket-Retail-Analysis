-- Create Database
CREATE DATABASE supermarket_sales;

-- Switch to the database
\c supermarket_sales;

-- Drop the table if it already exists --
DROP TABLE IF EXISTS supermarket_sales;

CREATE TABLE supermarket_sales (
    Order_ID VARCHAR,
    Customer_Name VARCHAR,
    Category VARCHAR,
    Sub_Category VARCHAR,
    City VARCHAR,
    Order_Date DATE,
    Region VARCHAR,
    Sales NUMERIC,
    Discount NUMERIC,
    Profit NUMERIC,
    store_state VARCHAR
);

--IMPORT CSV FILE 
copy 
supermarket_sales(order_ID, customer_name,	category, sub_category,	city, order_date, region, sales, discount,	profit,	store_state)
from 'C:\Users\91767\Downloads\Supermarket Retail Analytics Dataset (1).csv'
delimiter','
csv header;

Select * From supermarket_sales

-- Preview Data--
SELECT * FROM supermarket_sales
LIMIT 10;

-- Row Count --
SELECT COUNT(*) AS total_rows FROM supermarket_sales;

-- Chech Null Values --
SELECT 
    COUNT(*) FILTER (WHERE order_id IS NULL) AS null_order_id,
    COUNT(*) FILTER (WHERE customer_name IS NULL) AS null_customer_name,
    COUNT(*) FILTER (WHERE category IS NULL) AS null_category,
    COUNT(*) FILTER (WHERE sub_category IS NULL) AS null_sub_category,
    COUNT(*) FILTER (WHERE city IS NULL) AS null_city,
    COUNT(*) FILTER (WHERE order_date IS NULL) AS null_order_date,
    COUNT(*) FILTER (WHERE region IS NULL) AS null_region,
    COUNT(*) FILTER (WHERE sales IS NULL) AS null_sales,
    COUNT(*) FILTER (WHERE discount IS NULL) AS null_discount,
    COUNT(*) FILTER (WHERE profit IS NULL) AS null_profit
FROM supermarket_sales;

SELECT 
  TO_CHAR(order_date, 'DD-MM-YYYY') AS formatted_date
FROM 
  supermarket_sales;

--Cities and Their Regions--
SELECT DISTINCT city, region
FROM supermarket_sales
ORDER BY city;
--\\ Only vellore city has North region \\--

SELECT city, COUNT(DISTINCT region) AS region_count
FROM supermarket_sales
GROUP BY city
HAVING COUNT(DISTINCT region) > 1;

SELECT DISTINCT city, region
FROM supermarket_sales
WHERE city IN (
  SELECT city
  FROM supermarket_sales
  GROUP BY city
  HAVING COUNT(DISTINCT region) > 1
)
ORDER BY city, region;

--dataset has inconsistent Region values for the same City.-- 
--For example: Bodi is associated with South, Central, East, West--
--Chennai is associated with South, Central, East, West--
--Similar inconsistencies exist for other Tamil Nadu cities.--

--Let’s fix this by mapping each city in Tamil Nadu to "South", then update the Region column accordingly.--
UPDATE supermarket_sales
SET region = 'South';

-- Basic Descriptive Stats --
SELECT 
    ROUND(AVG(sales), 2) AS avg_sales,
    ROUND(MIN(sales), 2) AS min_sales,
    ROUND(MAX(sales), 2) AS max_sales,
    ROUND(AVG(profit), 2) AS avg_profit,
    ROUND(AVG(discount), 2) AS avg_discount
FROM supermarket_sales;

-- Descriptive Statistics for Sales, Profit, and Discount--
SELECT
  COUNT(*) AS total_records,
  MIN(sales) AS min_sales,
  MAX(sales) AS max_sales,
  ROUND(AVG(sales), 2) AS avg_sales,
  ROUND(STDDEV(sales), 2) AS stddev_sales,
  
  MIN(profit) AS min_profit,
  MAX(profit) AS max_profit,
  ROUND(AVG(profit), 2) AS avg_profit,
  ROUND(STDDEV(profit), 2) AS stddev_profit,
  
  ROUND(AVG(discount), 2) AS avg_discount,
  ROUND(STDDEV(discount), 2) AS stddev_discount

FROM supermarket_sales;

--Count of Unique Values--
SELECT
  COUNT(DISTINCT category) AS unique_categories,
  COUNT(DISTINCT sub_category) AS unique_subcategories,
  COUNT(DISTINCT customer_name) AS unique_customers,
  COUNT(DISTINCT city) AS unique_city,
  COUNT(DISTINCT order_id) AS unique_transactions
FROM supermarket_sales;

--Exploratory Data Analysis--
--Total Sales Revenue--
SELECT SUM(sales) AS total_sales_revenue
FROM supermarket_sales;

--Total Profit--
SELECT SUM(profit) AS total_profit
FROM supermarket_sales;

--Highest profit--
SELECT *
FROM supermarket_sales
ORDER BY profit DESC
LIMIT 1;

--Highest Discount--
SELECT 
  order_id,
  ROUND(sales / (1 - discount), 2) AS original_price,
  discount,
  sales,
  ROUND((sales * discount) / (1 - discount), 2) AS discount_amount
FROM supermarket_sales
  ORDER BY discount_amount DESC
  LIMIT 1;

--Sales by Category--
SELECT category, ROUND(SUM(sales), 2) AS total_sales
FROM supermarket_sales
GROUP BY category
ORDER BY total_sales DESC;

--Sales by Sub-Category--
SELECT sub_category, ROUND(SUM(sales), 2) AS total_sales
FROM supermarket_sales
GROUP BY sub_category
ORDER BY total_sales DESC;

--Monthly Sales Trend--
SELECT 
    DATE_TRUNC('month', order_date) AS month,
    ROUND(SUM(sales), 2) AS monthly_sales
FROM supermarket_sales
GROUP BY month
ORDER BY month;

--Monthly Profit Trend--
SELECT 
  DATE_TRUNC('month', order_date) AS month,
  ROUND(SUM(profit), 2) AS total_profit
FROM supermarket_sales
GROUP BY month
ORDER BY month;

--Top 5 City by Sales--
SELECT 
    City, 
    ROUND(SUM(sales), 2) AS total_sales
FROM supermarket_sales
GROUP BY City
ORDER BY total_sales DESC
LIMIT 5;

--Top 5 Products by Profit--
SELECT 
    sub_category, 
    ROUND(SUM(profit), 2) AS total_profit
FROM supermarket_sales
GROUP BY sub_category
ORDER BY total_profit DESC
LIMIT 5;

--Profit Margin percentage by Sub-Category--
SELECT 
    sub_category,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND((SUM(profit)/SUM(sales)) * 100, 2) AS profit_margin_percentage
FROM supermarket_sales
GROUP BY sub_category
ORDER BY profit_margin_percentage DESC;

--High value customer--
SELECT 
  customer_name,
  count(sales) AS total_orders,
  ROUND(SUM(sales - profit), 2) AS price_before_profit,
  ROUND(SUM(sales), 2) AS total_sales,
  ROUND(SUM(profit), 2) AS total_profit,
  ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin_percent
FROM supermarket_sales
GROUP BY customer_name
ORDER BY profit_margin_percent DESC;


--Summary Table by Category--
SELECT
  category,
  ROUND(SUM(sales), 2) AS total_sales,
  ROUND(SUM(profit), 2) AS total_profit,
  ROUND(AVG(discount), 2) AS avg_discount,
  COUNT(*) AS total_orders
FROM supermarket_sales
GROUP BY category
ORDER BY total_sales DESC;

--Summary Table by Sub-Category--
SELECT 
  sub_category,
  ROUND(SUM(sales), 2) AS total_sales,
  ROUND(SUM(profit), 2) AS total_profit,
  ROUND(AVG(discount), 2) AS avg_discount,
  COUNT(*) AS total_orders
FROM supermarket_sales
GROUP BY sub_category
ORDER BY total_sales DESC;

--Sub-Category wise Profit 
SELECT 
  sub_category,
  ROUND(SUM(sales - profit), 2) AS price_before_profit,
  ROUND(SUM(sales), 2) AS total_sales,
  ROUND(SUM(profit), 2) AS total_profit,
  ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin_percent
FROM supermarket_sales
GROUP BY sub_category
ORDER BY price_before_profit DESC;

-- Top 10 high-value customers--
SELECT 
    customer_name,
    order_id,
    sales,
    profit
FROM 
    supermarket_sales
ORDER BY 
    Profit DESC
LIMIT 10;

--Low-profit high-value transactions--
SELECT 
    customer_name,
    order_id,
    sales,
    profit
FROM 
    supermarket_sales
WHERE 
    Sales > 2000 AND profit < 200
	ORDER BY profit ASC;

--Assuming Sales price is after discount price to find original price--
SELECT order_id,
  ROUND(sales / (1 - discount), 2) AS selling_price,
  discount,
  ROUND((sales * discount) / (1 - discount), 2) AS discount_amount,
  sales,
  profit
FROM 
  supermarket_sales;

SELECT 
  (sales - profit) AS product_cost,
  ROUND(sales / (1 - discount), 2) AS selling_price,
  discount,
  sales,
  profit
FROM 
  supermarket_sales;


Select * From supermarket_sales;







