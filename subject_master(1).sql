-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 18, 2025 at 01:20 PM
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
  `status` enum('Active','Inactive') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `timestamp` text COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subject_master`
--

INSERT INTO `subject_master` (`subject_id`, `subject_name`, `status`, `timestamp`) VALUES
(1, 'कायदे व नियम', 'Active', '18-11-2025'),
(2, 'ई-बुक', 'Active', '18-11-2025'),
(3, 'मंत्री मंडळ निर्णय', 'Active', '18-11-2025'),
(4, 'कोषागार नमुने', 'Active', '18-11-2025'),
(5, 'नागरिकांची सनद', 'Active', '18-11-2025'),
(6, 'महत्वाची संकेतस्थळे', 'Active', '18-11-2025'),
(7, 'माहितीचा अधिकार', 'Active', '18-11-2025'),
(8, 'लोकसेवा', 'Active', '18-11-2025'),
(9, 'शासकीय धोरण', 'Active', '18-11-2025'),
(10, 'शासकीय दिनदर्शिका', 'Active', '18-11-2025'),
(11, 'महाराष्ट्र शासनाचे राजपत्र', 'Active', '18-11-2025'),
(12, 'शासकीय मोबाईल', 'Active', '18-11-2025'),
(13, 'वार्षिक अहवाल', 'Active', '18-11-2025'),
(14, 'शासन निर्णय परिपत्रक', 'Active', '18-11-2025'),
(15, 'शासकीय योजना', 'Active', '18-11-2025');

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
  MODIFY `subject_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
