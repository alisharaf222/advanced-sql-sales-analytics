/*
===============================================================================
Performance Analysis (Year-over-Year, Month-over-Month)
===============================================================================
Purpose:
    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track yearly trends and growth.

SQL Functions Used:
    - LAG(): Accesses data from previous rows.
    - AVG() OVER(): Computes average values within partitions.
    - CASE: Defines conditional logic for trend analysis.
===============================================================================
*/

-- ===============================================================================
-- Query 1: Yearly Product Sales Performance vs Average & Previous Year (YoY)
-- (For each product per year: how do sales compare to the product's own average, 
--  and how do they compare to the previous year's sales — growth or decline?)
-- ===============================================================================
  
USE [DataWarehouseAnalytics];
GO


  with product_sales_by_years as
       (
       select 
        year(s.order_date) as order_year ,
        p.product_name as product_name,
        sum(s.sales_amount) as current_sales
        from gold.dim_products p join gold.fact_sales s
        on s.product_key =p.product_key
        where year(s.order_date) is not null
        group by year(order_date),product_name
        )
  select 
  order_year,
  product_name,
  current_sales,
  avg(current_sales)over(partition by product_name) - current_sales as diff_avg,
  avg(current_sales)over(partition by product_name) as avg_sales,
  case when avg(current_sales)over(partition by product_name) - current_sales > 0 then 'above avg'
       when avg(current_sales)over(partition by product_name) - current_sales < 0 then 'below avg'
       else 'equal' end  avg_change ,
  lag(current_sales) over(partition by product_name order by order_year ) as Last_year_sales ,--problem
 ( current_sales - lag(current_sales) over(partition by product_name order by order_year ) ) as diff_cu_last,
 case when  current_sales - lag(current_sales) over(partition by product_name order by order_year ) > 0 then 'increase'
      when  current_sales - lag(current_sales) over(partition by product_name order by order_year ) < 0 then 'Decrease'
      else 'no change' end  last_year_change
  from product_sales_by_years
  order by product_name,order_year 

