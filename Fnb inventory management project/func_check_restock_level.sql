CREATE OR REPLACE FUNCTION check_restock_level(shopID BIGINT)
RETURNS TABLE(
	item_name VARCHAR,
	total_quantity NUMERIC,
	reorder_level INTEGER,
	status VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN QUERY
	SELECT 
		i.item_name,
		COALESCE(SUM(inv.quantity_remaining), 0) AS total_quantity,
		i.reorder_level,
		'Restock Needed'::VARCHAR AS status
	FROM shop_item_info i
	LEFT JOIN shop_inventory inv ON i.item_id = inv.item_id
	WHERE i.shop_id = shopID
	GROUP BY i.item_id, i.item_name, i.reorder_level
	HAVING COALESCE(SUM(inv.quantity_remaining), 0) <= i.reorder_level;
END;			
$$