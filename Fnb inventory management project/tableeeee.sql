INSERT INTO menu_ingredients (menu_id, item_id, required_unit) VALUES
((SELECT menu_id FROM shop_menu WHERE menu_name = 'Butter Croissant'), (SELECT item_id FROM shop_item_info WHERE item_name = 'All Purpose Flour' AND shop_id = 2), 1),
((SELECT menu_id FROM shop_menu WHERE menu_name = 'Butter Croissant'), (SELECT item_id FROM shop_item_info WHERE item_name = 'Unsalted Butter' AND shop_id = 2), 1);

-- Recipe: Chocolate Cake (Flour + Chocolate + Eggs)
INSERT INTO menu_ingredients (menu_id, item_id, required_unit) VALUES
((SELECT menu_id FROM shop_menu WHERE menu_name = 'Chocolate Lava Cake'), (SELECT item_id FROM shop_item_info WHERE item_name = 'All Purpose Flour' AND shop_id = 2), 1),
((SELECT menu_id FROM shop_menu WHERE menu_name = 'Chocolate Lava Cake'), (SELECT item_id FROM shop_item_info WHERE item_name = 'Dark Chocolate Chips' AND shop_id = 2), 1),
((SELECT menu_id FROM shop_menu WHERE menu_name = 'Chocolate Lava Cake'), (SELECT item_id FROM shop_item_info WHERE item_name = 'Fresh Eggs' AND shop_id = 2), 2);