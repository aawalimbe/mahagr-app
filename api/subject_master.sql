-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 17, 2025 at 01:27 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.0.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `maha_gr`
--

-- --------------------------------------------------------

--
-- Table structure for table `subject_master`
--

CREATE TABLE `subject_master` (
  `subject_id` int(11) NOT NULL,
  `subject_name` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `new_id` int(11) DEFAULT NULL,
  `status` enum('Active','Inactive') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `timestamp` text COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subject_master`
--

INSERT INTO `subject_master` (`subject_id`, `subject_name`, `new_id`, `status`, `timestamp`) VALUES
(1, 'अधिसुचना', 3, 'Active', '2025-09-11'),
(2, 'ई-बुक', 12, 'Active', '2025-09-11'),
(3, 'कायदे व नियम', 1, 'Active', '2025-09-11'),
(4, 'कोषागार नमुने', 10, 'Active', '2025-09-11'),
(5, 'नागरिकांची सनद', 7, 'Active', '2025-09-11'),
(6, 'मंत्री मंडळ निर्णय', 4, 'Active', '2025-09-11'),
(7, 'महत्वाची संपर्क स्थळे', 15, 'Active', '2025-09-11'),
(8, 'माहितीचा अधिकार', 9, 'Active', '2025-09-11'),
(9, 'लोकसेवा', 8, 'Active', '2025-09-11'),
(10, 'वार्षिक अहवाल', 11, 'Active', '2025-09-11'),
(11, 'शासकीय दिनदर्शिका', 13, 'Active', '2025-09-11'),
(12, 'शासकीय धोरण', 5, 'Active', '2025-09-11'),
(13, 'शासकीय मोबाईल APP', 14, 'Active', '2025-09-11'),
(14, 'शासन निर्णय परिपत्रक', 2, 'Active', '2025-09-11');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `subject_master`
--
ALTER TABLE `subject_master`
  ADD PRIMARY KEY (`subject_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `subject_master`
--
ALTER TABLE `subject_master`
  MODIFY `subject_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
