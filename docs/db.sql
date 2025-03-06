CREATE DATABASE aeroporto;
use aeroporto;

-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 06, 2023 at 04:51 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `es_8_aeroporti`
--

-- --------------------------------------------------------

--
-- Table structure for table `aerei`
--

CREATE TABLE `aerei` (
  `id_aereo` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `num_passeggeri` int(11) DEFAULT NULL,
  `id_compagnia` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `aerei`
--

INSERT INTO `aerei` (`id_aereo`, `nome`, `tipo`, `num_passeggeri`, `id_compagnia`) VALUES
(1, 'Boeing 737', 'Aereo di linea', 189, 1),
(2, 'Airbus A320', 'Aereo di linea', 150, 2),
(3, 'Boeing 747', 'Aereo di linea', 416, 3),
(4, 'Airbus A380', 'Aereo di linea', 853, 2),
(5, 'Boeing 777', 'Aereo di linea', 314, 4),
(6, 'Airbus A319', 'Aereo di linea', 124, 3),
(7, 'Boeing 787 Dreamliner', 'Aereo di linea', 242, 4),
(8, 'Boeing 737-800', 'Aereo di linea', 189, 2),
(9, 'Airbus A320', 'Aereo di linea', 150, 1),
(10, 'Boeing 747', 'Aereo di linea', 416, NULL),
(11, 'Embraer E190', 'Aereo di linea', 100, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `aeroporti`
--

CREATE TABLE `aeroporti` (
  `id_aeroporto` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `via` varchar(50) DEFAULT NULL,
  `citta` varchar(50) NOT NULL,
  `nazione` varchar(50) NOT NULL,
  `num_terminali` int(11) DEFAULT NULL,
  `num_piste` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `aeroporti`
--

INSERT INTO `aeroporti` (`id_aeroporto`, `nome`, `via`, `citta`, `nazione`, `num_terminali`, `num_piste`) VALUES
(1, 'Leonardo da Vinci', 'Via dell\'Aeroporto di Fiumicino, 320', 'Fiumicino', 'Italia', 4, 2),
(2, 'Charles de Gaulle', '95700 Roissy-en-France', 'Roissy-en-France', 'Francia', 3, 4),
(3, 'Heathrow', 'Longford TW6', 'Londra', 'Regno Unito', 5, 2),
(4, 'JFK', 'Queens, NY', 'New York', 'Stati Uniti d\'America', 6, 4),
(5, 'Narita', '1-1 Furugome, Narita', 'Chiba', 'Giappone', 2, 3),
(6, 'Heathrow Airport', 'Longford, Hounslow', 'Londra', 'Regno Unito', 4, 2),
(7, 'Charles de Gaulle Airport', '95700 Roissy-en-France', 'Parigi', 'Francia', 3, 4),
(8, 'Frankfurt Airport', '60547 Frankfurt am Main', 'Francoforte', 'Germania', 2, 3),
(9, 'Dubai International Airport', 'Dubai', 'Dubai', 'Emirati Arabi Uniti', 3, 2),
(10, 'Narita International Airport', '1-1 Furugome, Narita', 'Tokyo', 'Giappone', 2, 4);

-- --------------------------------------------------------

--
-- Table structure for table `compagnie`
--

CREATE TABLE `compagnie` (
  `id_compagnia` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `sitoweb` varchar(50) DEFAULT NULL,
  `peso_bagaglio_incluso` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `compagnie`
--

INSERT INTO `compagnie` (`id_compagnia`, `nome`, `sitoweb`, `peso_bagaglio_incluso`) VALUES
(1, 'Alitalia', 'www.alitalia.com', 23),
(2, 'Air France', 'www.airfrance.com', 25),
(3, 'British Airways', 'www.britishairways.com', 20),
(4, 'American Airlines', 'www.aa.com', 30),
(5, 'Japan Airlines', 'www.jal.co.jp', 25),
(6, 'Delta Air Lines', 'https://www.delta.com', 23),
(7, 'Lufthansa', NULL, 20),
(8, 'Air France', 'https://www.airfrance.it', 23),
(9, 'British Airways', NULL, 23),
(10, 'Emirates', 'https://www.emirates.com', 30);

-- --------------------------------------------------------

--
-- Table structure for table `voli`
--

CREATE TABLE `voli` (
  `id_volo` int(11) NOT NULL,
  `codice_volo` varchar(5) NOT NULL,
  `data` date DEFAULT NULL,
  `ora_partenza` time DEFAULT NULL,
  `ora_arrivo` time DEFAULT NULL,
  `id_aereo` int(11) DEFAULT NULL,
  `id_aeroporto_partenza` int(11) DEFAULT NULL,
  `id_aeroporto_arrivo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `voli`
--

INSERT INTO `voli` (`id_volo`, `codice_volo`, `data`, `ora_partenza`, `ora_arrivo`, `id_aereo`, `id_aeroporto_partenza`, `id_aeroporto_arrivo`) VALUES
(1, 'AZ123', '2023-05-10', '08:00:00', '11:00:00', 1, 1, 2),
(2, 'AF456', '2023-05-11', '14:00:00', '16:00:00', 2, 2, 3),
(3, 'BA789', '2023-05-12', '18:00:00', '22:00:00', 3, 3, 1),
(4, 'AA321', '2023-05-13', '11:00:00', '17:00:00', 4, 4, 5),
(5, 'JL567', '2023-05-14', '19:00:00', '08:00:00', 5, 5, 1),
(6, 'A357Z', '2023-05-15', '09:00:00', '12:00:00', 1, 2, 3),
(7, 'AZ751', '2023-05-10', '13:00:00', '15:30:00', 4, 7, 2),
(8, 'UA901', '2023-05-11', '11:45:00', '13:50:00', 6, 10, 5),
(9, 'BA222', '2023-05-12', '18:00:00', '20:00:00', 5, 6, 3),
(10, 'AF345', '2023-05-13', '09:00:00', '11:30:00', 7, 2, 7),
(11, 'BA101', '2023-05-10', '10:30:00', '12:30:00', 9, 1, 2),
(12, 'AF238', '2023-05-11', '14:15:00', '16:20:00', 7, 4, 5),
(13, 'DL904', '2023-05-12', '07:45:00', '09:15:00', 5, 3, 4),
(14, 'LH752', '2023-05-13', '08:20:00', '10:45:00', 6, 2, 1),
(15, 'EK563', '2023-05-14', '19:00:00', '21:30:00', 10, 5, 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `aerei`
--
ALTER TABLE `aerei`
  ADD PRIMARY KEY (`id_aereo`);

--
-- Indexes for table `aeroporti`
--
ALTER TABLE `aeroporti`
  ADD PRIMARY KEY (`id_aeroporto`);

--
-- Indexes for table `compagnie`
--
ALTER TABLE `compagnie`
  ADD PRIMARY KEY (`id_compagnia`);

--
-- Indexes for table `voli`
--
ALTER TABLE `voli`
  ADD PRIMARY KEY (`id_volo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;