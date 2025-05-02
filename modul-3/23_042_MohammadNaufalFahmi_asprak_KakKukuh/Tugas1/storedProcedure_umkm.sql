USE umkm;
-- 1.AddUMKM
DELIMITER //
CREATE PROCEDURE AddUMKM (
    IN u_nama_usaha VARCHAR(200),
    IN u_jumlah_karyawan INT (11)
)
BEGIN
    INSERT INTO umkm (nama_usaha, jumlah_karyawan)
    VALUES (u_nama_usaha, u_jumlah_karyawan);
    SELECT * FROM umkm WHERE nama_usaha = u_nama_usaha;
END //
DELIMITER ;
CALL AddUMKM('Toko Sepatu Belobog', 15);
DROP PROCEDURE AddUMKM;

-- 2.UpdateKategoriUMKM
DELIMITER //
CREATE PROCEDURE UpdateKategoriUMKM (
    IN ku_id_kategori INT,
    IN ku_nama_baru VARCHAR(100)
)
BEGIN
    UPDATE kategori_umkm
    SET nama_kategori = ku_nama_baru
    WHERE id_kategori = ku_id_kategori;
    SELECT * FROM kategori_umkm WHERE id_kategori = ku_id_kategori;
END //
DELIMITER ;
CALL UpdateKategoriUMKM(2, 'Fesyen Baru');
DROP PROCEDURE UpdateKategoriUMKM;

-- 3.DeletePemilikUMKM
DELIMITER //
CREATE PROCEDURE DeletePemilikUMKM (
    IN pu_id_pemilik INT (11)
)
BEGIN
    DELETE FROM pemilik_umkm
    WHERE id_pemilik = pu_id_pemilik;
    SELECT * FROM pemilik_umkm WHERE id_pemilik = pu_id_pemilik;
END //
DELIMITER ;
CALL DeletePemilikUMKM(16);
DROP PROCEDURE DeletePemilikUMKM;

-- 4.AddProduk
DELIMITER //
CREATE PROCEDURE AddProduk (
    IN pru_id_umkm INT (11),
    IN pru_nama_produk VARCHAR(200),
    IN pru_harga DECIMAL(15,2)
)
BEGIN
    INSERT INTO produk_umkm (id_umkm, nama_produk, harga)
    VALUES (pru_id_umkm, pru_nama_produk, pru_harga);
    SELECT * FROM produk_umkm
    WHERE id_umkm = pru_id_umkm AND nama_produk = pru_nama_produk;
END //
DELIMITER ;
CALL AddProduk(15, 'Kopi Souland', 18000);
DROP PROCEDURE AddProduk;

-- 5.GetUMKMByID
DELIMITER //
CREATE PROCEDURE GetUMKMByID (
    IN u_id_umkm INT,
    OUT u_nama_usaha VARCHAR(200),
    OUT u_alamat_usaha TEXT,
    OUT u_tahun_berdiri YEAR(4),
    OUT u_jumlah_karyawan INT
)
BEGIN
    SELECT nama_usaha, alamat_usaha, tahun_berdiri, jumlah_karyawan
    INTO u_nama_usaha, u_alamat_usaha, u_tahun_berdiri, u_jumlah_karyawan
    FROM umkm
    WHERE id_umkm = u_id_umkm;
    SELECT u_nama_usaha AS Nama_Usaha,
           u_alamat_usaha AS Alamat_Usaha,
           u_tahun_berdiri AS Tahun_Berdiri,
           u_jumlah_karyawan AS Jumlah_Karyawan;
END //
DELIMITER ;
CALL GetUMKMByID(8, @nama_usaha, @alamat_usaha, @tahun_berdiri, @jumlah_karyawan);
DROP PROCEDURE GetUMKMByID;









