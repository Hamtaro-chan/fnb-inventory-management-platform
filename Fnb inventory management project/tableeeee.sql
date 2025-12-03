INSERT INTO customer_order_items (order_id, menu_id, quantity, price_at_sale) VALUES
((SELECT MAX(order_id) FROM customer_orders), (SELECT menu_id FROM shop_menu WHERE menu_name = 'Butter Croissant'), 2, 65.00),
((SELECT MAX(order_id) - 1 FROM customer_orders), (SELECT menu_id FROM shop_menu WHERE menu_name = 'Chocolate Lava Cake'), 1, 120.00),
((SELECT MAX(order_id) - 2 FROM customer_orders), (SELECT menu_id FROM shop_menu WHERE menu_name = 'Vanilla Cupcake'), 4, 55.00),
((SELECT MAX(order_id) - 3 FROM customer_orders), (SELECT menu_id FROM shop_menu WHERE menu_name = 'Sourdough Loaf'), 1, 150.00);