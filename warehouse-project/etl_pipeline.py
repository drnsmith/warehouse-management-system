import pandas as pd
import psycopg2
import yaml

# Load Configurations
with open("config.yaml", "r") as file:
    config = yaml.safe_load(file)

def load_csv(file_path):
    return pd.read_csv(file_path)

def load_to_database(df, table_name, conn):
    cursor = conn.cursor()
    for _, row in df.iterrows():
        cursor.execute(f"INSERT INTO {table_name} VALUES (%s, %s, %s)", tuple(row))
    conn.commit()

def main():
    conn = psycopg2.connect(
        host=config['database']['host'],
        port=config['database']['port'],
        user=config['database']['user'],
        password=config['database']['password'],
        database=config['database']['database']
    )
    # Load and process files
    inventory = load_csv(config['etl']['source_files']['inventory'])
    load_to_database(inventory, "inventory", conn)
    conn.close()

if __name__ == "__main__":
    main()
