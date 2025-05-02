-- Buat Database
CREATE DATABASE catering_acara;
USE catering_acara;

-- Tabel Master
-- 1. Tabel Pelanggan
CREATE TABLE pelanggan (
    id_pelanggan INT PRIMARY KEY AUTO_INCREMENT,
    nama_pelanggan VARCHAR(100),
    telepon VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    alamat TEXT
);

-- 2. Tabel Kategori Menu
CREATE TABLE kategori_menu (
    id_kategori INT PRIMARY KEY AUTO_INCREMENT,
    nama_kategori VARCHAR(50)
);
-- 3. Tabel Menu
CREATE TABLE menu (
    id_menu INT PRIMARY KEY AUTO_INCREMENT,
    nama_menu VARCHAR(100),
    id_kategori INT,
    harga DECIMAL(10,2),
    deskripsi TEXT,
    FOREIGN KEY (id_kategori) REFERENCES kategori_menu(id_kategori) ON DELETE CASCADE
);
-- Tabel Transaksi
-- 4. Tabel Pesanan
CREATE TABLE pesanan (
    id_pesanan INT PRIMARY KEY AUTO_INCREMENT,
    id_pelanggan INT,
    jenis_acara VARCHAR(50),
    tanggal_acara DATETIME,
    alamat_pengiriman TEXT,
    total_harga DECIMAL(10,2),
    status_pesan ENUM('pending', 'confirmed', 'completed', 'canceled') DEFAULT 'pending',
    FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan) ON DELETE CASCADE
);
-- 5. Tabel Detail Pesanan
CREATE TABLE detail_pesanan (
    id_detail INT PRIMARY KEY AUTO_INCREMENT,
    id_pesanan INT,
    id_menu INT,
    kuantitas INT,
    subtotal DECIMAL(10,2),
    FOREIGN KEY (id_pesanan) REFERENCES pesanan(id_pesanan) ON DELETE CASCADE,
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu) ON DELETE CASCADE
);
-- 6. Tabel Pembayaran
CREATE TABLE pembayaran (
    id_pembayaran INT PRIMARY KEY AUTO_INCREMENT,
    id_pesanan INT,
    tanggal_pembayaran DATETIME,
    jumlah DECIMAL(10,2),
    metode_pembayaran ENUM('cash', 'transfer', 'credit_card'),
    status_bayar ENUM('pending', 'paid', 'failed') DEFAULT 'pending',
    FOREIGN KEY (id_pesanan) REFERENCES pesanan(id_pesanan) ON DELETE CASCADE
);
-- 7. Tabel Pengiriman
CREATE TABLE log_pengiriman (
    id_pengiriman INT PRIMARY KEY AUTO_INCREMENT,
    id_pesanan INT UNIQUE,
    tanggal_pengiriman DATETIME,
    status_kirim ENUM('pending', 'on the way', 'delivered') DEFAULT 'pending',
    FOREIGN KEY (id_pesanan) REFERENCES pesanan(id_pesanan) ON DELETE CASCADE
);
SHOW TABLES;

-- Insert Data 
-- Tabel Kategori Menu
INSERT INTO kategori_menu (nama_kategori) VALUES
('Makanan Utama'),
('Makanan Ringan'),
('Minuman');
SELECT * FROM kategori_menu;

-- Tabel Menu
INSERT INTO menu (nama_menu, id_kategori, harga, deskripsi) VALUES
('Nasi Goreng', 1, 25000, 'Nasi goreng spesial dengan ayam dan telur'),
('Ayam Penyet', 1, 30000, 'Ayam penyet dengan sambal terasi dan lalapan'),
('Sate Ayam', 1, 35000, 'Sate ayam dengan bumbu kacang yang khas'),
('Kue Cubir', 2, 15000, 'Kue cubir dengan isi cokelat manis'),
('Martabak Manis', 2, 25000, 'Martabak manis dengan berbagai pilihan topping'),
('Es Teh Manis', 3, 5000, 'Es teh manis segar'),
('Es Jeruk', 3, 7000, 'Es jeruk peras dengan rasa segar'),
('Gado-Gado', 1, 27000, 'Salad sayuran dengan bumbu kacang'),
('Mie Goreng', 1, 28000, 'Mie goreng spesial dengan ayam dan udang'),
('Capcay', 1, 22000, 'Sayur capcay dengan bumbu saus tiram');
SELECT * FROM menu;
INSERT INTO menu (nama_menu, id_kategori, harga, deskripsi) VALUES
('Pisang Goreng', 2, 12000, 'Pisang goreng renyah dengan baluran gula merah');

