/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - To compare performance or metrics across dimensions or time periods.
    - To evaluate differences between categories.
    - Useful for A/B testing or regional comparisons.

SQL Functions Used:
    - SUM(), AVG(): Aggregates values for comparison.
    - Window Functions: SUM() OVER() for total calculations.
===============================================================================
*/



-- ===============================================================================
-- Query 1: Sales Contribution by Category (% of Total)
-- (Which product categories contribute the most to overall sales, and by what percentage?)
-- ===============================================================================
USE [DataWarehouseAnalytics];
GO

with category_table as
 (
    select 
    category as category_name,
    sum(sales_amount)as total_sales
    from
    gold.fact_sales s join gold.dim_products p
    on s.product_key = p.product_key
    group by category 
   
)
select 
category_name,
total_sales,
sum(total_sales)over() overall_sales,
concat(round((cast(total_sales as float) / sum(total_sales)over()*100),2),'%') as dis_of_category
from category_table
group by category_name ,total_sales
order by dis_of_category desc
