# Online Store Sales Analysis with PostgreSQL

A SQL portfolio project using fictional sales data from a Nigerian
online store. It demonstrates relational database design, business
analysis and basic query-plan inspection.

## Tools

- PostgreSQL 18
- Visual Studio Code
- psql

## Dataset

The dataset contains:

- 8 customers
- 6 products
- 12 orders
- 19 order items

Orders cover January–March 2026. All monetary amounts are in Nigerian
naira (NGN). Names and email addresses are fictional.

## Database Design

- customers: customer details
- products: product categories and current prices
- orders: customer, order date and status
- order_items: products, quantities and prices at purchase

Primary keys identify records. Foreign keys connect the tables.
Constraints enforce unique emails, valid order statuses and positive
prices and quantities.

Historical sales use order_items.unit_price, rather than the product's
current price.

## Business Questions

1. What was the monthly revenue from completed orders?
2. Which products generated the most revenue?
3. Which customers spent the most?
4. What percentage of purchasing customers bought more than once?
5. What was the average completed order value?
6. Which products had no completed sales?
7. How did completed sales vary by customer city?
8. What percentage of revenue came from each category?
9. Which customers had no completed purchases?

## Key Findings

- Completed sales revenue totalled NGN 227,000 across 9 orders.
- Monthly revenue was NGN 44,000 in January, NGN 86,000 in February
  and NGN 97,000 in March.
- Denim Jeans generated the highest product revenue: NGN 72,000.
- Classic T-Shirt sold the most units: 7.
- Ada Okafor was the highest-spending customer: NGN 70,000.
- 2 of 6 purchasing customers bought more than once: 33.33%.
- Average completed order value was NGN 25,222.22.
- Clothing contributed 55.95% of completed sales revenue.
- Lagos customers contributed NGN 87,000.
- Leather Belt had no completed sales.
- Two customers had no completed purchases.

## SQL Skills Demonstrated

- Table creation and identity columns
- Primary keys, foreign keys and constraints
- INNER JOIN and LEFT JOIN
- Aggregation, GROUP BY and date functions
- Common table expressions (CTEs)
- DENSE_RANK and aggregate window functions
- FILTER and NULLIF
- Correlated subqueries using NOT EXISTS
- Reusable reporting views
- Index creation
- EXPLAIN ANALYZE with buffer information

## Query Performance

The performance script compares a customer-order lookup before and
after creating an index on orders.customer_id.

PostgreSQL selected a sequential scan in both observed plans. With
only 12 orders, scanning the table is inexpensive. These results do
not demonstrate an index-related performance improvement.

The script removes and recreates this project's index so the
comparison can be repeated.

## How to Run

Install PostgreSQL and make psql available in your terminal.
Connect using a PostgreSQL role that can create databases and tables.

Create the database:

    psql -h localhost -U postgres -d postgres -c "CREATE DATABASE store_analysis;"

Run these scripts in order from the project folder:

    psql -h localhost -U postgres -d store_analysis -v ON_ERROR_STOP=1 -f sql/01_create_tables.sql
    psql -h localhost -U postgres -d store_analysis -v ON_ERROR_STOP=1 -f sql/02_insert_data.sql
    psql -h localhost -U postgres -d store_analysis -v ON_ERROR_STOP=1 -f sql/03_sales_analysis.sql
    psql -h localhost -U postgres -d store_analysis -v ON_ERROR_STOP=1 -f sql/04_customer_analysis.sql
    psql -h localhost -U postgres -d store_analysis -v ON_ERROR_STOP=1 -f sql/05_reporting_views.sql
    psql -h localhost -U postgres -d store_analysis -v ON_ERROR_STOP=1 -f sql/06_query_performance.sql

Run the table-creation and data-insertion scripts only once, against
a fresh project database. The sample data assumes newly generated
IDs starting at 1.

On Windows, if psql is not on PATH, use its full executable path
with PowerShell's call operator (&).

## Limitations

This is a small, fictional learning dataset. Findings describe the
sample only and should not be treated as real market trends.

Revenue includes completed orders only. Costs, taxes, discounts,
refunds and shipping charges are not modelled, so revenue is not profit.

City analysis uses each customer's recorded city, not a delivery address.