-- orders

CREATE SCHEMA IF NOT EXISTS staging;

DROP TABLE IF EXISTS staging.orders;

CREATE TABLE staging.orders AS
SELECT
order_id,
customer_id,
order_status,

NULLIF(order_purchase_timestamp, '')::TIMESTAMP
    AS order_purchase_timestamp,

NULLIF(order_approved_at, '')::TIMESTAMP
    AS order_approved_at,

NULLIF(order_delivered_carrier_date, '')::TIMESTAMP
    AS order_delivered_carrier_date,

NULLIF(order_delivered_customer_date, '')::TIMESTAMP
    AS order_delivered_customer_date,

NULLIF(order_estimated_delivery_date, '')::TIMESTAMP
    AS order_estimated_delivery_date,

-- Logical date validity flags
COALESCE(
    NULLIF(order_delivered_carrier_date, '')::TIMESTAMP
    < NULLIF(order_approved_at, '')::TIMESTAMP,
    FALSE
) AS flag_carrier_before_approval,

COALESCE(
    NULLIF(order_delivered_customer_date, '')::TIMESTAMP
    < NULLIF(order_delivered_carrier_date, '')::TIMESTAMP,
    FALSE
) AS flag_customer_delivery_before_carrier,

COALESCE(
    NULLIF(order_delivered_customer_date, '')::TIMESTAMP
    > NULLIF(order_estimated_delivery_date, '')::TIMESTAMP,
    FALSE
) AS flag_delivery_after_estimate

FROM raw.orders;

-- customers

DROP TABLE IF EXISTS staging.customers;

CREATE TABLE staging.customers AS
SELECT
customer_id,
customer_unique_id,
customer_zip_code_prefix,
customer_city,
customer_state

FROM raw.customers;