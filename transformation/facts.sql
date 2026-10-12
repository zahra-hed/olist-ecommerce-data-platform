CREATE SCHEMA IF NOT EXISTS analytics;

-- Create fact_orders

CREATE TABLE analytics.fact_orders (
    order_id VARCHAR PRIMARY_KEY,
    customer_id VARCHAR NOT NULL,
    order_status VARCHAR,
    purchase_date_key INT,
    approved_at TIMESTAMP,
    delivered_carrier_at TIMESTAMP,
    delivered_customer_at TIMESTAMP,
    estimated_delivery_at TIMESTAMP,

    FOREIGN KEY (customer_id)
        REFERENCES analytics.dim_customer(customer_id),
    
    FOREIGN KEY (purchase_date_key)
        REFERENCES analytics.dim_date(date_key)
);

-- Populate fact_orders

INSERT INTO analytics.fact_orders (
    order_id,
    customer_id,
    order_status,
    purchase_date_key,
    approved_at,
    delivered_carrier_at,
    delivered_customer_at,
    estimated_delivery_at
)
SELECT
    o.order_id
    o.customer_id,
    o.order_status,
    TO_CHAR(o.order_purchase_timestamp::date, 'YYYYMMDD')::INT,
    o.order_approved_at,
    o.order_delivered_carrier_date,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date
FROM staging.orders o
JOIN analytics.dim_customer c
    ON o.customer_id = c.customer_id
WHERE o.order_id IS NOT NULL
ON CONFLICT (order_id) DO NOTHING;