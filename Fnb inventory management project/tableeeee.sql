INSERT INTO shop_inventory (item_id, quantity_remaining, expiry_date, received_date, cost) VALUES
((SELECT item_id FROM shop_item_info WHERE item_name = 'All Purpose Flour' AND shop_id = 2), 50.00, NOW() + INTERVAL '6 months', NOW() - INTERVAL '2 days', 20.00),
((SELECT item_id FROM shop_item_info WHERE item_name = 'All Purpose Flour' AND shop_id = 2), 20.00, NOW() + INTERVAL '5 months', NOW() - INTERVAL '20 days', 20.00),
((SELECT item_id FROM shop_item_info WHERE item_name = 'White Sugar' AND shop_id = 2), 30.00, NOW() + INTERVAL '1 year', NOW() - INTERVAL '10 days', 15.00),
((SELECT item_id FROM shop_item_info WHERE item_name = 'Unsalted Butter' AND shop_id = 2), 100.00, NOW() + INTERVAL '1 month', NOW() - INTERVAL '1 day', 80.00),
((SELECT item_id FROM shop_item_info WHERE item_name = 'Fresh Eggs' AND shop_id = 2), 20.00, NOW() + INTERVAL '14 days', NOW() - INTERVAL '1 day', 100.00),
((SELECT item_id FROM shop_item_info WHERE item_name = 'Fresh Eggs' AND shop_id = 2), 5.00, NOW() - INTERVAL '1 day', NOW() - INTERVAL '15 days', 100.00), -- EXPIRED BATCH
((SELECT item_id FROM shop_item_info WHERE item_name = 'Yeast' AND shop_id = 2), 50.00, NOW() + INTERVAL '6 months', NOW() - INTERVAL '30 days', 5.00),
((SELECT item_id FROM shop_item_info WHERE item_name = 'Dark Chocolate Chips' AND shop_id = 2), 10.00, NOW() + INTERVAL '1 year', NOW() - INTERVAL '5 days', 250.00),
((SELECT item_id FROM shop_item_info WHERE item_name = 'Heavy Cream' AND shop_id = 2), 15.00, NOW() + INTERVAL '10 days', NOW() - INTERVAL '2 days', 120.00),
((SELECT item_id FROM shop_item_info WHERE item_name = 'Salt' AND shop_id = 2), 5.00, NOW() + INTERVAL '2 years', NOW() - INTERVAL '60 days', 10.00);