-- Tabel Pelanggan
INSERT INTO pelanggan (nama_pelanggan, telepon, email, alamat) VALUES
('Alicia Rahma', '081234567890', 'alicia@mail.com', 'Jl. Merdeka No.1, Jakarta'),
('Budi Santoso', '082345678901', 'budi@mail.com', 'Jl. Pahlawan No.2, Bandung'),
('Citra Dewi', '083456789012', 'citra@mail.com', 'Jl. Raya No.3, Surabaya'),
('Diana Sari', '084567890123', 'diana@mail.com', 'Jl. Anggrek No.4, Yogyakarta'),
('Eka Prasetya', '085678901234', 'eka@mail.com', 'Jl. Mawar No.5, Bali'),
('Fahmi Aditya', '086789012345', 'fahmi@mail.com', 'Jl. Cemara No.6, Medan'),
('Gita Lestari', '087890123456', 'gita@mail.com', 'Jl. Sakura No.7, Malang'),
('Hendra Wijaya', '088901234567', 'hendra@mail.com', 'Jl. Raya No.8, Makassar'),
('Ika Kurniawati', '089012345678', 'ika@mail.com', 'Jl. Bunga No.9, Semarang'),
('Joko Prabowo', '090123456789', 'joko@mail.com', 'Jl. Padma No.10, Surakarta');
SELECT * FROM pelanggan;
INSERT INTO pelanggan (nama_pelanggan, telepon, email, alamat) VALUES ('Joko Prabowo', '090123456789', 'joko@mail.com', 'Jl. Padma No.10, Surakarta');
ALTER TABLE pelanggan AUTO_INCREMENT = 10;
INSERT INTO pelanggan (nama_pelanggan, telepon, email, alamat) VALUES
('Cstorice', '091234566654', 'cassie@mail.com', 'Jl. Talathon No.23, Amphoreus');

-- Tabel Pesanan
INSERT INTO pesanan (id_pelanggan, jenis_acara, tanggal_acara, alamat_pengiriman, total_harga, status_pesan) VALUES
(1, 'Pernikahan', '2025-05-10 10:00:00', 'Jl. Merdeka No.1, Jakarta', 2500000, 'pending'),
(2, 'Ulang Tahun', '2025-05-12 17:00:00', 'Jl. Pahlawan No.2, Bandung', 4500000, 'confirmed'),
(3, 'Rapat Kantor', '2025-05-15 08:30:00', 'Jl. Raya No.3, Surabaya', 3500000, 'completed'),
(4, 'Reuni', '2025-05-20 19:00:00', 'Jl. Anggrek No.4, Yogyakarta', 3000000, 'canceled'),
(5, 'Acara Keluarga', '2025-05-25 12:00:00', 'Jl. Mawar No.5, Bali', 2000000, 'pending'),
(6, 'Pernikahan', '2025-06-01 10:00:00', 'Jl. Cemara No.6, Medan', 4000000, 'pending'),
(7, 'Rapat Kantor', '2025-06-05 14:00:00', 'Jl. Sakura No.7, Malang', 2500000, 'pending'),
(8, 'Ulang Tahun', '2025-06-10 18:00:00', 'Jl. Raya No.8, Makassar', 5500000, 'confirmed'),
(9, 'Acara Keluarga', '2025-06-15 11:00:00', 'Jl. Bunga No.9, Semarang', 3000000, 'completed'),
(10, 'Reuni', '2025-06-20 17:00:00', 'Jl. Padma No.10, Surakarta', 3500000, 'pending');
SELECT * FROM pesanan;
INSERT INTO pesanan (id_pelanggan, jenis_acara, tanggal_acara, alamat_pengiriman, total_harga, status_pesan) VALUES
(12, 'Syukuran', '2025-06-10 18:00:00', 'Jl. Kenanga No.11, Bandung', 1500000, 'pending');


-- Tabel Detail Pesanan
INSERT INTO detail_pesanan (id_pesanan, id_menu, kuantitas, subtotal) VALUES
(1, 1, 100, 2500000),
(1, 2, 50, 1500000),
(2, 3, 150, 5250000),
(2, 5, 80, 2000000),
(3, 4, 100, 1500000),
(3, 6, 100, 500000),
(4, 1, 75, 1875000),
(4, 2, 60, 1800000),
(5, 7, 100, 700000),
(5, 6, 80, 400000),
(6, 3, 100, 3500000),
(6, 7, 100, 700000),
(7, 1, 80, 2000000),
(7, 2, 50, 1500000),
(8, 4, 200, 3000000),
(8, 5, 150, 3750000),
(9, 6, 80, 400000),
(9, 1, 120, 3000000),
(10, 3, 150, 5250000),
(10, 7, 100, 700000);
SELECT * FROM detail_pesanan;

