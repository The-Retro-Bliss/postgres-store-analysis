-- Monthly sales from completed orders.
-- Amounts are in NGN, before any costs or expenses.

SELECT
    DATE_TRUNC('month', o.order_date)::DATE AS sales_month,
    COUNT(DISTINCT o.order_id) AS completed_orders,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS sales_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY DATE_TRUNC('month', o.order_date)::DATE
ORDER BY sales_month;

-- Rank products by revenue from completed orders.
-- Amounts are in NGN.

SELECT
    p.product_name,
    p.category,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS sales_revenue
FROM products AS p
JOIN order_items AS oi
    ON p.product_id = oi.product_id
JOIN orders AS o
    ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY p.product_id, p.product_name, p.category
ORDER BY sales_revenue DESC, p.product_name;

-- Calculate each completed order's total before averaging.
-- Amounts are in NGN.

WITH order_totals AS (
    SELECT
        o.order_id,
        SUM(oi.quantity * oi.unit_price) AS order_total
    FROM orders AS o
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.status = 'completed'
    GROUP BY o.order_id
)
SELECT
    COUNT(*) AS completed_orders,
    SUM(order_total) AS total_sales_revenue,
    ROUND(AVG(order_total), 2) AS average_order_value
FROM order_totals;

-- Find products with no completed sales in the sample period.

SELECT
    p.product_id,
    p.product_name,
    p.category,
    p.current_price
FROM products AS p
WHERE NOT EXISTS (
    SELECT 1
    FROM order_items AS oi
    JOIN orders AS o
        ON oi.order_id = o.order_id
    WHERE oi.product_id = p.product_id
      AND o.status = 'completed'
)
ORDER BY p.product_id;

-- Category revenue and percentage of total completed sales.

WITH category_sales AS (
    SELECT
        p.category,
        SUM(oi.quantity) AS units_sold,
        SUM(oi.quantity * oi.unit_price) AS sales_revenue
    FROM products AS p
    JOIN order_items AS oi
        ON p.product_id = oi.product_id
    JOIN orders AS o
        ON oi.order_id = o.order_id
    WHERE o.status = 'completed'
    GROUP BY p.category
)
SELECT
    category,
    units_sold,
    sales_revenue,
    ROUND(
        100.0 * sales_revenue
        / NULLIF(SUM(sales_revenue) OVER (), 0),
        2
    ) AS revenue_share_pct
FROM category_sales
ORDER BY sales_revenue DESC, category;