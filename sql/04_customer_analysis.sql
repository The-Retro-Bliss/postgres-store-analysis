-- Rank customers by spending on completed orders.
-- Amounts are in NGN.

WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.full_name,
        c.city,
        COUNT(DISTINCT o.order_id) AS completed_orders,
        SUM(oi.quantity * oi.unit_price) AS total_spent
    FROM customers AS c
    JOIN orders AS o
        ON c.customer_id = o.customer_id
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.status = 'completed'
    GROUP BY c.customer_id, c.full_name, c.city
)
SELECT
    DENSE_RANK() OVER (
        ORDER BY total_spent DESC
    ) AS spending_rank,
    full_name,
    city,
    completed_orders,
    total_spent
FROM customer_spending
ORDER BY spending_rank, full_name;

-- Repeat purchase rate across the sample period.
-- Only completed orders count as purchases.

WITH customer_order_counts AS (
    SELECT
        customer_id,
        COUNT(*) AS completed_orders
    FROM orders
    WHERE status = 'completed'
    GROUP BY customer_id
)
SELECT
    COUNT(*) AS purchasing_customers,
    COUNT(*) FILTER (
        WHERE completed_orders > 1
    ) AS repeat_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE completed_orders > 1
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS repeat_purchase_rate_pct
FROM customer_order_counts;

-- Find customers with no completed purchases.

SELECT
    c.customer_id,
    c.full_name,
    c.city
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
    AND o.status = 'completed'
WHERE o.order_id IS NULL
ORDER BY c.customer_id;