-- Tabel Pembayaran
INSERT INTO pembayaran (id_pesanan, tanggal_pembayaran, jumlah, metode_pembayaran, status_bayar) VALUES
(1, '2025-05-09 09:00:00', 2500000, 'transfer', 'pending'),
(2, '2025-05-11 16:00:00', 4500000, 'credit_card', 'paid'),
(3, '2025-05-14 08:00:00', 3500000, 'cash', 'paid'),
(4, '2025-05-19 18:00:00', 3000000, 'cash', 'failed'),
(5, '2025-05-24 11:00:00', 2000000, 'transfer', 'pending'),
(6, '2025-05-30 10:00:00', 4000000, 'credit_card', 'pending'),
(7, '2025-06-04 13:00:00', 2500000, 'cash', 'pending'),
(8, '2025-06-09 16:00:00', 5500000, 'transfer', 'paid'),
(9, '2025-06-14 10:00:00', 3000000, 'cash', 'paid'),
(10, '2025-06-19 17:00:00', 3500000, 'credit_card', 'pending');
SELECT * FROM pembayaran;

-- Tabel Log Pengiriman
INSERT INTO log_pengiriman (id_pesanan, tanggal_pengiriman, status_kirim) VALUES
(1, '2025-05-10 12:00:00', 'pending'),
(2, '2025-05-12 18:00:00', 'on the way'),
(3, '2025-05-15 09:00:00', 'delivered'),
(4, '2025-05-20 20:00:00', 'delivered'),
(5, '2025-05-25 13:00:00', 'pending'),
(6, '2025-06-01 11:00:00', 'pending'),
(7, '2025-06-05 15:00:00', 'pending'),
(8, '2025-06-10 19:00:00', 'on the way'),
(9, '2025-06-15 12:00:00', 'delivered'),
(10, '2025-06-20 18:00:00', 'pending');
SELECT * FROM log_pengiriman;

-- VIew
-- 1. view_pesanan_pelanggan
CREATE VIEW view_pesanan_pelanggan AS
SELECT 
    p.nama_pelanggan, 
    p.telepon, 
    p.email, 
    ps.jenis_acara, 
    ps.tanggal_acara, 
    ps.total_harga, 
    ps.status_pesan
FROM pelanggan p
JOIN pesanan ps ON p.id_pelanggan = ps.id_pelanggan;
SELECT * FROM view_pesanan_pelanggan;
-- 2. view_pesanan_detail_menu
CREATE VIEW view_pesanan_detail_menu AS
SELECT 
    p.nama_pelanggan, 
    ps.jenis_acara, 
    ps.tanggal_acara, 
    d.id_menu, 
    m.nama_menu, 
    d.kuantitas, 
    d.subtotal
FROM pelanggan p
JOIN pesanan ps ON p.id_pelanggan = ps.id_pelanggan
JOIN detail_pesanan d ON ps.id_pesanan = d.id_pesanan
JOIN menu m ON d.id_menu = m.id_menu;
SELECT * FROM view_pesanan_detail_menu;
-- 3. view_pelanggan_confirmed
CREATE VIEW view_pelanggan_confirmed AS
SELECT 
    p.nama_pelanggan, 
    ps.jenis_acara, 
    ps.tanggal_acara, 
    ps.total_harga
FROM pelanggan p
JOIN pesanan ps ON p.id_pelanggan = ps.id_pelanggan
WHERE ps.status_pesan = 'confirmed';
SELECT * FROM view_pelanggan_confirmed;
-- 4. view_total_pembayaran
CREATE VIEW view_total_pembayaran AS
SELECT 
    ps.jenis_acara, 
    SUM(p.jumlah) AS total_pembayaran
FROM pesanan ps
JOIN pembayaran p ON ps.id_pesanan = p.id_pesanan
WHERE p.status_bayar = 'paid'
GROUP BY ps.jenis_acara;
SELECT * FROM view_total_pembayaran;
-- 5. view_pesanan_belum_dibayar
CREATE VIEW view_pesanan_belum_dibayar AS
SELECT 
    ps.id_pesanan, 
    p.nama_pelanggan, 
    ps.jenis_acara, 
    ps.total_harga, 
    ps.status_pesan AS status_pesanan, 
    lg.status_kirim AS status_pengiriman
FROM pesanan ps
JOIN pelanggan p ON ps.id_pelanggan = p.id_pelanggan
JOIN log_pengiriman lg ON ps.id_pesanan = lg.id_pesanan
WHERE ps.id_pesanan IN (
    SELECT id_pesanan FROM pembayaran WHERE status_bayar = 'pending'
);
SELECT * FROM view_pesanan_belum_dibayar;


DROP DATABASE catering_acara;

