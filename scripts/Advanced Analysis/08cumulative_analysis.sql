/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
===============================================================================
use DataWarehouseAnalytics;
Go */





-- ===============================================================================
-- Query 1: Yearly Running Total & Moving Average of Sales
-- (What is the cumulative sales trend year over year, and how does the average sale evolve?)
-- ===============================================================================
with performane_over_year as 
(
select
datetrunc(year ,order_date)as order_date,
sum(sales_amount) as total_sales,
avg(sales_amount) as avg_sales
from gold.fact_sales
where order_date is not null
group by datetrunc(year ,order_date)

)
select 
order_date ,
total_sales,
sum(total_sales) over(order by order_date) as runing_total_sale,
avg(avg_sales) over(order by order_date) as runing_avg_sale
from performane_over_year;



-- ===============================================================================
-- Query 2: Monthly Running Total & Moving Average of Sales
-- (What is the cumulative sales trend month over month, and how does the average sale evolve?)
-- ===============================================================================
with performane_over_months as 
(
select
datetrunc(month ,order_date)as order_date,
sum(sales_amount) as total_sales,
avg(sales_amount) as avg_sales
from gold.fact_sales
where order_date is not null
group by datetrunc(month ,order_date)

)
select 
order_date ,
total_sales,
sum(total_sales) over(order by order_date) as runing_total_sale,
avg(avg_sales) over(order by order_date) as runing_avg_sale

from performane_over_months;








