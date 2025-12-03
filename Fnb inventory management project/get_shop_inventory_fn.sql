CREATE OR REPLACE FUNCTION get_shop_inventory(_shop_id BIGINT)
RETURNS TABLE (
    item_name VARCHAR,
    batch_id BIGINT,
    quantity_remaining NUMERIC,
    expiry_date TIMESTAMPTZ
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        i.item_name, 
        inv.batch_id, 
        inv.quantity_remaining, 
        inv.expiry_date
    FROM shop_inventory inv
    JOIN shop_item_info i ON inv.item_id = i.item_id
    WHERE i.shop_id = _shop_id;
END;
$$;