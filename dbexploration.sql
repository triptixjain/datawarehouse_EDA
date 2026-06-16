/*
===========================================================
Data Warehouse Analytics - Exploratory Data Analysis (EDA)
===========================================================

Purpose:
- Explore data warehouse structure and contents
- Validate dimensions and fact tables
- Analyze customer, product, and sales data
- Generate key business KPIs and summary metrics
- Support reporting and dashboard development

Tables Used:
- dim_customers
- dim_products
- fact_sales

Analysis Includes:
- Database metadata exploration
- Customer demographics
- Product category analysis
- Sales performance metrics
- Revenue analysis by category and customer
- Geographic sales distribution


Date: 16-08-2026
===========================================================
*/



create database datawarehouse_analytics;

select top 10 * from dim_customers;
select top 10 * from dim_products;
select top 10 * from fact_sales;

--explore all obj in db
select * from INFORMATION_SCHEMA.TABLES


--explore all columns in db
select * from INFORMATION_SCHEMA.columns
where TABLE_NAME = 'dim_products'

--explore all the countries our customers are from

select distinct country from dim_customers;

--explore all categories "the major division"

select 
	category,
	subcategory,
	product_name
	from dim_products
	order by 1,2,3


--explore date dim
select 
	max(order_date) recent_order,
	min(order_date) first_order,

	DATEDIFF(year,min(order_date),max(order_date)) as diff
	from fact_sales

--find youngest and oldest customer
select 
	datediff(year,min(birthdate),getdate()) as oldest_customer,
	datediff(year,max(birthdate),getdate()) as newest_customer

	from dim_customers;




--total sales
--total item sold
--avg selling price
--total num of orders
--total num of products
--total customers
--total num of customers that placed order

select'total_sales' as measure_name,sum(sales_amount) as measure_value from fact_sales 
union all 
select'total_item_sold' as measure_name,sum(quantity) as measure_value from fact_sales 
union all
select'avg price' as measure_name,avg(price) as measure_value from fact_sales
union all
select'total orders' as measure_name,count(order_number) as measure_value from fact_sales 
union all
select'customer_placedorder' as measure_name,count(customer_key) as measure_value from fact_sales 
union all
select'total_item_sold' as measure_name,sum(quantity) as measure_value from fact_sales 
union all
select'total_customers' as measure_name,count(customer_id) as measure_value from dim_custom

--find total customers by countries 
	 select
		 count(customer_id) as total_customers,
		 country
		 from dim_customers
		 group by country
		 order by total_customers desc

 --by gender
		 select
		 count(customer_id) as total_customers,
		gender
		 from dim_customers
		 group by gender
		 order by total_customers desc

-- total product by category
	 select
		 count(product_id) as total_product,
		 category
		 from dim_products
		 group by category
		 order by total_product desc

--avg cost in each category
	 select
		 avg(cost) as avg_cost,
		 category
		 from dim_products
		 group by category
		 order by avg_cost desc

-- total revenue genetated by cat
		select 
			sum(f.sales_amount) as total_revenue,
			p.category
			from fact_sales f 
			left join dim_products p
			on f.product_key = p.product_key
			group by p.category


--total revenue by each customer
		select 
			sum(f.sales_amount) as total_revenue,
			c.customer_id
			from fact_sales f 
			left join dim_customers c
			on f.customer_key = c.customer_key
			group by c.customer_id

--distribution of sold items across countries
		select 
			sum(f.sales_amount) as total_sold_items,
			c.country
			from fact_sales f 
			left join dim_customers c
			on f.customer_key = c.customer_key
			group by c.country







