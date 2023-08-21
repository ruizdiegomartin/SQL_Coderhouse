USE ecommerce_project_ruiz;

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

# LLAMADO DE PRUEBA

CALL sp_add_new_product('test: jabon de limón', 3000, 10, 'limón', 'jabones');

# VERIFICAR QUE SE AGREGUE A LA TABLA PRODUCT EL PRODUCTO 'TEST: JABON DE LIMÓN'

SELECT * FROM product;

# ATAJO PARA BORRAR EL PRODUCTO AGREGADO POR EL SP

#DELETE FROM product WHERE id_product = 29;