DROP TABLE IF EXISTS waste_log CASCADE;
DROP TABLE IF EXISTS purchase_order_items CASCADE;
DROP TABLE IF EXISTS purchase_orders CASCADE;
DROP TABLE IF EXISTS supplier_goods CASCADE;
DROP TABLE IF EXISTS ingredient_supplier CASCADE;
DROP TABLE IF EXISTS customer_order_items CASCADE;
DROP TABLE IF EXISTS customer_orders CASCADE;
DROP TABLE IF EXISTS menu_ingredients CASCADE;
DROP TABLE IF EXISTS shop_menu CASCADE;
DROP TABLE IF EXISTS shop_inventory CASCADE;
DROP TABLE IF EXISTS shop_item_info CASCADE;
DROP TABLE IF EXISTS shop_user CASCADE;

CREATE TABLE shop_user (
	shop_id BIGSERIAL PRIMARY KEY,
    shop_name VARCHAR(255) NOT NULL,
    category VARCHAR(100)
);

CREATE TABLE shop_item_info (
	item_id BIGSERIAL PRIMARY KEY,
	shop_id BIGINT REFERENCES shop_user(shop_id),
	item_name VARCHAR(255) NOT NULL,
	unit_of_measure VARCHAR(50),
	reorder_level INTEGER DEFAULT 10
);

CREATE TABLE shop_inventory (
	batch_id BIGSERIAL PRIMARY KEY,
	item_id BIGINT REFERENCES shop_item_info(item_id),
	quantity_remaining NUMERIC(10, 2),
	expiry_date TIMESTAMPTZ,
	received_date TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
	cost NUMERIC(10, 2)
);

CREATE TABLE shop_menu (
	menu_id BIGSERIAL PRIMARY KEY,
	shop_id BIGINT REFERENCES shop_user(shop_id),
	menu_name VARCHAR(255) NOT NULL,
	price NUMERIC(10, 2)
);

CREATE TABLE menu_ingredients (
	menu_id BIGINT REFERENCES shop_menu(menu_id),
    item_id BIGINT REFERENCES shop_item_info(item_id),
	required_unit INTEGER,
    PRIMARY KEY (menu_id, item_id)
);

CREATE TABLE customer_orders(
	order_id BIGSERIAL PRIMARY KEY,
	shop_id BIGINT REFERENCES shop_user(shop_id),
	order_data TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
	total_price NUMERIC(10, 2),
	status VARCHAR(50)
);

CREATE TABLE customer_order_items (
	ordder_item_id BIGSERIAL PRIMARY KEY,
	order_id BIGINT REFERENCES customer_orders(order_id),
	menu_id BIGINT REFERENCES shop_menu(menu_id),
	quantity INTEGER,
	price_at_sale NUMERIC(10, 2)
);


CREATE TABLE ingredient_supplier (
	supplier_id BIGSERIAL PRIMARY KEY,
	supplier_name VARCHAR(255) NOT NULL,
    category VARCHAR(100)
);

CREATE TABLE supplier_goods (
	good_id BIGSERIAL PRIMARY KEY,
	supplier_id BIGINT REFERENCES ingredient_supplier(supplier_id),
	ingredient_name VARCHAR(255),
    current_cost NUMERIC(10, 2)
);


CREATE TABLE purchase_orders (
    po_id BIGSERIAL PRIMARY KEY,
    shop_id BIGINT REFERENCES shop_user(shop_id),
    supplier_id BIGINT REFERENCES ingredient_supplier(supplier_id),
	order_date TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
	total_amount NUMERIC(10, 2),
    commission_fee NUMERIC(10, 2), 
    status VARCHAR(50)
);

CREATE TABLE purchase_order_items (
    po_item_id BIGSERIAL PRIMARY KEY,
    po_id BIGINT REFERENCES purchase_orders(po_id),
    good_id BIGINT REFERENCES supplier_goods(good_id),
    quantity INTEGER,
    unit_cost_snapshot NUMERIC(10, 2)
);

CREATE TABLE waste_log (
    log_id BIGSERIAL PRIMARY KEY,
    shop_id BIGINT REFERENCES shop_user(shop_id),
    batch_id BIGINT REFERENCES shop_inventory(batch_id),
    quantity_wasted NUMERIC(10, 2),
    reason VARCHAR(255),
	log_date TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

