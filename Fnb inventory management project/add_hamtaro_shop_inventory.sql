INSERT INTO shop_inventory (item_id, quantity_remaining, expiry_date, received_date, cost) VALUES
(1, 1000.00, NOW() + INTERVAL '180 days', NOW() - INTERVAL '5 days', 20.00), -- Matcha (Fresh)
(2, 5000.00, NOW() + INTERVAL '7 days',   NOW() - INTERVAL '1 day',  0.05), -- Milk (Fresh)
(3, 2000.00, NOW() + INTERVAL '10 days',  NOW() - INTERVAL '1 day',  0.08), -- Oat Milk
(4, 2000.00, NOW() + INTERVAL '365 days', NOW() - INTERVAL '10 days', 0.40), -- Cocoa
(5, 50.00,   NOW() + INTERVAL '90 days',  NOW() - INTERVAL '30 days', 0.50), -- Mint Syrup
(7, 3000.00, NOW() + INTERVAL '30 days',  NOW() - INTERVAL '2 days',  0.60); -- Beans