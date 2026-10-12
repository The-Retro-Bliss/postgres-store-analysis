-- Update planner statistics for the sample data.
ANALYZE orders;

-- Remove this project's index to establish the baseline.
DROP INDEX IF EXISTS idx_orders_customer_id;

-- Inspect how PostgreSQL finds one customer's orders.
EXPLAIN (ANALYZE, BUFFERS)
SELECT
    order_id,
    order_date,
    status
FROM orders
WHERE customer_id = 1;

-- Index the foreign-key column used for customer lookups.
CREATE INDEX IF NOT EXISTS idx_orders_customer_id
    ON orders (customer_id);

-- Inspect the same query after adding the index.
EXPLAIN (ANALYZE, BUFFERS)
SELECT
    order_id,
    order_date,
    status
FROM orders
WHERE customer_id = 1;