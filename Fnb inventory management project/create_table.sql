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
		i.item_name
		inv.batch_id
		inv.quantity_remaining
		inv.expiry_date
		EXTRACT (DAY FROM(inv.expiry_date - NOW()))::INTEGER
	FROM shop_inventory inv
	JOIN shop_item_info i on inv.item_id = i.item_id
	
	
		
