-- Reusable report: one row per completed order.
-- Amounts are in NGN.

CREATE OR REPLACE VIEW completed_order_summary AS
SELECT
    o.order_id,
    o.order_date,
    c.customer_id,
    c.full_name,
    c.city,
    SUM(oi.quantity) AS units_purchased,
    SUM(oi.quantity * oi.unit_price) AS order_total
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY
    o.order_id,
    o.order_date,
    c.customer_id,
    c.full_name,
    c.city;

-- Use the view to compare sales by customer city.

SELECT
    city,
    COUNT(*) AS completed_orders,
    SUM(order_total) AS sales_revenue
FROM completed_order_summary
GROUP BY city
ORDER BY sales_revenue DESC, city;