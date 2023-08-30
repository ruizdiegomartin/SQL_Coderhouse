
#1 ********************************************************* VISTAS ************************************************************

/* VISTA 1: ITEMS EN EL CARRITO. ESTA VISTA ESTÁ CREADA CON EL FIN DE PORDER VISUALIZAR QUE PRODUCTOS TIENEN LOS USUARIOS AGREGADOS EN UN CARRITO, 
ADEMÁS ESTA ORDENADA POR NOMBRE DE USUARIO PARA QUE SEA MAS SENCILLO VER QUE TIENE CADA USER EN PARTICULAR*/

USE ecommerce_project_ruiz;

CREATE VIEW items_in_cart AS ( 
SELECT u.username AS usuario, p.name AS producto, c.item_quantity AS cantidad FROM cart c
JOIN user u
ON c.id_user = u.id_user
JOIN product p
ON c.id_product = p.id_product
ORDER BY u.username);

SELECT * FROM items_in_cart;

# VISTA 2: LUGAR DE RESIDENCIA DE LOS USUARIOS. ESTA VISTA PERMITE VER A QUE PROVINCIA PERTENCE CADA USUARIO, Y ESTÁ ORDENADA POR PROVINCIA EN ORDEN ASCENDENTE.

CREATE VIEW user_location AS (
SELECT CONCAT(u.last_name, ', ', u.first_name ) AS nombre_y_apellido, l.location_name as provincia FROM user u
JOIN location l
ON u.province = l.id_location
ORDER BY l.location_name);

SELECT * FROM user_location;

# VISTA 3: MUESTRA LOS USUARIOS QUE TIENEN MÁS DE UN PRODUCTO EN FAVORITOS (PARA IMPLEMENTAR LA CONDICIÓN DEL 'HAVING COUNT'), Y SU CANTIDAD DE PRODUCTOS EN FAVORITOS.

CREATE VIEW user_favorites_many AS (
SELECT u.username, COUNT(*) as favorites_products_amount FROM favorite f
JOIN user u
ON f.id_user = u.id_user
GROUP BY u.username
HAVING COUNT(*)> 1);

SELECT * FROM user_favorites_many;

/* VISTA 4: ESTA VISTA PERMITE PODER INTERPRETAR FACILMENTE LOS DATOS QUE SE OBTIENEN Y GENERAN POR EL RECLAMO DE UN USUARIO. CONTENMPLA QUE TIPO DE RECLAMO ES, UN COMENTARIO DEL USUARIO
Y EL ESTADO EN EL QUE SE ENCUENTRA EL RECLAMO.*/

CREATE VIEW claim_view AS (
SELECT c.id_claim AS id_reclamo, c.purchase_order_id AS id_orden_compra, ct.claim_type AS tipo_de_reclamo, c.comment AS comentario, s.status_type AS estado FROM claim c
JOIN claim_type ct
ON ct.id_claim_type = c.type
JOIN status s
ON c.claim_status = s.id_status);

SELECT * FROM claim_view;

# VISTA 5: CATALOGO DE PRODUCTOS. ESTA VISTA SIMPLEMENTE MUESTRA LOS PRODUCTOS Y SUS CARACTERÍSTICAS/VARIEDADES.

CREATE VIEW product_catalogue AS (
SELECT p.id_product as id, p.name AS producto, p.price AS precio, pv.variety AS variedad, pc.category as categoria, sd.sale_type as descuento FROM product p
LEFT JOIN product_variety pv
ON p.variety = pv.id_variety
LEFT JOIN product_category pc
ON p.category = pc.id_category
LEFT JOIN sale_discount sd
ON p.discount = sd.id_sale_discount);

SELECT * FROM product_catalogue;

# VISTA 6: VISTA CON LAS ORDENES DE COMPRA, FILTRADA PARA CONOCER CUALES SON LAS COMPRAS QUE SUPERAN LOS ARS $3000, CUANTO FUE EL TOTAL, A QUE USUARIO Y EL ESTADO DE LA COMPRA/ENVÍO. 

CREATE VIEW purchase_over_3k AS(
SELECT po.id_purchase_order AS id_compra, po.order_date AS fecha, po.total_price AS precio_total, u.username AS usuario, s.status_type as estado FROM purchase_order po
JOIN user u
ON po.id_user = u.id_user
JOIN status s
ON po.status = s.id_status
WHERE po.total_price > 3000);

SELECT * FROM purchase_over_3k;

#2 ********************************************************* FUNCIONES ************************************************************

