CREATE OR REPLACE FUNCTION create_purchase_order(shopID BIGINT, supplierID BIGINT, totalCost NUMERIC)
RETURNS BIGINT
LANGUAGE plpgsql
AS $$
DECLARE 
    new_po_id BIGINT;
    commission_rate NUMERIC := 0.15; -- it's where the app make money
    calculated_fee NUMERIC;
BEGIN
  
    calculated_fee := totalCost * commission_rate;

    INSERT INTO purchase_orders (
        shop_id, 
        supplier_id, 
        total_amount, 
        commission_fee, 
        status
    )
    VALUES (
        shopID,  
		supplierID,
		totalCost,
		calculated_fee,
		'ordered'
    )
    RETURNING po_id INTO new_po_id;
    RETURN new_po_id;
END;            
$$;