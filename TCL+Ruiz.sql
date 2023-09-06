USE ecommerce_project_ruiz;

#Desactivamos el autocommit
SELECT @@AUTOCOMMIT;
SET AUTOCOMMIT = 0;

SELECT * FROM `product`;

#Comenzamos la primer transacción
START TRANSACTION;
#Agregamos 3 productos nuevos con el Stored Procedure:
CALL sp_add_new_product('perfume', 2000, 12, 'limón', 'splash');
CALL sp_add_new_product('fragancia', 3000, 17, 'eucalípto', 'velas');
CALL sp_add_new_product('aroma', 4000, 18, 'jazmín', 'aromatizadores');

#ROLLBACK; #Descomentar para deshacer cambios.
#COMMIT; #Descomentar para efectivizar cambios.

# ************************************************** SEGUNDA TRANSACTION *****************************************************

START TRANSACTION;

SELECT * FROM `location`;

INSERT INTO `location` (location_name) VALUES
('Chile'),
('Brasil'),
('Uruguay'),
('Paraguay');
SAVEPOINT first_block_checkpoint;
INSERT INTO `location` (location_name) VALUES
('Estados Unidos'),
('Canada'),
('Italia'),
('España');
SAVEPOINT second_block_checkpoint;

#RELEASE SAVEPOINT first_block_checkpoint; #Descomentar para borrar el primer savepoint.

#ROLLBACK; #Descomentar para deshacer cambios.
#COMMIT; #Descomentar para efectivizar cambios.