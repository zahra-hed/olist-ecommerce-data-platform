-- orders 
SELECT
    'SELECT ''' || column_name || ''' AS column_name, '
    || 'COUNT(*) AS total_rows, '
    || 'COUNT(*) FILTER (WHERE "' || column_name || '" IS NULL) AS null_count, '
    || 'ROUND(100.0 * COUNT(*) FILTER (WHERE "' || column_name || '" IS NULL) / COUNT(*), 2) AS null_percentage '
    || 'FROM raw.orders;'
FROM information_schema.columns
WHERE table_schema = 'raw'
  AND table_name = 'orders';

-- order_items
SELECT
    'SELECT ''' || column_name || ''' AS column_name, '
    || 'COUNT(*) AS total_rows, '
    || 'COUNT(*) FILTER (WHERE "' || column_name || '" IS NULL) AS null_count, '
    || 'ROUND(100.0 * COUNT(*) FILTER (WHERE "' || column_name || '" IS NULL) / COUNT(*), 2) AS null_percentage '
    || 'FROM raw.order_items;'
FROM information_schema.columns
WHERE table_schema = 'raw'
  AND table_name = 'order_items';


-- products
SELECT
    'SELECT ''' || column_name || ''' AS column_name, '
    || 'COUNT(*) AS total_rows, '
    || 'COUNT(*) FILTER (WHERE "' || column_name || '" IS NULL) AS null_count, '
    || 'ROUND(100.0 * COUNT(*) FILTER (WHERE "' || column_name || '" IS NULL) / COUNT(*), 2) AS null_percentage '
    || 'FROM raw.products;'
FROM information_schema.columns
WHERE table_schema = 'raw'
  AND table_name = 'products';

--  customers 
SELECT
    'SELECT ''' || column_name || ''' AS column_name, '
    || 'COUNT(*) AS total_rows, '
    || 'COUNT(*) FILTER (WHERE "' || column_name || '" IS NULL) AS null_count, '
    || 'ROUND(100.0 * COUNT(*) FILTER (WHERE "' || column_name || '" IS NULL) / COUNT(*), 2) AS null_percentage '
    || 'FROM raw.customers;'
FROM information_schema.columns
WHERE table_schema = 'raw'
  AND table_name = 'customers';

-- sellers
SELECT
    'SELECT ''' || column_name || ''' AS column_name, '
    || 'COUNT(*) AS total_rows, '
    || 'COUNT(*) FILTER (WHERE "' || column_name || '" IS NULL) AS null_count, '
    || 'ROUND(100.0 * COUNT(*) FILTER (WHERE "' || column_name || '" IS NULL) / COUNT(*), 2) AS null_percentage '
    || 'FROM raw.sellers;'
FROM information_schema.columns
WHERE table_schema = 'raw'
  AND table_name = 'sellers';
