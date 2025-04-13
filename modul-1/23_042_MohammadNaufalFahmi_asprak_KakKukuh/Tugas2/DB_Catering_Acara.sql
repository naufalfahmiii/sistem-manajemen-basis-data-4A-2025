-- Buat Database
CREATE DATABASE catering_acara;
USE catering_acara;

-- Tabel Master
-- 1. Tabel Pelanggan
CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    NAME VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100) UNIQUE,
    address TEXT
);

-- 2. Tabel Kategori Menu
CREATE TABLE menu_categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    NAME VARCHAR(50) NOT NULL
);

-- 3. Tabel Menu
CREATE TABLE menu_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    NAME VARCHAR(100) NOT NULL,
    category_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    DESCRIPTION TEXT,
    FOREIGN KEY (category_id) REFERENCES menu_categories(id)
);

-- Tabel Transaksi
-- 4. Tabel Pesanan
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    event_type VARCHAR(50) NOT NULL,
    event_date DATETIME NOT NULL,
    delivery_address TEXT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    STATUS ENUM('pending', 'confirmed', 'completed', 'canceled') NOT NULL DEFAULT 'pending',
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- 5. Tabel Detail Pesanan
CREATE TABLE order_details (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    menu_item_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (menu_item_id) REFERENCES menu_items(id)
);

-- 6. Tabel Pembayaran
CREATE TABLE payments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    payment_date DATETIME NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('cash', 'transfer', 'credit_card') NOT NULL,
    STATUS ENUM('pending', 'paid', 'failed') NOT NULL DEFAULT 'pending',
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- 7. Tabel Pengiriman
CREATE TABLE delivery_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT UNIQUE NOT NULL,
    delivery_date DATETIME NOT NULL,
    STATUS ENUM('pending', 'on the way', 'delivered') NOT NULL DEFAULT 'pending',
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

SHOW TABLES;
