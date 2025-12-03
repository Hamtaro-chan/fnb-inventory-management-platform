CREATE OR REPLACE FUNCTION process_daily_expiry(shopID BIGINT)
RETURNS TABLE (
    result_message VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
	_batch RECORD;
	_count INTEGER := 0;
BEGIN 
	FOR _batch IN
		SELECT shop_inventory.batch_id
		FROM shop_inventory
		JOIN shop_item_info ON shop_inventory.item_id = shop_item_info.item_id
		WHERE shop_inventory.expiry_date < NOW()
			AND shop_inventory.quantity_remaining > 0
			AND shop_item_info.shop_id = shopID
		LOOP
			PERFORM record_waste(shopID, _batch.batch_id, 'Auto-Expired');
			_count := _count + 1;
		END LOOP;

		RETURN QUERY SELECT ('Processed ' || _count || ' expired batches.')::VARCHAR;
	--This check end-of-day expired items
END;
$$;