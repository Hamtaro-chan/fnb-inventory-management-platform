-- Find items expiring within X days
CREATE OR REPLACE FUNCTION check_expiring_inventory(shopID BIGINT, thresholdDate INT)
RETURNS TABLE(
	batch_id BIGINT,
	item_name VARCHAR,
    expiry_date TIMESTAMPTZ,
    quantity_remaining NUMERIC,
    days_until_expiry INTEGER
)
LANGUAGE plpgsql
As $$
BEGIN 
	RETURN QUERY
	SELECT 
		i.item_name,
		inv.batch_id,
		inv.expiry_date,
		inv.quantity_remaining,
		EXTRACT (DAY FROM(inv.expiry_date - NOW()))::INTEGER
	FROM shop_inventory inv
	JOIN shop_item_info i on inv.item_id = i.item_id
	WHERE inv.expiry_date BETWEEN NOW() AND (NOW() + (thresholdDate||'days')::INTERVAL)
		AND inv.quantity_remaining > 0
		AND i.shop_id = shopID
	ORDER BY inv.expiry_date ASC;
END;
$$;
	
		
