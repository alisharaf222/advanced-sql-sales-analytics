/*

Measures Exploration (Key Metrics)

*/
USE [DataWarehouseAnalytics];
GO
--  Total Sales
select sum(sales_amount)as total_sales from gold.fact_sales 

--  items are sold

select count(dp.product_name) 
from gold.dim_products dp inner join
gold.fact_sales fs on dp.product_id =fs.product_key
where sales_amount <> 0
--  average selling price
select avg(sales_amount) as avg_sales from gold.fact_sales 

--  Total number of Orders
select count(order_number) as total_orders from gold.fact_sales

--  total number of products
select count(product_id)as total_products from gold.dim_products

--  total number of customers
select count(customer_id) as total_customars from gold.dim_customers

--  total number of customers that has placed an order
select count(c.customer_id) as customars_placed_orders 
from gold.dim_customers c join gold.fact_sales s on c.customer_key =s.customer_key
where s.order_number is not null



--  Report that shows all key metrics of the business
select sum(sales_amount), 'total sales' from gold.fact_sales 
union all
select count(dp.product_name) ,'items solded'
from gold.dim_products dp inner join
gold.fact_sales fs on dp.product_id =fs.product_key
where sales_amount <> 0
union all
select avg(sales_amount)  ,'avg sales' from gold.fact_sales 
union all
select count(order_number) , 'total orders' from gold.fact_sales
union all
select count(product_id), 'total products' from gold.dim_products
union all
select count(customer_id) , 'total customars' from gold.dim_customers
union all
select count(c.customer_id) , 'customars placed orders' 
from gold.dim_customers c join gold.fact_sales s on c.customer_key =s.customer_key
where s.order_number is not null