USE ecommerce_project_ruiz;

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