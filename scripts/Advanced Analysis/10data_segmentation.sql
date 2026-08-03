/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - To group data into meaningful categories for targeted insights.
    - For customer segmentation, product categorization, or regional analysis.

SQL Functions Used:
    - CASE: Defines custom segmentation logic.
    - GROUP BY: Groups data into segments.
===============================================================================
*/

use DataWarehouseAnalytics;
go

-- ===============================================================================
-- Query 1: Product Segmentation by Cost Range
-- (How many products fall into each cost range/tier?)
-- ===============================================================================
with segment_products_table as 
(
    select 
    product_key,
    product_name,
    cost,
    case when cost < 100 then 'below 100'
         when cost between 100 and 500 then '100 - 500'
         when cost between 500 and 1000 then '500 - 1000'
         else 'above 1000' end range_of_cost
    from gold.dim_products
    )
    select 
   range_of_cost,
   count(product_key) as total_products
   from segment_products_table
    group by range_of_cost 
    order by total_products desc



-- ===============================================================================
-- Query 2: Customer Segmentation by Spending Behavior (VIP / Regular / New)
-- (How many customers fall into each behavioral segment based on tenure and total spend?)
-- ===============================================================================
with segment as
   (
        select 
        c.customer_key,
        sum(sales_amount) as total_sales,
        min(order_date) as first_order,
        max(order_date)as last_order, 
        datediff(month,min(order_date),max(order_date)) as life_span
        from gold.fact_sales s left join gold.dim_customers c
        on s.customer_key =c.customer_key
        group by c.customer_key 
   )

select
count(se.customer_key),
case when life_span >= 12 and total_sales >= 5000 then 'vip'
     when life_span >= 12 and total_sales <= 5000 then 'regular'
     else 'new' end customers_segmentation 
from segment se 
group by case when life_span >= 12 and total_sales >= 5000 then 'vip'
     when life_span >= 12 and total_sales <= 5000 then 'regular'
     else 'new' end 

