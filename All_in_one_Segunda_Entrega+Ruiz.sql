CREATE SCHEMA ecommerce_project_ruiz;
USE ecommerce_project_ruiz;

# ************************************************************** CREACIÓN DE TABLAS ********************************************************

CREATE TABLE `user` (
	`id_user` INT AUTO_INCREMENT PRIMARY KEY,
    `username` VARCHAR(30) NOT NULL,
    `login_password` VARCHAR(50) NOT NULL,
    `email` VARCHAR(50) NOT NULL UNIQUE,
    `first_name` VARCHAR(30) NOT NULL,
    `last_name` VARCHAR(30) NOT NULL,
    `address` VARCHAR(50) NOT NULL,
    `province` INT,
    `user_favorite` INT,
    `user_cart` INT,
    `user_purchase_order` INT
);

CREATE UNIQUE INDEX idx_username
ON user(username);

CREATE TABLE `cart` (
	`id_cart` INT AUTO_INCREMENT PRIMARY KEY,
    `id_user` INT NOT NULL,
    `id_product` INT NOT NULL,
    `item_quantity` INT NOT NULL DEFAULT 1
);

CREATE TABLE `product` (
	`id_product` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255),
    `price` FLOAT,
    `stock` INT,
    #`id_cart` INT,
    #`id_favorite` INT,
    `variety` INT,
    `category` INT,
    `discount` INT
);

CREATE TABLE `purchase_order` (
	`id_purchase_order` INT AUTO_INCREMENT PRIMARY KEY,
    `order_date` DATETIME NOT NULL,
    `total_price` FLOAT NOT NULL DEFAULT 0,
    #`cart_id` INT NOT NULL,
    `id_user` INT NOT NULL,
    `status` INT NOT NULL
);

CREATE TABLE `claim` (
	`id_claim` INT AUTO_INCREMENT PRIMARY KEY,
    `type` INT NOT NULL,
    `comment` VARCHAR(255) NOT NULL,
    `claim_status` INT NOT NULL,
    `purchase_order_id` INT NOT NULL
);

CREATE TABLE `product_category` (
	`id_category` INT AUTO_INCREMENT PRIMARY KEY,
    `category` VARCHAR(55) NOT NULL
);

CREATE TABLE `product_variety` (
	`id_variety` INT AUTO_INCREMENT PRIMARY KEY,
    `variety` VARCHAR(55) NOT NULL
);

CREATE TABLE `sale_discount` (
	`id_sale_discount` INT AUTO_INCREMENT PRIMARY KEY,
    `sale_type` VARCHAR(55) NOT NULL,
    `sale_value` FLOAT NOT NULL
);

CREATE TABLE `favorite` (
	`id_favorite` INT AUTO_INCREMENT PRIMARY KEY,
    `id_product` INT NOT NULL,
    `id_user` INT NOT NULL
);

CREATE TABLE `location` (
	`id_location` INT AUTO_INCREMENT PRIMARY KEY,
    `location_name` VARCHAR(55) NOT NULL
);

CREATE TABLE `status` (
	`id_status` INT AUTO_INCREMENT PRIMARY KEY,
    `status_type` VARCHAR(55)
);

CREATE TABLE `claim_type` (
	`id_claim_type` INT AUTO_INCREMENT PRIMARY KEY,
    `claim_type` VARCHAR(55) NOT NULL
);

# TABLE'S FOREING KEYS (FK) ASSIGNATION

ALTER TABLE `user`
ADD FOREIGN KEY(`province`) REFERENCES `location`(`id_location`),
ADD FOREIGN KEY(`user_favorite`) REFERENCES `favorite`(`id_favorite`),
ADD FOREIGN KEY(`user_cart`) REFERENCES `cart`(`id_cart`),
ADD FOREIGN KEY(`user_purchase_order`) REFERENCES `purchase_order`(`id_purchase_order`);

ALTER TABLE `claim`
ADD FOREIGN KEY(`claim_status`) REFERENCES `status`(`id_status`),
ADD FOREIGN KEY(`type`) REFERENCES `claim_type`(`id_claim_type`),
ADD FOREIGN KEY(`purchase_order_id`) REFERENCES `purchase_order`(`id_purchase_order`);

ALTER TABLE `cart`
ADD FOREIGN KEY(`id_user`) REFERENCES `user`(`id_user`),
ADD FOREIGN KEY(`id_product`) REFERENCES product(`id_product`);

ALTER TABLE `product`
#ADD FOREIGN KEY(`id_cart`) REFERENCES `cart`(`id_cart`),
#ADD FOREIGN KEY(`id_favorite`) REFERENCES `favorite`(`id_favorite`),
ADD FOREIGN KEY(`category`) REFERENCES `product_category`(`id_category`),
ADD FOREIGN KEY(`variety`) REFERENCES `product_variety`(`id_variety`),
ADD FOREIGN KEY(`discount`) REFERENCES `sale_discount`(`id_sale_discount`);

