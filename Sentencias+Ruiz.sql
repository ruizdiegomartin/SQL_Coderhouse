use mysql;
SHOW tables;
SHOW VARIABLES LIKE 'validate_password%';


SELECT * FROM user;


# CREATE USER crea el usuario user1@localhost y user2@localhost, con sus respectivas passwords.
CREATE USER user1@localhost IDENTIFIED BY 'easyPassword1#';
CREATE USER user2@localhost IDENTIFIED BY 'easyPassword2#';


GRANT SELECT ON ecommerce_project_ruiz.* TO user1@localhost; # Da permisos de SELECT (leer) al usuario user1, en todas las tablas (*) del esquema ecommerce_project_ruiz.
GRANT SELECT, UPDATE, INSERT ON ecommerce_project_ruiz.* TO user2@localhost; # Da permisos de SELECT (leer), UPDATE (modificar) y INSERT (insertar) al usuario user2, en todas las tablas (*) del esquema ecommerce_project_ruiz.

SHOW GRANTS FOR user1@localhost;
SHOW GRANTS FOR user2@localhost;