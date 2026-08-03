/*
Database Exploration
*/
USE [DataWarehouseAnalytics];
GO
-- list of all tables in the database
select * 
from information_schema.tables

--  columns for a specific table (dim_customers)
select * 
from information_schema.columns 
where table_name ='fact_sales'

select * 
from information_schema.columns 
where table_name ='dim_customers'

select * 
from information_schema.columns 
where table_name ='dim_products'