ALTER TABLE `purchase_order`
#ADD FOREIGN KEY(cart_id) REFERENCES cart(id_cart),
ADD FOREIGN KEY(`id_user`) REFERENCES `user`(`id_user`),
ADD FOREIGN KEY(`status`) REFERENCES `status`(`id_status`);

ALTER TABLE `favorite`
ADD FOREIGN KEY(`id_product`) REFERENCES product(`id_product`),
ADD FOREIGN KEY(`id_user`) REFERENCES user(`id_user`);

# ************************************************************** INSERCIÓN DE DATOS ***********************************************************

SELECT * FROM `location`;
INSERT INTO `location` (id_location, location_name) VALUES 
(null, 'Buenos Aires'),
(null, 'Ciudad Autónoma de Buenos Aires'),
(null, 'Catamarca'),
(null, 'Chaco'),
(null, 'Chubut'),
(null, 'Córdoba'),
(null, 'Corrientes'),
(null, 'Entre Ríos'),
(null, 'Formosa'),
(null, 'Jujuy'),
(null, 'La Pampa'),
(null, 'La Rioja'),
(null, 'Mendoza'),
(null, 'Misiones'),
(null, 'Neuquén'),
(null, 'Río Negro'),
(null, 'Salta'),
(null, 'San Juan'),
(null, 'Santa Cruz'),
(null, 'Santa Fe'),
(null, 'Santiago del Estero'),
(null, 'Tierra del Fuego'),
(null, 'Tucumán');

SELECT * FROM `status`;
INSERT INTO `status` (id_status, status_type) VALUES
(null, 'Pago realizado'),
(null, 'Esperando pago'),
(null, 'Pago rechazado'),
(null, 'Preparando producto'),
(null, 'Envío realizado'),
(null, 'Envío fallido'),
(null, 'Producto devuelto'),
(null, 'Reclamo iniciado'),
(null, 'Reclamo resuelto'),
(null, 'Reclamo en proceso');

SELECT * FROM `claim_type`;
INSERT INTO `claim_type` (id_claim_type, claim_type) VALUES
(null, 'No llegó el envío'),
(null, 'No es el producto que solicitó'),
(null, 'Error en la cantidad del producto'),
(null, 'Producto recibido en mal estado'),
(null, 'Producto defectuoso'),
(null, 'Otro');

SELECT * FROM `sale_discount`;
INSERT INTO `sale_discount` (id_sale_discount, sale_type, sale_value) VALUES
(null, 'Promoción bancaria', 20),
(null, 'Promoción bancaria especial', 25),
(null, 'Promoción del día', 10),
(null, 'Cyber Monday', 30),
(null, 'Liquidación', 50);

SELECT * FROM `product_category`;
INSERT INTO `product_category` (id_category, category) VALUES 
(null, 'velas'),
(null, 'jabones'),
(null, 'difusores'),
(null, 'splash'),
(null, 'aromatizadores'),
(null, 'sahumerios'),
(null, 'esencias'),
(null, 'otros');

SELECT * FROM `product_variety`;
INSERT INTO `product_variety` (id_variety, variety) VALUES 
(null, 'colírio'),
(null, 'limón'),
(null, 'flynn-paff'),
(null, 'menta y naranja'),
(null, 'cher'),
(null, 'pitanga'),
(null, 'sandía y frambuesa'),
(null, 'eucalípto'),
(null, 'palo santo'),
(null, 'jazmín'),
(null, 'colírio'),
(null, 'frutos rojos'),
(null, 'vainilla');

SELECT * FROM `user`;
INSERT INTO `user` (id_user, username, login_password, email, first_name, last_name, address, province) VALUES 
(null, 'diegoo10', 'aCEvX324$', 'diego.martin@gmail.com', 'Diego', 'Martin', 'Av. Rivadavia 10231', 2),
(null, 'angeladanvers', 'angEL$21szx', 'angeladanvers@gmail.com', 'Angela', 'Danvers', 'Glaston 334', 6),
(null, 'lourdessflow', '38480sXs&', 'lourdesprincess@yahoo.com.ar', 'Lourdes', 'Gucci', 'Cnel. Fran Rivarte 104', 12),
(null, 'juanb3', 'u324j098m5utb34', 'juanii_23@gmail.com', 'Juan', 'Salas', 'Trenquelauquen 1578', 15),
(null, 'tomas.sali22', 'h097n8ar3yv3w', 'tomas.salii@gmail.com', 'Tomas', 'Salinas', 'Pasaje Rivera 558', 20),
(null, 'giseromaa2', 'fj34098rtDERF', 'gise_roma@gmail.com', 'Gisell', 'Roma', 'Av. Tirufan 1234', 21),
(null, 'maurii.30', 'AN98UFfsdsdSA', 'maurii@outlook.com', 'Mauricio', 'Lopez', 'Av. Roca 3422', 15),
(null, 'camiilitaa_star', 'as3sazL$21szx', 'camiliiita@yahoo.com.ar', 'Camila', 'Solano', 'Gascon 748', 2),
(null, 'rosalia77', '8snfFJ8fj', 'rosaliaf@gmail.com', 'Rosalía', 'Fuentes', 'Av. Don Bosco 1889', 1),
(null, 'jessij', 'a2134355324$$', 'jessi_j@gmail.com', 'Jessica', 'Juarez', 'Psje. Sinatra 343', 1),
(null, 'lucio12', '89fdkojsfHFS34$&', 'lucio.la12@outlook.com', 'Lucio', 'Delgado', 'Av. de Mayo 2523', 1),
(null, 'delfina.prietto', 'a94490328FSDAFXzxx', 'deelfiprie@gmail.com', 'Delfina', 'Prietto', 'Saleberry 3334', 8),
(null, 'nerea.lopez2', '83JFjsu6&', 'nereaperez@hotmail.com', 'Nerea', 'Lopez', 'Saladillo 164', 3),
(null, 'vanee1', 'a9d3sdX', 'vane.bocco@gmail.com', 'Vanesa', 'Bocco', 'Miguel Suarez 112', 9),
(null, 'pablope', 'sad7878xx', 'perezpablo@outlook.com', 'Pablo', 'Perez', 'Av. De La Cruz 1230', 13),
(null, 'julii23', 'a94490328FSasda21DAFXzxx', 'juliangomez23@gmail.com', 'Julian', 'Gomez', 'Av. Trujillo 723', 16);

