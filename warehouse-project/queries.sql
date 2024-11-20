-- Check low inventory
SELECT item_name, quantity
FROM inventory
WHERE quantity < 100;

-- Identify fastest suppliers for low-stock items
SELECT s.supplier_name, i.item_name, s.supply_lead_time
FROM suppliers s
JOIN inventory i ON s.item_id = i.item_id
WHERE i.quantity < 100
ORDER BY s.supply_lead_time ASC;

-- Aggregate order quantities
SELECT item_id, SUM(quantity) as total_ordered
FROM orders
GROUP BY item_id;
