USE catering_acara;
-- 1.Kolom keterangan salah satu tabel
ALTER TABLE pesanan
ADD COLUMN catatan TEXT AFTER status_pesan;

-- 2.Gabungan 2 tabel
SELECT ps.id_pesanan, pl.nama_pelanggan, pl.alamat, ps.jenis_acara, ps.tanggal_acara
FROM pesanan ps
JOIN pelanggan pl ON ps.id_pelanggan = pl.id_pelanggan;

-- 3.Penggunaan Order By, DESC, dan ASC
-- DESC
SELECT 
    m.nama_menu,
    km.nama_kategori,
    m.harga
FROM menu m
JOIN kategori_menu km ON m.id_kategori = km.id_kategori
ORDER BY    
    m.harga DESC; 
-- ASC
SELECT 
    l.id_pengiriman,
    l.id_pesanan,
    l.status_kirim,
    l.tanggal_pengiriman
FROM log_pengiriman l
ORDER BY         
    l.tanggal_pengiriman ASC;     
          
-- 4.Perubahan tipe data
ALTER TABLE menu
MODIFY COLUMN harga INT;

-- 5.Kode Left Join, Right Join dan Self Join
-- left join
SELECT m.nama_menu, dp.kuantitas
FROM menu m
LEFT JOIN detail_pesanan dp ON m.id_menu = dp.id_menu;
-- right join
SELECT ps.id_pesanan, pl.nama_pelanggan
FROM pesanan ps
RIGHT JOIN pelanggan pl ON ps.id_pelanggan = pl.id_pelanggan;
-- self join
SELECT psa.id_pesanan AS pesanan_a, psb.id_pesanan AS pesanan_b, psa.tanggal_acara
FROM pesanan psa
JOIN pesanan psb ON psa.tanggal_acara = psb.tanggal_acara
WHERE psa.id_pesanan < psb.id_pesanan;

-- 6.Kode yang mengandung operator perbandingan
SELECT * FROM pesanan
WHERE 
    status_pesan != 'canceled' AND         
    total_harga >= 2500000 AND             
    total_harga <= 5000000 AND            
    id_pelanggan BETWEEN 2 AND 8 AND       
    jenis_acara = 'Pernikahan';            















