-- For start shopping with supplier
CREATE OR REPLACE FUNCTION start_purchase_order(shopID BIGINT, supplierID BIGINT)
RETURNS BIGINT
LANGUAGE plpgsql
AS $$
DECLARE 
    new_po_id BIGINT;
BEGIN
    INSERT INTO purchase_orders (
        shop_id, supplier_id, total_amount, commission_fee, status
    )
    VALUES (
        shopID, supplierID, 0, 0, 'draft' 
    )
    RETURNING po_id INTO new_po_id;
    RETURN new_po_id;
END;            
$$;