USE catering_acara;
-- 1. UpdateDataMaster
DELIMITER //
CREATE PROCEDURE UpdateDataMaster (
    IN pl_id_pelanggan INT,
    IN pl_nama_baru VARCHAR(100),
    OUT pl_status VARCHAR(50)
)
BEGIN
    DECLARE jumlah_data INT;
    -- cek id
    SELECT COUNT(*) INTO jumlah_data
    FROM pelanggan
    WHERE id_pelanggan = pl_id_pelanggan;
    -- validasi
    IF jumlah_data > 0 THEN
        UPDATE pelanggan
        SET nama_pelanggan = pl_nama_baru
        WHERE id_pelanggan = pl_id_pelanggan;
        SET pl_status = 'Berhasil diupdate';
    ELSE
        SET pl_status = 'Data tidak ditemukan';
    END IF;
END //
DELIMITER ;
CALL UpdateDataMaster(11, 'Nopin', @status);
SELECT @status;
DROP PROCEDURE UpdateDataMaster;

-- 2.CountTransaksi
DELIMITER //
CREATE PROCEDURE CountTransaksi (
    OUT ps_total INT,
    OUT ps_status VARCHAR(50)
)
BEGIN
    DECLARE jumlah_data INT;
    BEGIN
        SELECT COUNT(*) INTO jumlah_data
        FROM information_schema.tables
        WHERE TABLE_NAME = 'pesanan' AND table_schema = DATABASE();
        IF jumlah_data > 0 THEN
            SELECT COUNT(*) INTO ps_total FROM pesanan;
            SET ps_status = 'Sukses menghitung transaksi';
        ELSE
            SET ps_status = 'Tabel pesanan tidak ditemukan';
        END IF;
    END;
END //
DELIMITER ;
CALL CountTransaksi(@total_transaksi, @status);
SELECT @total_transaksi AS Total_Transaksi, @status AS STATUS;
DROP PROCEDURE CountTransaksi;

-- 3. GetDataMasterByID
DELIMITER //
CREATE PROCEDURE GetDataMasterByID (
    IN pl_id_pelanggan INT,
    OUT pl_nama_pelanggan VARCHAR(100),
    OUT pl_telepon VARCHAR(15),
    OUT pl_alamat TEXT,
    OUT pl_status VARCHAR(50)
)
BEGIN
    DECLARE jumlah_data INT;
    SELECT COUNT(*) INTO jumlah_data
    FROM pelanggan
    WHERE id_pelanggan = pl_id_pelanggan;
    IF jumlah_data > 0 THEN
        SELECT nama_pelanggan, telepon, alamat
        INTO pl_nama_pelanggan, pl_telepon, pl_alamat
        FROM pelanggan
        WHERE id_pelanggan = pl_id_pelanggan;
        SET pl_status = 'Data ditemukan';
    ELSE
        SET pl_nama_pelanggan = NULL;
        SET pl_telepon = NULL;
        SET pl_alamat = NULL;
        SET pl_status = 'Data tidak ditemukan';
    END IF;
END //
DELIMITER ;
CALL GetDataMasterByID(1, @nama, @telepon, @alamat, @status);
SELECT @nama AS Nama_Pelanggan, 
       @telepon AS No_Telepon,
       @alamat AS Alamat,
       @status AS STATUS;
DROP PROCEDURE GetDataMasterByID;

-- 4. UpdateFieldTransaksi
DELIMITER //
CREATE PROCEDURE UpdateFieldTransaksi(
    IN ps_id_pesanan INT,
    INOUT ps_status_pesan ENUM('pending', 'confirmed', 'completed', 'canceled'),
    INOUT ps_total_harga DECIMAL(10,2),
    OUT ps_status VARCHAR(50)
)
BEGIN
    -- variabel penampung
    DECLARE v_status_pesan ENUM('pending', 'confirmed', 'completed', 'canceled');
    DECLARE v_total_harga DECIMAL(10,2);
    DECLARE jumlah_data INT;
    -- cek id
    SELECT COUNT(*) INTO jumlah_data
    FROM pesanan
    WHERE id_pesanan = ps_id_pesanan;
    IF jumlah_data > 0 THEN
        SELECT status_pesan, total_harga
        INTO v_status_pesan, v_total_harga
        FROM pesanan
        WHERE id_pesanan = ps_id_pesanan;
        UPDATE pesanan
        SET 
            status_pesan = IFNULL(ps_status_pesan, v_status_pesan),
            total_harga = IFNULL(ps_total_harga, v_total_harga)
        WHERE id_pesanan = ps_id_pesanan;
        SET ps_status = 'Data berhasil diperbarui';
    ELSE
        SET ps_status = 'Pesanan tidak ditemukan';
    END IF;
END //
DELIMITER ;
SET @status_pesan = 'confirmed';
SET @total_harga = 4000000; 
CALL UpdateFieldTransaksi(10, @status_pesan, @total_harga, @status);
SELECT @status AS STATUS;
SELECT * FROM pesanan WHERE id_pesanan = 10;
DROP PROCEDURE UpdateFieldTransaksi;

-- 5.DeleteEntriesByIDMaster
DELIMITER //
CREATE PROCEDURE DeleteEntriesByIDMaster (
    IN pl_id_pelanggan INT,
    OUT ps_status VARCHAR(50)
)
BEGIN
    DECLARE jumlah_data INT;
    SELECT COUNT(*) INTO jumlah_data
    FROM pelanggan
    WHERE id_pelanggan = pl_id_pelanggan;
    IF jumlah_data > 0 THEN
        DELETE FROM pelanggan
        WHERE id_pelanggan = pl_id_pelanggan;
        SET ps_status = 'Data berhasil dihapus';
    ELSE
        SET ps_status = 'Data tidak ditemukan';
    END IF;
END //
DELIMITER ;
CALL DeleteEntriesByIDMaster(11, @status);
SELECT @status AS STATUS;
SELECT * FROM pelanggan WHERE id_pelanggan = 11;
DROP PROCEDURE DeleteEntriesByIDMaster;




