-- orders

-- check if the date formats are valid
SELECT
    column_name,
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (
        WHERE date_value IS NOT NULL
          AND date_value !~ '^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$'
    ) AS invalid_format_count,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE date_value IS NOT NULL
              AND date_value !~ '^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$'
        ) / COUNT(*),
        2
    ) AS invalid_format_percentage
FROM raw.orders
CROSS JOIN LATERAL (
    VALUES
        ('order_purchase_timestamp', order_purchase_timestamp),
        ('order_approved_at', order_approved_at),
        ('order_delivered_carrier_date', order_delivered_carrier_date),
        ('order_delivered_customer_date', order_delivered_customer_date),
        ('order_estimated_delivery_date', order_estimated_delivery_date)
) AS dates(column_name, date_value)
GROUP BY column_name
ORDER BY column_name;

-- Check logical date validity
SELECT
    COUNT(*) FILTER (
        WHERE order_approved_at < order_purchase_timestamp
    ) AS approved_before_purchase,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE order_approved_at < order_purchase_timestamp
        ) / COUNT(*), 2
    ) AS approved_before_purchase_pct,

    COUNT(*) FILTER (
        WHERE order_delivered_carrier_date < order_approved_at
    ) AS carrier_before_approval,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE order_delivered_carrier_date < order_approved_at
        ) / COUNT(*), 2
    ) AS carrier_before_approval_pct,

    COUNT(*) FILTER (
        WHERE order_delivered_customer_date < order_delivered_carrier_date
    ) AS customer_delivery_before_carrier,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE order_delivered_customer_date < order_delivered_carrier_date
        ) / COUNT(*), 2
    ) AS customer_delivery_before_carrier_pct,

    COUNT(*) FILTER (
        WHERE order_delivered_customer_date < order_purchase_timestamp
    ) AS delivery_before_purchase,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE order_delivered_customer_date < order_purchase_timestamp
        ) / COUNT(*), 2
    ) AS delivery_before_purchase_pct,

    COUNT(*) FILTER (
        WHERE order_delivered_customer_date > order_estimated_delivery_date
    ) AS delivered_after_estimate,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE order_delivered_customer_date > order_estimated_delivery_date
        ) / COUNT(*), 2
    ) AS delivered_after_estimate_pct

FROM raw.orders;