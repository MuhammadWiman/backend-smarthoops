-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 26 Des 2025 pada 13.42
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `spk_ahp_basket`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `bobot_kriteria`
--

CREATE TABLE `bobot_kriteria` (
  `id_kriteria` int(11) NOT NULL,
  `bobot` decimal(6,4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `bobot_kriteria`
--

INSERT INTO `bobot_kriteria` (`id_kriteria`, `bobot`) VALUES
(1, 0.0932),
(2, 0.0706),
(3, 0.0706),
(4, 0.0674),
(5, 0.0706),
(6, 0.1664),
(7, 0.0785),
(8, 0.0749),
(9, 0.0785),
(10, 0.0785),
(11, 0.0754),
(12, 0.0754);

-- --------------------------------------------------------

--
-- Struktur dari tabel `hasil_ahp`
--

CREATE TABLE `hasil_ahp` (
  `id_pemain` int(11) NOT NULL,
  `nilai_akhir` decimal(6,4) DEFAULT NULL,
  `ranking` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `hasil_ahp`
--

INSERT INTO `hasil_ahp` (`id_pemain`, `nilai_akhir`, `ranking`) VALUES
(1, 80.3057, 3),
(2, 83.9371, 2),
(3, 84.5322, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `kriteria`
--

CREATE TABLE `kriteria` (
  `id_kriteria` int(11) NOT NULL,
  `nama_kriteria` varchar(100) NOT NULL,
  `kelompok` enum('Skill','Fisik') NOT NULL,
  `deskripsi` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `kriteria`
--

INSERT INTO `kriteria` (`id_kriteria`, `nama_kriteria`, `kelompok`, `deskripsi`) VALUES
(1, 'Shooting', 'Skill', 'Kemampuan pemain dalam melakukan tembakan ke ring dengan akurat, baik jarak dekat, menengah, maupun jauh.'),
(2, 'Dribbling', 'Skill', 'Kemampuan menguasai bola saat bergerak dan menghindari lawan.'),
(3, 'Defense', 'Skill', 'Kemampuan bertahan, menjaga lawan, merebut bola, dan menghalangi tembakan.'),
(4, 'kecepatan (Speed)', 'Fisik', 'Kemampuan bergerak cepat saat menyerang maupun bertahan.'),
(5, 'Passing', 'Skill', 'Kemampuan memberikan umpan yang tepat, cepat, dan akurat kepada rekan satu tim.'),
(6, 'Game Intelligence (IQ Bermain)', 'Skill', 'Kemampuan membaca permainan, mengambil keputusan cepat, dan memahami strategi tim.'),
(7, 'Teamwork', 'Skill', 'Kemampuan bekerja sama dengan tim, komunikasi, dan peran dalam sistem permainan.'),
(8, 'Kekuatan (Strength)', 'Fisik', 'Kekuatan fisik pemain dalam bertahan, duel badan, dan menjaga posisi.'),
(9, 'Daya Tahan (Endurance)', 'Fisik', 'Kemampuan bertahan bermain dalam durasi lama tanpa penurunan performa.'),
(10, 'Kelincahan (Agility)', 'Fisik', 'Kemampuan perubahan arah secara cepat dan efisien.'),
(11, 'Tinggi Badan', 'Fisik', 'Tinggi fisik pemain yang berpengaruh pada rebound, block, dan shooting.'),
(12, 'Power Lompat (Vertical Jump)', 'Fisik', 'Kemampuan melompat tinggi untuk rebound, block, dan finishing.');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pemain`
--

CREATE TABLE `pemain` (
  `id_pemain` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `umur` int(11) DEFAULT NULL,
  `posisi` varchar(50) DEFAULT NULL,
  `tinggi` int(11) DEFAULT NULL,
  `berat` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pemain`
--

INSERT INTO `pemain` (`id_pemain`, `nama`, `umur`, `posisi`, `tinggi`, `berat`, `created_at`) VALUES
(1, 'Andi', 25, 'Center', 175, 75, '2025-12-21 10:58:56'),
(2, 'Budi', 19, 'Point Guard', 180, 70, '2025-12-21 11:02:27'),
(3, 'Cahyo', 22, 'Guard', 185, 69, '2025-12-21 11:02:50');

-- --------------------------------------------------------

--
-- Struktur dari tabel `penilaian`
--

CREATE TABLE `penilaian` (
  `id_penilaian` int(11) NOT NULL,
  `id_pemain` int(11) NOT NULL,
  `id_kriteria` int(11) NOT NULL,
  `nilai` decimal(5,2) NOT NULL,
  `id_user` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `penilaian`
--

INSERT INTO `penilaian` (`id_penilaian`, `id_pemain`, `id_kriteria`, `nilai`, `id_user`) VALUES
(11, 1, 1, 85.00, 2),
(12, 1, 2, 85.00, 2),
(13, 1, 12, 80.00, 2),
(14, 2, 1, 80.00, 2),
(15, 2, 2, 80.00, 2),
(16, 1, 7, 80.00, 2),
(17, 1, 8, 80.00, 2),
(18, 1, 9, 75.00, 2),
(19, 1, 11, 85.00, 2),
(20, 2, 4, 75.00, 2),
(21, 1, 5, 90.00, 2),
(22, 1, 4, 80.00, 2),
(23, 2, 3, 80.00, 2),
(24, 1, 3, 60.00, 2),
(25, 1, 6, 85.00, 2),
(26, 2, 5, 95.00, 2),
(27, 2, 6, 90.00, 2),
(28, 2, 7, 80.00, 2),
(29, 2, 8, 90.00, 2),
(30, 2, 9, 85.00, 2),
(31, 2, 10, 70.00, 2),
(32, 2, 11, 90.00, 2),
(33, 2, 12, 85.00, 2),
(34, 3, 1, 80.00, 2),
(35, 3, 2, 80.00, 2),
(36, 1, 2, 80.00, 1),
(37, 1, 1, 80.00, 1),
(38, 1, 3, 60.00, 1),
(39, 1, 11, 80.00, 1),
(40, 1, 12, 80.00, 1),
(41, 2, 1, 85.00, 1),
(42, 2, 2, 75.00, 1),
(43, 2, 3, 80.00, 1),
(44, 2, 4, 75.00, 1),
(45, 1, 4, 80.00, 1),
(46, 1, 5, 85.00, 1),
(47, 1, 6, 85.00, 1),
(48, 1, 7, 85.00, 1),
(49, 1, 8, 75.00, 1),
(50, 1, 9, 75.00, 1),
(51, 1, 10, 85.00, 1),
(52, 2, 5, 85.00, 1),
(53, 2, 6, 90.00, 1),
(54, 2, 7, 85.00, 1),
(55, 2, 8, 80.00, 1),
(56, 2, 9, 85.00, 1),
(57, 2, 10, 75.00, 1),
(58, 2, 11, 85.00, 1),
(59, 2, 12, 85.00, 1),
(60, 3, 1, 80.00, 1),
(61, 3, 2, 80.00, 1),
(62, 3, 3, 85.00, 1),
(63, 3, 4, 78.00, 1),
(64, 3, 5, 90.00, 1),
(65, 3, 6, 87.00, 1),
(66, 3, 7, 90.00, 1),
(67, 3, 8, 80.00, 1),
(68, 3, 9, 80.00, 1),
(69, 3, 11, 87.00, 1),
(70, 3, 12, 90.00, 1),
(71, 3, 10, 72.00, 1),
(72, 1, 1, 80.00, 4),
(73, 1, 3, 80.00, 4),
(74, 1, 4, 80.00, 4),
(75, 1, 2, 80.00, 4),
(76, 1, 8, 80.00, 4),
(77, 1, 9, 80.00, 4),
(78, 1, 7, 80.00, 4),
(79, 1, 6, 80.00, 4),
(80, 1, 10, 80.00, 4),
(81, 1, 5, 80.00, 4),
(82, 1, 11, 80.00, 4),
(83, 1, 12, 80.00, 4),
(84, 2, 1, 85.00, 4),
(85, 2, 2, 85.00, 4),
(86, 2, 3, 85.00, 4),
(87, 2, 4, 85.00, 4),
(88, 2, 5, 85.00, 4),
(89, 2, 6, 85.00, 4),
(90, 2, 7, 85.00, 4),
(91, 2, 8, 85.00, 4),
(92, 2, 9, 85.00, 4),
(93, 2, 10, 85.00, 4),
(94, 2, 11, 85.00, 4),
(95, 2, 12, 85.00, 4),
(96, 3, 3, 86.00, 4),
(97, 3, 7, 86.00, 4),
(98, 3, 4, 84.00, 4),
(99, 3, 2, 86.00, 4),
(100, 3, 1, 86.00, 4),
(101, 3, 6, 86.00, 4),
(102, 3, 5, 86.00, 4),
(103, 3, 8, 86.00, 4),
(104, 3, 9, 86.00, 4),
(105, 3, 10, 86.00, 4),
(106, 3, 11, 86.00, 4),
(107, 3, 12, 86.00, 4);

-- --------------------------------------------------------

--
-- Struktur dari tabel `perbandingan_kriteria`
--

CREATE TABLE `perbandingan_kriteria` (
  `id_perbandingan` int(11) NOT NULL,
  `kriteria_1` int(11) NOT NULL,
  `kriteria_2` int(11) NOT NULL,
  `nilai` decimal(5,2) NOT NULL,
  `id_user` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `perbandingan_kriteria`
--

INSERT INTO `perbandingan_kriteria` (`id_perbandingan`, `kriteria_1`, `kriteria_2`, `nilai`, `id_user`) VALUES
(8, 1, 1, 1.00, 1),
(9, 1, 2, 1.00, 1),
(10, 2, 1, 1.00, 1),
(11, 1, 3, 1.00, 1),
(12, 3, 1, 1.00, 1),
(13, 1, 4, 1.00, 1),
(14, 4, 1, 1.00, 1),
(15, 1, 5, 1.00, 1),
(16, 5, 1, 1.00, 1),
(17, 1, 6, 0.20, 1),
(18, 6, 1, 5.00, 1),
(19, 1, 7, 1.00, 1),
(20, 7, 1, 1.00, 1),
(21, 1, 8, 1.00, 1),
(22, 8, 1, 1.00, 1),
(23, 1, 9, 1.00, 1),
(24, 9, 1, 1.00, 1),
(25, 1, 10, 1.00, 1),
(26, 10, 1, 1.00, 1),
(27, 1, 11, 1.00, 1),
(28, 11, 1, 1.00, 1),
(29, 1, 12, 1.00, 1),
(30, 12, 1, 1.00, 1),
(31, 2, 2, 1.00, 1),
(32, 2, 3, 1.00, 1),
(33, 3, 2, 1.00, 1),
(34, 2, 4, 1.00, 1),
(35, 4, 2, 1.00, 1),
(36, 2, 5, 1.00, 1),
(37, 5, 2, 1.00, 1),
(38, 2, 6, 0.20, 1),
(39, 6, 2, 5.00, 1),
(40, 2, 7, 1.00, 1),
(41, 7, 2, 1.00, 1),
(42, 2, 8, 1.00, 1),
(43, 8, 2, 1.00, 1),
(44, 2, 9, 1.00, 1),
(45, 9, 2, 1.00, 1),
(46, 2, 10, 1.00, 1),
(47, 10, 2, 1.00, 1),
(48, 2, 11, 1.00, 1),
(49, 11, 2, 1.00, 1),
(50, 2, 12, 1.00, 1),
(51, 12, 2, 1.00, 1),
(52, 3, 3, 1.00, 1),
(53, 3, 4, 1.00, 1),
(54, 4, 3, 1.00, 1),
(55, 3, 5, 1.00, 1),
(56, 5, 3, 1.00, 1),
(57, 3, 6, 0.20, 1),
(58, 6, 3, 5.00, 1),
(59, 3, 7, 1.00, 1),
(60, 7, 3, 1.00, 1),
(61, 3, 8, 1.00, 1),
(62, 8, 3, 1.00, 1),
(63, 3, 9, 1.00, 1),
(64, 9, 3, 1.00, 1),
(65, 3, 10, 1.00, 1),
(66, 10, 3, 1.00, 1),
(67, 3, 11, 1.00, 1),
(68, 11, 3, 1.00, 1),
(69, 3, 12, 1.00, 1),
(70, 12, 3, 1.00, 1),
(71, 4, 4, 1.00, 1),
(72, 4, 5, 1.00, 1),
(73, 5, 4, 1.00, 1),
(74, 4, 6, 0.20, 1),
(75, 6, 4, 5.00, 1),
(76, 4, 7, 1.00, 1),
(77, 7, 4, 1.00, 1),
(78, 4, 8, 1.00, 1),
(79, 8, 4, 1.00, 1),
(80, 4, 9, 1.00, 1),
(81, 9, 4, 1.00, 1),
(82, 4, 10, 1.00, 1),
(83, 10, 4, 1.00, 1),
(84, 4, 11, 1.00, 1),
(85, 11, 4, 1.00, 1),
(86, 4, 12, 1.00, 1),
(87, 12, 4, 1.00, 1),
(88, 5, 5, 1.00, 1),
(89, 5, 6, 0.20, 1),
(90, 6, 5, 5.00, 1),
(91, 5, 7, 1.00, 1),
(92, 7, 5, 1.00, 1),
(93, 5, 8, 1.00, 1),
(94, 8, 5, 1.00, 1),
(95, 5, 9, 1.00, 1),
(96, 9, 5, 1.00, 1),
(97, 5, 10, 1.00, 1),
(98, 10, 5, 1.00, 1),
(99, 5, 11, 1.00, 1),
(100, 11, 5, 1.00, 1),
(101, 5, 12, 1.00, 1),
(102, 12, 5, 1.00, 1),
(103, 6, 6, 1.00, 1),
(104, 6, 7, 1.00, 1),
(105, 7, 6, 1.00, 1),
(106, 6, 8, 1.00, 1),
(107, 8, 6, 1.00, 1),
(108, 6, 9, 1.00, 1),
(109, 9, 6, 1.00, 1),
(110, 6, 10, 1.00, 1),
(111, 10, 6, 1.00, 1),
(112, 6, 11, 1.00, 1),
(113, 11, 6, 1.00, 1),
(114, 6, 12, 1.00, 1),
(115, 12, 6, 1.00, 1),
(116, 7, 7, 1.00, 1),
(117, 7, 8, 1.00, 1),
(118, 8, 7, 1.00, 1),
(119, 7, 9, 1.00, 1),
(120, 9, 7, 1.00, 1),
(121, 7, 10, 1.00, 1),
(122, 10, 7, 1.00, 1),
(123, 7, 11, 1.00, 1),
(124, 11, 7, 1.00, 1),
(125, 7, 12, 1.00, 1),
(126, 12, 7, 1.00, 1),
(127, 8, 8, 1.00, 1),
(128, 8, 9, 1.00, 1),
(129, 9, 8, 1.00, 1),
(130, 8, 10, 1.00, 1),
(131, 10, 8, 1.00, 1),
(132, 8, 11, 1.00, 1),
(133, 11, 8, 1.00, 1),
(134, 8, 12, 1.00, 1),
(135, 12, 8, 1.00, 1),
(136, 9, 9, 1.00, 1),
(137, 9, 10, 1.00, 1),
(138, 10, 9, 1.00, 1),
(139, 9, 11, 1.00, 1),
(140, 11, 9, 1.00, 1),
(141, 9, 12, 1.00, 1),
(142, 12, 9, 1.00, 1),
(143, 10, 10, 1.00, 1),
(144, 10, 11, 1.00, 1),
(145, 11, 10, 1.00, 1),
(146, 10, 12, 1.00, 1),
(147, 12, 10, 1.00, 1),
(148, 11, 11, 1.00, 1),
(149, 11, 12, 1.00, 1),
(150, 12, 11, 1.00, 1),
(151, 12, 12, 1.00, 1),
(152, 1, 1, 1.00, 2),
(153, 1, 2, 1.00, 2),
(154, 2, 1, 1.00, 2),
(155, 1, 3, 1.00, 2),
(156, 3, 1, 1.00, 2),
(157, 1, 4, 5.00, 2),
(158, 4, 1, 0.20, 2),
(159, 1, 5, 1.00, 2),
(160, 5, 1, 1.00, 2),
(161, 1, 6, 5.00, 2),
(162, 6, 1, 0.20, 2),
(163, 1, 7, 1.00, 2),
(164, 7, 1, 1.00, 2),
(165, 1, 8, 7.00, 2),
(166, 8, 1, 0.14, 2),
(167, 1, 9, 1.00, 2),
(168, 9, 1, 1.00, 2),
(169, 1, 10, 1.00, 2),
(170, 10, 1, 1.00, 2),
(171, 1, 11, 5.00, 2),
(172, 11, 1, 0.20, 2),
(173, 1, 12, 5.00, 2),
(174, 12, 1, 0.20, 2),
(175, 2, 2, 1.00, 2),
(176, 2, 3, 1.00, 2),
(177, 3, 2, 1.00, 2),
(178, 2, 4, 1.00, 2),
(179, 4, 2, 1.00, 2),
(180, 2, 5, 1.00, 2),
(181, 5, 2, 1.00, 2),
(182, 2, 6, 0.20, 2),
(183, 6, 2, 5.00, 2),
(184, 2, 7, 1.00, 2),
(185, 7, 2, 1.00, 2),
(186, 2, 8, 1.00, 2),
(187, 8, 2, 1.00, 2),
(188, 2, 9, 1.00, 2),
(189, 9, 2, 1.00, 2),
(190, 2, 10, 1.00, 2),
(191, 10, 2, 1.00, 2),
(192, 2, 11, 1.00, 2),
(193, 11, 2, 1.00, 2),
(194, 2, 12, 1.00, 2),
(195, 12, 2, 1.00, 2),
(196, 3, 3, 1.00, 2),
(197, 3, 4, 1.00, 2),
(198, 4, 3, 1.00, 2),
(199, 3, 5, 1.00, 2),
(200, 5, 3, 1.00, 2),
(201, 3, 6, 0.20, 2),
(202, 6, 3, 5.00, 2),
(203, 3, 7, 1.00, 2),
(204, 7, 3, 1.00, 2),
(205, 3, 8, 1.00, 2),
(206, 8, 3, 1.00, 2),
(207, 3, 9, 1.00, 2),
(208, 9, 3, 1.00, 2),
(209, 3, 10, 1.00, 2),
(210, 10, 3, 1.00, 2),
(211, 3, 11, 1.00, 2),
(212, 11, 3, 1.00, 2),
(213, 3, 12, 1.00, 2),
(214, 12, 3, 1.00, 2),
(215, 4, 4, 1.00, 2),
(216, 4, 5, 1.00, 2),
(217, 5, 4, 1.00, 2),
(218, 4, 6, 0.20, 2),
(219, 6, 4, 5.00, 2),
(220, 4, 7, 1.00, 2),
(221, 7, 4, 1.00, 2),
(222, 4, 8, 1.00, 2),
(223, 8, 4, 1.00, 2),
(224, 4, 9, 1.00, 2),
(225, 9, 4, 1.00, 2),
(226, 4, 10, 1.00, 2),
(227, 10, 4, 1.00, 2),
(228, 4, 11, 1.00, 2),
(229, 11, 4, 1.00, 2),
(230, 4, 12, 1.00, 2),
(231, 12, 4, 1.00, 2),
(232, 5, 5, 1.00, 2),
(233, 5, 6, 0.20, 2),
(234, 6, 5, 5.00, 2),
(235, 5, 7, 1.00, 2),
(236, 7, 5, 1.00, 2),
(237, 5, 8, 1.00, 2),
(238, 8, 5, 1.00, 2),
(239, 5, 9, 1.00, 2),
(240, 9, 5, 1.00, 2),
(241, 5, 10, 1.00, 2),
(242, 10, 5, 1.00, 2),
(243, 5, 11, 1.00, 2),
(244, 11, 5, 1.00, 2),
(245, 5, 12, 1.00, 2),
(246, 12, 5, 1.00, 2),
(247, 6, 6, 1.00, 2),
(248, 6, 7, 1.00, 2),
(249, 7, 6, 1.00, 2),
(250, 6, 8, 1.00, 2),
(251, 8, 6, 1.00, 2),
(252, 6, 9, 1.00, 2),
(253, 9, 6, 1.00, 2),
(254, 6, 10, 1.00, 2),
(255, 10, 6, 1.00, 2),
(256, 6, 11, 1.00, 2),
(257, 11, 6, 1.00, 2),
(258, 6, 12, 1.00, 2),
(259, 12, 6, 1.00, 2),
(260, 7, 7, 1.00, 2),
(261, 7, 8, 1.00, 2),
(262, 8, 7, 1.00, 2),
(263, 7, 9, 1.00, 2),
(264, 9, 7, 1.00, 2),
(265, 7, 10, 1.00, 2),
(266, 10, 7, 1.00, 2),
(267, 7, 11, 1.00, 2),
(268, 11, 7, 1.00, 2),
(269, 7, 12, 1.00, 2),
(270, 12, 7, 1.00, 2),
(271, 8, 8, 1.00, 2),
(272, 8, 9, 1.00, 2),
(273, 9, 8, 1.00, 2),
(274, 8, 10, 1.00, 2),
(275, 10, 8, 1.00, 2),
(276, 8, 11, 1.00, 2),
(277, 11, 8, 1.00, 2),
(278, 8, 12, 1.00, 2),
(279, 12, 8, 1.00, 2),
(280, 9, 9, 1.00, 2),
(281, 9, 10, 1.00, 2),
(282, 10, 9, 1.00, 2),
(283, 9, 11, 1.00, 2),
(284, 11, 9, 1.00, 2),
(285, 9, 12, 1.00, 2),
(286, 12, 9, 1.00, 2),
(287, 10, 10, 1.00, 2),
(288, 10, 11, 1.00, 2),
(289, 11, 10, 1.00, 2),
(290, 10, 12, 1.00, 2),
(291, 12, 10, 1.00, 2),
(292, 11, 11, 1.00, 2),
(293, 11, 12, 1.00, 2),
(294, 12, 11, 1.00, 2),
(295, 12, 12, 1.00, 2),
(296, 1, 1, 1.00, 4),
(297, 1, 2, 1.00, 4),
(298, 2, 1, 1.00, 4),
(299, 1, 3, 1.00, 4),
(300, 3, 1, 1.00, 4),
(301, 1, 4, 1.00, 4),
(302, 4, 1, 1.00, 4),
(303, 1, 5, 1.00, 4),
(304, 5, 1, 1.00, 4),
(305, 1, 6, 0.20, 4),
(306, 6, 1, 5.00, 4),
(307, 1, 7, 1.00, 4),
(308, 7, 1, 1.00, 4),
(309, 1, 8, 1.00, 4),
(310, 8, 1, 1.00, 4),
(311, 1, 9, 1.00, 4),
(312, 9, 1, 1.00, 4),
(313, 1, 10, 1.00, 4),
(314, 10, 1, 1.00, 4),
(315, 1, 11, 1.00, 4),
(316, 11, 1, 1.00, 4),
(317, 1, 12, 1.00, 4),
(318, 12, 1, 1.00, 4),
(319, 2, 2, 1.00, 4),
(320, 2, 3, 1.00, 4),
(321, 3, 2, 1.00, 4),
(322, 2, 4, 1.00, 4),
(323, 4, 2, 1.00, 4),
(324, 2, 5, 1.00, 4),
(325, 5, 2, 1.00, 4),
(326, 2, 6, 0.20, 4),
(327, 6, 2, 5.00, 4),
(328, 2, 7, 1.00, 4),
(329, 7, 2, 1.00, 4),
(330, 2, 8, 1.00, 4),
(331, 8, 2, 1.00, 4),
(332, 2, 9, 1.00, 4),
(333, 9, 2, 1.00, 4),
(334, 2, 10, 1.00, 4),
(335, 10, 2, 1.00, 4),
(336, 2, 11, 1.00, 4),
(337, 11, 2, 1.00, 4),
(338, 2, 12, 1.00, 4),
(339, 12, 2, 1.00, 4),
(340, 3, 3, 1.00, 4),
(341, 3, 4, 1.00, 4),
(342, 4, 3, 1.00, 4),
(343, 3, 5, 1.00, 4),
(344, 5, 3, 1.00, 4),
(345, 3, 6, 0.20, 4),
(346, 6, 3, 5.00, 4),
(347, 3, 7, 1.00, 4),
(348, 7, 3, 1.00, 4),
(349, 3, 8, 1.00, 4),
(350, 8, 3, 1.00, 4),
(351, 3, 9, 1.00, 4),
(352, 9, 3, 1.00, 4),
(353, 3, 10, 1.00, 4),
(354, 10, 3, 1.00, 4),
(355, 3, 11, 1.00, 4),
(356, 11, 3, 1.00, 4),
(357, 3, 12, 1.00, 4),
(358, 12, 3, 1.00, 4),
(359, 4, 4, 1.00, 4),
(360, 4, 5, 1.00, 4),
(361, 5, 4, 1.00, 4),
(362, 4, 6, 0.20, 4),
(363, 6, 4, 5.00, 4),
(364, 4, 7, 1.00, 4),
(365, 7, 4, 1.00, 4),
(366, 4, 8, 1.00, 4),
(367, 8, 4, 1.00, 4),
(368, 4, 9, 1.00, 4),
(369, 9, 4, 1.00, 4),
(370, 4, 10, 1.00, 4),
(371, 10, 4, 1.00, 4),
(372, 4, 11, 1.00, 4),
(373, 11, 4, 1.00, 4),
(374, 4, 12, 1.00, 4),
(375, 12, 4, 1.00, 4),
(376, 5, 5, 1.00, 4),
(377, 5, 6, 0.20, 4),
(378, 6, 5, 5.00, 4),
(379, 5, 7, 1.00, 4),
(380, 7, 5, 1.00, 4),
(381, 5, 8, 1.00, 4),
(382, 8, 5, 1.00, 4),
(383, 5, 9, 1.00, 4),
(384, 9, 5, 1.00, 4),
(385, 5, 10, 1.00, 4),
(386, 10, 5, 1.00, 4),
(387, 5, 11, 1.00, 4),
(388, 11, 5, 1.00, 4),
(389, 5, 12, 1.00, 4),
(390, 12, 5, 1.00, 4),
(391, 6, 6, 1.00, 4),
(392, 6, 7, 1.00, 4),
(393, 7, 6, 1.00, 4),
(394, 6, 8, 1.00, 4),
(395, 8, 6, 1.00, 4),
(396, 6, 9, 1.00, 4),
(397, 9, 6, 1.00, 4),
(398, 6, 10, 1.00, 4),
(399, 10, 6, 1.00, 4),
(400, 6, 11, 1.00, 4),
(401, 11, 6, 1.00, 4),
(402, 6, 12, 1.00, 4),
(403, 12, 6, 1.00, 4),
(404, 7, 7, 1.00, 4),
(405, 7, 8, 1.00, 4),
(406, 8, 7, 1.00, 4),
(407, 7, 9, 1.00, 4),
(408, 9, 7, 1.00, 4),
(409, 7, 10, 1.00, 4),
(410, 10, 7, 1.00, 4),
(411, 7, 11, 1.00, 4),
(412, 11, 7, 1.00, 4),
(413, 7, 12, 1.00, 4),
(414, 12, 7, 1.00, 4),
(415, 8, 8, 1.00, 4),
(416, 8, 9, 1.00, 4),
(417, 9, 8, 1.00, 4),
(418, 8, 10, 1.00, 4),
(419, 10, 8, 1.00, 4),
(420, 8, 11, 1.00, 4),
(421, 11, 8, 1.00, 4),
(422, 8, 12, 1.00, 4),
(423, 12, 8, 1.00, 4),
(424, 9, 9, 1.00, 4),
(425, 9, 10, 1.00, 4),
(426, 10, 9, 1.00, 4),
(427, 9, 11, 1.00, 4),
(428, 11, 9, 1.00, 4),
(429, 9, 12, 1.00, 4),
(430, 12, 9, 1.00, 4),
(431, 10, 10, 1.00, 4),
(432, 10, 11, 1.00, 4),
(433, 11, 10, 1.00, 4),
(434, 10, 12, 1.00, 4),
(435, 12, 10, 1.00, 4),
(436, 11, 11, 1.00, 4),
(437, 11, 12, 1.00, 4),
(438, 12, 11, 1.00, 4),
(439, 12, 12, 1.00, 4);

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','pelatih') NOT NULL DEFAULT 'pelatih',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id_user`, `nama_lengkap`, `email`, `password`, `role`, `created_at`) VALUES
(1, 'Muhammad Wiman', 'admin@basket.com', '$2b$10$GGAwa6cnS438cOCTpkiwuehIuPj7K25aOlUVL49XKssZ2DCBtxqDq', 'pelatih', '2025-12-21 10:55:17'),
(2, 'Asep', 'asep@basket.com', '$2b$10$Lf1xzbG3ey1N4hfOeGTp0e02gpPeQxeBmzYe6yhr3W1gc4emUHJUS', 'pelatih', '2025-12-26 09:47:56'),
(3, 'admin', 'wiman@admin.com', '$2b$10$YFkeyk6kPi7/sw42PqvTWeqGhkUgGif/nXzWKml6lRW9WPJskEOJq', 'admin', '2025-12-26 10:19:27'),
(4, 'ujang', 'ujang@basket.com', '$2b$10$MXOms9KQhlMgCHOuRf18AOzMRcfm4zRhAhEqFB5ICOFLBxET.FVRC', 'pelatih', '2025-12-26 10:24:38');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `bobot_kriteria`
--
ALTER TABLE `bobot_kriteria`
  ADD PRIMARY KEY (`id_kriteria`);

--
-- Indeks untuk tabel `hasil_ahp`
--
ALTER TABLE `hasil_ahp`
  ADD PRIMARY KEY (`id_pemain`);

--
-- Indeks untuk tabel `kriteria`
--
ALTER TABLE `kriteria`
  ADD PRIMARY KEY (`id_kriteria`);

--
-- Indeks untuk tabel `pemain`
--
ALTER TABLE `pemain`
  ADD PRIMARY KEY (`id_pemain`);

--
-- Indeks untuk tabel `penilaian`
--
ALTER TABLE `penilaian`
  ADD PRIMARY KEY (`id_penilaian`),
  ADD KEY `id_pemain` (`id_pemain`),
  ADD KEY `id_kriteria` (`id_kriteria`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `perbandingan_kriteria`
--
ALTER TABLE `perbandingan_kriteria`
  ADD PRIMARY KEY (`id_perbandingan`),
  ADD KEY `kriteria_1` (`kriteria_1`),
  ADD KEY `kriteria_2` (`kriteria_2`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `kriteria`
--
ALTER TABLE `kriteria`
  MODIFY `id_kriteria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT untuk tabel `pemain`
--
ALTER TABLE `pemain`
  MODIFY `id_pemain` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `penilaian`
--
ALTER TABLE `penilaian`
  MODIFY `id_penilaian` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;

--
-- AUTO_INCREMENT untuk tabel `perbandingan_kriteria`
--
ALTER TABLE `perbandingan_kriteria`
  MODIFY `id_perbandingan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=440;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `bobot_kriteria`
--
ALTER TABLE `bobot_kriteria`
  ADD CONSTRAINT `bobot_kriteria_ibfk_1` FOREIGN KEY (`id_kriteria`) REFERENCES `kriteria` (`id_kriteria`);

--
-- Ketidakleluasaan untuk tabel `hasil_ahp`
--
ALTER TABLE `hasil_ahp`
  ADD CONSTRAINT `hasil_ahp_ibfk_1` FOREIGN KEY (`id_pemain`) REFERENCES `pemain` (`id_pemain`);

--
-- Ketidakleluasaan untuk tabel `penilaian`
--
ALTER TABLE `penilaian`
  ADD CONSTRAINT `penilaian_ibfk_1` FOREIGN KEY (`id_pemain`) REFERENCES `pemain` (`id_pemain`),
  ADD CONSTRAINT `penilaian_ibfk_2` FOREIGN KEY (`id_kriteria`) REFERENCES `kriteria` (`id_kriteria`),
  ADD CONSTRAINT `penilaian_ibfk_3` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`);

--
-- Ketidakleluasaan untuk tabel `perbandingan_kriteria`
--
ALTER TABLE `perbandingan_kriteria`
  ADD CONSTRAINT `perbandingan_kriteria_ibfk_1` FOREIGN KEY (`kriteria_1`) REFERENCES `kriteria` (`id_kriteria`),
  ADD CONSTRAINT `perbandingan_kriteria_ibfk_2` FOREIGN KEY (`kriteria_2`) REFERENCES `kriteria` (`id_kriteria`),
  ADD CONSTRAINT `perbandingan_kriteria_ibfk_3` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
