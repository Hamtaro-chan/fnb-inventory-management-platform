ALTER TABLE ingredient_supplier 
ADD COLUMN password_hash VARCHAR(255);
UPDATE ingredient_supplier 
SET password_hash = '$2kueThisIsAFakeHashString';