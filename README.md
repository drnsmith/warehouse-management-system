### Scalable Data Warehouse Design with Snowflake and Oracle

#### **Overview**
This project demonstrates a **warehouse management system** that uses **ETL pipelines** and **PostgreSQL** for efficient inventory and order management. The system supports data ingestion, low-stock alerts, supplier management, and analytical queries to enhance operational decision-making.

---

#### **Features**
1. **Database Schema**:
   - Tracks inventory, orders, and supplier details through a relational database.
   - Enforces referential integrity using foreign keys.
   
2. **SQL Queries**:
   - Identifies low inventory items.
   - Recommends the fastest suppliers for replenishment.
   - Aggregates order quantities for inventory planning.

3. **ETL Pipeline**:
   - Loads inventory data from CSV files into the database.
   - Automates data extraction, transformation, and loading (ETL).

---

## **Database Schema**

### **Tables**
#### 1. **`inventory`**
Tracks warehouse items, their quantities, and storage locations.
```sql
CREATE TABLE inventory (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(255),
    quantity INT,
    warehouse_location VARCHAR(50)
);
```

#### 2. **`orders`**
Records order transactions for inventory items.
```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    item_id INT REFERENCES inventory(item_id),
    quantity INT,
    order_date DATE
);
```

#### 3. **`suppliers`**
Stores supplier details, including lead times for supplying inventory items.
```sql
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(255),
    item_id INT REFERENCES inventory(item_id),
    supply_lead_time INT
);
```

---

## **SQL Queries**

### 1. **Check Low Inventory**
Identifies items with quantities below a threshold:
```sql
SELECT item_name, quantity
FROM inventory
WHERE quantity < 100;
```

### 2. **Identify Fastest Suppliers for Low-Stock Items**
Lists suppliers for items with low stock, sorted by lead time:
```sql
SELECT s.supplier_name, i.item_name, s.supply_lead_time
FROM suppliers s
JOIN inventory i ON s.item_id = i.item_id
WHERE i.quantity < 100
ORDER BY s.supply_lead_time ASC;
```

### 3. **Aggregate Order Quantities**
Summarises total quantities ordered for each item:
```sql
SELECT item_id, SUM(quantity) as total_ordered
FROM orders
GROUP BY item_id;
```

---

## **Installation**

### **1. Clone the Repository**
```bash
git clone https://github.com/drnsmith/warehouse-management-system.git
cd warehouse-management-system
```

### **2. Set Up Python Environment**
- Create a virtual environment:
  ```bash
  python -m venv venv
  ```
- Activate the virtual environment:
  - On Windows:
    ```bash
    venv\Scripts\activate
    ```
  - On Unix or macOS:
    ```bash
    source venv/bin/activate
    ```
- Install dependencies:
  ```bash
  pip install -r requirements.txt
  ```

### **3. Set Up PostgreSQL**
- Create a PostgreSQL database:
  ```sql
  CREATE DATABASE warehouse_db;
  ```
- Run the SQL schema definitions to create the tables (`inventory`, `orders`, `suppliers`).

### **4. Configure Database Connection**
- Update the `config.yaml` file with your database credentials:
  ```yaml
  database:
    host: "localhost"
    port: 5432
    user: "your_username"
    password: "your_password"
    database: "warehouse_db"
  ```

---

## **Usage**

### **1. Load Data**
- Place your CSV files for inventory in the directory specified in `config.yaml`.
- Run the Python ETL pipeline:
  ```bash
  python etl_pipeline.py
  ```

### **2. Execute SQL Queries**
- Use the provided SQL queries to:
  - Identify low-stock items.
  - Find the fastest suppliers.
  - Analyse order trends.

---

## **Future Enhancements**
1. **Data Validation**:
   - Ensure input data adheres to schema constraints before loading.
2. **Reporting Dashboard**:
   - Create a dashboard for real-time monitoring of inventory, orders, and supplier metrics.
3. **Machine Learning**:
   - Predict inventory shortages based on historical order trends and lead times.
---

## Contributing
Special thanks to Ela Bastani for her dedication to making this project a success. 

If you have any questions or suggestions, please feel free to open an issue or contact me directly. 

Contributions are welcome! Please fork the repository and submit a pull request with your changes. For major updates, open an issue to discuss them first.

## License
This project is licensed under the MIT License. See the LICENSE file for details.

