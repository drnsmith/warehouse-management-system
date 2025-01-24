CREATE TABLE inventory (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(255),
    quantity INT,
    warehouse_location VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    item_id INT REFERENCES inventory(item_id),
    quantity INT,
    order_date DATE
);

CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(255),
    item_id INT REFERENCES inventory(item_id),
    supply_lead_time INT
);
