/*
Ranking Analysis
*/
USE [DataWarehouseAnalytics];
GO
--  5 products Generating the Highest Revenue
 select top 5
     p.product_name ,
     sum(s.sales_amount)as Highest_total_sales,
     rank() over(order by sum(s.sales_amount) desc ) as rank_of_products
 from gold.fact_sales s join gold.dim_products p
     on s.product_key =p.product_key 
 group by p.product_name
 
 
-- the 5 worst-performing products in terms of sales
select top 5
     p.product_name ,
     sum(s.sales_amount)as worst_total_sales,
     rank() over(order by sum(s.sales_amount) asc ) as rank_of_products
 from gold.fact_sales s join gold.dim_products p
     on s.product_key =p.product_key 
 group by product_name
 
 
-- Find the top 10 customers who have generated the highest revenue
select top 10 
    first_name+' '+last_name as customer_name ,
    sum(sales_amount) as total_sales,
    row_number() over(order by sum(sales_amount) desc) as rank_of_TheBest_customers
from gold.dim_customers c join gold.fact_sales s
    on c.customer_key =s.customer_key 
group by first_name+' '+last_name


-- The 3 customers with the fewest orders placed
select top 3
    first_name+' '+last_name as customer_name ,
    count(order_number) as total_orders,
    row_number() over(order by count(order_number) asc) as rank_of_worest_customers
from gold.dim_customers c join gold.fact_sales s
    on c.customer_key =s.customer_key 
group by first_name+' '+last_name

