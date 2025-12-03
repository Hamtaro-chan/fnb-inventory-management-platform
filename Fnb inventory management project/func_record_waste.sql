CREATE OR REPLACE FUNCTION record_waste(shopID BIGINT, batchID BIGINT, reason VARCHAR)
RETURNS VARCHAR
LANGUAGE plpgsql
AS $$
DECLARE
	qty_to_waste NUMERIC;
	itemID BIGINT;
BEGIN 
	SELECT quantity_remaining, item_id
	INTO qty_to_waste, itemID
	FROM shop_inventory
	WHERE batch_id = batchID;

	IF qty_to_waste IS NULL THEN
		RAISE EXCEPTION 'Batch ID % not found.', batchID;
	END IF;
	IF qty_to_waste = 0 THEN 
		RETURN 'Batch is already empty. No waste recorded.';
	END IF;

	INSERT INTO waste_log(shop_id, batch_id, quantity_wasted, reason, log_date)
	VALUES (shopID, batchID, qty_to_waste, reason, NOW());

	UPDATE shop_inventory 
    SET quantity_remaining = 0 
    WHERE batch_id = batchID;

	RETURN 'Success: Wasted ' || qty_to_waste || ' units.';
END;
$$