Data Quality Check — raw.orders

Total Rows: 99,441

order_id:
    NULL: 0
    DUPLICATES: 0

customer_id:
    NULL: 0

order_status:
    NULL: 0
    Validate Categories:
        delivered: 96478
        shipped: 1107
        canceled: 625
        unavailable: 609
        invoiced : 314
        processing: 301
        created: 5
        approved: 2

order_purchase_timestamp:
    NULL: 0

order_approved_at:
    NULL: 160 (0.16%)

order_delivered_carrier_date:
    NULL: 1783 (1.79%)        

order_delivered_customer_date:
    NULL: 2965 (2.98%)

order_estimated_delivery_date:
    NULL: 0


Logical Date Validity
    order_approved_at < order_purchase_timestamp: 0
    order_delivered_carrier_date < order_approved_at: 1359 (1.37%)
    order_delivered_customer_date < order_delivered_carrier_date: 23 (0.02%)
    order_delivered_customer_date < order_purchase_timestamp: 0
    order_delivered_customer_date > order_estimated_delivery_date: 7827 (7.87%)


Data Quality Check — raw.order_items:

Total Rows: 112,650

order_id:
    NULL: 0

order_item_id:
    NULL: 0

product_id:
    NULL: 0

seller_id:
    NULL: 0

shipping_limit_date:
    NULL: 0

price:
    NULL: 0

fright_value:
    NULL: 0



Data Quality Check — raw.products:

Total Rows: 32,951

product_id:
    NULL: 0

product_category_name:
    NULL: 610 (1.85%)

product_name_length:
    NULL: 610 (1.85%)

product_description_lenght:
    NULL: 610 (1.85%)

product_photos_qty:
    NULL: 610 (1.85%)

product_weight_g:
    NULL: 2 (0.01%)

product_length_cm:
    NULL: 2 (0.01%)

product_height_cm:
    NULL: 2 (0.01%)

product_width_cm:
    NULL: 2 (0.01%)



Data Quality Check — raw.customers:

Total Rows: 99,441

customer_id:
    NULL: 0
    Duplicates: 0

customer_unique_id:
    NULL: 0

customer_zip_code_prefix:
    NULL: 0

customer_city:
    NULL: 0

customer_state:
    NULL: 0



Data Quality Check — raw.sellers:

Total Rows: 3,095
seller_id:
    NULL: 0

seller_zip_code_prefix:
    NULL: 0

seller_city:
    NULL: 0

seller_state:
    NULL: 0

