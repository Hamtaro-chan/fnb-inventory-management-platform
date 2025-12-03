CREATE OR REPLACE FUNCTION add_purchase_order(poID BIGINT, goodID BIGINT, qty INTEGER, unit_cost NUMERIC)
RETURNS VOID
LANGUAGE plpgsql
AS $$
	INSERT INTO purchase_order_items (po_id, good_id, quantity, unit_cost_snapshot)
	VALUES (poID, goodID, qty, unit_cost);
END;
$$;