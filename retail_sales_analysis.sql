create table sql_project1(
transaction_id int,
sale_date date, 
sale_time time, 
customer_id int, 
gender varchar(15), 
age int ,
category varchar(15), 
quantiy int ,
price_per_unit float, 
cogs float ,
total_sale float,
primary key (transaction_id)
);

select *, row_number() over(partition by transaction_id) as rn from sql_project1;
select count(distinct(transaction_id)) from sql_project1;

SELECT COUNT(*) 
FROM sql_project1
WHERE price_per_unit REGEXP '[\r\n]';
show warnings;


select * from sql_project1;

select count(*) from sql_project1;
update sql_project1 
set age=0 
where age is null;

update sql_project1 
set age=null 
where age=0;

-- remove the rows where the important data are missing
select * from sql_project1 where quantiy=0.00 or price_per_unit=0.00 or cogs=0.00 or total_sale=0.00;
select * from sql_project1 where age=0;
select median(age) from sql_project1;

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from sql_project1 where sale_date='2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
select * from sql_project1 where category="Clothing" and quantiy >=4 and date_format(sale_date,'%Y-%m')="2022-11";

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category, sum(total_sale) from sql_project1 group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select avg(age) from sql_project1 where category="Beauty";

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from sql_project1 where total_sale>1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category,gender, count(transaction_id) from sql_project1 group by category,gender order by category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select * from (
select *,rank() over(partition by years order by avg_sales desc) rnk from (
select years,months,round(avg(total_sale),2) as avg_sales from (
select *,year(sale_date) as years, month(sale_date) as months from sql_project1)t group by years,months order by years,avg_sales desc)y)z where z.rnk=1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select * from sql_project1;
select customer_id, sum(total_sale) as sales from sql_project1 group by customer_id order by 2 desc limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category,count(distinct customer_id) from sql_project1 group by category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
with orderss as(
select *,case when hour(sale_time) <12 then "Morning"
when hour(sale_time) between 12 and 17 then "Afternoon"
else "Evening" end as Shift
from sql_project1)
select Shift, count(*) from orderss group by Shift;















