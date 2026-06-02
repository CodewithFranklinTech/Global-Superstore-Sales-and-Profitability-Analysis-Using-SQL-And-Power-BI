/*
MODULE ONE: 
Task 1: Standardize the column name order_id
*/
ALTER TABLE superstore_shop
CHANGE COLUMN ï»¿order_id order_id VARCHAr(255);

/*
Task 2: Write SQL to display the first 10 rows from: superstore_sales
*/
SELECT *
FROM superstore_shop
LIMIT 20;

/*
Task 3 — Count total records
Find: total number of rows in the dataset
*/
SELECT COUNT(*) AS total_records
FROM superstore_shop;

/*
Task 4 — Check for missing values
Check if any rows contain NULL values in: 
order_id, customer_name, sales, profit, category
*/
SELECT
	COUNT(*) - COUNT(order_id) AS null_order_id,
    COUNT(*) - COUNT(customer_name) AS null_customer_name,
    COUNT(*) - COUNT(sales) AS null_sales,
    COUNT(*) - COUNT(profit) AS null_profit,
    COUNT(*) - COUNT(category) AS null_category
FROM superstore_shop;

/*
Task 5 — Inspect unique categories
Find all DISTINCT product categories.
*/
SELECT DISTINCT category AS unique_categories 
FROM superstore_shop;

/*
Task 6 — Inspect unique regions
Find all DISTINCT regions.
*/
SELECT DISTINCT region AS unique_regions
FROM superstore_shop;

/*
Task 7 — Find duplicate order IDs
Check whether any order_id appears more than once.
*/
SELECT order_id, COUNT(*) AS duplicate_order_id
FROM superstore_shop
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY duplicate_order_id DESC;

/*
Task 8 — Check sales quality
Find: minimum sales, maximum sales, and average sales
*/
SELECT
	MIN(sales) AS min_sales,
    MAX(sales) AS max_sales,
    AVG(sales) AS avg_sales
FROM superstore_shop;

/*
Task 9 — Check profit quality
Find: minimum profit, maximum profit, and average profit
*/
SELECT 
	MIN(profit) AS min_profit,
    MAX(profit) AS max_profit,
    AVG(profit) AS avg_profit
FROM superstore_shop;

/*
Task 10 — Explore discount distribution
Find all DISTINCT discount values.
*/
SELECT DISTINCT discount AS unique_discount
FROM superstore_shop;

/*
Task 11 — Inspect date columns
Display: order_date and ship_date for 20 rows.
*/
SELECT 
	order_date,
    ship_date
FROM superstore_shop
LIMIT 20;

/*
MODULE TWO:
Task 1 — Create profit_category column
Create a new column called: profit_category
*/
ALTER TABLE superstore_shop
ADD COLUMN profit_category VARCHAR(20);

/*
Task 2 — Populate profit_category
Rules: profit < 0	Loss. 0–100 Low Profit, and >100 High Profit
Use: CASE WHEN
*/
UPDATE superstore_shop
SET profit_category = 
CASE
	WHEN profit < 0 THEN 'Loss'
    WHEN profit >= 0 AND profit <= 100 THEN 'Low Profit'
    WHEN profit > 100 THEN 'High Profit'
    ELSE NULL
END;

/*
Task 3 — Verify the new column
Display: product_name, sales, profit, and profit_category for 20 rows.
*/
SELECT 
	product_name,
    sales,
    profit,
    profit_category
FROM superstore_shop
LIMIT 20;

/*
Task 4 — Create shipping_days column
Create a new column: shipping_days
*/
ALTER TABLE superstore_shop
ADD COLUMN shipping_days INT;

/*
Task 5: 
Convert order_date values from text to proper date format
*/
UPDATE superstore_shop
SET order_date = STR_TO_DATE(order_date, '%d/%m/%Y');

/*
Task 6: 
Convert ship_date values from text to proper date format
*/
UPDATE superstore_shop
SET ship_date = STR_TO_DATE(ship_date, '%d/%m/%Y');

/*
Task 7: Fix order_date formats in one update using CASE
*/
UPDATE superstore_shop
SET order_date =
CASE
	WHEN order_date LIKE '%/%' THEN STR_TO_DATE(order_date, '%d/%m/%Y')
    WHEN order_date LIKE '%-%' THEN STR_TO_DATE(order_date, '%d-%m-%Y')
    ELSE NULL
END;