SELECT * FROM `product`;
INSERT INTO `product` (id_product, name, price, stock, variety, category, discount) VALUES
(null, 'vela de soja jazmín', 1250, 10, 4, 1, 1),
(null, 'vela de soja colírio', 1250, 8, 1, 1, null),
(null, 'vela de soja eucalípto', 1250, 8, 8, 1, 3),
(null, 'vela de soja sandía y frambuesa', 1250, 2, 7, 1, null),
(null, 'vela de soja menta y naranja', 1250, 15, 4, 1, null),
(null, 'jabon flor limón', 650.5, 20, 2, 2, 5),
(null, 'jabon flor pitanga', 650.5, 16, 6, 2, null),
(null, 'jabon con semillas frutos rojos', 850.5, 10, 12, 2, null),
(null, 'jabon con semillas vainilla', 850.5, 15, 13, 2, null),
(null, 'difusor limón', 1300, 20, 2, 3, null),
(null, 'difusor vainilla', 1300, 10, 13, 3, 1),
(null, 'difusor menta y naranja', 1300, 5, 4, 3, null),
(null, 'difusor sandía y frambuesa', 1300, 23, 7, 3, null),
(null, 'splash limón', 1300, 10, 2, 4, null),
(null, 'splash flynn-paff', 1300, 10, 3, 4, 3),
(null, 'splash cher', 1300, 10, 5, 4, null),
(null, 'splash vainilla', 1300, 10, 13, 4, null),
(null, 'aromatizador cher', 1000, 10, 5, 5, null),
(null, 'aromatizador pitanga', 1000, 12, 6, 5, 1),
(null, 'aromatizador jazmín', 1000, 15, 10, 5, null),
(null, 'sahumerio de limón', 250, 30, 2, 6, 5),
(null, 'sahumerio de eucalípto', 250, 20, 8, 6, null),
(null, 'sahumerio de palo santo', 250, 27, 9, 6, null),
(null, 'sahumerio de jazmín', 250, 9, 10, 6, null),
(null, 'esencia de vainilla', 2230, 10, 13, 7, 3),
(null, 'esencia de limon', 2230, 12, 2, 7, 3),
(null, 'esencia de eucalipto', 2230, 12, 8, 7, 3),
(null, 'base porta-sahumerio', 500, 20, null, 8, null);

SELECT * FROM cart;
INSERT INTO cart (id_user, id_product, item_quantity) VALUES
(1,1,2),
(1,3,1),
(1,12,4),
(3,1,1),
(3,2,4),
(2,12,1),
(4,13,3),
(4,2,1),
(5,2,1),
(6,13,1),
(9,10,2),
(11,4,5),
(11,3,1),
(11,6,2),
(12,10,1),
(12,8,2),
(14,7,3),
(14,11,1),
(15,15,2);

SELECT * FROM favorite;
INSERT INTO favorite (id_user, id_product) VALUES
(1,1),
(1,5),
(1,3),
(2,4),
(5,13),
(6,2),
(6,4),
(8,8),
(9,4),
(9,1),
(10,1),
(10,16),
(10,5),
(11,3),
(14,18);

SELECT * FROM purchase_order;
INSERT INTO purchase_order (order_date, total_price, id_user, status) VALUES
(current_date(), 8950, 1, 5),
('2023-04-03 08:02:21', 2500, 15, 4),
(current_date(), 3001, 9, 5),
('2023-06-14 10:00:50', 1300, 6, 3),
('2023-07-23 09:00:50', 1701, 9, 5);

SELECT * FROM claim;
INSERT INTO claim (type, comment, claim_status, purchase_order_id) VALUES
(6 ,'Me rebota la tarjeta de crédito, puedo usar otro medio de pago?', 8, 4),
(2, 'Me mandaron un producto equivocado' , 10, 5);


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
