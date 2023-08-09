USE ecommerce_project_ruiz;

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