/*
Task 8: Fix ship_date formats in one update using CASE
*/
UPDATE superstore_shop
SET ship_date = 
CASE
	WHEN ship_date LIKE '%/%' THEN STR_TO_DATE(ship_date, '%d/%m/%Y')
    WHEN ship_date LIKE '%-%' THEN STR_TO_DATE(ship_date, '%d-%m-%Y')
    ELSE NULL
END;

/*
Task 8: Change order_date and ship_date to DATE type
*/
ALTER TABLE superstore_shop
MODIFY COLUMN order_date DATE,
MODIFY COLUMN ship_date DATE;

/*
Task 9 — Calculate shipping_days
Calculate: ship_date - order_date Use: DATEDIFF()
*/
UPDATE superstore_shop
SET shipping_days = DATEDIFF(ship_date, order_date);

/*
Task 10 — Validate shipping days
Display: order_date, ship_date, and shipping_days for 20 rows.
*/
SELECT 
	order_date,
    ship_date,
    shipping_days
FROM superstore_shop
LIMIT 20;

/*
Task 11 — Find impossible shipping records
Find rows where: shipping_days < 0
*/
SELECT *
FROM superstore_shop
WHERE shipping_days < 0;

/*
Task 12 — Create sales_segment column
Create: sales_segment
Rules: sales < 100 Small Sale, 100–500 Medium Sale, and > 500 Large Sale
*/
ALTER TABLE superstore_shop
ADD COLUMN sales_segment VARCHAR(20);

/*
Task 13: 
Populate the sales_segment column with values
*/
UPDATE superstore_shop
SET sales_segment =
CASE
	WHEN sales < 100 THEN 'Small Sale'
    WHEN sales >= 100 AND sales <= 500 THEN 'Medium Sale'
    WHEN sales > 500 THEN 'Large Sale'
    ELSE NULL
END;

/*
Task 14 — Distribution Analysis
Count how many rows belong to each: sales_segment
*/
SELECT sales_segment, COUNT(*) AS sales_segment_distribution
FROM superstore_shop
GROUP BY sales_segment
ORDER BY sales_segment_distribution DESC;

/*
Task 15 — Profitability Quality Check
Find: total sales, total profit, profit margin %. 
Round to 2 decimal places.
*/
SELECT
	ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_magin
FROM superstore_shop;

/*
MODULE THREE:
Task 1 — Rank Highest Sales Orders
Using: ROW_NUMBER(). Assign a unique ranking to orders based on: sales DESC
Show: order_id, customer_name, sales, and sales_rank
*/
SELECT
	order_id,
    customer_name,
    sales,
ROW_NUMBER() OVER(ORDER BY sales DESC) AS sales_rank
FROM superstore_shop;

/*
Task 2 — Profit Ranking Per Category
Using: RANK(), Rank products INSIDE each category based on: profit DESC
Use: PARTITION BY category
*/
SELECT
	product_name,
    category,
    profit,
RANK() OVER(
	   PARTITION BY category
       ORDER BY profit DESC) AS profit_rank
FROM superstore_shop;

/*
Task 3 — Dense Ranking By Region
Using: DENSE_RANK(), Rank customers inside each region based on: sales DESC
*/
SELECT 
	customer_name,
    region,
    sales,
DENSE_RANK() OVER(
			PARTITION BY region
            ORDER BY sales DESC) AS sales_dense_rank
FROM superstore_shop;

/*
Task 4 — Top 3 Customers Per Region
Using: CTE and ROW_NUMBER() 
Find: top 3 customers with highest sales in each region.
*/
WITH customers_per_region AS (
	SELECT 
		customer_name,
        region,
        sales,
	ROW_NUMBER() OVER(
				 PARTITION BY region
                 ORDER BY sales DESC) AS sales_rank
	FROM superstore_shop
)
SELECT customer_name, region, sales, sales_rank
FROM customers_per_region
WHERE sales_rank <= 3
ORDER BY region, sales_rank;

/*
Task 5 — Running Total Sales
Using: SUM() OVER()
Create a cumulative running total of sales ordered by: order_date
*/
SELECT
	sales,
    order_date,
SUM(sales) OVER(ORDER BY order_date, order_id) AS total_sales
FROM superstore_shop;

/*
Task 6 — Previous Order Sales Analysis
Using: LAG(), Show: customer_name, order_date, sales, and previous_order_sales
*/
SELECT
	customer_name,
    order_date,
    sales,
LAG(sales) OVER(
		   PARTITION BY customer_name
           ORDER BY order_date) AS previous_order_sales
FROM superstore_shop;

/*
Task 7 — Next Order Sales Prediction Style
Using: LEAD(), Show: customer_name, order_date, sales, and next_order_sales
*/
SELECT
	customer_name,
    order_date,
    sales,
