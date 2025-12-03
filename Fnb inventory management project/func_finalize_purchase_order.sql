-- For start shopping with supplier
CREATE OR REPLACE FUNCTION finalize_purchase_order(poID BIGINT)
RETURNS VARCHAR
LANGUAGE plpgsql
AS $$
DECLARE
    real_total NUMERIC;
    comm_rate NUMERIC := 0.15;
    calc_fee NUMERIC;
BEGIN
    SELECT SUM(quantity * unit_cost_snapshot) 
    INTO real_total
    FROM purchase_order_items
    WHERE po_id = poID;

	IF real_total IS NULL THEN
        real_total := 0;
    END IF

	calc_fee := real_total * comm_rate;

	UPDATE purchase_orders
    SET total_amount = real_total,
        commission_fee = calc_fee,
        status = 'ordered'
	WHERE po_id = poID;
	RETURN 'Order Finalized. Total: ' || real_total || '. Fee: ' || calc_fee;
	
END;            
$$;