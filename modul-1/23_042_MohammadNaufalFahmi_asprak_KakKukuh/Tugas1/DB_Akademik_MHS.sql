-- Buat Database
CREATE DATABASE Akademik_Mahasiswa;
USE Akademik_Mahasiswa;

-- Tabel
-- 1. Jurusan
CREATE TABLE Jurusan (
    id_jurusan INT PRIMARY KEY,
    nama VARCHAR(100)
);

-- 2. Dosen
CREATE TABLE Dosen (
    id_dosen INT PRIMARY KEY,
    nama VARCHAR(100),
    nip VARCHAR(20) UNIQUE
);

-- 3. Mahasiswa
CREATE TABLE Mahasiswa (
    id_mahasiswa INT PRIMARY KEY,
    nama VARCHAR(100),
    nim VARCHAR(15) UNIQUE,
    id_jurusan INT,
    FOREIGN KEY (id_jurusan) REFERENCES Jurusan(id_jurusan)
        ON DELETE CASCADE
);

-- 4. Mata Kuliah
CREATE TABLE Mata_Kuliah (
    id_matakuliah INT PRIMARY KEY,
    kode VARCHAR(10) UNIQUE,
    nama VARCHAR(100),
    sks INT,
    id_jurusan INT,
    FOREIGN KEY (id_jurusan) REFERENCES Jurusan(id_jurusan)
        ON DELETE CASCADE
);

-- 5. Pengajar (relasi Dosen, Mata Kuliah)
CREATE TABLE Pengajar (
    id_pengajar INT PRIMARY KEY,
    id_dosen INT,
    id_matakuliah INT,
    ruang VARCHAR(50),
    kapasitas INT,
    hari VARCHAR(20),
    jam VARCHAR(20),
    FOREIGN KEY (id_dosen) REFERENCES Dosen(id_dosen)
        ON DELETE CASCADE,
    FOREIGN KEY (id_matakuliah) REFERENCES Mata_Kuliah(id_matakuliah)
        ON DELETE CASCADE
);

-- 6. KRS
CREATE TABLE KRS (
    id_krs INT PRIMARY KEY,
    id_mahasiswa INT,
    id_matakuliah INT,
    semester INT,
    FOREIGN KEY (id_mahasiswa) REFERENCES Mahasiswa(id_mahasiswa)
        ON DELETE CASCADE,
    FOREIGN KEY (id_matakuliah) REFERENCES Mata_Kuliah(id_matakuliah)
        ON DELETE CASCADE
);

-- show tables;

-- Insert data
-- Jurusan
INSERT INTO Jurusan (id_jurusan, nama) VALUES 
(1, 'Teknik Informatika'), 
(2, 'Sistem Informasi');

-- Dosen
INSERT INTO Dosen (id_dosen, nama, nip) VALUES 
(1, 'Mohammad Syarief,ST.,M.Cs', '198003212008011008'), 
(2, 'Doni Abdul Fatah,S.Kom.,M.Kom', '198705202019031013'),
(3, 'Firmansyah Adiputra,S.T.,M.Cs.', '197805042002121002'), 
(4, 'Muhammad Yusuf,ST,M.MT,PhD', '197912152008121002'), 
(5, 'Dr. Yeni Kustiyahningsih,S.Kom.,M.Kom', '197709212008122002'), 
(6, 'Sri Herawati,S.Kom.,M.Kom', '198308282008122002'), 
(7, 'Eza Rahmanita,S.T.,M.T.', '197906052003122003'), 
(8, 'Yudha Dwi Putra Negara,S.Kom.,M.Kom', '198905302019031012'), 
(9, 'Firli Irhamni,S.T.,M.Kom', '197601202001121001'), 
(10, 'Imamah,S.Kom.,M.Kom', '198507212014042001');

-- Mahasiswa
INSERT INTO Mahasiswa (id_mahasiswa, nama, nim, id_jurusan) VALUES 
(1, 'Ar-raffi Abqori Nur Azizi', '230441100026', 1), 
(2, 'Dony Eka Octavian Putra', '230441100041', 2), 
(3, 'Agatha Yasmin Rahman', '230441100156', 1), 
(4, 'Alvyan Maulana Karnawan Putra', '230441100120', 2), 
(5, 'Mohammad Naufal Fahmi', '230441100042', 1), 
(6, 'Isma Yafa Nur Zamzami R', '230441100081', 2), 
(7, 'Erlangga Satrya Husada', '230441100101', 1), 
(8, 'M Fajri Alfaini', '230441100171', 2), 
(9, 'M Maulana Khanif', '230441100047', 1), 
(10, 'Dylan Akhtarreza', '230441100027', 2);

-- Mata Kuliah
INSERT INTO Mata_Kuliah (id_matakuliah, kode, nama, sks, id_jurusan) VALUES 
(1, 'TIF101', 'Struktur Data', 4, 1), 
(2, 'TIF102', 'Aljabar Linier', 3, 1), 
(3, 'TIF103', 'Statistika', 3, 1), 
(4, 'TIF104', 'Interaksi Manusia Komputer', 2, 1), 
(5, 'TIF105', 'Pengantar Teknologi Informasi', 4, 1), 
(6, 'SI101', 'Sistem Manajemen Basis Data', 4, 2), 
(7, 'SI102', 'Pemrograman Bergerak', 4, 2), 
(8, 'SI103', 'Rekayasa Perangkat Lunak', 3, 2), 
(9, 'SI104', 'Analisa Proses Bisnis', 2, 2), 
(10, 'SI105', 'Desain Manajemen Jaringan', 3, 2);

-- Pengajar
INSERT INTO Pengajar (id_pengajar, id_dosen, id_matakuliah, ruang, kapasitas, hari, jam) VALUES 
(1, 1, 1, 'LAB TI', 30, 'Senin', '08.00 - 10.00'), 
(2, 2, 2, 'RKBF 308', 45, 'Selasa', '10.00 - 12.00'), 
(3, 3, 3, 'RKBF 204', 30, 'Rabu', '08.00 - 11.00'), 
(4, 4, 4, 'RKBF 206', 40, 'Kamis', '09.00 - 12.00'), 
(5, 5, 5, 'RKBF 204', 30, 'Jumat', '13.00 - 15.00'), 
(6, 6, 6, 'LAB TI', 30, 'Senin', '10.00 - 12.00'), 
(7, 7, 7, 'RKBF 308', 45, 'Selasa', '13.00 - 15.00'), 
(8, 8, 8, 'RKBF 204', 30, 'Rabu', '08.00 - 10.00'), 
(9, 9, 9, 'RKBF 308', 45, 'Kamis', '14.00 - 16.00'), 
(10, 10, 10, 'LAB BIS', 35, 'Jumat', '09.00 - 11.00');

-- Tampilkan Seluruh Tabel Selain KRS
SELECT * FROM Jurusan;
SELECT * FROM Dosen;
SELECT * FROM Mahasiswa;
SELECT * FROM Mata_Kuliah;
SELECT * FROM Pengajar;
SELECT * FROM Matkul;

-- Insert Data ke Tabel KRS
INSERT INTO KRS (id_krs, id_mahasiswa, id_matakuliah, semester) VALUES 
(1, 1, 1, 2), 
(2, 2, 6, 4), 
(3, 3, 2, 4), 
(4, 4, 7, 2), 
(5, 5, 3, 2);

SELECT * FROM KRS;

-- Ubah Nama Salah Satu Tabel
ALTER TABLE Mata_Kuliah RENAME TO MATKUL;

-- Hapus Database
DROP DATABASE Akademik_Mahasiswa;

