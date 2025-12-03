INSERT INTO waste_log (shop_id, batch_id, quantity_wasted, reason, log_date) VALUES
(2, (SELECT MAX(batch_id) FROM shop_inventory), 5.00, 'Dropped', NOW()),
(2, (SELECT MAX(batch_id)-1 FROM shop_inventory), 2.00, 'Expired', NOW() - INTERVAL '1 day'),
(1, 1, 10.00, 'Spilled', NOW() - INTERVAL '5 days'),
(1, 2, 5.00, 'Quality Check Failed', NOW() - INTERVAL '6 days'),
(5, (SELECT MIN(batch_id) FROM shop_inventory WHERE item_id = 11), 50.00, 'Bag Ripped', NOW()),
(5, (SELECT MIN(batch_id) FROM shop_inventory WHERE item_id = 12), 200.00, 'Fridge Failure', NOW()),
(2, (SELECT MAX(batch_id)-2 FROM shop_inventory), 1.00, 'Sample Testing', NOW()),
(2, (SELECT MAX(batch_id)-3 FROM shop_inventory), 10.00, 'Expired', NOW() - INTERVAL '2 days');