LEAD(sales) OVER(
			PARTITION BY customer_name
            ORDER BY order_date ASC) AS next_order_sales
FROM superstore_shop;

/*
Task 8 — Sales Difference Analysis
Using: LAG(), Calculate: current sales - previous sales
Alias: sales_difference
*/
SELECT
	customer_name,
    order_date,
    sales,
sales - LAG(sales) OVER(
				   PARTITION BY customer_name
                   ORDER BY order_date) AS sales_difference
FROM superstore_shop;

/*
Task 9 — Highest Profit Product Per Category
Using: CTE, ROW_NUMBER(), PARTITION BY 
Find: most profitable product in each category.
*/
WITH profit_product_per_category AS (
	SELECT 
		category,
        product_name,
        SUM(profit) AS total_profit
	FROM superstore_shop
    GROUP BY category, product_name 
),
ranked AS (
	SELECT
		category,
        product_name,
        total_profit,
	ROW_NUMBER() OVER(
				 PARTITION BY category
                 ORDER BY total_profit DESC) AS profit_rank
	FROM profit_product_per_category
)
SELECT category, product_name, total_profit, profit_rank
FROM ranked
WHERE profit_rank = 1
ORDER BY category;

/*
Task 10 — Regional Revenue Contribution
Using: window function, Calculate:
total regional sales and percentage contribution to total company sales
*/
SELECT
	region,
    SUM(sales) AS total_region_sales,
    ROUND(SUM(sales) * 100.0 / SUM(SUM(sales)) OVER(), 2) AS pct_of_company_sales
FROM superstore_shop
GROUP BY region
ORDER BY total_region_sales DESC;

/*
MODULE FOUR:
BUSINESS TASK 1 — Top Revenue Customers
Find the top 10 customers generating the highest total sales revenue.
Requirements: customer_name, total_sales, and customer_rank
Use: CTE, SUM(), RANK()
*/
WITH top_revenue_customers AS (
	SELECT 
		customer_name,
        SUM(sales) AS total_sales
	FROM superstore_shop
    GROUP BY customer_name
),
ranked_customers AS (
	SELECT
		customer_name,
        total_sales,
	RANK() OVER(ORDER BY total_sales DESC) AS customer_rank
    FROM top_revenue_customers
)
SELECT customer_name, total_sales, customer_rank
FROM ranked_customers
WHERE customer_rank <= 10
ORDER BY customer_rank;

/*
BUSINESS TASK 2 — Most Profitable Sub-Categories
Which product sub-categories generate the highest total profit?
Show: sub_category, total_profit, profit_rank 
Use: CTE, DENSE_RANK()       
*/
WITH most_profitable_subcategories AS (
	SELECT
		sub_category,
        SUM(profit) AS total_profit
	FROM superstore_shop
    GROUP BY sub_category
),
dense_ranked_subcat AS (
	SELECT
		sub_category,
        total_profit,
	DENSE_RANK() OVER(ORDER BY total_profit DESC) AS profit_rank
	FROM most_profitable_subcategories
)
SELECT sub_category, total_profit, profit_rank
FROM dense_ranked_subcat
ORDER BY profit_rank;

/*
BUSINESS TASK 3 — Loss-Making Products
Find products where: total profit < 0
Show: product_name, category, total_sales, and total_profit 
Order: highest loss first. 
*/
WITH loss_making_profit AS (
	SELECT
		product_name,
        category,
        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit
	FROM superstore_shop
    GROUP BY product_name, category
)
SELECT product_name, category, total_sales, total_profit
FROM loss_making_profit
WHERE total_profit < 0
ORDER BY total_profit ASC;

/*
BUSINESS TASK 4 — Regional Sales Leaders
Find the highest revenue customer in EACH region.
Use: CTE, ROW_NUMBER(), PARTITION BY region 
*/
WITH regional_sales_leaders AS (
	SELECT
		customer_name,
        region,
        SUM(sales) AS total_revenue
	FROM superstore_shop
    GROUP BY customer_name, region
),
customer_ranked AS (
	SELECT
		customer_name,
        region,
        total_revenue,
	ROW_NUMBER() OVER(
				 PARTITION BY region
                 ORDER BY total_revenue DESC) AS region_rank
	FROM regional_sales_leaders
)
SELECT customer_name, region, total_revenue, region_rank
FROM customer_ranked
WHERE region_rank = 1
ORDER BY region, region_rank;

