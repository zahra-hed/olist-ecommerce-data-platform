-- orders

-- check for duplicates in order_id column
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_order_ids,
    COUNT(*) - COUNT(DISTINCT order_id) AS duplicate_rows
FROM raw.orders;


-- customers

-- check for duplicates in customer_id column
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customer_id) AS customer_id,
    COUNT(*) - COUNT(DISTINCT customer_id) AS duplicate_rows
FROM raw.customers;