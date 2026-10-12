BEGIN;

INSERT INTO customers (full_name, email, city)
VALUES
    ('Ada Okafor', 'ada@example.com', 'Lagos'),
    ('Tunde Bello', 'tunde@example.com', 'Ibadan'),
    ('Zainab Musa', 'zainab@example.com', 'Abuja'),
    ('Emeka Obi', 'emeka@example.com', 'Enugu'),
    ('Bisi Adewale', 'bisi@example.com', 'Lagos'),
    ('Ibrahim Yusuf', 'ibrahim@example.com', 'Kano'),
    ('Efua Mensah', 'efua@example.com', 'Abuja'),
    ('Chidinma Eze', 'chidinma@example.com', 'Port Harcourt');

INSERT INTO products (product_name, category, current_price)
VALUES
    ('Classic T-Shirt', 'Clothing', 8000.00),
    ('Denim Jeans', 'Clothing', 18000.00),
    ('Everyday Sneakers', 'Footwear', 25000.00),
    ('Canvas Tote Bag', 'Accessories', 6000.00),
    ('Baseball Cap', 'Accessories', 5000.00),
    ('Leather Belt', 'Accessories', 9000.00);

INSERT INTO orders (customer_id, order_date, status)
VALUES
    (1, '2026-01-05', 'completed'),
    (2, '2026-01-12', 'completed'),
    (3, '2026-01-20', 'cancelled'),
    (1, '2026-02-03', 'completed'),
    (4, '2026-02-10', 'completed'),
    (5, '2026-02-18', 'completed'),
    (2, '2026-03-02', 'completed'),
    (6, '2026-03-08', 'completed'),
    (3, '2026-03-15', 'completed'),
    (1, '2026-03-22', 'completed'),
    (7, '2026-03-25', 'pending'),
    (5, '2026-03-28', 'cancelled');

INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES
    (1, 1, 2, 7500.00),
    (1, 4, 1, 6000.00),
    (2, 2, 1, 18000.00),
    (2, 5, 1, 5000.00),
    (3, 3, 1, 25000.00),
    (4, 3, 1, 25000.00),
    (4, 1, 1, 8000.00),
    (5, 2, 2, 18000.00),
    (6, 4, 2, 6000.00),
    (6, 5, 1, 5000.00),
    (7, 1, 3, 8000.00),
    (8, 3, 1, 25000.00),
    (8, 4, 1, 6000.00),
    (9, 2, 1, 18000.00),
    (9, 1, 1, 8000.00),
    (10, 5, 2, 5000.00),
    (10, 4, 1, 6000.00),
    (11, 3, 2, 25000.00),
    (12, 1, 1, 8000.00);

COMMIT;