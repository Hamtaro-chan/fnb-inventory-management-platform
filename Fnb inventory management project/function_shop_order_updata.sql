CREATE OR REPLACE FUNCTION sell_menu_item (shopID BIGINT, menuID BIGINT)
RETURNS VARCHAR
LANGUAGE plpgsql
AS $$
DECLARE 
	ingred RECORD;
	batch RECORD;
	required_qty NUMERIC;
	menu_price NUMERIC;
BEGIN
	SELECT price INTO menu_price FROM shop_menu WHERE menu_id = menuID;
	FOR ingred IN 
		SELECT item_id, required_unit
		FROM menu_ingredients
		WHERE menu_id = menuID
	LOOP
		required_qty:=ingred.required_unit;

		FOR batch IN 
			SELECT batch_id, quantity_remaining
			FROM shop_inventory
			WHERE item_id = ingred.item_id
				AND quantity_remaining > 0
			ORDER BY received_date ASC -- Oldest First
		LOOP 
			--Enough ingredien
			IF batch.quantity_remaining >= required_qty THEN
				UPDATE shop_inventory
				SET quantity_remaining = quantity_remaining - required_qty
				WHERE batch_id = batch.batch_id;
				required_qty := 0;
				EXIT;
			ELSE 
				UPDATE shop_inventory 
                SET quantity_remaining = 0
				WHERE batch_id = batch.batch_id;
				required_qty := required_qty - batch.quantity_remaining;
			END IF;
		END LOOP;
		IF required_qty > 0 THEN
			RAISE EXCEPTION 'Not enough stock for Ingredient ID %', ingred.item_id;
        END IF;
    END LOOP;

	INSERT INTO customer_orders (shop_id, total_price, status) -- updata the sale table
    VALUES (shopID, menu_price, 'paid');
    RETURN 'Sale Successful';
END;			
$$