/*
BUSINESS TASK 5 — Shipping Performance Analysis
Analyze average shipping days by: ship_mode
Show: ship_mode, avg_shipping_days, total_orders 
Order: slowest shipping first. 
*/
WITH shipping_performance_analysis AS (
	SELECT
		ship_mode,
        AVG(shipping_days) AS avg_shipping_days,
        COUNT(*) AS total_orders
	FROM superstore_shop
    GROUP BY ship_mode
)
SELECT 
	ship_mode, 
    avg_shipping_days, 
    total_orders
FROM shipping_performance_analysis
ORDER BY avg_shipping_days DESC;

/*
BUSINESS TASK 6 — Discount Impact Analysis 
Analyze how discount affects profit.
Create categories: 0 No Discount, 0.01–0.2 Low Discount, >0.2 High Discount
Then calculate: total sales, total profit, average profit for each discount group. 
*/
WITH discount_impact_analysis AS (
	SELECT
		sales,
        profit,
		CASE
			WHEN discount = 0 THEN 'No Discount'
            WHEN discount > 0.01 AND discount <= 0.2 THEN 'Low Discount'
            WHEN discount > 0.2 THEN 'High Discount'
            ELSE 'Other'
	END AS discount_category
    FROM superstore_shop
)
SELECT
	discount_category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    AVG(profit) AS avg_profit,
    COUNT(*) AS order_lines
FROM discount_impact_analysis
GROUP BY discount_category
ORDER BY
	CASE discount_category
		WHEN 'No Discount' THEN 1
        WHEN 'Low Discount' THEN 2
        WHEN 'High Discount' THEN 3
        ELSE 4
END;

/*
BUSINESS TASK 7 — Yearly Sales Growth Analysis
Calculate yearly sales totals.
Then use: LAG() to compare: current year sales, previous year sales, 
and sales growth difference 
*/
WITH yearly_sales AS (
	SELECT 
		YEAR(order_date) AS sales_year,
        SUM(sales) AS total_sales
	FROM superstore_shop
    GROUP BY YEAR(order_date)
)
SELECT
	sales_year,
    total_sales,
	LAG(total_sales) OVER(ORDER BY sales_year) AS previous_year_sales,
	total_sales - LAG(total_sales) OVER(ORDER BY sales_year) AS sales_growth_diff
FROM yearly_sales
ORDER BY sales_year;

/*
BUSINESS TASK 8 — Most Valuable Markets
Find markets generating: highest sales and highest profit margin % 
Use: GROUP BY, aggregates, ORDER BY 
*/
SELECT
	market,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(SUM(profit) * 100 / NULLIF(SUM(sales), 0), 2) AS profit_margin_pct
FROM superstore_shop
GROUP BY market
ORDER BY total_sales DESC, profit_margin_pct DESC;

/*
BUSINESS TASK 9 — Customer Purchase Behavior
Classify customers into: < 500 Low Value, 500–5000 Medium Value, 
and >5000 High Value
Then: count customers in each segment.
Use: CTE, CASE and GROUP BY 
*/
WITH customer_totals AS (
	SELECT
		customer_name,
        SUM(sales) AS total_customer_sales
	FROM superstore_shop
    GROUP BY customer_name
),
customer_segment AS (
	SELECT
		customer_name,
        total_customer_sales,
        CASE
			WHEN total_customer_sales < 500 THEN 'Low Value'
            WHEN total_customer_sales >= 500 AND total_customer_sales <= 5000 THEN 'Medium Value'
            WHEN total_customer_sales > 5000 THEN 'High Value'
            ELSE 'Other'
		END AS customer_segments
    FROM customer_totals
)
SELECT
	customer_segments,
    COUNT(*) AS customer_count 
FROM customer_segment
GROUP BY customer_segments
ORDER BY 
	CASE customer_segments
		WHEN 'Low Value' THEN 1
        WHEN 'Medium Value' THEN 2
        WHEN 'High Value' THEN 3
        ELSE 4
END;

/*
BUSINESS TASK 10 — Executive Summary Report
Using: UNION ALL, Create one combined result showing:
Total Orders, Total Sales, Total Profit, Total Customers 
*/
SELECT
	'Total Orders' AS metric,
    COUNT(DISTINCT order_id) AS value
FROM superstore_shop

UNION ALL

SELECT
	'Total Sales' AS metric,
    ROUND(SUM(sales), 2) AS value
FROM superstore_shop

UNION ALL

SELECT
	'Total Profit' AS metric,
    ROUND(SUM(profit), 2) AS value
FROM superstore_shop

UNION ALL

SELECT
	'Total CustomerS' AS metric,
    COUNT(DISTINCT customer_name) AS value
FROM superstore_shop;