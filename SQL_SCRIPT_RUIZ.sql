CREATE SCHEMA ecommerce_project_ruiz;
USE ecommerce_project_ruiz;

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