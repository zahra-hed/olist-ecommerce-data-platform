CREATE SCHEMA IF NOT EXISTS analytics;

-- Create dim_customer

CREATE TABLE analytics.dim_customer (
    customer_id VARCHAR PRIMARY KEY,
    customer_unique_id VARCHAR,
    customer_zip_code_prefix VARCHAR,
    customer_city VARCHAR,
    customer_state VARCHAR
);

-- Populate dim_customer from staging.customers

INSERT INTO analytics.dim_customer (
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
)
SELECT DISTINCT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
FROM staging.customers
WHERE customer_id IS NOT NULL
ON CONFLICT (customer_id) DO NOTHING;


-- create dim_date

CREATE TABLE analytics.dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE UNIQUE NOT NULL,
    year INT,
    quarter INT,
    month INT,
    month_name VARCHAR(15),
    day INT,
    day_of_week INT
);

-- Populate dim_date

INSERT INTO analytics.dim_date (
    date_key,
    full_date,
    year,
    quarter,
    month,
    month_name,
    day,
    day_of_week
)
SELECT DISTINCT
    TO_CHAR(d::date, 'YYYMMDD')::INT,
    d::date,
    EXTRACT(YEAR FROM d)::INT,
    EXTRACT(QUARTER FROM d)::INT,
    EXTRACT(MONTH FROM d)::INT,
    TO_CHAR(d, 'FMMonth'),
    EXTRACT(DAY FROM d)::INT,
    EXTRACT(ISODOW FROM d)::INT
FROM generate_series(
    (SELECT MIN(order_purchase_timestamp)::date
    FROM staging.orders),
    (SELECT MAX(order_purchase_timestamp)::date
    FROM staging.orders),
    INTERVAL '1 day'
) AS gs(d)
ON CONFLICT (date_key) DO NOTHING;
