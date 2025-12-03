CREATE OR REPLACE FUNCTION record_waste(
    shopID BIGINT, 
    batchID BIGINT, 
    amount NUMERIC,
    reason VARCHAR
)
RETURNS VARCHAR
LANGUAGE plpgsql
AS $$
DECLARE
    current_qty NUMERIC;
BEGIN 

    SELECT quantity_remaining INTO current_qty
    FROM shop_inventory
    WHERE batch_id = batchID;

    IF current_qty IS NULL THEN
        RAISE EXCEPTION 'Batch ID % not found.', batchID; 
    END IF;

    IF amount > current_qty THEN 
        RAISE EXCEPTION 'Cannot waste % units. Only % units available in Batch %.', amount, current_qty, batchID;
    END IF;

    INSERT INTO waste_log(shop_id, batch_id, quantity_wasted, reason, log_date)
    VALUES (shopID, batchID, amount, reason, NOW());

    UPDATE shop_inventory 
    SET quantity_remaining = quantity_remaining - amount 
    WHERE batch_id = batchID;

    RETURN 'Success: Wasted ' || amount || ' units. Remaining: ' || (current_qty - amount);
END;
$$;