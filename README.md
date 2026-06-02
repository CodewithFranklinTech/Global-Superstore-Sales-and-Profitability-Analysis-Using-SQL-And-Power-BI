#Project Title
Global Superstore Sales and Profitability Analysis Using SQL And Power BI

#Project Overview
This project presents a comprehensive retail sales analysis using SQL for data cleaning, transformation, feature engineering, and business intelligence analysis, alongside Power BI for interactive dashboard development and reporting.
The analysis was performed using a superstore sales dataset obtained from Kaggle containing customer information, product categories, sales transactions, profit data, shipping details, regional performance, and market-level business metrics.
The primary objective of this project is to transform raw retail transaction data into meaningful business insights that support sales performance evaluation, customer analysis, profitability monitoring, market performance assessment, and executive decision-making.
Using SQL, the project performs:
•	Data inspection
•	Data cleaning and validation
•	Feature engineering
•	Business intelligence analysis
•	Advanced analytical querying using CTEs and Window Functions
The transformed dataset was then imported into Power BI to build interactive dashboards that visually communicate sales performance, customer behaviour, regional trends, profitability patterns, and market contributions.
This project demonstrates a complete end-to-end retail analytics workflow combining:
•	SQL data analysis
•	Business intelligence logic
•	Dashboard development
•	Executive-level reporting

#Tools and Technologies Used
•	SQL (MySQL Workbench)
•	Microsoft Power BI
•	Kaggle Superstore Dataset
•	DAX (Power BI Calculated Columns)
 
#Dataset Description
Source: Superstore Sales Dataset obtained from Kaggle
The dataset contains retail sales transaction records from a global superstore business. Each row represents an individual product purchase within a customer order.

#Dataset Variables
•	order_id: Unique order identifier
•	order_date: Date order was placed
•	ship_date: Date order was shipped
•	ship_mode: Shipping method used
•	customer_name: Customer name
•	segment: Customer segment
•	country: Customer country
•	market: Market classification
•	region: Sales region
•	product_id: Product identifier
•	category: Product category
•	sub_category: Product sub-category
•	product_name: Product name
•	sales: Sales revenue generated
•	quantity: Quantity sold
•	discount: Discount applied
•	profit: Profit generated
•	shipping_cost: Shipping cost
•	order_priority: Order priority level
•	year: Transaction year

#Feature Engineering
Additional analytical features were created during the analysis process.

#SQL Engineered Features
#profit_category
Orders were classified into profitability groups:
•	Loss: Profit below 0
•	Low Profit: Profit between 0 and 100
•	High Profit: Profit above 100
 
#shipping_days
Calculated using:
ship_date − order_date
#sales_segment
Orders were classified into sales groups:
•	Small Sale: Sales below 100
•	Medium Sale: Sales between 100 and 500
•	Large Sale: Sales above 500

#Power BI Engineered Features

#customer_segment
Customers were classified based on total customer sales:
•	Low Value Customer
•	Medium Value Customer
•	High Value Customer

#Data Cleaning Process
The dataset was cleaned and validated using SQL. Cleaning tasks included:
•	Inspecting table structure and data types
•	Renaming incorrectly imported column names
•	Checking missing values
•	Identifying duplicate records
•	Validating sales and profit values
•	Converting date columns into proper date format
•	Creating shipping_days calculations
•	Creating profit categories
•	Creating sales segments
•	Validating engineered columns
•	Performing sales and profitability quality checks
 
#SQL Concepts Applied
This project applies both foundational and advanced SQL concepts.
Core SQL Skills
•	SELECT
•	FROM
•	WHERE
•	GROUP BY
•	ORDER BY
•	HAVING
•	DISTINCT
•	CASE
•	Aggregate Functions
•	UNION ALL

#Advanced SQL Skills
•	Common Table Expressions (CTEs)
•	Window Functions
•	ROW_NUMBER()
•	RANK()
•	DENSE_RANK()
•	PARTITION BY
•	LAG()
•	LEAD()
•	Running Totals
•	Ranking Analysis
•	Contribution Analysis

#Business Questions Solved
The project answers several retail business intelligence questions, including:
•	Which customers generate the highest sales revenue?
•	Which sub-categories generate the highest profit?
•	Which products generate losses?
•	Which customers are top performers within each region?
•	Which shipping methods are the slowest and fastest?
•	How do discounts impact profitability?
•	How has sales performance changed over time?
•	Which markets generate the highest revenue and profit margins?
•	How are customers distributed across value segments?
•	What are the overall sales, profit, order, and customer metrics?

#Power BI Dashboard
Interactive Power BI dashboards were developed to communicate business insights visually.

#Page 1 – Sales Performance Dashboard
Visualizations:
•	Total Orders KPI
•	Total Customers KPI
•	Total Profit KPI
•	Sales by Region
•	Profit by Category
•	Sales Trend Over Time
•	Region Slicer

#Page 2 – Customer & Market Analysis Dashboard
Visualizations:
•	Top 10 Customers by Sales
•	Customers by Region
•	Unique Customers KPI
•	Customer Segment Distribution
•	Sales by Market
•	Region Slicer
The dashboards allow users to interactively explore sales performance, customer behaviour, regional trends, and market opportunities.

![Executive Overview](images/supersore_dashboards_page-0001.jpg)

Executive Overview: Shows total sales, profit, and orders at a glance. Breaks down performance by category, region, and monthly trends to find top and low performing areas.


![Customer Analysis](images/supersore_dashboards_page-0002.jpg)

Customer Analysis: Lists top customers by sales and profit. Shows how different customer segments perform and lets you filter all charts by region or state.

#Key Insights
•	The business processed approximately 94,000 orders across multiple global markets.
•	Total profit generated was approximately 7.57K, indicating positive overall business performance.
•	A small group of customers contributed a disproportionately large share of total sales revenue.
•	The EU and APAC markets generated the highest sales volumes among all markets.
•	Customer activity was concentrated in a few major regions, while some regions contributed relatively little revenue.
•	Most customers belonged to the Medium Value segment, representing the largest customer group.
•	Certain product categories generated significantly higher profits than others.
•	Higher discount levels showed evidence of reduced profitability in several transactions.
•	Shipping performance varied across shipping modes, creating opportunities for operational improvement.
•	Regional sales trends fluctuated over time, highlighting periods of stronger and weaker business performance.

#Conclusion
The analysis demonstrates how SQL and Power BI can be combined to transform retail transaction data into actionable business intelligence insights.
Using SQL, the project successfully cleaned, transformed, and analysed sales data using both foundational and advanced analytical techniques.
Using Power BI, the project transformed analytical outputs into visually interactive dashboards suitable for executive reporting and strategic decision-making.

#Recommendations
•	Focus retention efforts on top-performing customers to maximize long-term revenue.
•	Review discount strategies to balance sales growth and profitability.
•	Expand successful products and categories that consistently generate strong profit margins.
•	Investigate loss-making products and implement corrective pricing strategies.
•	Monitor regional sales performance regularly to identify growth opportunities.
•	Improve shipping efficiency for slower delivery methods to enhance customer experience.
•	Use customer segmentation insights to create targeted marketing campaigns.

#Project Files
This repository contains:
•	SQL analysis scripts
•	Power BI dashboard file
•	Exported business reports
•	Project documentation

#Author
Franklin Chisom
Junior Data Analyst | Aspiring Data Scientist | SQL, Power BI, Python, and R Enthusiast
