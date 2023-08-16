USE ecommerce_project_ruiz;

#FUNCTION 1
DELIMITER $$
CREATE FUNCTION `get_product_price` (id INT) RETURNS FLOAT
# Esta función recibe el ID de un producto por parámetro y devuelve el precio de dicho producto. 
DETERMINISTIC
BEGIN
	DECLARE price_found FLOAT;
	SELECT price INTO price_found FROM product 
	WHERE id_product = id;
    RETURN price_found;
END
$$

SELECT get_product_price(3);

# FUNCTION 2
DELIMITER $$
CREATE FUNCTION `check_stock` (stock INT) RETURNS VARCHAR(55)
# Esta función recibe el número de stock de un producto por parámetro y devuelve un aviso sobre la cantidad de stock. 
DETERMINISTIC
BEGIN
	CASE
    WHEN stock = 0 THEN
    RETURN 'Producto agotado.';
	WHEN stock <= 5 THEN
    RETURN 'Bajo stock';
    WHEN stock > 5 AND stock <20 THEN
    RETURN 'Producto en stock';
    WHEN stock > 20 THEN
    RETURN 'Exceso de stock';
    END CASE;
END
$$

SELECT check_stock(0)


# FUNCTION 3
DELIMITER $$
CREATE FUNCTION `change_username` (old_username VARCHAR(30), new_username VARCHAR(30)) RETURNS VARCHAR(30)
# Esta función actualiza el nombre de usuario de un cliente, ingresando por parámetro: primero el nombre de usuario viejo, y luego el nuevo nombre a actualizar. 
DETERMINISTIC
BEGIN
    UPDATE `user` SET username = new_username WHERE username = old_username;
    RETURN new_username;
END
$$


SELECT change_username('diegoo10', 'diegoo.martin');
SELECT * FROM user;

#FUNCTION 4
DELIMITER $$
CREATE FUNCTION `search_last_purchase` (client_username VARCHAR(50)) RETURNS FLOAT
# Esta función actualiza el nombre de usuario de un cliente, ingresando por parámetro: primero el nombre de usuario viejo, y luego el nuevo nombre a actualizar. 
DETERMINISTIC
BEGIN
    DECLARE user_identifier INT;
    DECLARE result INT;
    SELECT id_user INTO user_identifier FROM `user` WHERE username = client_username;
    SELECT total_price INTO result FROM `purchase_order` WHERE id_user = user_identifier;
    RETURN result;
END
$$

# Usuario que efectuo compra:
SELECT search_last_purchase('giseromaa2'); 
# Usuario que no tiene ninguna compra, devuelve null:
SELECT search_last_purchase('maurii.30'); 

