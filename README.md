# sql_retail_sales_p1
# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: I have used the existing database for this project in Mysql Workbench.
- **Table Creation**: A table named `sql_project1` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
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
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
select *, row_number() over(partition by transaction_id) as rn from sql_project1;
select count(distinct(transaction_id)) from sql_project1;

-- remove the rows where the important data are missing
select * from sql_project1 where quantiy=0.00 or price_per_unit=0.00 or cogs=0.00 or total_sale=0.00;
select * from sql_project1 where age=0;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
select * from sql_project1 where sale_date='2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
select * from sql_project1 where category="Clothing" and quantiy >=4 and date_format(sale_date,'%Y-%m')="2022-11";
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
select category, sum(total_sale) from sql_project1 group by category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
select avg(age) from sql_project1 where category="Beauty";
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
select * from sql_project1 where total_sale>1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
select category,gender, count(transaction_id) from sql_project1 group by category,gender order by category;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
select * from (
select *,rank() over(partition by years order by avg_sales desc) rnk from (
select years,months,round(avg(total_sale),2) as avg_sales from (
select *,year(sale_date) as years, month(sale_date) as months from sql_project1)t group by years,months order by years,avg_sales desc)y)z where z.rnk=1;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
select * from sql_project1;
select customer_id, sum(total_sale) as sales from sql_project1 group by customer_id order by 2 desc limit 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
select category,count(distinct customer_id) from sql_project1 group by category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
select *,case when hour(sale_time) <12 then "Morning"
when hour(sale_time) between 12 and 17 then "Afternoon"
else "Evening" end as Shift
from sql_project1)
select Shift, count(*) from orderss group by Shift;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**
2. **Set Up the Database**
3. **Run the Queries**
4. **Explore and Modify**

