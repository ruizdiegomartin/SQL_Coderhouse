# VISTA 1: CON LOS PRODUCTOS QUE TIENEN AGREGADOS LOS USUARIOS AL CARRITO.

CREATE VIEW items_in_cart AS ( 
SELECT u.username AS usuario, p.name AS producto, c.item_quantity AS cantidad FROM cart c
JOIN user u
ON c.id_user = u.id_user
JOIN product p
ON c.id_product = p.id_product
ORDER BY u.username);

SELECT * FROM items_in_cart;

# VISTA 2: CONTIENE EL NOMBRE COMPLETO DE LOS USUARIOS, Y DONDE RESIDE CADA UNO/A ORDENADO POR LA PROVINCIA DONDE VIVEN.

CREATE VIEW user_location AS (
SELECT CONCAT(u.last_name, ', ', u.first_name ) AS nombre_y_apellido, l.location_name as provincia FROM user u
JOIN location l
ON u.province = l.id_location
ORDER BY l.location_name);

SELECT * FROM user_location;

# VISTA 3: MUESTRA LOS USUARIOS QUE TIENEN MAS DE UN PRODUCTO EN FAVORITOS, Y SU CANTIDAD DE PRODUCTOS FAVORITOS.

CREATE VIEW user_favorites_many AS (
SELECT u.username, COUNT(*) as favorites_products_amount FROM favorite f
JOIN user u
ON f.id_user = u.id_user
GROUP BY u.username
HAVING COUNT(*)> 1);

SELECT * FROM user_favorites_many;

# VISTA CON LOS RECLAMOS REALIZADOS CON RESPECTO A UNA COMPRA.

CREATE VIEW claim_view AS (
SELECT c.id_claim AS id_reclamo, c.purchase_order_id AS id_orden_compra, ct.claim_type AS tipo_de_reclamo, c.comment AS comentario, s.status_type AS estado FROM claim c
JOIN claim_type ct
ON ct.id_claim_type = c.type
JOIN status s
ON c.claim_status = s.id_status);

SELECT * FROM claim_view;

# VISTA 5: CATALOGO DE PRODUCTOS.

CREATE VIEW product_catalogue AS (
SELECT p.id_product as id, p.name AS producto, p.price AS precio, pv.variety AS variedad, pc.category as categoria, sd.sale_type as descuento FROM product p
LEFT JOIN product_variety pv
ON p.variety = pv.id_variety
LEFT JOIN product_category pc
ON p.category = pc.id_category
LEFT JOIN sale_discount sd
ON p.discount = sd.id_sale_discount);

SELECT * FROM product_catalogue;

# VISTA 6: TABLA CON LAS ORDENES DE COMPRA, FILTRADA POR COMPRAS QUE SUPEREN LOS ARS $3000

CREATE VIEW purchase_over_3k AS(
SELECT po.id_purchase_order AS id_compra, po.order_date AS fecha, po.total_price AS precio_total, u.username AS usuario, s.status_type as estado FROM purchase_order po
JOIN user u
ON po.id_user = u.id_user
JOIN status s
ON po.status = s.id_status
WHERE po.total_price > 3000);

SELECT * FROM purchase_over_3k;