#FUNCTION 1
DELIMITER $$
CREATE FUNCTION `get_product_price` (id INT) RETURNS FLOAT
# Esta función recibe el ID de un producto por parámetro y devuelve el precio de dicho producto. Por lo tanto se la utiliza para conocer el precio de un producto a través de su ID.
DETERMINISTIC
BEGIN
	DECLARE price_found FLOAT;
	SELECT price INTO price_found FROM product 
	WHERE id_product = id;
    RETURN price_found;
END
$$
DELIMITER ;

SELECT get_product_price(3);

# FUNCTION 2
DELIMITER $$
CREATE FUNCTION `check_stock` (stock INT) RETURNS VARCHAR(55)
# Esta función se la utiliza para conocer el estado de stock de un producto, recibiendo la cantidad en número por parámetro, y devolviendo el string correspondiente. 
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
DELIMITER ;

SELECT check_stock(0);


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
DELIMITER ;

SELECT change_username('diegoo10', 'diegoo.martin');
SELECT * FROM user;

#FUNCTION 4
DELIMITER $$
CREATE FUNCTION `search_last_purchase` (client_username VARCHAR(50)) RETURNS FLOAT
# Esta función me permite saber cuanto gastó un cliente en su compra, pasandole el username por parámetro. En caso de no haber efectuado compra retorna nulo. 
DETERMINISTIC
BEGIN
    DECLARE user_identifier INT;
    DECLARE result INT;
    SELECT id_user INTO user_identifier FROM `user` WHERE username = client_username;
    SELECT total_price INTO result FROM `purchase_order` WHERE id_user = user_identifier;
    RETURN result;
END
$$
DELIMITER ;

# Usuario que efectuo compra:
SELECT search_last_purchase('giseromaa2'); 
# Usuario que no tiene ninguna compra, devuelve null:
SELECT search_last_purchase('maurii.30'); 

#3 ********************************************************* STORED PROCEDURES ************************************************************

/*STORED PROCEDURE 1: ORDER_PRODUCT_TABLE_BY. ACEPTA DOS PARÁMETROS: CAMPO/COLUMNA Y ASC/DESC PARA ORDENAR LA TABLA PRODUCTOS POR DICHOS CRITERIOS.
TAMBIÉN CONTROLA QUE EL VALOR INGRESADO POR EL PARÁMETRO DE CAMPO, SE FUERZE A MINÚSCULAS.*/

DELIMITER //
DROP PROCEDURE IF EXISTS sp_order__product_table_by//
CREATE PROCEDURE `sp_order__product_table_by` (IN input_field VARCHAR(30), IN criteria CHAR(4))
BEGIN
	SET @field = LOWER(input_field);
	IF @field != '' THEN
		SET @field_selected = concat('ORDER BY ', @field);
	ELSE	
		SET @field_selected = '';
	END IF;
        
	IF criteria IN ('asc','ASC','DESC','desc') THEN
		SET @criteria_selected = criteria;
	ELSE
		SET @criteria_selected = '';
	END IF;
 
 SET @clausula = concat('SELECT * FROM product ', @field_selected, ' ', @criteria_selected);
 PREPARE runSQL FROM @clausula;
 EXECUTE runSQL;
 DEALLOCATE PREPARE runSQL;
END
//
DELIMITER ;

#LLAMADOS DE PRUEBA

CALL sp_order__product_table_by('STOCK', 'asc');
CALL sp_order__product_table_by('name', 'desc');
CALL sp_order__product_table_by('name', 'asc');


/*STORED PROCEDURE 2 ADD_NEW_PRODUCT: PERMITE AGREGAR UN NUEVO PRODUCTO A LA TABLA DE PRODUCTOS. TAMBIÉN PERMITE INGRESAR POR PARÁMETRO CATEGORIA Y VARIEDAD COMO STRING, 
Y LUEGO LO CONVIERTE A SU CORRESPONDIENTE ID DE FK*/

DELIMITER //
DROP PROCEDURE IF EXISTS `sp_add_new_product`//
CREATE PROCEDURE `sp_add_new_product` (IN new_product VARCHAR(50), IN new_price INT, IN new_stock INT, IN variedad VARCHAR(20), IN categoria VARCHAR (20))
BEGIN
	SET @product_name = concat("'", new_product, "'");
    SET @new_price = new_price;
    IF variedad IN (SELECT category FROM product_category) THEN
		SELECT id_variety INTO @new_variety FROM product_variety WHERE variety = variedad;
	ELSE
		SET @new_variety = 1;
    END IF;
    
    IF categoria IN (SELECT category FROM product_category) THEN
		SELECT id_category INTO @new_category FROM product_category WHERE category = categoria;
	ELSE
		SET @new_category = 8;
    END IF;
    
    
    SET @parameters_in = concat(@product_name,', ', new_price,', ',new_stock,', ',@new_variety,', ',@new_category);
    
	SET @clausula2 = concat('INSERT INTO product (name, price, stock, variety, category) VALUES (', @parameters_in, ');');
    PREPARE runSQL FROM @clausula2;
	EXECUTE runSQL;
	DEALLOCATE PREPARE runSQL;
