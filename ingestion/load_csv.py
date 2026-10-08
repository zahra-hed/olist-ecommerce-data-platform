import pandas as pd
from sqlalchemy import create_engine

DATABASE_URL = "postgresql://postgres:capy3ara@localhost:5432/olist_ecommerce_db"

engine = create_engine(DATABASE_URL)

files = {
    "customers": "data/olist_customers_dataset.csv",
    "geolocation": "data/olist_geolocation_dataset.csv",
    "order_items": "data/olist_order_items_dataset.csv",
    "order_payments": "data/olist_order_payments_dataset.csv",
    "order_reviews": "data/olist_order_reviews_dataset.csv",
    "orders": "data/olist_orders_dataset.csv",
    "products": "data/olist_products_dataset.csv",
    "sellers": "data/olist_sellers_dataset.csv",
    "category_name_translation": "data/product_category_name_translation.csv"
    }

for table_name, file_path in files.items():

    print(f"Loading {file_path}...")

    df = pd.read_csv(file_path)

    df.to_sql(
        table_name,
        engine,
        schema="raw",
        if_exists="replace",
        index="False"
    )

    print(f"Loaded {len(df)} rows into raw.{table_name}")