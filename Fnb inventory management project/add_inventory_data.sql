INSERT INTO shop_inventory (item_id, quantity_remaining, expiry_date, received_date, cost) VALUES
(9, 150.00, NOW() + INTERVAL '1 year',   NOW() - INTERVAL '8 months', 0.20);