END
//
DELIMITER ;

# LLAMADO DE PRUEBA

CALL sp_add_new_product('test: jabon de limón', 3000, 10, 'limón', 'jabones');

# VERIFICAR QUE SE AGREGUE A LA TABLA PRODUCT EL PRODUCTO 'TEST: JABON DE LIMÓN'

SELECT * FROM product;

# ATAJO PARA BORRAR EL PRODUCTO AGREGADO POR EL SP

#DELETE FROM product WHERE id_product = 29;

#4 ********************************************************* TRIGGERS ************************************************************

#CREACIÓN TABLA DE AUDITORIA DE PRODUCTOS
CREATE TABLE `_product_audit` (    
	id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_product INT,
    product_name VARCHAR(120),
    date datetime,
    created_by VARCHAR(100),
    last_updated_by VARCHAR(100),
    last_update_date datetime
);

#EL TRIGGER TR_AUDIT_PRODUCT HARÁ AUDITORIA EN LA TABLA _PRODUCT_AUDIT DESPUÉS DE AGREGARSE UN PRODUCTO A LA TABLA PRODUCT.

CREATE TRIGGER `tr_audit_product`
AFTER INSERT ON `product`
FOR EACH ROW
INSERT INTO `_product_audit` (id_product, product_name, created_by, date, last_updated_by, last_update_date)
VALUES (NEW.id_product, NEW.name, user(), current_timestamp(), user(), current_timestamp());  

INSERT INTO product VALUES (null, 'canasta_mimbre', 5000, 5, null, 8, null);   

# EL TRIGGER TR_AUDIT_PRODUCT_UPDATE SE DISPARA CUANDO HAY ALGUN UPDATE EN LA TABLA PRODUCT, Y ACCIONA ACTUALIZANDO EN LA TABLA DE AUDITORIA QUIEN Y CUANDO REALIZO LA ÚLTIMA ACTUALIZACIÓN.
CREATE TRIGGER `tr_audit_product_update`
AFTER UPDATE ON `product`
FOR EACH ROW
UPDATE `_product_audit` SET last_updated_by = user(), last_update_date = current_timestamp()
WHERE id_product = OLD.id_product;

UPDATE product SET name = 'canasta_plástico' WHERE id_product = 30;
# CHECKEAR QUE EL ID DEL CONDICIONAL "WHERE" SEA EL QUE CORRESPONDE EN LA TABLA PRODUCT. PUEDE CAMBIAR POR EJERCICIOS ANTERIORES (QUIZAR NO SEA 30).
 
#VERIFICAR FUNCIONAMIENTO: 
SELECT * FROM product; 
SELECT * FROM _product_audit; 

# TABLA USER AUDIT DONDE SE PODRA VER EL USERNAME Y EMAIL DE LOS USUARIOS REGISTRADOS/BORRADOS ASI COMO LA FECHA DONDE CAMBIO SU ESTADO.
CREATE TABLE `_user_audit`(
	id_log INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50),
    email VARCHAR(50),
    action VARCHAR(15),
    date datetime
);

#TRIGGER TR_USER_AUDIT_SIGNED QUE REGISTRA EN LA TABLA USER AUDIT EL USERNAME, EMAIL DEL USUARIO Y FECHA DEL CLIENTE QUE SE REGISTRA, DESPUÉS DEL INSERTARSE EN LA TABLA.
CREATE TRIGGER `tr_user_audit_signed`
AFTER INSERT ON `user`
FOR EACH ROW
INSERT INTO `_user_audit` (username, email, action, date)
VALUES (NEW.username, NEW.email, 'registrado', current_timestamp());

INSERT INTO `user` VALUES (null, 'test.user', 'fakepassword123', 'email@test.com', 'Juan', 'Test', 'Calle falsa 123', 1, null, null, null);

#TRIGGER TR_USER_AUDIT_DELETED QUE REGISTRA EN LA TABLA USER AUDIT EL USERNAME, EMAIL DEL USUARIO Y FECHA DEL CLIENTE QUE SE ELIMINA, ANTES DEL DELETE EN LA TABLA USUARIO.
CREATE TRIGGER `tr_user_audit_deleted`
BEFORE DELETE ON `user`
FOR EACH ROW
INSERT INTO `_user_audit` (username, email, action, date)
VALUES (OLD.username, OLD.email, 'eliminado', current_timestamp());

DELETE FROM `user` WHERE username = 'test.user';

#VERIFICAR FUNCIONAMIENTO: 
SELECT * FROM user;
SELECT * FROM _user_audit;

