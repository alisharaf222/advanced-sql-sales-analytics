/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality/patterns.

SQL Functions Used:
    - Date Functions: DATETRUNC(), FORMAT()
    - Aggregate Functions: SUM(), COUNT()
===============================================================================
*/
use [DataWarehouseAnalytics];
GO


-- ===============================================================================
-- Query 1: Yearly Sales Performance Trend
-- (Analyse sales performance over years: total sales, customers, and quantity per year)
-- ===============================================================================
Select 
DATETRUNC(YEAR,order_date) as the_date,
SUM(sales_amount)as total_sales ,
COUNT(customer_id)as total_customers,
SUM(quantity)as total_quantity
from 
gold.fact_sales s join gold.dim_customers c 
on s.customer_key =c.customer_key 
join gold.dim_products p 
on s.product_key=p.product_key 
group by DATETRUNC(YEAR,order_date)
having DATETRUNC(YEAR,order_date) is not null
order by DATETRUNC(YEAR,order_date) asc


-- ===============================================================================
-- Query 2: Monthly Sales Performance Trend
-- (Analyse sales performance over months: total sales, customers, and quantity per month)
-- ===============================================================================
Select 
FORMAT(order_date ,'yyyy,MMM') as the_date,
SUM(sales_amount)as total_sales ,
COUNT(customer_id)as total_customers,
SUM(quantity)as total_quantity
from 
gold.fact_sales s join gold.dim_customers c 
on s.customer_key =c.customer_key 
join gold.dim_products p 
on s.product_key=p.product_key 
group by FORMAT(order_date ,'yyyy,MMM') 
having FORMAT(order_date ,'yyyy,MMM')  is not null
order by FORMAT(order_date ,'yyyy,MMM')  asc


-- ===============================================================================
-- Query 3: Total Sales per Product by Country
-- (Which products generate the most sales, broken down by customer country?)
-- ===============================================================================
SELECT 
p.product_name,
sum(s.sales_amount)as total_sales,
c.country
FROM gold.dim_products p 
JOIN gold.fact_sales s ON p.product_key = s.product_key
JOIN gold.dim_customers c ON s.customer_key = c.customer_key
GROUP BY p.product_name, c.country
ORDER BY c.country DESC;