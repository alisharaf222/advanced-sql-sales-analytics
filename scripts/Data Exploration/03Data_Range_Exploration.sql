/*
Date Range Exploration 
*/
USE [DataWarehouseAnalytics];
GO
-- first and last order date and the total duration in months
select min (order_date) as first_order,
max (order_date) as last_order ,
datediff(year,min(order_date),max(order_date)) as Diff_between_First_And_Last_order_by_year,
datediff(month,min(order_date),max(order_date)) as Diff_between_First_And_Last_order_by_month
from gold.fact_sales
-- youngest and oldest customer based on birthdate

select min(birthdate)as oldest_birhdate,
max(birthdate)as youngest_birthdate,
datediff(year ,min(birthdate) ,getdate()) as the_oldest,
datediff(year ,max(birthdate) ,getdate()) as the_youngest
from gold.dim_customers