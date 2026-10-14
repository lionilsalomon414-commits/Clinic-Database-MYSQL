-- =====================================================================
-- Tugas 2 - MSIM4206 Basis Data
-- Database : db_klinik (MySQL / MariaDB pada XAMPP)
-- Tabel    : dokter, pasien, administrator, dokter_admin, daftar,
--            pasien_dokter
-- =====================================================================

-- 1. Membuat database
CREATE DATABASE IF NOT EXISTS db_klinik
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_general_ci;

USE db_klinik;

-- 2. Tabel dokter
CREATE TABLE dokter (
  id_dokter     INT          NOT NULL AUTO_INCREMENT,
  nama_dokter   VARCHAR(100) NOT NULL,
  tanggal_lahir DATE         NOT NULL,
  alamat_dokter VARCHAR(255) DEFAULT NULL,
  no_hp         VARCHAR(15)  DEFAULT NULL,
  spesialis     VARCHAR(50)  NOT NULL,
  waktu_kerja   VARCHAR(50)  DEFAULT NULL,
  PRIMARY KEY (id_dokter)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Tabel pasien
CREATE TABLE pasien (
  id_pasien     INT          NOT NULL AUTO_INCREMENT,
  nama_pasien   VARCHAR(100) NOT NULL,
  alamat_pasien VARCHAR(255) DEFAULT NULL,
  jenis_kelamin ENUM('L','P') NOT NULL,
  PRIMARY KEY (id_pasien)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. Tabel administrator
CREATE TABLE administrator (
  id_admin   INT          NOT NULL AUTO_INCREMENT,
  nama_admin VARCHAR(100) NOT NULL,
  waktu_jaga VARCHAR(50)  DEFAULT NULL,
  PRIMARY KEY (id_admin)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. Tabel dokter_admin
--    (administrator memberikan data, dokter menyimpan data)
CREATE TABLE dokter_admin (
  id_data   INT NOT NULL AUTO_INCREMENT,
  id_admin  INT NOT NULL,
  id_dokter INT NOT NULL,
  PRIMARY KEY (id_data),
  CONSTRAINT fk_dokteradmin_admin
    FOREIGN KEY (id_admin) REFERENCES administrator (id_admin)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_dokteradmin_dokter
    FOREIGN KEY (id_dokter) REFERENCES dokter (id_dokter)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 6. Tabel daftar
--    (administrator melayani pendaftaran, pasien melakukan pendaftaran)
CREATE TABLE daftar (
  id_daftar INT NOT NULL AUTO_INCREMENT,
  id_admin  INT NOT NULL,
  id_pasien INT NOT NULL,
  PRIMARY KEY (id_daftar),
  CONSTRAINT fk_daftar_admin
    FOREIGN KEY (id_admin) REFERENCES administrator (id_admin)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_daftar_pasien
    FOREIGN KEY (id_pasien) REFERENCES pasien (id_pasien)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 7. Tabel pasien_dokter
--    (dokter memeriksa, pasien diperiksa)
CREATE TABLE pasien_dokter (
  id            INT      NOT NULL AUTO_INCREMENT,
  id_dokter     INT      NOT NULL,
  id_pasien     INT      NOT NULL,
  waktu_periksa DATETIME NOT NULL,
  resep         TEXT     DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_pasiendokter_dokter
    FOREIGN KEY (id_dokter) REFERENCES dokter (id_dokter)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_pasiendokter_pasien
    FOREIGN KEY (id_pasien) REFERENCES pasien (id_pasien)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================================
-- 8. Data contoh (urutan: tabel induk dahulu, baru tabel anak)
-- =====================================================================
INSERT INTO dokter (nama_dokter, tanggal_lahir, alamat_dokter, no_hp, spesialis, waktu_kerja) VALUES
('dr. Andi Pratama, Sp.PD', '1980-03-15', 'Jl. Merdeka No. 10, Bandung',   '081234567801', 'Penyakit Dalam', 'Senin-Jumat 08.00-14.00'),
('dr. Sinta Maharani, Sp.A', '1985-07-22', 'Jl. Sudirman No. 25, Bandung', '081234567802', 'Anak',           'Senin-Sabtu 09.00-15.00'),
('dr. Budi Santoso, Sp.JP',  '1978-11-05', 'Jl. Asia Afrika No. 7, Bandung','081234567803', 'Jantung',        'Selasa-Jumat 13.00-19.00');

INSERT INTO pasien (nama_pasien, alamat_pasien, jenis_kelamin) VALUES
('Rina Wulandari', 'Jl. Melati No. 3, Bandung',   'P'),
('Agus Setiawan',  'Jl. Kenanga No. 12, Bandung', 'L'),
('Siti Aminah',    'Jl. Mawar No. 8, Cimahi',     'P'),
('Doni Kurniawan', 'Jl. Anggrek No. 21, Bandung', 'L'),
('Putri Lestari',  'Jl. Dahlia No. 5, Lembang',   'P');

INSERT INTO administrator (nama_admin, waktu_jaga) VALUES
('Dewi Anggraini', 'Pagi 07.00-14.00'),
('Hendra Gunawan', 'Siang 14.00-21.00');

INSERT INTO dokter_admin (id_admin, id_dokter) VALUES
(1, 1),
(1, 2),
(2, 3);

INSERT INTO daftar (id_admin, id_pasien) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(1, 5);

INSERT INTO pasien_dokter (id_dokter, id_pasien, waktu_periksa, resep) VALUES
(1, 1, '2026-10-12 09:00:00', 'Paracetamol 500 mg, 3 kali sehari'),
(1, 2, '2026-10-12 09:30:00', 'Antasida, 3 kali sehari sesudah makan'),
(2, 5, '2026-10-12 10:15:00', 'Sirup vitamin C, 1 kali sehari'),
(3, 3, '2026-10-12 14:00:00', 'Amlodipine 5 mg, 1 kali sehari'),
(3, 4, '2026-10-12 14:45:00', 'Bisoprolol 2,5 mg, 1 kali sehari');

-- =====================================================================
-- 9. Query untuk memeriksa hasil
-- =====================================================================
SHOW TABLES;

DESCRIBE dokter;
DESCRIBE pasien;
DESCRIBE administrator;
DESCRIBE dokter_admin;
DESCRIBE daftar;
DESCRIBE pasien_dokter;

SELECT * FROM dokter;
SELECT * FROM pasien;
SELECT * FROM administrator;
SELECT * FROM dokter_admin;
SELECT * FROM daftar;
SELECT * FROM pasien_dokter;

-- Pemeriksaan: nama pasien, dokter yang memeriksa, waktu, dan resep
SELECT p.nama_pasien, d.nama_dokter, pd.waktu_periksa, pd.resep
FROM pasien_dokter pd
JOIN pasien p ON p.id_pasien = pd.id_pasien
JOIN dokter d ON d.id_dokter = pd.id_dokter
ORDER BY pd.waktu_periksa;

-- Pendaftaran: nama pasien dan administrator yang melayani
SELECT p.nama_pasien, a.nama_admin
FROM daftar df
JOIN pasien p ON p.id_pasien = df.id_pasien
JOIN administrator a ON a.id_admin = df.id_admin;
