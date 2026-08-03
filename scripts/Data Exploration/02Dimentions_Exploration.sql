
/*
Dimensions Exploration
*/
USE [DataWarehouseAnalytics];
GO
--  unique countries from which customers originate

select distinct country from gold.dim_customers

--  unique categories, subcategories, and products
select 
distinct category as Category_Name , subcategory as Sub_Category_Name , product_name  
from gold.dim_products 
where category is not null

