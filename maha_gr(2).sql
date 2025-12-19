-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 02, 2025 at 03:16 PM
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
-- Table structure for table `admin_users`
--

CREATE TABLE `admin_users` (
  `admin_id` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `mobile_number` text DEFAULT NULL,
  `email` text DEFAULT NULL,
  `password` text DEFAULT NULL,
  `role` enum('admin','user') DEFAULT NULL,
  `status` enum('Active','Inactive') DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin_users`
--

INSERT INTO `admin_users` (`admin_id`, `name`, `mobile_number`, `email`, `password`, `role`, `status`, `timestamp`) VALUES
(1, 'Ranjit Kulkarni', '7709598998', 'ranjit', '123', 'admin', 'Active', '2025-06-19 05:29:26');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

-- CREATE TABLE `categories` (
--   `category_id` int(11) NOT NULL,
--   `department_id` int(11) DEFAULT NULL,
--   `category_name` text DEFAULT NULL,
--   `status` enum('Active','Inactive') DEFAULT NULL,
--   `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `categories`
--

-- INSERT INTO `categories` (`category_id`, `department_id`, `category_name`, `status`, `timestamp`) VALUES
-- (1, 1, 'HR', 'Inactive', '2025-06-19 10:07:53'),
-- (2, 1, 'Accounts', 'Active', '2025-06-19 10:10:35'),
-- (3, 1, 'Demo', 'Inactive', '2025-06-19 10:13:25'),
-- (4, 1, 'HR', 'Active', '2025-06-19 10:20:54'),
-- (5, 1, 'Demo', 'Active', '2025-06-19 10:31:02'),
-- (6, 1, 'Demo', 'Inactive', '2025-06-19 10:31:05'),
-- (7, 1, '123', 'Inactive', '2025-06-19 10:34:00'),
-- (8, 1, '123', 'Inactive', '2025-06-19 10:36:52'),
-- (9, 1, '1234', 'Inactive', '2025-06-19 10:44:07'),
-- (10, 1, '123', 'Active', '2025-06-24 06:33:42'),
-- (11, 1, '123', 'Active', '2025-06-24 06:33:42'),
-- (12, 2, 'demo', 'Active', '2025-06-24 06:49:10'),
-- (13, 2, 'Revenue', 'Active', '2025-06-24 06:49:35'),
-- (14, 1, 'test', 'Active', '2025-06-24 06:50:22');

-- --------------------------------------------------------

--
-- Table structure for table `category_master`
--

CREATE TABLE `category_master` (
  `category_id` int(11) NOT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `category_name` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('Active','Inactive') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `timestamp` text COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `category_master`
--

INSERT INTO `category_master` (`category_id`, `subject_id`, `category_name`, `status`, `timestamp`) VALUES
(1, 1, 'कृषी, पशुसंवर्धन, दुग्‍धव्‍यवसाय विकास व मत्‍स्‍यव्‍यवसाय विभाग', 'Active', '2025-09-15'),
(2, 1, 'सहकार, पणन व वस्‍त्रोद्योग विभाग', 'Active', '2025-09-15'),
(3, 1, 'पर्यावरण विभाग', 'Active', '2025-09-15'),
(4, 1, 'वित्त विभाग', 'Active', '2025-09-15'),
(5, 1, 'अन्‍न, नागरी पुरवठा व ग्राहक संरक्षण विभाग', 'Active', '2025-09-15'),
(6, 1, 'सामान्य प्रशासन विभाग', 'Active', '2025-09-15'),
(7, 1, 'उच्च व तंत्र शिक्षण विभाग', 'Active', '2025-09-15'),
(8, 1, 'गृहनिर्माण विभाग', 'Active', '2025-09-15'),
(9, 1, 'उद्योग, उर्जा व कामगार विभाग', 'Active', '2025-09-15'),
(10, 1, 'माहिती तंत्रज्ञान (सा.प्र.वि.) विभाग', 'Active', '2025-09-15'),
(11, 1, 'विधी व न्याय विभाग', 'Active', '2025-09-15'),
(12, 1, 'नियोजन विभाग', 'Active', '2025-09-15'),
(13, 1, 'सार्वजनिक आरोग्य विभाग', 'Active', '2025-09-15'),
(14, 1, 'सार्वजनिक बांधकाम विभाग', 'Active', '2025-09-15'),
(15, 1, 'महसूल व वन विभाग', 'Active', '2025-09-15'),
(16, 1, 'वन विभाग', 'Active', '2025-09-15'),
(17, 1, 'ग्राम विकास विभाग', 'Active', '2025-09-15'),
(18, 1, 'शालेय शिक्षण व क्रीडा विभाग', 'Active', '2025-09-15'),
(19, 1, 'कौशल्य विकास व उदयोजकता विभाग', 'Active', '2025-09-15'),
(20, 1, 'सामाजिक न्‍याय व विशेष सहाय्य विभाग', 'Active', '2025-09-15'),
(21, 1, 'मृद व जलसंधारण विभाग', 'Active', '2025-09-15'),
(22, 1, 'पर्यटन व सांस्कृतिक कार्य विभाग', 'Active', '2025-09-15'),
(23, 1, 'जलसंपदा विभाग', 'Active', '2025-09-15'),
(24, 1, 'पाणीपुरवठा व स्वच्छता विभाग', 'Active', '2025-09-15'),
(25, 2, 'अन्न नागरी पुरवठा व ग्राहक संरक्षण विभाग', 'Active', '2025-09-15'),
(26, 2, 'सार्वजनिक बांधकाम विभाग', 'Active', '2025-09-15'),
(27, 2, 'सार्वजनिक आरोग्य विभाग', 'Active', '2025-09-15'),
(28, 2, 'सामाजिक न्याय व विशेष सहाय्य विभाग', 'Active', '2025-09-15'),
(29, 2, 'सामान्य प्रशासन विभाग', 'Active', '2025-09-15'),
(30, 2, 'राज्य महिला आयोग', 'Active', '2025-09-15'),
(31, 2, 'सारथी', 'Active', '2025-09-15'),
(32, 2, '  शासन मुद्रण, लेखनसामग्री व प्रकाशन संचालनालयाच्या प्रकाशनाची यादी', 'Active', '2025-09-15'),
(33, 3, 'अन्न, नागरी पुरवठा व ग्राहक संरक्षण विभाग', 'Active', '2025-09-15'),
(34, 3, 'Urban Development Department', 'Active', '2025-09-15'),
(35, 3, 'MAHARASHTRA POLLUTION CONTROL BOARD (MPCB)', 'Active', '2025-09-15'),
(36, 3, 'उर्जा विभाग', 'Active', '2025-09-15'),
(37, 3, 'कामगार विभाग', 'Active', '2025-09-15'),
(38, 3, 'Labour Department', 'Active', '2025-09-15'),
(39, 3, 'आदिवासी विकास विभाग', 'Active', '2025-09-15'),
(40, 3, 'कृषी विभाग', 'Active', '2025-09-15'),
(41, 3, 'ग्रामविकास व पंचायत राज विभाग', 'Active', '2025-09-15'),
(42, 3, 'गृहविभाग', 'Active', '2025-09-15'),
(43, 3, 'परिवहन विभाग', 'Active', '2025-09-15'),
(44, 3, 'गृहनिर्माण विभाग', 'Active', '2025-09-15'),
(45, 3, 'जलसंपदा विभाग', 'Active', '2025-09-15'),
(46, 3, 'दिव्यांग कल्याण विभाग', 'Active', '2025-09-15'),
(47, 3, 'नगर विकास विभाग', 'Active', '2025-09-15'),
(48, 3, 'पाणी पुरवठा व स्वच्छता विभाग', 'Active', '2025-09-15'),
(49, 3, 'महिला व बालविकास विभाग', 'Active', '2025-09-15'),
(50, 3, 'वन विभाग', 'Active', '2025-09-15'),
(51, 3, 'सहकार विभाग', 'Active', '2025-09-15'),
(52, 3, 'सामाजिक न्याय व विशेष सहाय्य विभाग', 'Active', '2025-09-15'),
(53, 3, 'सामान्य प्रशासन विभाग', 'Active', '2025-09-15'),
(54, 3, 'वित्त विभाग', 'Active', '2025-09-15'),
(55, 3, 'सार्वजनिक आरोग्य विभाग', 'Active', '2025-09-15'),
(56, 3, 'सार्वजनिक बांधकाम विभाग', 'Active', '2025-09-15'),
(57, 3, 'सांस्कृतिक कार्य विभाग', 'Active', '2025-09-15'),
(58, 3, 'संसदीय कार्य विभाग', 'Active', '2025-09-15'),
(59, 3, 'Maharashtra Fire Services', 'Active', '2025-09-15'),
(60, 3, 'महाराष्ट्र राज्य मानवी हक्क आयोग', 'Active', '2025-09-15'),
(61, 3, 'वस्तु व सेवाकर विभाग', 'Active', '2025-09-15'),
(62, 3, 'नोंदणी व मुद्रांक शुल्क विभाग', 'Active', '2025-09-15'),
(63, 4, 'House Bulding  Advance', 'Active', '2025-09-15'),
(64, 4, 'Vehicle / Computer Purchase', 'Active', '2025-09-15'),
(65, 4, 'GPF', 'Active', '2025-09-15'),
(66, 4, 'Pension Forms', 'Active', '2025-09-15'),
(67, 5, 'अन्न, नागरी पुरवठा व ग्राहक संरक्षण विभाग', 'Active', '2025-09-15'),
(68, 5, 'अल्पसंख्यांक विकास विभाग', 'Active', '2025-09-15'),
(69, 5, 'उच्च आणि तंत्र शिक्षण विभाग', 'Active', '2025-09-15'),
(70, 5, 'उद्योग, उर्जा, कामगार व खनिकर्म विभाग', 'Active', '2025-09-15'),
(71, 5, 'कामगार विभाग', 'Active', '2025-09-15'),
(72, 5, 'गृहविभाग', 'Active', '2025-09-15'),
(73, 5, 'पर्यावरण विभाग', 'Active', '2025-09-15'),
(74, 5, 'महिला व बालविकास विभाग', 'Active', '2025-09-15'),
(75, 5, 'मराठी भाषा विभाग', 'Active', '2025-09-15'),
(76, 5, 'वित्त विभाग', 'Active', '2025-09-15'),
(77, 5, 'शालेय शिक्षण आणि क्रीडा विभाग', 'Active', '2025-09-15'),
(78, 5, 'सामाजिक न्याय व विशेष सहाय्य विभाग', 'Active', '2025-09-15'),
(79, 5, 'सामान्य प्रशासन विभाग', 'Active', '2025-09-15'),
(80, 5, 'पर्यटन व सांस्कृतिक कार्य विभाग', 'Active', '2025-09-15'),
(81, 5, 'नोंदणी व मुद्रांक', 'Active', '2025-09-15'),
(82, 5, 'विधी ', 'Active', '2025-09-15'),
(83, 5, 'MAT ', 'Active', '2025-09-15'),
(84, 5, ' आयोग', 'Active', '2025-09-15'),
(85, 6, 'मंत्रिमंडळाचे निर्णय ', 'Active', '2025-09-15'),
(86, 7, 'आपले सरकार', 'Active', '2025-09-15'),
(87, 7, 'अल्पसंख्यांक विकास विभाग', 'Active', '2025-09-15'),
(88, 7, 'आदिवासी विकास विभाग', 'Active', '2025-09-15'),
(89, 7, 'इतर मागास बहुजन कल्याण विभाग', 'Active', '2025-09-15'),
(90, 7, 'उच्च आणि तंत्र शिक्षण विभाग', 'Active', '2025-09-15'),
(91, 7, 'उद्योग विभाग', 'Active', '2025-09-15'),
(92, 7, 'उर्जा विभाग', 'Active', '2025-09-15'),
(93, 7, 'कौशल्य,रोजगार,उद्योजकता व नाविन्यता विभाग', 'Active', '2025-09-15'),
(94, 7, 'कृषी विभाग', 'Active', '2025-09-15'),
(95, 7, 'गृहविभाग', 'Active', '2025-09-15'),
(96, 7, 'गृहनिर्माण विभाग', 'Active', '2025-09-15'),
(97, 7, 'जलसंपदा विभाग', 'Active', '2025-09-15'),
(98, 7, 'दिव्यांग कल्याण विभाग', 'Active', '2025-09-15'),
(99, 7, 'नगर विकास विभाग', 'Active', '2025-09-15'),
(100, 7, 'नियोजन विभाग', 'Active', '2025-09-15'),
(101, 7, 'परिवहन विभाग', 'Active', '2025-09-15'),
(102, 7, 'पर्यटन विभाग', 'Active', '2025-09-15'),
(103, 7, 'पर्यावरण विभाग', 'Active', '2025-09-15'),
(104, 7, 'पाणी पुरवठा व स्वच्छता विभाग', 'Active', '2025-09-15'),
(105, 7, 'महिला व बालविकास विभाग', 'Active', '2025-09-15'),
(106, 7, 'मराठी भाषा विभाग', 'Active', '2025-09-15'),
(107, 7, 'माहिती तंत्रज्ञान', 'Active', '2025-09-15'),
(108, 7, 'वन विभाग', 'Active', '2025-09-15'),
(109, 7, 'वस्त्रोद्योग विभाग', 'Active', '2025-09-15'),
(110, 7, 'वित्त विभाग', 'Active', '2025-09-15'),
(111, 7, 'वैद्यकीय शिक्षण व औषधी द्रव्ये विभाग', 'Active', '2025-09-15'),
(112, 7, 'शालेय शिक्षण आणि क्रीडा विभाग', 'Active', '2025-09-15'),
(113, 7, 'सहकार, पणन आणि वस्त्रोद्योग विभाग', 'Active', '2025-09-15'),
(114, 7, 'सामाजिक न्याय व विशेष सहाय्य विभाग', 'Active', '2025-09-15'),
(115, 7, 'सामान्य प्रशासन विभाग', 'Active', '2025-09-15'),
(116, 7, 'सार्वजनिक आरोग्य विभाग', 'Active', '2025-09-15'),
(117, 7, 'सार्वजनिक बांधकाम विभाग', 'Active', '2025-09-15'),
(118, 7, 'सांस्कृतिक कार्य विभाग', 'Active', '2025-09-15'),
(119, 8, 'माहितीच्या अधिकाराशी संबंधीत शासन निर्णय', 'Active', '2025-09-15'),
(120, 8, 'ऑनलाईन', 'Active', '2025-09-15'),
(121, 9, 'लोकसेवा संबंधीत शासन निर्णय', 'Active', '2025-09-15'),
(122, 9, 'शासनाच्या विविध विभागामार्फत  पुरविल्या जाणाऱ्या सेवा', 'Active', '2025-09-15'),
(123, 10, 'उर्जा विभाग', 'Active', '2025-09-15'),
(124, 10, 'जलसंपदा विभाग', 'Active', '2025-09-15'),
(125, 10, 'अल्पसंख्यांक विकास विभाग', 'Active', '2025-09-15'),
(126, 10, 'आदिवासी विकास विभाग', 'Active', '2025-09-15'),
(127, 10, 'महाराष्ट्र राज्य सहकारी आदिवासी विकास महामंडळ मर्यादित', 'Active', '2025-09-15'),
(128, 10, 'बाष्पके संचालनालय, कामगाव विभाग, महाराष्ट्र राज्य', 'Active', '2025-09-15'),
(129, 10, 'दिव्यांग कल्याण विभाग', 'Active', '2025-09-15'),
(130, 10, 'रोजगार हमी योजना विभाग', 'Active', '2025-09-15'),
(131, 10, 'वन विभाग', 'Active', '2025-09-15'),
(132, 10, 'शालेय शिक्षण आणि क्रीडा विभाग', 'Active', '2025-09-15'),
(133, 10, 'अर्थ व सांख्यिकी संचालनालय', 'Active', '2025-09-15'),
(134, 10, 'अर्थसंकल्प', 'Active', '2025-09-15'),
(135, 10, 'महाराष्ट्र राज्य माहिती आयोग', 'Active', '2025-09-15'),
(136, 10, 'महाराष्ट्र राज्य लोकसेवा आयोग', 'Active', '2025-09-15'),
(137, 10, 'महाराष्ट्र राज्य महिला आयोग', 'Active', '2025-09-15'),
(138, 12, 'अन्‍न, नागरी पुरवठा व ग्राहक संरक्षण विभाग', 'Active', '2025-09-15'),
(139, 12, 'अल्पसंख्याक विकास विभाग', 'Active', '2025-09-15'),
(140, 12, 'आदिवासी विकास विभाग', 'Active', '2025-09-15'),
(141, 12, 'इतर मागास बहुजन कल्याण विभाग', 'Active', '2025-09-15'),
(142, 12, 'उच्च व तंत्र शिक्षण विभाग', 'Active', '2025-09-15'),
(143, 12, 'उद्योग, उर्जा व कामगार विभाग', 'Active', '2025-09-15'),
(144, 12, 'कृषी विभाग', 'Active', '2025-09-15'),
(145, 12, 'पशुसंवर्धन विभाग', 'Active', '2025-09-15'),
(146, 12, ' मत्‍स्‍यव्‍यवसाय विभाग', 'Active', '2025-09-15'),
(147, 12, 'कौशल्य विकास व उदयोजकता विभाग', 'Active', '2025-09-15'),
(148, 12, 'ग्राम विकास विभाग', 'Active', '2025-09-15'),
(149, 12, 'गृह विभाग', 'Active', '2025-09-15'),
(150, 12, 'गृहनिर्माण विभाग', 'Active', '2025-09-15'),
(151, 12, 'जलसंपदा विभाग', 'Active', '2025-09-15'),
(152, 12, 'दिव्यांग कल्याण विभाग', 'Active', '2025-09-15'),
(153, 12, 'नगर विकास विभाग', 'Active', '2025-09-15'),
(154, 12, 'नियोजन विभाग', 'Active', '2025-09-15'),
(155, 12, 'पर्यटन व सांस्कृतिक कार्य विभाग', 'Active', '2025-09-15'),
(156, 12, 'पर्यावरण विभाग', 'Active', '2025-09-15'),
(157, 12, 'पाणीपुरवठा व स्वच्छता विभाग', 'Active', '2025-09-15'),
(158, 12, 'मृद व जलसंधारण विभाग', 'Active', '2025-09-15'),
(159, 12, 'मराठी भाषा विभाग', 'Active', '2025-09-15'),
(160, 12, 'महसूल विभाग', 'Active', '2025-09-15'),
(161, 12, 'वन विभाग', 'Active', '2025-09-15'),
(162, 12, 'महिला व बाल विकास विभाग', 'Active', '2025-09-15'),
(163, 12, 'माहिती तंत्रज्ञान (सा.प्र.वि.) विभाग', 'Active', '2025-09-15'),
(164, 12, 'वैद्यकीय शिक्षण व औषधी द्रव्‍ये विभाग', 'Active', '2025-09-15'),
(165, 12, 'वित्त विभाग', 'Active', '2025-09-15'),
(166, 12, 'विधी व न्याय विभाग', 'Active', '2025-09-15'),
(167, 12, 'क्रीडा विभाग', 'Active', '2025-09-15'),
(168, 12, 'शालेय शिक्षण विभाग', 'Active', '2025-09-15'),
(169, 12, 'सहकार, पणन विभाग', 'Active', '2025-09-15'),
(170, 12, 'वस्‍त्रोद्योग विभाग', 'Active', '2025-09-15'),
(171, 12, 'सामाजिक न्‍याय व विशेष सहाय्य विभाग', 'Active', '2025-09-15'),
(172, 12, 'सामान्य प्रशासन विभाग', 'Active', '2025-09-15'),
(173, 12, 'सार्वजनिक आरोग्य विभाग', 'Active', '2025-09-15'),
(174, 12, 'सार्वजनिक बांधकाम विभाग', 'Active', '2025-09-15'),
(175, 13, 'Agricultural', 'Active', '2025-09-15'),
(176, 13, 'Transport', 'Active', '2025-09-15'),
(177, 13, 'Post', 'Active', '2025-09-15'),
(178, 13, 'Judicial', 'Active', '2025-09-15'),
(179, 13, 'Police', 'Active', '2025-09-15'),
(180, 13, 'Education', 'Active', '2025-09-15'),
(181, 13, 'Gram Vikas', 'Active', '2025-09-15'),
(182, 13, 'Health', 'Active', '2025-09-15'),
(183, 13, 'Disaster Management App', 'Active', '2025-09-15'),
(184, 13, 'Election', 'Active', '2025-09-15'),
(185, 13, 'RTS services', 'Active', '2025-09-15'),
(186, 13, 'Forest', 'Active', '2025-09-15'),
(187, 13, 'Disability health management', 'Active', '2025-09-15'),
(188, 13, 'EGS', 'Active', '2025-09-15'),
(189, 13, 'Consumer', 'Active', '2025-09-15'),
(190, 13, 'Tresury', 'Active', '2025-09-15'),
(191, 13, 'Pension', 'Active', '2025-09-15'),
(192, 13, 'Civil services Capacity Building', 'Active', '2025-09-15'),
(193, 13, 'Engery', 'Active', '2025-09-15'),
(194, 13, 'Revenue', 'Active', '2025-09-15'),
(195, 13, 'Mudrank Vibhag', 'Active', '2025-09-15'),
(196, 13, 'PWD', 'Active', '2025-09-15'),
(197, 13, 'e Goverance services', 'Active', '2025-09-15'),
(198, 13, 'Digital documents', 'Active', '2025-09-15'),
(199, 13, 'Passport', 'Active', '2025-09-15'),
(200, 13, 'Aadhar', 'Active', '2025-09-15'),
(201, 13, 'Translation app', 'Active', '2025-09-15'),
(202, 13, 'Digital Payments', 'Active', '2025-09-15'),
(203, 13, 'Telecummunication', 'Active', '2025-09-15'),
(204, 13, 'Messaging ', 'Active', '2025-09-15'),
(205, 13, 'Emergency Communication', 'Active', '2025-09-15'),
(206, 13, 'Income Tax', 'Active', '2025-09-15'),
(207, 13, 'Mantrlaya entry', 'Active', '2025-09-15'),
(208, 8, 'माहितीचा अधिकार अधिनियम 2005', 'Active', '2025-09-17'),
(209, 8, 'महाराष्ट्र माहिती अधिकार नियम, 2005', 'Active', '2025-09-17'),
(210, 8, 'अपीलाची कार्यपध्दती', 'Active', '2025-09-17'),
(211, 8, 'वारंवार विचारले जाणारे प्रश्न ', 'Active', '2025-09-17'),
(212, 2, 'लेखा व कोषागार संचलनालय', 'Active', '2025-10-09'),
(213, 2, 'एकात्मिक प्रकल्प व्यवस्थापन कक्ष महसूल विभाग', 'Active', '2025-10-09'),
(214, 2, 'महाराष्ट्र गृह निर्माण व क्षेत्रविकास प्राधिकरण', 'Active', '2025-10-09'),
(215, 2, 'नोंदणी व मुद्रांक  विभाग', 'Active', '2025-10-09'),
(216, 2, 'महाराष्ट्र राज्य साहित्य आणि संस्कृती मंडळ', 'Active', '2025-10-09'),
(217, 2, 'National Portal of India', 'Active', '2025-10-09'),
(218, 2, 'राष्ट्रीय e - पुस्तकालय', 'Active', '2025-10-09'),
(219, 2, 'दर्शनिका विभागाच्या प्रकाशनाची यादी', 'Active', '2025-10-09'),
(220, 2, 'भाषा संचालनालयाच्या प्रकाशनाची यादी', 'Active', '2025-10-09'),
(221, 2, 'वित्त विभागाच्या प्रकाशनाची यादी', 'Active', '2025-10-09'),
(222, 2, 'शिक्षण विभागाच्या प्रकाशनाची यादी', 'Active', '2025-10-09'),
(223, 2, 'इतर प्रकाशने', 'Active', '2025-10-09'),
(224, 4, 'Festival Advance Form', 'Active', '2025-10-09'),
(225, 4, 'Earned Leave Application Form', 'Active', '2025-10-09'),
(226, 4, 'Medical Reimbursement Form', 'Active', '2025-10-09'),
(227, 4, 'Matta Va Dayitva', 'Active', '2025-10-09'),
(228, 4, 'No Objection Certificate for obtaining Passport', 'Active', '2025-10-09'),
(229, 4, 'Charge Transfer Certificate Gazeted Officer', 'Active', '2025-10-09'),
(230, 4, 'Charge Transfer Certificate Non Gazeted Officer', 'Active', '2025-10-09'),
(231, 4, 'Budget Estimation Form', 'Active', '2025-10-09'),
(232, 4, 'Form M.T.R. -45-A', 'Active', '2025-10-09'),
(233, 4, 'Transfer Application Form', 'Active', '2025-10-09'),
(234, 4, ' Seeking Permission for Purchasing of Property', 'Active', '2025-10-09'),
(235, 4, 'Contingency expenses (Annexure 29)', 'Active', '2025-10-09'),
(236, 5, 'सहकार, पणन व वस्‍त्रोद्योग विभाग', 'Active', '2025-10-13'),
(237, 5, 'विधी व न्याय विभाग', 'Active', '2025-10-13'),
(238, 5, 'आदिवासी विकास विभाग', 'Active', '2025-10-13'),
(239, 5, 'कौशल्य, रोजगार, उद्योजकता व नविन्यता विभाग ', 'Active', '2025-10-13'),
(240, 5, 'कृषी, पशुसंवर्धन, दुग्‍धव्‍यवसाय विकास व मत्‍स्‍यव्‍यवसाय विभाग', 'Active', '2025-10-13'),
(241, 5, ' ग्रामविकास व पंचायत राज विभाग', 'Active', '2025-10-13'),
(242, 5, 'गृहनिर्माण विभाग', 'Active', '2025-10-13'),
(243, 5, 'जलसंपदा विभाग', 'Active', '2025-10-13'),
(244, 5, 'दिव्यांग कल्याण विभाग', 'Active', '2025-10-13'),
(245, 5, 'नगर विकास विभाग', 'Active', '2025-10-13'),
(246, 5, 'नियोजन विभाग', 'Active', '2025-10-13'),
(247, 5, 'पाणी पुरवठा व स्वच्छता विभाग', 'Active', '2025-10-13'),
(248, 5, 'सार्वजनिक आरोग्य विभाग', 'Active', '2025-10-13'),
(249, 5, 'सार्वजनिक बांधकाम विभाग', 'Active', '2025-10-13'),
(250, 5, 'संसदीय कार्य विभाग', 'Active', '2025-10-13'),
(251, 5, 'राज्य उत्पादन शुल्क विभाग', 'Active', '2025-10-13'),
(252, 5, 'भूजल सर्वेक्षण आणि विकास यंत्रणा', 'Active', '2025-10-13'),
(253, 5, 'महाराष्ट्र मेरिटाइम बोर्ड', 'Active', '2025-10-13'),
(254, 5, 'माहिती जनसंपर्क महासंचालनालय', 'Active', '2025-10-13'),
(255, 5, 'महाराष्ट्र राज्य परीक्षा परिषद, पुणे', 'Active', '2025-10-13'),
(256, 5, 'चॅरिटी कमिश्नर कार्यालय', 'Active', '2025-10-13'),
(257, 5, 'महाराष्ट्र जलसंपदा महामंडळ औरंगाबाद', 'Active', '2025-10-13'),
(258, 5, 'आगरी समाज आर्थिक विकास महामंडळ', 'Active', '2025-10-13'),
(259, 5, 'झोपडपट्टी पुनर्वसन प्राधिकरण, मुंबई', 'Active', '2025-10-13');

-- --------------------------------------------------------

--
-- Table structure for table `districts`
--

CREATE TABLE `districts` (
  `district_id` int(11) NOT NULL,
  `district_name` text DEFAULT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `districts`
--

INSERT INTO `districts` (`district_id`, `district_name`, `status`, `timestamp`) VALUES
(1, 'Mumbai', 'Active', '2025-08-07 10:05:23'),
(2, 'Pune', 'Active', '2025-08-07 10:05:23'),
(3, 'Nagpur', 'Active', '2025-08-07 10:05:23'),
(4, 'Thane', 'Active', '2025-08-07 10:05:23'),
(5, 'Nashik', 'Active', '2025-08-07 10:05:23'),
(6, 'Aurangabad', 'Active', '2025-08-07 10:05:23'),
(7, 'Solapur', 'Active', '2025-08-07 10:05:23'),
(8, 'Kolhapur', 'Active', '2025-08-07 10:05:23'),
(9, 'Amravati', 'Active', '2025-08-07 10:05:23'),
(10, 'Nanded', 'Active', '2025-08-07 10:05:23'),
(11, 'Sangli', 'Active', '2025-08-07 10:05:23'),
(12, 'Jalgaon', 'Active', '2025-08-07 10:05:23'),
(13, 'Akola', 'Active', '2025-08-07 10:05:23'),
(14, 'Latur', 'Active', '2025-08-07 10:05:23'),
(15, 'Dhule', 'Active', '2025-08-07 10:05:23'),
(16, 'Ahmednagar', 'Active', '2025-08-07 10:05:23'),
(17, 'Chandrapur', 'Active', '2025-08-07 10:05:23'),
(18, 'Jalna', 'Active', '2025-08-07 10:05:23'),
(19, 'Parbhani', 'Active', '2025-08-07 10:05:23'),
(20, 'Buldhana', 'Active', '2025-08-07 10:05:23'),
(21, 'Yavatmal', 'Active', '2025-08-07 10:05:23'),
(22, 'Osmanabad', 'Active', '2025-08-07 10:05:23'),
(23, 'Nandurbar', 'Active', '2025-08-07 10:05:23'),
(24, 'Washim', 'Active', '2025-08-07 10:05:23'),
(25, 'Hingoli', 'Active', '2025-08-07 10:05:23'),
(26, 'Gadchiroli', 'Active', '2025-08-07 10:05:23'),
(27, 'Bhandara', 'Active', '2025-08-07 10:05:23'),
(28, 'Gondia', 'Active', '2025-08-07 10:05:23'),
(29, 'Wardha', 'Active', '2025-08-07 10:05:23'),
(30, 'Ratnagiri', 'Active', '2025-08-07 10:05:23'),
(31, 'Sindhudurg', 'Active', '2025-08-07 10:05:23'),
(32, 'Raigad', 'Active', '2025-08-07 10:05:23'),
(33, 'Satara', 'Active', '2025-08-07 10:05:23'),
(34, 'Beed', 'Active', '2025-08-07 10:05:23'),
(35, 'Usmanabad', 'Active', '2025-08-07 10:05:23'),
(36, 'Bid', 'Active', '2025-08-07 10:05:23');

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `document_id` int(11) NOT NULL,
  `title` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `file_type` text DEFAULT NULL,
  `file_url` text DEFAULT NULL,
  `gr_date` text DEFAULT NULL,
  `uploaded_by` int(11) DEFAULT NULL,
  `upload_date` datetime DEFAULT current_timestamp(),
  `status` enum('Active','Inactive') DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `documents`
--

INSERT INTO `documents` (`document_id`, `title`, `description`, `category_id`, `file_type`, `file_url`, `gr_date`, `uploaded_by`, `upload_date`, `status`, `timestamp`) VALUES
(1, 'demo', 'test functionality', 13, '', 'uploads/Revenue/Forest GR and notifications App.pdf', NULL, NULL, '2025-06-26 00:00:00', NULL, '2025-06-26 04:48:17'),
(2, 'demo', 'test', 2, '', 'uploads/Accounts/Forest GR and notifications App.pdf', NULL, NULL, '2025-06-11 00:00:00', NULL, '2025-06-26 06:13:08'),
(3, 'test', 'dewfew', 13, 'image/jpeg', 'uploads/Revenue/pallavi-palaskar.JPG', '2025-06-04', NULL, '2025-06-04 00:00:00', NULL, '2025-06-26 06:18:22');

-- --------------------------------------------------------

--
-- Table structure for table `document_access_logs`
--

CREATE TABLE `document_access_logs` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `document_id` int(11) DEFAULT NULL,
  `access_time` datetime DEFAULT current_timestamp(),
  `status` enum('Active','Inactive') DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `gr_master`
--

CREATE TABLE `gr_master` (
  `gr_id` int(11) NOT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `sub_category_id` int(11) DEFAULT NULL,
  `gr_name` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gr_link` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_upload_location` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('Active','Inactive') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `timestamp` text COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `gr_master`
--

INSERT INTO `gr_master` (`gr_id`, `subject_id`, `category_id`, `sub_category_id`, `gr_name`, `gr_link`, `date`, `file_upload_location`, `status`, `timestamp`) VALUES
(1, 8, 208, 0, '', 'file:///C:/Users/Admin/Desktop/PDF%20NEW%20WORK%202025/New%20folder/RTI%20Acts_MR.pdf', '', NULL, 'Active', '2025-09-17'),
(2, 8, 209, 0, '', 'https://rti.maharashtra.gov.in/downloadcircular.action?fname=Maharashtra+Right+to+Information+Rule-11-11-2005.pdf', '', 'upload/माहितीचा_अधिकार/gr_2_1759999170_downloadcircular.action', 'Active', '2025-09-17'),
(3, 8, 119, 0, 'रिट याचिका क्र.990/2021 प्रकरणी मा.सर्वोच्च न्यायालयाने दिलेल्या आदेशानुसार माहितीचा अधिकार अधिनियम 2005 मधील कलम 4 च्या अंमलबजावणीबाबत...', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/202403041624338207.pdf', '04-03-2024', 'upload/माहितीचा_अधिकार/gr_3_1759999172_202403041624338207.pdf', 'Active', '2025-09-17'),
(4, 8, 119, 0, 'माहितीचा अधिकार अधिनियम 2005 च्या कलम 4(1)(क) व (ख) च्या अंमलबजावणीबाबत', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/202302161636459507.pdf', '16-02-2023', 'upload/माहितीचा_अधिकार/gr_4_1759999173_202302161636459507.pdf', 'Active', '2025-09-17'),
(5, 8, 119, 0, 'माहिती अधिकार अधिनियम, २००५ अंतर्गत कोणतीही माहिती विचारल्यानंतर जो पर्यंत त्यावर अंतिम न्यायनिर्णय होत नाही तोपर्यंत माहिती सुरक्षित ठेवणे :', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/202208251707084807.pdf', '25-08-2022', NULL, 'Active', '2025-09-17'),
(6, 8, 119, 0, 'मा. राज्य मुख्य माहिती आयुक्त यांना सेवानिवृत्ती नंतर दूरध्वनी भत्ता :', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/201903191244177607.pdf', '19-03-2019', 'upload/माहितीचा_अधिकार/gr_6_1759999175_201903191244177607.pdf', 'Active', '2025-09-17'),
(7, 8, 119, 0, 'माहितीचा अधिकार अधिनियम, २००५, महाराष्ट्र राज्य माहिती आयोगातील राज्य मुख्य माहिती आयुक्त / राज्य माहिती आयुक्त पदावरील नियुक्तीसाठी शोध समितीची (सर्च कमिटी) स्थापना करणेबाबत :', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/201902221750445907.....pdf', '22-02-2019', 'upload/माहितीचा_अधिकार/gr_7_1759999175_201902221750445907____.pdf', 'Active', '2025-09-17'),
(8, 8, 119, 0, 'माहितीचा अधिकार अधिनियम 2005 च्या कलम 4(1) (क) व (ख) च्या अंमलबजावणीबाबत', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/201902121708381107.pdf', '12-02-2019', 'upload/माहितीचा_अधिकार/gr_8_1759999176_201902121708381107.pdf', 'Active', '2025-09-17'),
(9, 8, 119, 0, 'माहितीचा अधिकार अधिनियम, 2005 नागरिकांना अवलोकनासाठी अभिलेख उपलब्ध करुन देणेबाबत.', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/201811261528353707.pdf', '26-11-2018', 'upload/माहितीचा_अधिकार/gr_9_1759999178_201811261528353707.pdf', 'Active', '2025-09-17'),
(10, 8, 119, 0, 'माहितीचा अधिकार अधिनियम, 2005- दर आठवडयास नागरिकांना अवलोकनासाठी अभिलेख उपलब्ध करुन देणे या प्रयोगाची सार्वत्रिक अंमलजावणी करावी किंवा कसे याचा अभ्यास करण्यासाठी राज्यस्तरीय समितीची स्थापना.', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/201902131538445007.pdf', '26-11-2018', 'upload/माहितीचा_अधिकार/gr_10_1759999197_201902131538445007.pdf', 'Active', '2025-09-17'),
(11, 8, 119, 0, 'माहिती अधिकार अधिनियमाच्या कलम ४ ची प्रभावी अंमलबजावणी सर्व सार्वजनिक प्राधीकरणांकडून होणेवावत:', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/201804201521570607.pdf', '13-04-2018', 'upload/माहितीचा_अधिकार/gr_11_1759999198_201804201521570607.pdf', 'Active', '2025-09-17'),
(12, 8, 119, 0, 'माहितीच्या शुल्काची रक्कम अर्जदारास टपालखर्चासह कळविण्याबाबत आणि माहिती अधिकाराशी संबंधित पत्रव्यवहाराचा आढावा घेऊन त्यासाठी आवश्यक आर्थिक तरतूद करणे :', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/201711171132293007.pdf', '17-11-2017', 'upload/माहितीचा_अधिकार/gr_12_1759999219_201711171132293007.pdf', 'Active', '2025-09-17'),
(13, 8, 119, 0, 'मा. राज्य मुख्य माहिती आयुक्त यांना माहितीचा अधिकार अधिनियम, 2005 कलम 15(4) अन्वये स्वायत्त अधिकार असल्याबाबत.', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/201704121238171107.pdf', '12-04-2017', 'upload/माहितीचा_अधिकार/gr_13_1759999219_201704121238171107.pdf', 'Active', '2025-09-17'),
(14, 8, 119, 0, 'राज्य माहिती आयोगाने माहिती अधिकार अधिनियम, २००५ च्या प्रभावी अंमलबजावणीसाठी शासनास केलेल्या शिफारशींचे अनुपालन करणे :', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/201702011555408107.pdf', '01-02-2017', 'upload/माहितीचा_अधिकार/gr_14_1759999234_201702011555408107.pdf', 'Active', '2025-09-17'),
(15, 8, 119, 0, 'Regarding holding a form for feedback to every public authority.pdf', 'https://rti.maharashtra.gov.in/downloadcircular.action?fname=Regarding+holding+a+form+for+feedback+to+every+public+authority.pdf', '23-11-2016', 'upload/माहितीचा_अधिकार/gr_15_1759999236_downloadcircular.action', 'Active', '2025-09-17'),
(16, 8, 119, 0, 'माहितीचा अधिकार अधिनियम,2005 अंतर्गत मा.मंत्री/राज्यमंत्री यांचे कार्यालयात जन माहिती अधिकारी व अपिलीय प्राधिकारी पदनिर्देशित करणेबाबत.', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/201610141751058007.pdf', '13-10-2016', 'upload/माहितीचा_अधिकार/gr_16_1759999236_201610141751058007.pdf', 'Active', '2025-09-17'),
(17, 8, 119, 0, 'Public authority has information on itself or on a social basis.pdf', 'https://rti.maharashtra.gov.in/downloadcircular.action?fname=Public+authority+has+information+on+itself+or+on+a+social+basis.pdf', '12-07-2016', 'upload/माहितीचा_अधिकार/gr_17_1759999237_downloadcircular.action', 'Active', '2025-09-17'),
(18, 8, 119, 0, 'The provisions under section 4 of the Right to Information Act 2005.pdf', 'https://rti.maharashtra.gov.in/downloadcircular.action?fname=The+provisions+under+section+4+of+the+Right+to+Information+Act+2005.pdf', '01-04-2016', 'upload/माहितीचा_अधिकार/gr_18_1759999238_downloadcircular.action', 'Active', '2025-09-17'),
(19, 8, 119, 0, 'Regarding specific issues of citizens under the Right to Information Act.pdf', 'https://rti.maharashtra.gov.in/downloadcircular.action?fname=Regarding+specific+issues+of+citizens+under+the+Right+to+Information+Act.pdf', '08-03-2016', 'upload/माहितीचा_अधिकार/gr_19_1759999240_downloadcircular.action', 'Active', '2025-09-17'),
(20, 8, 119, 0, 'Circular regarding recommendation of expert commitee on proactive disclosures.pdf ', 'https://rti.maharashtra.gov.in/downloadcircular.action?fname=Circular+regarding+recommendation+of+expert+commitee+on+proactive+disclosures.pdf', '16-03-2016', 'upload/माहितीचा_अधिकार/gr_20_1759999258_downloadcircular.action', 'Active', '2025-09-17'),
(21, 8, 119, 0, 'Section 4 of the Right to Information Act, 2005.pdf', 'https://rti.maharashtra.gov.in/downloadcircular.action?fname=Section+4+of+the+Right+to+Information+Act%2C+2005.pdf', '16-03-2016', 'upload/माहितीचा_अधिकार/gr_21_1759999260_downloadcircular.action', 'Active', '2025-09-17'),
(22, 8, 119, 0, 'माहिती अधिकार अधिनियम २००५ अंतर्गत स्वताःशीच संबंधीत माहिती अर्ज वा अपील अर्ज निकाली न काढण्याबाबत :', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/201609071521306407.pdf', '07-09-2016', 'upload/माहितीचा_अधिकार/gr_22_1759999265_201609071521306407.pdf', 'Active', '2025-09-17'),
(23, 8, 119, 0, 'माहिती अधिकार अधिनियम, २००५ च्या कलम ४ मधील तरतूदींच्या अंमल बजावणीबाबत :', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/201601281520167007.pdf', '28-01-2016', 'upload/माहितीचा_अधिकार/gr_23_1759999266_201601281520167007.pdf', 'Active', '2025-09-17'),
(24, 8, 119, 0, 'माहिती अधिकार अधिनियम २००५ अंतर्गत माहिती मागविणाऱ्या अर्जदारांकडून प्राप्त होण्याऱ्या अर्जाचे वेगळी नोंदवही ठेवणे', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/201609071402001507.pdf', '07-09-2016', 'upload/माहितीचा_अधिकार/gr_24_1759999267_201609071402001507.pdf', 'Active', '2025-09-17'),
(25, 8, 119, 0, 'माहिती अधिकार अधिनियम, २००५ अंतर्गत माहिती मागविणाऱ्या अर्जदारांना माहिती उपलब्ध करुन देणे:', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/201512191228090007.pdf', '19-12-2015', 'upload/माहितीचा_अधिकार/gr_25_1759999268_201512191228090007.pdf', 'Active', '2025-09-17'),
(26, 8, 119, 0, 'माहिती अधिकार अधिनियम, २००५ च्या अंमल बजावणीबाबत व्दितीय अपील सुनावणीस उपस्थित राहणे :', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/201512011221082807.pdf', '01-12-2015', 'upload/माहितीचा_अधिकार/gr_26_1759999269_201512011221082807.pdf', 'Active', '2025-09-17'),
(27, 8, 119, 0, 'माहिती अधिकार अधिनियम, २००५ च्या अंमलबजावणीबाबत :', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/201510261519331007.pdf', '26-10-2015', 'upload/माहितीचा_अधिकार/gr_27_1759999270_201510261519331007.pdf', 'Active', '2025-09-17'),
(28, 8, 119, 0, 'Regarding implementation of Right to Information Act 2005 dated 29-04-2015.pdf', 'https://rti.maharashtra.gov.in/downloadcircular.action?fname=Regarding+implementation+of+Right+to+Information+Act+2005+dated+29-04-2015.pdf', '29-04-2015', 'upload/माहितीचा_अधिकार/gr_28_1759999271_downloadcircular.action', 'Active', '2025-09-17'),
(29, 8, 119, 0, 'राज्य माहिती आयोगाकडून पारित होणारे निर्णय, निर्देश इत्यादिचे काटेकोरपणे पालन होण्याबाबत :', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/201502131313545207.pdf', '13-02-2015', 'upload/माहितीचा_अधिकार/gr_29_1759999271_201502131313545207.pdf', 'Active', '2025-09-17'),
(30, 8, 119, 0, 'Notification-bribery department under the Right to Information Act.pdf', 'https://rti.maharashtra.gov.in/downloadcircular.action?fname=Notification-bribery+department+under+the+Right+to+Information+Act.pdf', '31-10-2014', 'upload/माहितीचा_अधिकार/gr_30_1759999271_downloadcircular.action', 'Active', '2025-09-17'),
(31, 8, 119, 0, 'माहितीचा अधिकार अधिनियम, 2005 मधील तरतूदींनुसार व्यापक जनहिताशी संबंध नसलेली वैयक्तिक स्वरुपाची माहिती न पुरविण्याबाबत', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/201410171525492607.pdf', '17-10-2014', 'upload/माहितीचा_अधिकार/gr_31_1759999272_201410171525492607.pdf', 'Active', '2025-09-17'),
(32, 8, 119, 0, 'माहितीचा अधिकार अधिनियम 2005 मधील कलम 4 व 5 च्या अंमलबजावणीबाबत', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/201405091624543707.pdf', '09-05-2014', 'upload/माहितीचा_अधिकार/gr_32_1759999272_201405091624543707.pdf', 'Active', '2025-09-17'),
(33, 8, 119, 0, 'Notification regarding the application fee application form dated 23-04-2013.pdf', 'https://rti.maharashtra.gov.in/downloadcircular.action?fname=Notification+regarding+the+application+fee+application+form+dated+23-04-2013.pdf', '23-04-2023', 'upload/माहितीचा_अधिकार/gr_33_1759999281_downloadcircular.action', 'Active', '2025-09-17'),
(34, 8, 119, 0, 'Notification-Under Right to Information checking limit dated 31-12-2012.pdf', 'https://rti.maharashtra.gov.in/downloadcircular.action?fname=Notification-Under+Right+to+Information+checking+limit+dated+31-12-2012.pdf', '31-01-2010', 'upload/माहितीचा_अधिकार/gr_34_1759999282_downloadcircular.action', 'Active', '2025-09-17'),
(35, 8, 119, 0, 'माहितीचा अधिकार (सुधारणा) नियम,2012', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/201206120640320100.pdf', '31-05-2012', 'upload/माहितीचा_अधिकार/gr_35_1759999282_201206120640320100.pdf', 'Active', '2025-09-17'),
(36, 8, 119, 0, 'Notification-One request application should be related to one topic only_Dt_16-01-2012.pdf', 'https://rti.maharashtra.gov.in/downloadcircular.action?fname=Notification-One+request+application+should+be+related+to+one+topic+only_Dt_16-01-2012.pdf', '16-01-2012', 'upload/माहितीचा_अधिकार/gr_36_1759999283_downloadcircular.action', 'Active', '2025-09-17'),
(37, 8, 119, 0, 'माहितीचा अधिकार अधिनियम - २००५ कारीताचा बोध चिन्हा लोगोबाबत', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/20111122111414001.pdf', '22-11-2011', 'upload/माहितीचा_अधिकार/gr_37_1759999283_20111122111414001.pdf', 'Active', '2025-09-17'),
(38, 8, 119, 0, 'Force one exempted from RTI dated 23-08-2011.pdf', 'https://rti.maharashtra.gov.in/downloadcircular.action?fname=Force+one+exempted+from+RTI+dated+23-08-2011.pdf', '', 'upload/माहितीचा_अधिकार/gr_38_1759999284_downloadcircular.action', 'Active', '2025-09-17'),
(39, 8, 119, 0, 'जन माहिती अधिकारी व अपिलीय प्राधिकारी यांबाबतची माहिती विभागाच्या वेबसाईटवर प्रसिध्द करणेबाबत :', '', '12-01-2009', NULL, 'Active', '2025-09-17'),
(40, 8, 119, 0, 'Regarding the application received under the Right to Information Act 2005 appeals in the prescribed period 31-3-08.pdf', 'https://rti.maharashtra.gov.in/downloadcircular.action?fname=Regarding+the+application+received+under+the+Right+to+Information+Act+2005+appeals+in+the+prescribed+period+31-3-08.pdf', '31-03-2008', 'upload/माहितीचा_अधिकार/gr_40_1759999284_downloadcircular.action', 'Active', '2025-09-17'),
(41, 8, 119, 0, '२८ सप्टेंबर हा दिवस \"आंतरराष्ट्रीय माहिती अधिकार दिन\" म्हणून साजरा करणे :', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/20080920155318001.pdf', '20-09-2008', 'upload/माहितीचा_अधिकार/gr_41_1759999285_20080920155318001.pdf', 'Active', '2025-09-17'),
(42, 8, 119, 0, 'माहितीचा अधिकार अधिनियम, २००५ अंतर्गत प्राप्त होणाऱ्या अर्जासंदर्भात अकिफायतशीर पत्रव्यवहार टाळून विहीत मुदतीत अर्ज निकालात काढणे :', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/20080906142736001.pdf', '06-09-2008', 'upload/माहितीचा_अधिकार/gr_42_1759999285_20080906142736001.pdf', 'Active', '2025-09-17'),
(43, 8, 119, 0, 'राज्य माहिती आयोगाकडून पारीत होणारे निर्णय, निदेश इ. चे काटेकोरपणे पालन करणे बाबत :', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/20080610145000001.pdf', '10-06-2008', 'upload/माहितीचा_अधिकार/gr_43_1759999286_20080610145000001.pdf', 'Active', '2025-09-17'),
(44, 8, 119, 0, 'माहितीचा अधिकार अधिनियम २००५ अन्वये माहिती अधिकारी व अपिलीय अधिकारी यांच्या नावाचे फलक लावण्याबाबत :', '', '22-05-2008', NULL, 'Active', '2025-09-17'),
(45, 8, 119, 0, 'माहितीचा अधिकार अधिनियम, २००५ अन्वये माहिती अधिकारी व अपिलीय प्राधिकारी यांच्या नावाचे फलक लावणेबाबत ', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/20080516124714001.pdf', '15-05-2008', 'upload/माहितीचा_अधिकार/gr_45_1759999286_20080516124714001.pdf', 'Active', '2025-09-17'),
(46, 8, 119, 0, 'माहितीचा अधिकार अधिनियम २००५ संदर्भातील ठळक १० मुद्यांची माहितीः', '', '14-02-2008', NULL, 'Active', '2025-09-17'),
(47, 8, 119, 0, 'माहितीचा अधिकार अधिनियम 2005 मधील कलम 19 (1) अन्वये प्रथम अपिलीय अधिकारी यांची त्यांचेडे प्राप्त हााोरे सर्व अपीले विहित मुदतीत निकालात काढणेबाबत.', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/20071212164158001.pdf', '12-12-2007', 'upload/माहितीचा_अधिकार/gr_47_1759999288_20071212164158001.pdf', 'Active', '2025-09-17'),
(48, 8, 119, 0, 'माहितीचा अधिकार अधिनियम', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/20070531112540001.pdf', '31-05-2007', 'upload/माहितीचा_अधिकार/gr_48_1759999288_20070531112540001.pdf', 'Active', '2025-09-17'),
(49, 8, 119, 0, 'माहितीचा अधिकार अधिनियम', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/20070528123102001.pdf', '28-05-2007', 'upload/माहितीचा_अधिकार/gr_49_1759999288_20070528123102001.pdf', 'Active', '2025-09-17'),
(50, 8, 119, 0, 'केंद्र शासनाचा माहितीचा अधिकार अधिनियम', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/20051221174944001.pdf', '01-12-2005', 'upload/माहितीचा_अधिकार/gr_50_1759999289_20051221174944001.pdf', 'Active', '2025-09-17'),
(51, 8, 119, 0, 'केंद शासनाचा माहितीचा अधिकार अधिनियम, २००५ चा अंमलबजावणीच्या नियमांबाबत.', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/20051221174944001.pdf', '01-12-2005', 'upload/माहितीचा_अधिकार/gr_51_1759999290_20051221174944001.pdf', 'Active', '2025-09-17'),
(52, 8, 119, 0, 'केंद्र शासनाचा माहितीचा अधिकार अधिनियम', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/20050908142039001.pdf', '06-09-2005', 'upload/माहितीचा_अधिकार/gr_52_1759999290_20050908142039001.pdf', 'Active', '2025-09-17'),
(53, 8, 119, 0, 'महाराष्ट्र माहितीचा अधिकार अधिनियम 2002 - माहिती अधिकारी', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/20051018161019001.pdf', '10-08-2005', 'upload/माहितीचा_अधिकार/gr_53_1759999291_20051018161019001.pdf', 'Active', '2025-09-17'),
(54, 8, 119, 0, 'Telephone fax e-mail to the office of correspondence under information authority Dated 13-05-2009.pdf', 'https://rti.maharashtra.gov.in/downloadcircular.action?fname=Telephone+fax+e-mail+to+the+office+of+correspondence+under+information+authority+Dated+13-05-2009.pdf', '13-05-2009', 'upload/माहितीचा_अधिकार/gr_54_1759999291_downloadcircular.action', 'Active', '2025-09-17'),
(55, 8, 119, 0, 'माहितीचा अधिकार अधिनियम 2002 शासकीय माहिती अधिकारी / अपीलीय प्राधिकारी यांच्याविरुंध्दच्या तक्रारींबाबतची कार्यवाही', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/20050426172221001.pdf', '11-04-2005', 'upload/माहितीचा_अधिकार/gr_55_1759999292_20050426172221001.pdf', 'Active', '2025-09-17'),
(56, 8, 119, 0, 'महाराष्ट्र माहितीचा अधिकार अधिनियम 2002 अंतर्गत माहिती अधिका-याला नैसर्गिक न्यायाच्या तत्वानुसार अपिलीय प्राधिका-यांच्या आदेशाविरुंध्द दाद मागण्याबाबत', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/20050420112604001.pdf', '31-03-2005', 'upload/माहितीचा_अधिकार/gr_56_1759999293_20050420112604001.pdf', 'Active', '2025-09-17'),
(57, 8, 119, 0, 'महाराष्ट्र माहितीचा अधिकार अधिनियम 2002 अंतर्गत प्राप्त झालेल्या अर्जांची/अपिलांची माहिती पाठविणेबाबत', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/20050901130257001.pdf', '03-11-2004', 'upload/माहितीचा_अधिकार/gr_57_1759999293_20050901130257001.pdf', 'Active', '2025-09-17'),
(58, 8, 119, 0, 'महाराष्ट्र माहितीचा अधिकार अधिनियम', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/20041102144526001.pdf', '16-10-2004', 'upload/माहितीचा_अधिकार/gr_58_1759999294_20041102144526001.pdf', 'Active', '2025-09-17'),
(59, 8, 119, 0, 'महाराष्ट्र माहितीचा अधिकार अधिनियम', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/20040730161431001.pdf', '06-07-2004', 'upload/माहितीचा_अधिकार/gr_59_1759999300_20040730161431001.pdf', 'Active', '2025-09-17'),
(60, 8, 119, 0, 'महाराष्ट्र माहितीचा अधिकार अधिनियम 2002', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/20040805145247001.pdf', '24-06-2004', 'upload/माहितीचा_अधिकार/gr_60_1759999301_20040805145247001.pdf', 'Active', '2025-09-17'),
(61, 8, 119, 0, 'महाराष्ट्र माहितीचा अधिकार अधिनियम 2002 अंतर्गत उदभवणा-या शंकाचे निरसन/स्पष्टीकरण', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/20040730144725001.pdf', '22-06-2004', 'upload/माहितीचा_अधिकार/gr_61_1759999312_20040730144725001.pdf', 'Active', '2025-09-17'),
(62, 8, 119, 0, 'महाराष्ट्र माहितीचा अधिकार अधिनियम 2002 / अपिलिय अधिका-यांना सूचना निर्गमित करण्याबाबत', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/20040805145617001.pdf', '25-05-2004', 'upload/माहितीचा_अधिकार/gr_62_1759999312_20040805145617001.pdf', 'Active', '2025-09-17'),
(63, 8, 119, 0, 'माहितीचा अधिकार', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/20030910150337001.pdf', '14-08-2003', 'upload/माहितीचा_अधिकार/gr_63_1759999314_20030910150337001.pdf', 'Active', '2025-09-17'),
(64, 8, 210, 0, '', 'file:///C:/Users/Admin/Desktop/PDF%20NEW%20WORK%202025/New%20folder/Appeal%20Procedure.pdf', '', NULL, 'Active', '2025-09-17'),
(65, 8, 120, 0, 'ऑनलाईन आरटीआय  वापरकर्ता पुस्तिका', 'https://rtionline.maharashtra.gov.in/UMcitizen_Eng.pdf', '', 'upload/माहितीचा_अधिकार/gr_65_1759999327_UMcitizen_Eng.pdf', 'Active', '2025-09-17'),
(66, 8, 120, 0, ' माहितीच्या अधिकाराचा अर्ज दाखल करा /अपील करा', 'https://rtionline.maharashtra.gov.in/', '', 'upload/माहितीचा_अधिकार/gr_66_1759999355_document_66.pdf', 'Active', '2025-09-17'),
(67, 8, 120, 0, 'ऑनलाईन अर्जाची सद्य:स्थिती', 'https://rtionline.maharashtra.gov.in/request/status.php', '', 'upload/माहितीचा_अधिकार/gr_67_1759999355_status.php', 'Active', '2025-09-17'),
(68, 8, 120, 0, 'राज्य माहिती आयोगाकडे द्वितीय अपील ', 'http://sic.maharashtra.gov.in/siconline', '', 'upload/माहितीचा_अधिकार/gr_68_1759999355_document_68.pdf', 'Active', '2025-09-17'),
(69, 8, 211, 0, '', 'file:///C:/Users/Admin/Desktop/PDF%20NEW%20WORK%202025/New%20folder/FAQ_RTI.pdf', '', NULL, 'Active', '2025-09-17'),
(70, 1, 1, 4, 'Demo GR', 'https://gr.maharashtra.gov.in/Site/Upload/Government%20Resolutions/Marathi/201902221750445907.....pdf', '2025-10-09', 'upload/अधिसुचना/gr_70_1760000956_201902221750445907____.pdf', 'Active', '2025-10-09'),
(71, 4, 63, 0, 'HBA Check List ', 'https://mahakosh.maharashtra.gov.in/images/stories/HBA_Checklist.pdf', '2025-10-09', 'upload/कोषागार_नमुने/gr_71_1760005460_HBA_Checklist.pdf', 'Active', '2025-10-09'),
(72, 2, 212, 0, 'देयके वेळेत कशी पारित करावीत संपूर्ण पुस्तक ', 'देयके वेळेत कशी पारित करावीत संपूर्ण पुस्तक ', '', '', 'Active', '09-10-2025'),
(73, 2, 212, 0, 'वेतन पडताळणी मार्गदर्शिका संपूर्ण पुस्तक ', 'वेतन पडताळणी मार्गदर्शिका संपूर्ण पुस्तक ', '', '', 'Active', '09-10-2025'),
(74, 2, 25, 0, 'आरसीएमएस वापरकर्ता पुस्तिका (भाग 1)', 'https://cdnbbsr.s3waas.gov.in/s3e21e4e58ad9ab56e8a4634046da90113/uploads/2024/04/202404181779919910.pdf', '', 'upload/ई-बुक/gr_74_1760598924_202404181779919910.pdf', 'Active', '09-10-2025'),
(75, 2, 25, 0, 'आरसीएमएस वापरकर्ता पुस्तिका (भाग 2) ', 'https://cdnbbsr.s3waas.gov.in/s3e21e4e58ad9ab56e8a4634046da90113/uploads/2024/04/202404181097362309.pdf', '', 'upload/ई-बुक/gr_75_1760598927_202404181097362309.pdf', 'Active', '09-10-2025'),
(76, 2, 26, 0, 'विकासकाडे वाटचाल', 'https://cdnbbsr.s3waas.gov.in/s3ea80421fc06a2ed5c7adc1018e0026df/uploads/2025/03/202503161301778631.pdf', '', 'upload/ई-बुक/gr_76_1762092177_202503161301778631.pdf', 'Active', '09-10-2025'),
(77, 2, 26, 0, 'महाराष्ट्रातील सार्वजनिक बांधकाम विभागाच्या डिझाईन सर्कलमध्ये अवलंबली जाणारी सामान्य प्रक्रिया', 'https://pwd.maharashtra.gov.in/publication/%e0%a4%ae%e0%a4%b9%e0%a4%be%e0%a4%b0%e0%a4%be%e0%a4%b7%e0%a5%8d%e0%a4%9f%e0%a5%8d%e0%a4%b0%e0%a4%be%e0%a4%a4%e0%a5%80%e0%a4%b2-%e0%a4%b8%e0%a4%be%e0%a4%b0%e0%a5%8d%e0%a4%b5%e0%a4%9c%e0%a4%a8%e0%a4%bf/', '', 'upload/ई-बुक/gr_77_1762092178_document_77.pdf', 'Active', '09-10-2025'),
(78, 2, 26, 0, 'इंडियन रोड काँग्रेस विशेष प्रकाशन', 'https://pwd.maharashtra.gov.in/publication/%e0%a4%87%e0%a4%82%e0%a4%a1%e0%a4%bf%e0%a4%af%e0%a4%a8-%e0%a4%b0%e0%a5%8b%e0%a4%a1-%e0%a4%95%e0%a4%be%e0%a4%81%e0%a4%97%e0%a5%8d%e0%a4%b0%e0%a5%87%e0%a4%b8-%e0%a4%b5%e0%a4%bf%e0%a4%b6%e0%a5%87/', '', 'upload/ई-बुक/gr_78_1762092179_document_78.pdf', 'Active', '09-10-2025'),
(79, 2, 26, 0, 'सार्वजनिक बांधकाम विभागाचे पुणे विभागाचे सचिव (रस्ते) श्री के.एस. जांगडे आणि सीई श्री एस.बी. तामसेकर यांनी लिहिलेले पुस्तक', 'https://pwd.maharashtra.gov.in/publication/%e0%a4%b8%e0%a4%be%e0%a4%b0%e0%a5%8d%e0%a4%b5%e0%a4%9c%e0%a4%a8%e0%a4%bf%e0%a4%95-%e0%a4%ac%e0%a4%be%e0%a4%82%e0%a4%a7%e0%a4%95%e0%a4%be%e0%a4%ae-%e0%a4%b5%e0%a4%bf%e0%a4%ad%e0%a4%be%e0%a4%97-6/', '', 'upload/ई-बुक/gr_79_1762092180_document_79.pdf', 'Active', '09-10-2025'),
(80, 2, 26, 0, 'कालेलकर सारांश', 'https://pwd.maharashtra.gov.in/publication/%e0%a4%95%e0%a4%be%e0%a4%b2%e0%a5%87%e0%a4%b2%e0%a4%95%e0%a4%b0-%e0%a4%b8%e0%a4%be%e0%a4%b0%e0%a4%be%e0%a4%82%e0%a4%b6/', '', 'upload/ई-बुक/gr_80_1762092181_document_80.pdf', 'Active', '09-10-2025'),
(81, 2, 26, 0, 'सार्वजनिक बांधकाम विभाग, नियम पुस्तिका', 'https://pwd.maharashtra.gov.in/publication/%e0%a4%b8%e0%a4%be%e0%a4%b0%e0%a5%8d%e0%a4%b5%e0%a4%9c%e0%a4%a8%e0%a4%bf%e0%a4%95-%e0%a4%ac%e0%a4%be%e0%a4%82%e0%a4%a7%e0%a4%95%e0%a4%be%e0%a4%ae-%e0%a4%b5%e0%a4%bf%e0%a4%ad%e0%a4%be%e0%a4%97-5/', '', 'upload/ई-बुक/gr_81_1762092183_document_81.pdf', 'Active', '09-10-2025'),
(82, 2, 26, 0, 'सार्वजनिक बांधकाम विभाग, लेखा नियमावली', 'https://pwd.maharashtra.gov.in/publication/%e0%a4%b8%e0%a4%be%e0%a4%b0%e0%a5%8d%e0%a4%b5%e0%a4%9c%e0%a4%a8%e0%a4%bf%e0%a4%95-%e0%a4%ac%e0%a4%be%e0%a4%82%e0%a4%a7%e0%a4%95%e0%a4%be%e0%a4%ae-%e0%a4%b5%e0%a4%bf%e0%a4%ad%e0%a4%be%e0%a4%97-4/', '', 'upload/ई-बुक/gr_82_1762092183_document_82.pdf', 'Active', '09-10-2025'),
(83, 2, 27, 0, 'महा आरोग्य संवाद', 'https://mahaarogyasamvadiec.in/e-book/', '', 'upload/ई-बुक/gr_83_1760599081_document_83.pdf', 'Active', '09-10-2025'),
(84, 2, 27, 0, 'आरोग्य योजना', 'https://mahaarogyasamvadiec.in/wp-content/uploads/2025/08/Arogya%20Yojana%20Booklet_11zon.pdf', '', 'upload/ई-बुक/gr_84_1760599083_Arogya_Yojana_Booklet_11zon.pdf', 'Active', '09-10-2025'),
(85, 2, 28, 0, 'विकासाच्या पाऊल खुणा - 2016', 'https://cdnbbsr.s3waas.gov.in/s3b090409688550f3cc93f4ed88ec6cafb/uploads/2024/12/20241220837230328.pdf', '', 'upload/ई-बुक/gr_85_1760599087_20241220837230328.pdf', 'Active', '09-10-2025'),
(86, 2, 28, 0, 'आरक्षण धोरण - 2016 ', 'https://cdnbbsr.s3waas.gov.in/s3b090409688550f3cc93f4ed88ec6cafb/uploads/2024/12/2024122048435383.pdf', '', 'upload/ई-बुक/gr_86_1760599087_2024122048435383.pdf', 'Active', '09-10-2025'),
(87, 2, 29, 0, 'मंत्रालयीन विभागांतील लिपिक टंकलेखक यांचेसाठी माहिती पुस्तिका ( मराठी ) ', 'https://cdnbbsr.s3waas.gov.in/s398e6f17209029f4ae6dc9d88ec8eac2c/uploads/2023/06/2023060471.pdf', '', 'upload/ई-बुक/gr_87_1760599088_2023060471.pdf', 'Active', '09-10-2025'),
(88, 2, 29, 0, 'कक्ष अधिकारी विभागीय परीक्षेसाठी मंत्रालयीन विभागांमधील महत्वाच्या विविध शासकीय योजनांची माहिती पुस्तिका (मराठी)', 'https://cdnbbsr.s3waas.gov.in/s398e6f17209029f4ae6dc9d88ec8eac2c/uploads/2023/06/2023060465-1.pdf', '', 'upload/ई-बुक/gr_88_1762092184_2023060465-1.pdf', 'Active', '09-10-2025'),
(89, 2, 29, 0, 'मंत्रालयीन विभागातील सर्वसाधारण लिपिकाची कर्तव्ये (इंग्रजी)', 'https://cdnbbsr.s3waas.gov.in/s398e6f17209029f4ae6dc9d88ec8eac2c/uploads/2023/06/2023060437.pdf', '', 'upload/ई-बुक/gr_89_1762092187_2023060437.pdf', 'Active', '09-10-2025'),
(90, 2, 29, 0, 'मंत्रालयीन विभागांतील सहायक यांचेसाठी माहिती पुस्तिका ( मराठी )', 'https://cdnbbsr.s3waas.gov.in/s398e6f17209029f4ae6dc9d88ec8eac2c/uploads/2023/06/2023060492.pdf', '', 'upload/ई-बुक/gr_90_1760599138_2023060492.pdf', 'Active', '09-10-2025'),
(91, 2, 29, 0, 'मंत्रालयीन विभागांतील कक्ष अधिकारी यांचेसाठी माहिती पुस्तिका ( मराठी )', 'https://cdnbbsr.s3waas.gov.in/s398e6f17209029f4ae6dc9d88ec8eac2c/uploads/2023/06/2023060421.pdf', '', 'upload/ई-बुक/gr_91_1762092188_2023060421.pdf', 'Active', '09-10-2025'),
(92, 2, 29, 0, 'टिप्पणी लेखन व पत्रव्यवहार ( मराठी )', 'https://cdnbbsr.s3waas.gov.in/s398e6f17209029f4ae6dc9d88ec8eac2c/uploads/2023/06/2023060442.pdf', '', 'upload/ई-बुक/gr_92_1760599164_2023060442.pdf', 'Active', '09-10-2025'),
(93, 2, 29, 0, 'मंत्रालयातील टिप्पणी लेखन व पत्रव्यवहार पुस्तक ( इंग्रजी )', 'https://cdnbbsr.s3waas.gov.in/s398e6f17209029f4ae6dc9d88ec8eac2c/uploads/2023/06/2023060434.pdf', '', 'upload/ई-बुक/gr_93_1760599164_2023060434.pdf', 'Active', '09-10-2025'),
(94, 2, 29, 0, 'कार्यालयीन कार्यपध्दतई नियमपुस्तिका ( मराठी )', 'https://cdnbbsr.s3waas.gov.in/s398e6f17209029f4ae6dc9d88ec8eac2c/uploads/2023/06/2023060465.pdf', '', 'upload/ई-बुक/gr_94_1760599164_2023060465.pdf', 'Active', '09-10-2025'),
(95, 2, 30, 0, 'Posco Conference.pdf', 'https://mscw.org.in/pdf/Posco%20Conference.pdf', '', 'upload/ई-बुक/gr_95_1760599165_Posco_Conference.pdf', 'Active', '09-10-2025'),
(96, 2, 30, 0, 'Criminal Law', 'https://mscw.org.in/pdf/Criminal%20Law%20(2)%20Final%20for%20Printing.pdf', '', 'upload/ई-बुक/gr_96_1760599168_Criminal_Law__2__Final_for_Printing.pdf', 'Active', '09-10-2025'),
(97, 2, 30, 0, 'DOMESTIC Violence', 'https://mscw.org.in/pdf/DOMESTIC%20Violence%20(3)%20Final%20for%20Printing.pdf', '', 'upload/ई-बुक/gr_97_1760599169_DOMESTIC_Violence__3__Final_for_Printing.pdf', 'Active', '09-10-2025'),
(98, 2, 30, 0, 'Family Law', 'https://mscw.org.in/pdf/Family%20Law%20(1)%20Final%20for%20Printing.pdf', '', 'upload/ई-बुक/gr_98_1760599170_Family_Law__1__Final_for_Printing.pdf', 'Active', '09-10-2025'),
(99, 2, 30, 0, 'NRI Marriges', 'https://mscw.org.in/pdf/NRI%20Marriges%20(8)%20Final%20for%20Printing.pdf', '', 'upload/ई-बुक/gr_99_1760599171_NRI_Marriges__8__Final_for_Printing.pdf', 'Active', '09-10-2025'),
(100, 2, 30, 0, 'PCPNDT', 'https://mscw.org.in/pdf/PCPNDT(7)%20Final%20for%20Printing.pdf', '', 'upload/ई-बुक/gr_100_1760599172_PCPNDT_7__Final_for_Printing.pdf', 'Active', '09-10-2025'),
(101, 2, 30, 0, 'SEXUAL HARRASEMENT ACT Office', 'https://mscw.org.in/pdf/SEXUAL%20HARRASEMENT%20ACT%20Office%20(5)%20Final%20for%20Printing.pdf', '', 'upload/ई-बुक/gr_101_1760599173_SEXUAL_HARRASEMENT_ACT_Office__5__Final_for_Printing.pdf', 'Active', '09-10-2025'),
(102, 2, 30, 0, 'Triple Talaq', 'https://mscw.org.in/pdf/Triple%20Talaq(9)%20Final%20for%20Printing.pdf', '', 'upload/ई-बुक/gr_102_1760599173_Triple_Talaq_9__Final_for_Printing.pdf', 'Active', '09-10-2025'),
(103, 2, 30, 0, 'Working Women Law', 'https://mscw.org.in/pdf/Working%20Women%20Law(6)%20Final%20for%20Printing.pdf', '', 'upload/ई-बुक/gr_103_1760599174_Working_Women_Law_6__Final_for_Printing.pdf', 'Active', '09-10-2025'),
(104, 2, 30, 0, 'NRI Conference', 'https://mscw.org.in/pdf/NRI%20Conference.pdf', '', 'upload/ई-बुक/gr_104_1760599175_NRI_Conference.pdf', 'Active', '09-10-2025'),
(105, 2, 30, 0, 'दिशा परिवर्तीनाची.', 'https://mscw.org.in/pdf/disha.pdf', '', 'upload/ई-बुक/gr_105_1760599178_disha.pdf', 'Active', '09-10-2025'),
(106, 2, 31, 0, 'सारथी उपक्रम', 'https://sarthi-maharashtragov.in/sarthimahitipustika3#df_button/1/', '', '', 'Active', '09-10-2025'),
(107, 2, 31, 0, 'ई - बुक', 'https://sarthi-maharashtragov.in/en/e-books', '', '', 'Active', '09-10-2025'),
(108, 2, 213, 0, 'एकात्मिक प्रकल्प व्यवस्थापन कक्ष महसूल विभाग', 'https://cdn.s3waas.gov.in/s33493894fa4ea036cfc6433c3e2ee63b0/uploads/2022/10/2022101225.pdf', '', 'upload/ई-बुक/gr_108_1760599182_2022101225.pdf', 'Active', '09-10-2025'),
(109, 2, 214, 0, 'महाराष्ट्र गृह निर्माण व क्षेत्रविकास प्राधिकरण', 'https://www.mhada.gov.in/en/content/assembly-session-mahiti-pustika', '', 'upload/ई-बुक/gr_109_1760599183_document_109.pdf', 'Active', '09-10-2025'),
(110, 2, 215, 0, 'नोंदणी व मुद्रांक  विभाग', 'https://igrmaharashtra.gov.in/pdf/sarathi_book.pdf', '', 'upload/ई-बुक/gr_110_1760600900_sarathi_book.pdf', 'Active', '09-10-2025'),
(111, 2, 216, 0, 'महाराष्ट्र राज्य साहित्य आणि संस्कृती मंडळ', 'https://sahitya.marathi.gov.in/%e0%a4%87-%e0%a4%ac%e0%a5%81%e0%a4%95-%e0%a4%a1%e0%a4%be%e0%a4%8a%e0%a4%a8%e0%a4%b2%e0%a5%8b%e0%a4%a1/', '', 'upload/ई-बुक/gr_111_1760600966_document_111.pdf', 'Active', '09-10-2025'),
(112, 2, 217, 0, 'National Portal of India', 'https://www.india.gov.in/my-government/documents/e-books', '', 'upload/ई-बुक/gr_112_1760600966_document_112.pdf', 'Active', '09-10-2025'),
(113, 2, 218, 0, 'राष्ट्रीय e - पुस्तकालय', 'https://ndl.education.gov.in/home', '', 'upload/ई-बुक/gr_113_1760600969_document_113.pdf', 'Active', '09-10-2025'),
(114, 2, 219, 0, 'दर्शनिका विभागाच्या प्रकाशनाची यादी', 'https://gazetteers.maharashtra.gov.in/cultural.maharashtra.gov.in/english/gazetteer/Latur_Site/CHAPTER/LATUR-Vol-1-Prakashan-list.pdf', '', 'upload/ई-बुक/gr_114_1762092191_LATUR-Vol-1-Prakashan-list.pdf', 'Active', '09-10-2025'),
(115, 2, 220, 0, 'भाषा संचालनालयाच्या प्रकाशनाची यादी', 'https://dgps.maharashtra.gov.in/FckUpload/Image/file/PDF/Bhasha_Sanchalnalayachi_Prakashane.pdf', '', 'upload/ई-बुक/gr_115_1762092192_Bhasha_Sanchalnalayachi_Prakashane.pdf', 'Active', '09-10-2025'),
(116, 2, 221, 0, 'वित्त विभागाच्या प्रकाशनाची यादी', 'https://dgps.maharashtra.gov.in/FckUpload/Image/file/PDF/Vitt_Vibhagachi_Prakashane.pdf', '', 'upload/ई-बुक/gr_116_1762092193_Vitt_Vibhagachi_Prakashane.pdf', 'Active', '09-10-2025'),
(117, 2, 222, 0, 'शिक्षण विभागाच्या प्रकाशनाची यादी', 'https://dgps.maharashtra.gov.in/FckUpload/Image/file/PDF/Shikshan_Vibhagachi_Prakashane.pdf', '', 'upload/ई-बुक/gr_117_1762092194_Shikshan_Vibhagachi_Prakashane.pdf', 'Active', '09-10-2025'),
(118, 2, 223, 0, 'इतर प्रकाशने', 'https://dgps.maharashtra.gov.in/FckUpload/Image/file/PDF/Etar_prakashane.pdf', '', 'upload/ई-बुक/gr_118_1762092195_Etar_prakashane.pdf', 'Active', '09-10-2025'),
(119, 2, 32, 0, 'ग्रंथसूची भाग १', 'https://dgps.maharashtra.gov.in/FckUpload/Image/file/Granthasuchi%20Part-1.pdf', '', 'upload/ई-बुक/gr_119_1762092196_Granthasuchi_Part-1.pdf', 'Active', '09-10-2025'),
(120, 2, 32, 0, 'ग्रंथसूची भाग २', 'https://dgps.maharashtra.gov.in/FckUpload/Image/file/Granthasuchi%20Part-2.pdf', '', 'upload/ई-बुक/gr_120_1762092198_Granthasuchi_Part-2.pdf', 'Active', '09-10-2025'),
(121, 4, 63, 0, 'HBA Check List ', 'https://mahakosh.maharashtra.gov.in/images/stories/HBA_Checklist.pdf', '', 'upload/कोषागार_नमुने/gr_121_1762092199_HBA_Checklist.pdf', 'Active', '09-10-2025'),
(122, 4, 63, 0, 'HBA Application Form', 'https://mahakosh.maharashtra.gov.in/images/stories/download/hba.pdf', '', 'upload/कोषागार_नमुने/gr_122_1762092206_hba.pdf', 'Active', '09-10-2025'),
(123, 4, 63, 0, 'Interest Rate of HBA & Vehichles Advances', 'https://mahakosh.maharashtra.gov.in/images/stories/circular/interest_rate_of_hba_and_vehicles_advances.pdf', '', 'upload/कोषागार_नमुने/gr_123_1762092208_interest_rate_of_hba_and_vehicles_advances.pdf', 'Active', '09-10-2025'),
(124, 4, 64, 0, 'Vehicle Advance Check List ', 'https://mahakosh.maharashtra.gov.in/images/stories/download/MCA_Check_List.pdf', '', 'upload/कोषागार_नमुने/gr_124_1762092208_MCA_Check_List.pdf', 'Active', '09-10-2025'),
(125, 4, 64, 0, 'MCA  Application Form in Marathi', 'https://mahakosh.maharashtra.gov.in/images/stories/download/MCA_Application.pdf', '', 'upload/कोषागार_नमुने/gr_125_1762092209_MCA_Application.pdf', 'Active', '09-10-2025'),
(126, 4, 64, 0, 'Circular regarding Vehicle Advance', 'https://mahakosh.maharashtra.gov.in/images/stories/download/MCA_Circular.pdf', '', 'upload/कोषागार_नमुने/gr_126_1762092210_MCA_Circular.pdf', 'Active', '09-10-2025'),
(127, 4, 64, 0, 'Computer Advance Check List ', 'https://mahakosh.maharashtra.gov.in/images/stories/Computer_Adv_Checklist.pdf', '', 'upload/कोषागार_नमुने/gr_127_1762092211_Computer_Adv_Checklist.pdf', 'Active', '09-10-2025'),
(128, 4, 65, 0, 'GPF-1 ', 'https://mahakosh.maharashtra.gov.in/images/stories/download/gpf_1.pdf', '', 'upload/कोषागार_नमुने/gr_128_1762092214_gpf_1.pdf', 'Active', '09-10-2025'),
(129, 4, 65, 0, 'GPF-2 ', 'https://mahakosh.maharashtra.gov.in/images/stories/download/gpf_2.pdf', '', 'upload/कोषागार_नमुने/gr_129_1762092215_gpf_2.pdf', 'Active', '09-10-2025'),
(130, 4, 65, 0, 'GPF-5', 'https://mahakosh.maharashtra.gov.in/images/stories/download/gpf_5.pdf', '', 'upload/कोषागार_नमुने/gr_130_1762092216_gpf_5.pdf', 'Active', '09-10-2025'),
(131, 4, 65, 0, 'GPF-Refundable', 'https://mahakosh.maharashtra.gov.in/images/stories/download/gpf_refundable.pdf', '', 'upload/कोषागार_नमुने/gr_131_1762092217_gpf_refundable.pdf', 'Active', '09-10-2025'),
(132, 4, 65, 0, 'GPF-Non Refundable ', 'https://mahakosh.maharashtra.gov.in/images/stories/download/gpf_non_refundable.pdf', '', 'upload/कोषागार_नमुने/gr_132_1762092218_gpf_non_refundable.pdf', 'Active', '09-10-2025'),
(133, 4, 66, 0, 'Departmental Data Sheet ', 'https://mahakosh.maharashtra.gov.in/images/stories/pension/deptdatasheet.pdf', '', 'upload/कोषागार_नमुने/gr_133_1762092219_deptdatasheet.pdf', 'Active', '09-10-2025'),
(134, 4, 66, 0, 'Form 1', 'https://mahakosh.maharashtra.gov.in/images/stories/pension/form1.pdf', '', 'upload/कोषागार_नमुने/gr_134_1762092219_form1.pdf', 'Active', '09-10-2025'),
(135, 4, 66, 0, 'Form 2', 'https://mahakosh.maharashtra.gov.in/images/stories/pension/form2.pdf', '', 'upload/कोषागार_नमुने/gr_135_1762092220_form2.pdf', 'Active', '09-10-2025'),
(136, 4, 66, 0, ' Form 3', 'https://mahakosh.maharashtra.gov.in/images/stories/pension/form3.pdf', '', 'upload/कोषागार_नमुने/gr_136_1762092220_form3.pdf', 'Active', '09-10-2025'),
(137, 4, 66, 0, '5. Form 4', 'https://mahakosh.maharashtra.gov.in/images/stories/pension/form4.pdf', '', 'upload/कोषागार_नमुने/gr_137_1762092220_form4.pdf', 'Active', '09-10-2025'),
(138, 4, 66, 0, 'Form 5', 'https://mahakosh.maharashtra.gov.in/images/stories/pension/form5.pdf', '', 'upload/कोषागार_नमुने/gr_138_1762092221_form5.pdf', 'Active', '09-10-2025'),
(139, 4, 66, 0, 'Life Certificate', 'https://mahakosh.maharashtra.gov.in/images/stories/pension/life_certificate.pdf', '', 'upload/कोषागार_नमुने/gr_139_1762092221_life_certificate.pdf', 'Active', '09-10-2025'),
(140, 4, 224, 0, '', 'https://mahakosh.maharashtra.gov.in/images/stories/download/fa.pdf', '', 'upload/कोषागार_नमुने/gr_140_1762092221_fa.pdf', 'Active', '09-10-2025'),
(141, 4, 225, 0, '', 'https://mahakosh.maharashtra.gov.in/images/stories/download/el.pdf', '', 'upload/कोषागार_नमुने/gr_141_1762092222_el.pdf', 'Active', '09-10-2025'),
(142, 4, 226, 0, '', 'https://mahakosh.maharashtra.gov.in/images/stories/download/medical_reimbursement_new_dated_250912.pdf', '', 'upload/कोषागार_नमुने/gr_142_1762092223_medical_reimbursement_new_dated_250912.pdf', 'Active', '09-10-2025'),
(143, 4, 227, 0, '', 'https://mahakosh.maharashtra.gov.in/images/stories/download/matta_va_dayittva.pdf', '', 'upload/कोषागार_नमुने/gr_143_1762092224_matta_va_dayittva.pdf', 'Active', '09-10-2025'),
(144, 4, 228, 0, '', 'https://mahakosh.maharashtra.gov.in/images/stories/download/passport_download_form.pdf', '', 'upload/कोषागार_नमुने/gr_144_1762092225_passport_download_form.pdf', 'Active', '09-10-2025'),
(145, 4, 229, 0, '', 'https://mahakosh.maharashtra.gov.in/images/stories/download/charge_transfer_certificate_gaz_officer_gen_93_m.pdf', '', 'upload/कोषागार_नमुने/gr_145_1762092225_charge_transfer_certificate_gaz_officer_gen_93_m.pdf', 'Active', '09-10-2025'),
(146, 4, 230, 0, '', 'https://mahakosh.maharashtra.gov.in/images/stories/download/charge_transfer_certificate_non_gaz_officer.pdf', '', 'upload/कोषागार_नमुने/gr_146_1762092226_charge_transfer_certificate_non_gaz_officer.pdf', 'Active', '09-10-2025'),
(147, 4, 231, 0, '', 'https://mahakosh.maharashtra.gov.in/images/stories/circular/budget_estimation_form.pdf', '', 'upload/कोषागार_नमुने/gr_147_1762092226_budget_estimation_form.pdf', 'Active', '09-10-2025'),
(148, 4, 232, 0, '', 'https://mahakosh.maharashtra.gov.in/images/stories/download/form_mtr_45a_dated_250612.pdf', '', 'upload/कोषागार_नमुने/gr_148_1762092229_form_mtr_45a_dated_250612.pdf', 'Active', '09-10-2025'),
(149, 4, 233, 0, '', 'https://mahakosh.maharashtra.gov.in/images/stories/circular/2016/transfer_app_2016.pdf', '', 'upload/कोषागार_नमुने/gr_149_1762092230_transfer_app_2016.pdf', 'Active', '09-10-2025'),
(150, 4, 234, 0, '', 'https://mahakosh.maharashtra.gov.in/images/stories/download/malmatta_kharedi_approval.pdf', '', 'upload/कोषागार_नमुने/gr_150_1762092231_malmatta_kharedi_approval.pdf', 'Active', '09-10-2025'),
(151, 4, 235, 0, '', 'https://mahakosh.maharashtra.gov.in/images/stories/download/annexure_29_dated_250612.pdf', '', 'upload/कोषागार_नमुने/gr_151_1762092231_annexure_29_dated_250612.pdf', 'Active', '09-10-2025'),
(152, 5, 67, 0, 'अन्न, नागरी पुरवठा व ग्राहक संरक्षण विभाग', 'https://cdnbbsr.s3waas.gov.in/s3e21e4e58ad9ab56e8a4634046da90113/uploads/2023/06/2023061494.pdf', '', 'upload/नागरिकांची_सनद/gr_152_1762092232_2023061494.pdf', 'Active', '09-10-2025'),
(153, 5, 67, 0, 'नियंत्रक शिधावाटप व संचालक नागरी पुरवठा कार्यालय', 'https://cdnbbsr.s3waas.gov.in/s3e21e4e58ad9ab56e8a4634046da90113/uploads/2023/06/2023061430.pdf', '', 'upload/नागरिकांची_सनद/gr_153_1762092236_2023061430.pdf', 'Active', '09-10-2025'),
(154, 5, 67, 0, 'नियंत्रक वैधमापनशास्त्र कार्यालय', 'https://cdnbbsr.s3waas.gov.in/s3e21e4e58ad9ab56e8a4634046da90113/uploads/2023/06/2023061428.pdf', '', 'upload/नागरिकांची_सनद/gr_154_1762092237_2023061428.pdf', 'Active', '09-10-2025'),
(155, 5, 68, 0, 'अल्पसंख्याक विकास विभाग', 'https://cdnbbsr.s3waas.gov.in/s3f55cadb97eaff2ba1980e001b0bd9842/uploads/2025/08/2025080133201765.pdf', '', 'upload/नागरिकांची_सनद/gr_155_1762092240_2025080133201765.pdf', 'Active', '09-10-2025'),
(156, 5, 68, 0, 'महाराष्ट्र राज्य अल्पसंख्यक आयोग', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/citizen-charter-minority-alp-aayog.pdf', '', 'upload/नागरिकांची_सनद/gr_156_1762092241_citizen-charter-minority-alp-aayog.pdf', 'Active', '09-10-2025'),
(157, 5, 69, 0, 'तंत्र शिक्षण संचालनालय', 'https://dte.maharashtra.gov.in/wp-content/uploads/2025/04/%E0%A4%A8%E0%A4%BE%E0%A4%97%E0%A4%B0%E0%A4%BF%E0%A4%95%E0%A4%BE%E0%A4%82%E0%A4%9A%E0%A5%80-%E0%A4%B8%E0%A4%A8%E0%A4%A6-2025Ver.1.pdf', '', 'upload/नागरिकांची_सनद/gr_157_1762092242_______________________________-_________-2025Ver_1.pdf', 'Active', '09-10-2025'),
(158, 5, 69, 0, 'उच्च व तंत्र शिक्षण विभाग', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/Citizen%20Charter_HTED.pdf', '', 'upload/नागरिकांची_सनद/gr_158_1762092243_Citizen_Charter_HTED.pdf', 'Active', '09-10-2025'),
(159, 5, 69, 0, 'व्यावसायिक शिक्षण प्रशिक्षण', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/charter-vocational-education.pdf', '', 'upload/नागरिकांची_सनद/gr_159_1762092243_charter-vocational-education.pdf', 'Active', '09-10-2025'),
(160, 5, 69, 0, 'ग्रंथालय संचालनालय', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/Directorate%20of%20Library1.pdf', '', 'upload/नागरिकांची_सनद/gr_160_1762092247_Directorate_of_Library1.pdf', 'Active', '09-10-2025'),
(161, 5, 70, 0, 'उद्योग प्रभाग खुद्द', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/Udyog%20Proper%20Citizen%20Charter.pdf', '', 'upload/नागरिकांची_सनद/gr_161_1762092250_Udyog_Proper_Citizen_Charter.pdf', 'Active', '09-10-2025'),
(162, 5, 70, 0, 'उद्योग, उर्जा, कामगार विभाग', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/6886NSanad.pdf', '', 'upload/नागरिकांची_सनद/gr_162_1762092251_6886NSanad.pdf', 'Active', '09-10-2025'),
(163, 5, 70, 0, 'उद्योग संचालनालय', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/Citizen%20Charter%202013_23122013.pdf', '', 'upload/नागरिकांची_सनद/gr_163_1762092251_Citizen_Charter_2013_23122013.pdf', 'Active', '09-10-2025'),
(164, 5, 70, 0, 'भूविज्ञान आणि खनिकर्म संचालनालय', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/bhuvidnyan_v_khanikama.pdf.', '', '', 'Active', '09-10-2025'),
(165, 5, 70, 0, 'महाराष्ट्र राज्य खादी व ग्रामोद्योग मंडळ', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/KHAADI_GRAMODYOG.pdf', '', 'upload/नागरिकांची_सनद/gr_165_1762092255_KHAADI_GRAMODYOG.pdf', 'Active', '09-10-2025'),
(166, 5, 70, 0, 'महाराष्ट्र पेट्रोकेमिकल्स महामंडळ', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/Nagrikachi%20Sanad%20Petrochemical_10092013.pdf', '', 'upload/नागरिकांची_सनद/gr_166_1762092256_Nagrikachi_Sanad_Petrochemical_10092013.pdf', 'Active', '09-10-2025'),
(167, 5, 70, 0, 'महाराष्ट्र लघुउद्योग विकास महामंडळ', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/LAGHU_UDYOG.pdf', '', 'upload/नागरिकांची_सनद/gr_167_1762092257_LAGHU_UDYOG.pdf', 'Active', '09-10-2025'),
(168, 5, 70, 0, 'शासकीय मुद्रण आणि लेखन सामग्री', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/babi%2017%20mahiti%202011%2071.pdf', '', 'upload/नागरिकांची_सनद/gr_168_1762092258_babi_17_mahiti_2011_71.pdf', 'Active', '09-10-2025'),
(169, 5, 70, 0, 'कार्यकारी अभियंता मऔविम मुंबई', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/Nagrikanchi_Sanad_Revised%5b2%5d.pdf', '', 'upload/नागरिकांची_सनद/gr_169_1762092259_Nagrikanchi_Sanad_Revised_2_.pdf', 'Active', '09-10-2025'),
(170, 5, 70, 0, 'विदर्भ विकास महामंडळ नागपूर', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/Citizen_Chattered2.pdf', '', 'upload/नागरिकांची_सनद/gr_170_1762092260_Citizen_Chattered2.pdf', 'Active', '09-10-2025'),
(171, 5, 70, 0, 'पश्चिम महाराष्ट्र विकास', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/paschim_maharashtra%20vikas.pdf', '', 'upload/नागरिकांची_सनद/gr_171_1762092261_paschim_maharashtra_vikas.pdf', 'Active', '09-10-2025'),
(172, 5, 70, 0, 'महाराष्ट्र राज्य खनिकर्म महामंडळ नागपूर', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/12%20MSMC.pdf', '', 'upload/नागरिकांची_सनद/gr_172_1762092261_12_MSMC.pdf', 'Active', '09-10-2025'),
(173, 5, 71, 0, 'कामगार विभाग', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/Kamgar%20Citizen%20Charter%20Final.pdf', '', 'upload/नागरिकांची_सनद/gr_173_1762092262_Kamgar_Citizen_Charter_Final.pdf', 'Active', '09-10-2025'),
(174, 5, 71, 0, 'कामगार आयुक्त, मुंबई', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/Labour_Commissioner_Mumbai.pdf', '', 'upload/नागरिकांची_सनद/gr_174_1762092263_Labour_Commissioner_Mumbai.pdf', 'Active', '09-10-2025'),
(175, 5, 71, 0, 'औद्योगिक सुरक्षा व आरोग्य संचालनालय, मुंबई', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/Directorate_of_Industrial_Security_and_Health_Mumbai.pdf', '', 'upload/नागरिकांची_सनद/gr_175_1762092266_Directorate_of_Industrial_Security_and_Health_Mumbai.pdf', 'Active', '09-10-2025'),
(176, 5, 71, 0, 'बाष्पके संचालनालय, मुंबई', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/Steam_Boiler.pdf', '', 'upload/नागरिकांची_सनद/gr_176_1762092267_Steam_Boiler.pdf', 'Active', '09-10-2025'),
(177, 5, 71, 0, 'औद्योगिक न्यायालय,मुंबई', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/Udyogik%20Nyayalaya%20Mumbai.pdf', '', 'upload/नागरिकांची_सनद/gr_177_1762092268_Udyogik_Nyayalaya_Mumbai.pdf', 'Active', '09-10-2025'),
(178, 5, 71, 0, 'महाराष्ट्र कामगार कल्याण मंडळ , मुंबई', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/nagrikanchi_sanad_KaamgarKalyanMandal.pdf', '', 'upload/नागरिकांची_सनद/gr_178_1762092268_nagrikanchi_sanad_KaamgarKalyanMandal.pdf', 'Active', '09-10-2025'),
(179, 5, 71, 0, 'कै. नारायण मेघाजी लोखंडे महाराष्ट्र श्रम विज्ञान संस्था, मुंबई', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/mils.pdf', '', 'upload/नागरिकांची_सनद/gr_179_1762092269_mils.pdf', 'Active', '09-10-2025'),
(180, 5, 72, 0, 'गृह विभाग खुद्द', 'https://cdnbbsr.s3waas.gov.in/s3a012869311d64a44b5a0d567cd20de04/uploads/2023/07/2023070496.pdf', '', 'upload/नागरिकांची_सनद/gr_180_1762092270_2023070496.pdf', 'Active', '09-10-2025'),
(181, 5, 72, 0, 'पोलिस आयुक्त बृहन्मुंबई कार्यालय', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/CP%20Sanad%202015.pdf', '', 'upload/नागरिकांची_सनद/gr_181_1762092270_CP_Sanad_2015.pdf', 'Active', '09-10-2025'),
(182, 5, 72, 0, 'तुरुंग', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/prision-citizen-charter.pdf', '', 'upload/नागरिकांची_सनद/gr_182_1762092271_prision-citizen-charter.pdf', 'Active', '09-10-2025'),
(183, 5, 72, 0, 'परिवहन ', 'https://transport.maharashtra.gov.in/Site/Upload/Pdf/CITIZEN-CHARTER.pdf', '', 'upload/नागरिकांची_सनद/gr_183_1762092272_CITIZEN-CHARTER.pdf', 'Active', '09-10-2025'),
(184, 5, 73, 0, 'नागरिकांची सनद भाग-1', 'https://cdnbbsr.s3waas.gov.in/s35e6bd7a6970cd4325e587f02667f7f73/uploads/2025/03/20250307828129690.pdf', '', 'upload/नागरिकांची_सनद/gr_184_1762092274_20250307828129690.pdf', 'Active', '09-10-2025'),
(185, 5, 73, 0, 'नागरिकांची सनद भाग-२', 'https://cdnbbsr.s3waas.gov.in/s35e6bd7a6970cd4325e587f02667f7f73/uploads/2025/03/20250307392956633.pdf', '', 'upload/नागरिकांची_सनद/gr_185_1762092331_20250307392956633.pdf', 'Active', '09-10-2025'),
(186, 5, 74, 0, 'नागरिक सनद वर्ष 2018', 'https://womenchild.maharashtra.gov.in/sites/default/files/inline-files/citizen_charter_year_2018.pdf', '', '', 'Active', '09-10-2025'),
(187, 5, 74, 0, 'नागरिक सनद वर्ष 2021', 'https://womenchild.maharashtra.gov.in/sites/default/files/inline-files/scan_nagrikanchi_sanad.pdf', '', '', 'Active', '09-10-2025'),
(188, 5, 75, 0, 'मराठी भाषा', 'https://marathi.gov.in/wp-content/uploads/2023/04/sanad2023.pdf', '', 'upload/नागरिकांची_सनद/gr_188_1762092334_sanad2023.pdf', 'Active', '09-10-2025'),
(189, 5, 75, 0, 'भाषा संचालनालय', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/charter-director-languages.pdf', '', 'upload/नागरिकांची_सनद/gr_189_1762092335_charter-director-languages.pdf', 'Active', '09-10-2025'),
(190, 5, 76, 0, 'वित्त विभाग ', 'https://cdnbbsr.s3waas.gov.in/s349d4b2faeb4b7b9e745775793141e2b2/uploads/2025/01/20250127491000486.pdf', '', 'upload/नागरिकांची_सनद/gr_190_1762092335_20250127491000486.pdf', 'Active', '09-10-2025'),
(191, 5, 76, 0, 'महाराष्ट्र राज्य लॉंटरी', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/charter-state-lottery.pdf', '', 'upload/नागरिकांची_सनद/gr_191_1762092336_charter-state-lottery.pdf', 'Active', '09-10-2025'),
(192, 5, 76, 0, 'शासकीय विमा निधी', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/charter-finance-tresury.pdf', '', 'upload/नागरिकांची_सनद/gr_192_1762092343_charter-finance-tresury.pdf', 'Active', '09-10-2025'),
(193, 5, 76, 0, 'स्थानिक निधी लेखा परीक्षा संचालनालय', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/fund.pdf', '', 'upload/नागरिकांची_सनद/gr_193_1762092345_fund.pdf', 'Active', '09-10-2025'),
(194, 5, 76, 0, 'विक्रीकर विभाग', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/Tax.pdf', '', 'upload/नागरिकांची_सनद/gr_194_1762092347_Tax.pdf', 'Active', '09-10-2025'),
(195, 5, 76, 0, 'अल्पबचत संचालनालय', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/Savings.pdf', '', 'upload/नागरिकांची_सनद/gr_195_1762092349_Savings.pdf', 'Active', '09-10-2025'),
(196, 5, 77, 0, 'शालेय शिक्षण व क्रीडा विभाग', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/CitizenCharter_Schoolandsport.pdf', '', 'upload/नागरिकांची_सनद/gr_196_1762092357_CitizenCharter_Schoolandsport.pdf', 'Active', '09-10-2025'),
(197, 5, 77, 0, 'माध्यमिक संचालनालय उच्च माध्यमिक', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/charter-directorate-of-secondary-higher-secondary.pdf', '', 'upload/नागरिकांची_सनद/gr_197_1762092359_charter-directorate-of-secondary-higher-secondary.pdf', 'Active', '09-10-2025'),
(198, 5, 77, 0, 'एसएससी बोर्ड', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/charter-ssc-board.pdf', '', 'upload/नागरिकांची_सनद/gr_198_1762092361_charter-ssc-board.pdf', 'Active', '09-10-2025');
INSERT INTO `gr_master` (`gr_id`, `subject_id`, `category_id`, `sub_category_id`, `gr_name`, `gr_link`, `date`, `file_upload_location`, `status`, `timestamp`) VALUES
(199, 5, 77, 0, 'SCERT बोर्ड', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/charter-scert.pdf', '', 'upload/नागरिकांची_सनद/gr_199_1762092363_charter-scert.pdf', 'Active', '09-10-2025'),
(200, 5, 78, 0, 'सामाजिक न्याय व विशेष सहाय्य विभाग', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/charter_social_justice_2012.pdf', '', 'upload/नागरिकांची_सनद/gr_200_1762092364_charter_social_justice_2012.pdf', 'Active', '09-10-2025'),
(201, 5, 78, 0, 'महाराष्ट्र राज्य इतर मागासवर्गीय वित्त आणि विकास महामंडळ मर्यादित', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/MS_OBC_FDCL_CC_2016.pdf', '', 'upload/नागरिकांची_सनद/gr_201_1762092366_MS_OBC_FDCL_CC_2016.pdf', 'Active', '09-10-2025'),
(202, 5, 79, 0, 'राज्यपालांचे परिवार प्रबंधक कार्यालय', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/Governor-Comptroller-establishment_07Sep2015.pdf', '', 'upload/नागरिकांची_सनद/gr_202_1762092368_Governor-Comptroller-establishment_07Sep2015.pdf', 'Active', '09-10-2025'),
(203, 5, 79, 0, 'राज्यपालांचे सचिवालय', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/Governors_Secretariat_08Sep2015.pdf', '', 'upload/नागरिकांची_सनद/gr_203_1762092368_Governors_Secretariat_08Sep2015.pdf', 'Active', '09-10-2025'),
(204, 5, 80, 0, 'पर्यटन व सांस्कृतिक कार्य विभाग ', 'https://testcultural.mahaitgov.in/Upload/PDF/%E0%A4%A8%E0%A4%BE%E0%A4%97%E0%A4%B0%E0%A4%BF%E0%A4%95%E0%A4%BE%E0%A4%82%E0%A4%9A%E0%A5%80%20%E0%A4%B8%E0%A4%A8%E0%A4%A6%20%E0%A4%B6%E0%A4%BE%20%E0%A4%A8%E0%A4%BF%208%206%202021.pdf', '', 'upload/नागरिकांची_सनद/gr_204_1762092369________________________________________________________8_6_2021.pdf', 'Active', '09-10-2025'),
(205, 5, 80, 0, 'सांस्कृतिक कार्य संचालनालय', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/Cultural%20Affairs.pdf', '', 'upload/नागरिकांची_सनद/gr_205_1762092372_Cultural_Affairs.pdf', 'Active', '09-10-2025'),
(206, 5, 80, 0, 'पुराभिलेख संचालनालय', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/Archives.pdf', '', 'upload/नागरिकांची_सनद/gr_206_1762092373_Archives.pdf', 'Active', '09-10-2025'),
(207, 5, 81, 0, 'नागरिकांची सनद (मराठी)', 'https://igrmaharashtra.gov.in/pdf/documents/citizen%20charter%20marathi%2016Aug14%20.pdf', '', 'upload/नागरिकांची_सनद/gr_207_1762092378_citizen_charter_marathi_16Aug14_.pdf', 'Active', '09-10-2025'),
(208, 5, 81, 0, 'नागरिकांची सनद (इंग्रजी)', 'https://igrmaharashtra.gov.in/pdf/documents/Citizen\'s%20Charter%20English%20-%2016th%20Aug14.pdf', '', 'upload/नागरिकांची_सनद/gr_208_1762092379_Citizen_s_Charter_English_-_16th_Aug14.pdf', 'Active', '09-10-2025'),
(209, 5, 82, 0, 'सार्वजनिक अभियोग संचालनालय', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/citizen_charter_dpp_marathi.pdf', '', 'upload/नागरिकांची_सनद/gr_209_1762092382_citizen_charter_dpp_marathi.pdf', 'Active', '09-10-2025'),
(210, 5, 82, 0, 'महाधिवक्ता महाराष्ट्र राज्य, मुंबई', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/Advocate%20Gen.%20M.S.H.C.Mumbai.pdf', '', 'upload/नागरिकांची_सनद/gr_210_1762092382_Advocate_Gen__M_S_H_C_Mumbai.pdf', 'Active', '09-10-2025'),
(211, 5, 82, 0, 'महाराष्ट्र राज्य विधी सेवा प्राधिकरण (एमएसएलएसए)', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/citizen_charter_MSLSA.pdf', '', 'upload/नागरिकांची_सनद/gr_211_1762092383_citizen_charter_MSLSA.pdf', 'Active', '09-10-2025'),
(212, 5, 83, 0, 'MAT नागपूर', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/13%20mat%20Nagpur.pdf', '', 'upload/नागरिकांची_सनद/gr_212_1762092384_13_mat_Nagpur.pdf', 'Active', '09-10-2025'),
(213, 5, 83, 0, 'MAT मुंबई', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/15%20Sanad%20Mat%20Mumbai.pdf', '', 'upload/नागरिकांची_सनद/gr_213_1762092384_15_Sanad_Mat_Mumbai.pdf', 'Active', '09-10-2025'),
(214, 5, 83, 0, 'MAT औरंगाबाद', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/20%20Mat%20Aurangabad.pdf', '', 'upload/नागरिकांची_सनद/gr_214_1762092385_20_Mat_Aurangabad.pdf', 'Active', '09-10-2025'),
(215, 5, 84, 0, 'महाराष्ट्र राज्य बाल हक्क संरक्षण आयोग', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/citizen-charter-protection-child-right.pdf', '', 'upload/नागरिकांची_सनद/gr_215_1762092385_citizen-charter-protection-child-right.pdf', 'Active', '09-10-2025'),
(216, 5, 84, 0, 'महिला व बाल विकास आयोग', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/WC%20Sanad%20Revised%2027.02.2013.pdf', '', 'upload/नागरिकांची_सनद/gr_216_1762092385_WC_Sanad_Revised_27_02_2013.pdf', 'Active', '09-10-2025'),
(217, 5, 236, 0, 'सहकार, पणन व वस्‍त्रोद्योग विभाग', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/Nagrikanchi%20Sanad%2030.07.2019.pdf', '', 'upload/नागरिकांची_सनद/gr_217_1762092386_Nagrikanchi_Sanad_30_07_2019.pdf', 'Active', '09-10-2025'),
(218, 5, 237, 0, 'विधी व न्याय विभाग', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/5-9-2022_citizen%20Charter2021.pdf', '', 'upload/नागरिकांची_सनद/gr_218_1762092400_5-9-2022_citizen_Charter2021.pdf', 'Active', '09-10-2025'),
(219, 5, 238, 0, 'आदिवासी विकास विभाग', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/Citizen%20Charter%202014%20TDD%2010%2009%202014.pdf', '', 'upload/नागरिकांची_सनद/gr_219_1762092403_Citizen_Charter_2014_TDD_10_09_2014.pdf', 'Active', '09-10-2025'),
(220, 5, 239, 0, 'कौशल्य, रोजगार, उद्योजकता व नविन्यता विभाग ', '', '', '', 'Active', '09-10-2025'),
(221, 5, 240, 0, 'कृषी, पशुसंवर्धन, दुग्‍धव्‍यवसाय विकास व मत्‍स्‍यव्‍यवसाय विभाग', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/Agriculture_sanad_2021.pdf', '', 'upload/नागरिकांची_सनद/gr_221_1762092537_Agriculture_sanad_2021.pdf', 'Active', '09-10-2025'),
(222, 5, 241, 0, ' ग्रामविकास व पंचायत राज विभाग ', 'https://cdnbbsr.s3waas.gov.in/s3e6c2dc3dee4a51dcec3a876aa2339a78/uploads/2025/01/20250325767535750.pdf', '', 'upload/नागरिकांची_सनद/gr_222_1762092577_20250325767535750.pdf', 'Active', '09-10-2025'),
(223, 5, 242, 0, 'गृहनिर्माण विभाग', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/charterhousingdept-2022.pdf', '', 'upload/नागरिकांची_सनद/gr_223_1762092578_charterhousingdept-2022.pdf', 'Active', '09-10-2025'),
(224, 5, 243, 0, 'जलसंपदा विभाग', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/charter-water-resourcesDepartment1.pdf', '', 'upload/नागरिकांची_सनद/gr_224_1762092580_charter-water-resourcesDepartment1.pdf', 'Active', '09-10-2025'),
(225, 5, 244, 0, 'दिव्यांग कल्याण विभाग ', 'https://cdnbbsr.s3waas.gov.in/s349c0b9d84c2a16fcaf9d25694fda75e1/uploads/2025/01/202501181947925043.pdf', '', 'upload/नागरिकांची_सनद/gr_225_1762092581_202501181947925043.pdf', 'Active', '09-10-2025'),
(226, 5, 245, 0, 'नगर विकास विभाग', '', '', '', 'Active', '09-10-2025'),
(227, 5, 246, 0, 'नियोजन विभाग', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/Citizen%20Charter_Planning_15102013.pdf', '', 'upload/नागरिकांची_सनद/gr_227_1762092582_Citizen_Charter_Planning_15102013.pdf', 'Active', '09-10-2025'),
(228, 5, 247, 0, 'पाणी पुरवठा व स्वच्छता विभाग ', 'https://cdnbbsr.s3waas.gov.in/s3347665597cbfaef834886adbb848011f/uploads/2025/01/202501281040220767.pdf', '', 'upload/नागरिकांची_सनद/gr_228_1762092584_202501281040220767.pdf', 'Active', '09-10-2025'),
(229, 5, 248, 0, ' सार्वजनिक आरोग्य विभाग ', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/health.pdf', '', 'upload/नागरिकांची_सनद/gr_229_1762092585_health.pdf', 'Active', '09-10-2025'),
(230, 5, 249, 0, 'सार्वजनिक बांधकाम विभाग ', 'https://cdnbbsr.s3waas.gov.in/s3ea80421fc06a2ed5c7adc1018e0026df/uploads/2025/06/202506261687437380.pdf', '', 'upload/नागरिकांची_सनद/gr_230_1762092745_202506261687437380.pdf', 'Active', '09-10-2025'),
(231, 5, 250, 0, 'संसदीय कार्य विभाग', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/CItizen%20charter_PAD17062013.pdf', '', 'upload/नागरिकांची_सनद/gr_231_1762092746_CItizen_charter_PAD17062013.pdf', 'Active', '09-10-2025'),
(232, 5, 251, 0, 'राज्य उत्पादन शुल्क विभाग', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/charter-state-excise.pdf', '', 'upload/नागरिकांची_सनद/gr_232_1762092751_charter-state-excise.pdf', 'Active', '09-10-2025'),
(233, 5, 252, 0, 'भूजल सर्वेक्षण आणि विकास यंत्रणा', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/gsda%20citizen%20charter.pdf', '', 'upload/नागरिकांची_सनद/gr_233_1762092754_gsda_citizen_charter.pdf', 'Active', '09-10-2025'),
(234, 5, 253, 0, 'महाराष्ट्र मेरिटाइम बोर्ड', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/Citizen_charter_Eng.pdf', '', 'upload/नागरिकांची_सनद/gr_234_1762092755_Citizen_charter_Eng.pdf', 'Active', '09-10-2025'),
(235, 5, 254, 0, 'माहिती जनसंपर्क महासंचालनालय', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/Citizen%20Chartered.pdf', '', 'upload/नागरिकांची_सनद/gr_235_1762092756_Citizen_Chartered.pdf', 'Active', '09-10-2025'),
(236, 5, 255, 0, 'महाराष्ट्र राज्य परीक्षा परिषद, पुणे', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/citizen%20charter.pdf', '', 'upload/नागरिकांची_सनद/gr_236_1762092759_citizen_charter.pdf', 'Active', '09-10-2025'),
(237, 5, 256, 0, 'चॅरिटी कमिश्नर कार्यालय', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/charity.pdf', '', 'upload/नागरिकांची_सनद/gr_237_1762092759_charity.pdf', 'Active', '09-10-2025'),
(238, 5, 257, 0, 'महाराष्ट्र जलसंपदा महामंडळ औरंगाबाद', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/CitizenCharter_MWCC_27112013.pdf', '', 'upload/नागरिकांची_सनद/gr_238_1762092764_CitizenCharter_MWCC_27112013.pdf', 'Active', '09-10-2025'),
(239, 5, 258, 0, 'आगरी समाज आर्थिक विकास महामंडळ', 'https://cdnbbsr.s3waas.gov.in/s35b705565012940a34a84ac3e16b08cf3/uploads/2025/04/20250609883360697.pdf', '', 'upload/नागरिकांची_सनद/gr_239_1762092117_20250609883360697.pdf', 'Active', '09-10-2025'),
(240, 5, 259, 0, 'झोपडपट्टी पुनर्वसन प्राधिकरण, मुंबई', 'https://testgomweb.mahaitgov.in/Upload/pdf/Citizen%20Charter/English/charter-slum-rehabitation.pdf', '', 'upload/नागरिकांची_सनद/gr_240_1762091121_charter-slum-rehabitation.pdf', 'Active', '09-10-2025');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL,
  `title` text DEFAULT NULL,
  `message` text DEFAULT NULL,
  `related_document_id` int(11) DEFAULT NULL,
  `scheduled_at` datetime DEFAULT NULL,
  `sent_at` datetime DEFAULT NULL,
  `status` enum('pending','sent') DEFAULT 'pending',
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `shared_links`
--

CREATE TABLE `shared_links` (
  `share_id` int(11) NOT NULL,
  `document_id` int(11) DEFAULT NULL,
  `unique_link_token` varchar(100) DEFAULT NULL,
  `status` enum('Active','Inactive') DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `subject_master`


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





-- --------------------------------------------------------

--
-- Table structure for table `sub_yy_master`
--

CREATE TABLE `sub_category_master` (
  `sub_category_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `sub_category_name` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('Active','Inactive') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `timestamp` text COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sub_category_master`
--

INSERT INTO `sub_category_master` (`sub_category_id`, `category_id`, `sub_category_name`, `status`, `timestamp`) VALUES
(1, 1, 'अध्यापक संवर्गातील आरक्षण', 'Active', '2025-09-15'),
(2, 1, 'महाराष्ट्र फळांचे रोपमळे विनियमन', 'Active', '2025-09-15'),
(3, 1, 'थेट लाभ हस्तांतरण', 'Active', '2025-09-15'),
(4, 1, 'मर्यादित विभागीय स्पर्धा परीक्षा नियम', 'Active', '2025-09-15'),
(5, 1, 'सेवाप्रवेश नियम', 'Active', '2025-09-15'),
(6, 1, 'बैलगाडी शर्यतीचे आयोजन', 'Active', '2025-09-15'),
(7, 1, 'बिटी कापूस बियाणे', 'Active', '2025-09-15'),
(8, 2, 'महाराष्ट्र सहकारी संस्था अधिनियम, 1960 सुधारणा', 'Active', '2025-09-15'),
(9, 2, 'गृहनिर्माण संस्था', 'Active', '2025-09-15'),
(10, 2, 'सहकारी पतसंस्था', 'Active', '2025-09-15'),
(11, 2, 'अधिकार प्रदान करणेबाबत.', 'Active', '2025-09-15'),
(12, 2, 'कृषि उत्पन्न पणन अधिनियम, 1963  सुधारणा ', 'Active', '2025-09-15'),
(13, 3, 'प्लास्टिक आणि थर्मोकॉल', 'Active', '2025-09-15'),
(14, 3, 'महाराष्ट्र (नागरी क्षेत्रे) झाडांचे संरक्षण व जतन अधिनियम, 1975', 'Active', '2025-09-15'),
(15, 4, 'महाराष्ट्र नागरी (सुधारीत वेतन) नियमात सुधारणा ', 'Active', '2025-09-15'),
(16, 4, 'बदली', 'Active', '2025-09-15'),
(17, 4, 'सेवाप्रवेश नियम', 'Active', '2025-09-15'),
(18, 4, 'हमी विमोचन निधी योजना', 'Active', '2025-09-15'),
(19, 4, 'भविष्य निर्वाह निधी', 'Active', '2025-09-15'),
(20, 4, 'मनासे (सेवेच्या सर्वसाधारण शर्ती) ', 'Active', '2025-09-15'),
(21, 4, 'मनासे (निवृत्तीवेतनाचे अंशराशीकरण)', 'Active', '2025-09-15'),
(22, 4, 'मनासे (निवृत्ती वेतन)', 'Active', '2025-09-15'),
(23, 4, 'मुंबई वित्तीय (सुधारणा) नियम', 'Active', '2025-09-15'),
(24, 4, 'राजकोषीय उत्तरदायित्व व अर्थसंकल्पीय व्यवस्थापन नियम, 2020', 'Active', '2025-09-15'),
(25, 4, 'अधिसेविका पदाच्या ग्रेड वेतनामध्ये सुधारणा', 'Active', '2025-09-15'),
(26, 4, 'पाचवा महाराष्ट्र वित्त आयोग ', 'Active', '2025-09-15'),
(27, 4, 'विभाग प्रमुख यादी', 'Active', '2025-09-15'),
(28, 4, 'रजेचे रोखीकरण - स्वेच्छानिवृत्त, रुग्णता निवृत्त, राजीनामा', 'Active', '2025-09-15'),
(29, 4, 'सक्तीचा प्रतिक्षाधिन कालावधी ', 'Active', '2025-09-15'),
(30, 5, 'महाराष्ट्र अन्न सुरक्षा (सुधारणा) नियम,2023', 'Active', '2025-09-15'),
(31, 6, ' विभागीय परीक्षा', 'Active', '2025-09-15'),
(32, 6, 'सेवाप्रवेश नियम', 'Active', '2025-09-15'),
(33, 6, 'नवीन विभाग निर्मिती', 'Active', '2025-09-15'),
(34, 6, 'विभागाच्या नावात बदल करणे', 'Active', '2025-09-15'),
(35, 6, 'विषय विभागाकडे सोपविण्याबाबत', 'Active', '2025-09-15'),
(36, 6, 'कालबद्ध प्रशिक्षण नियम', 'Active', '2025-09-15'),
(37, 6, 'जनगणना', 'Active', '2025-09-15'),
(38, 6, 'महसुल विभाग वाटप', 'Active', '2025-09-15'),
(39, 6, 'ज्येष्ठतेचे विनियमन', 'Active', '2025-09-15'),
(40, 6, 'राष्ट्रपती राजवट', 'Active', '2025-09-15'),
(41, 6, 'जमीन अधिग्रहण', 'Active', '2025-09-15'),
(42, 6, ' बदली', 'Active', '2025-09-15'),
(43, 6, 'संगणक हाताळणी/ वापराबाबतचे ज्ञान ', 'Active', '2025-09-15'),
(44, 6, ' हिंदी परिक्षा', 'Active', '2025-09-15'),
(45, 6, ' भविष्य निर्वाह निधी', 'Active', '2025-09-15'),
(46, 6, ' लोकसेवा', 'Active', '2025-09-15'),
(47, 6, '  मनासे शिस्त व अपील', 'Active', '2025-09-15'),
(48, 6, ' मनासे (वर्तणूक)', 'Active', '2025-09-15'),
(49, 6, 'लोक आयुक्त यांच्या अधिकार कक्षेत आणणेबाबत', 'Active', '2025-09-15'),
(50, 6, 'RCS विमानतळ', 'Active', '2025-09-15'),
(51, 7, '7 वा वेतन आयोग', 'Active', '2025-09-15'),
(52, 7, 'शिष्यवृत्ती/आर्थिक सहाय्य ', 'Active', '2025-09-15'),
(53, 7, 'सेवा प्रवेश नियम', 'Active', '2025-09-15'),
(54, 7, 'लोकसेवा', 'Active', '2025-09-15'),
(55, 8, 'लेखापरीक्षण', 'Active', '2025-09-15'),
(56, 8, 'महाराष्ट्र भाडे नियंत्रण नियम, 2017', 'Active', '2025-09-15'),
(57, 8, 'महाराष्ट्र झोपडपट्टी (सुधारणा, निर्मुलन व पुनर्विकास) अधिनियम, 1971', 'Active', '2025-09-15'),
(58, 9, 'व्यावसायिक सुरक्षा, आरोग्य व कामाची स्थिती नियम', 'Active', '2025-09-15'),
(59, 9, 'संहिता', 'Active', '2025-09-15'),
(60, 9, 'सेवा प्रवेश नियम', 'Active', '2025-09-15'),
(61, 9, 'लोकसेवा', 'Active', '2025-09-15'),
(62, 9, ' विद्युत शुल्क', 'Active', '2025-09-15'),
(63, 9, 'केंद्रीय विद्युत प्राधिकरण विनियम, 2010', 'Active', '2025-09-15'),
(64, 9, 'उद्वाहन अधिनियम', 'Active', '2025-09-15'),
(65, 9, 'सुरक्षा रक्षक', 'Active', '2025-09-15'),
(66, 9, 'वीज विक्रीकर', 'Active', '2025-09-15'),
(67, 9, ' विद्युत संच मांडणीचे निरीक्षण व चाचणी', 'Active', '2025-09-15'),
(68, 9, 'बदली', 'Active', '2025-09-15'),
(69, 9, 'सुक्ष्म लघु व मध्यम उपक्रम विकास अधिनियम 2006', 'Active', '2025-09-15'),
(70, 9, 'महाराष्ट्र विद्युत शुल्क अधिनियम - 1958 ', 'Active', '2025-09-15'),
(71, 9, 'माथाडी सल्लागार समिती', 'Active', '2025-09-15'),
(72, 9, 'श्रमजीवी कामगार (नोकरीचे नियमन व कल्याण) योजना, 2017', 'Active', '2025-09-15'),
(73, 9, 'वीजनिर्मितीच्या पारेषण संलग्न प्रकल्पासाठी एकत्रित धोरण 2015', 'Active', '2025-09-15'),
(74, 9, 'माहिती तंत्रज्ञान सहाय्यभूत सेवा धोरण 2015', 'Active', '2025-09-15'),
(75, 9, 'महाराष्ट्र वीज सुधारणा हस्तांतरण (पहिली दुरुस्ती) योजना 2016', 'Active', '2025-09-15'),
(76, 9, 'विद्युत वाहिन्या व विद्युत केंद्राची उभारणी करण्यासाठी अधिकार देण्याबाबत', 'Active', '2025-09-15'),
(77, 9, 'महाराष्ट्र विद्युत अनुज्ञापक मंडळ नियम, 2017', 'Active', '2025-09-15'),
(78, 9, 'नोटीफाईड व्होल्टेज', 'Active', '2025-09-15'),
(79, 9, 'विदयुत अधिनियम 2003', 'Active', '2025-09-15'),
(80, 10, 'आधार ', 'Active', '2025-09-15'),
(81, 11, 'सेवा प्रवेश नियम', 'Active', '2025-09-15'),
(82, 11, 'सरपंचाची थेट जनतेमधून नेमणूक', 'Active', '2025-09-15'),
(83, 11, 'पेसा', 'Active', '2025-09-15'),
(84, 11, 'शुल्क व भत्ते ', 'Active', '2025-09-15'),
(85, 12, ' महाराष्ट्र जमिन महसूल संहिता, 1966', 'Active', '2025-09-15'),
(86, 12, 'वार्षिक उद्योग पाहणी ', 'Active', '2025-09-15'),
(87, 13, 'राष्ट्रीय नमुना पाहणी', 'Active', '2025-09-15'),
(88, 13, 'विवाह नोंदणी प्रमाणपत्र', 'Active', '2025-09-15'),
(89, 13, 'आजार अधिसूचित करणे', 'Active', '2025-09-15'),
(90, 13, 'लिंग निवडीस प्रतिबंध', 'Active', '2025-09-15'),
(91, 13, 'सरोगसी', 'Active', '2025-09-15'),
(92, 13, 'एचआयव्ही व एड्स', 'Active', '2025-09-15'),
(93, 13, 'ख्रिश्चन विवाह ', 'Active', '2025-09-15'),
(94, 13, 'सेवाप्रवेश नियम', 'Active', '2025-09-15'),
(95, 13, 'खाजगी रूग्णालय', 'Active', '2025-09-15'),
(96, 13, 'बदली', 'Active', '2025-09-15'),
(97, 13, 'आनंद विवाह', 'Active', '2025-09-15'),
(98, 13, 'मानसिक आरोग्य प्राधिकरण', 'Active', '2025-09-15'),
(99, 13, 'लोकसेवा', 'Active', '2025-09-15'),
(100, 13, 'सैल सिगारेट आणि बीडीच्या विक्रीवर बंदी', 'Active', '2025-09-15'),
(101, 13, 'साथरोग कायदा', 'Active', '2025-09-15'),
(102, 14, ' पथकर वसूली', 'Active', '2025-09-15'),
(103, 15, 'अधिमूल्याची रक्कम', 'Active', '2025-09-15'),
(104, 15, 'भोगवटादार वर्ग-2 आणि भाडेपट्ट्याने प्रदान केलेल्या जमिनी भोगवटादार वर्ग-1 मध्ये रुपांतरीत करणे', 'Active', '2025-09-15'),
(105, 15, 'बदली', 'Active', '2025-09-15'),
(106, 15, 'अधिनियमात सुधारणा', 'Active', '2025-09-15'),
(107, 15, 'भूदान यज्ञ मंडळ बरखास्त करण्याबाबत', 'Active', '2025-09-15'),
(108, 15, 'आजी/माजी सैनिकांना कृषिक प्रयोजनासाठी जमीन प्रदान करणेबाबत', 'Active', '2025-09-15'),
(109, 15, 'महाराष्ट्र जमीन महसूल (सरकारी जमिनींची विल्हेवाट करणे) नियम 1971', 'Active', '2025-09-15'),
(110, 15, 'भोगवटादार वर्ग-2 जमिनीची अकृषिक कारणास्तव झालेली बांधकामे नियमित करणेबाबत', 'Active', '2025-09-15'),
(111, 15, 'महाराष्ट्र जमीन महसूल व विशेष आकारणी अधिनियम, 1974', 'Active', '2025-09-15'),
(112, 15, 'महाराष्ट्र जमीन महसूल संहिता 1966', 'Active', '2025-09-15'),
(113, 15, 'महाराष्ट्र कुळवहिवाट व शेतजमीन अधिनियम', 'Active', '2025-09-15'),
(114, 15, 'अप्पर तहसिल कार्यालय स्थापन करण्यास मान्यता', 'Active', '2025-09-15'),
(115, 15, 'महाराष्ट्र गौण खनिज उत्खनन ', 'Active', '2025-09-15'),
(116, 15, 'क्रीडांगण किंवा खेळाचे मैदान, व्यायामशाळा यांचे भाडेपट्टयाबाबत', 'Active', '2025-09-15'),
(117, 15, 'पाच ब्रास वाळू काढण्यास परवानगी देण्याबाबत', 'Active', '2025-09-15'),
(118, 15, 'महाराष्ट्र जमीन महसूल (जमिनीच्या वापरावर निर्बंध) नियम, 1968', 'Active', '2025-09-15'),
(119, 15, 'भूमी संपादन, पुनर्वसन व पुनर्वसाहत', 'Active', '2025-09-15'),
(120, 15, 'राज्यात सुविधा व सेवा जमिनीमधील वापर हक्काचे संपादन', 'Active', '2025-09-15'),
(121, 15, 'अधिकार अभिलेख ', 'Active', '2025-09-15'),
(122, 15, 'विस्थापित इसम (नुवपु) अधिनियम, 1954', 'Active', '2025-09-15'),
(123, 15, ' जमिनींचे तुकडे पाडण्यास प्रतिबंध ', 'Active', '2025-09-15'),
(124, 15, 'करमणूक शुल्क', 'Active', '2025-09-15'),
(125, 15, 'हैदराबाद इनामे व रोख अनुदाने रद्द करण्याबाबत अधिनियम, 1954 ', 'Active', '2025-09-15'),
(126, 15, 'स्वामित्वधनातून सूट देण्याबाबत', 'Active', '2025-09-15'),
(127, 15, 'विभागीय आयुक्त कार्यालय स्थापन करणेबाबत', 'Active', '2025-09-15'),
(128, 16, 'तेंदू', 'Active', '2025-09-15'),
(129, 16, 'लोकसेवा', 'Active', '2025-09-15'),
(130, 16, 'बदली', 'Active', '2025-09-15'),
(131, 16, ' सेवाप्रवेश नियम', 'Active', '2025-09-15'),
(132, 16, 'वाहतूक परवान्यातून सूट', 'Active', '2025-09-15'),
(133, 16, ' वार्डन नियुक्ती', 'Active', '2025-09-15'),
(134, 16, 'अभयारण्याची अधिसुचना', 'Active', '2025-09-15'),
(135, 16, 'महाराष्ट्र पर्यायी वनीकरण निधी', 'Active', '2025-09-15'),
(136, 16, 'महाराष्ट्र जमीन महसूल (झाडे इत्यादीच्या बाबतीतील अधिकारांचे नियमन करण्याबाबत.) सुधारणा नियम 2017.', 'Active', '2025-09-15'),
(137, 17, 'महाराष्ट्र विकास सेवा', 'Active', '2025-09-15'),
(138, 17, 'सेवा प्रवेश नियम', 'Active', '2025-09-15'),
(139, 17, 'लोकसेवा', 'Active', '2025-09-15'),
(140, 17, ' स्थानिक स्वराज्य संस्थांवर प्रशासक नियुक्त करणेबाबत', 'Active', '2025-09-15'),
(141, 17, 'महाराष्ट्र ग्रामपंचायत अधिनियम आणि महाराष्ट्र जिल्हा परिषद व पंचायत समिती अधिनियम, 1961', 'Active', '2025-09-15'),
(142, 17, 'महाराष्ट्र ग्रामपंचायत कर व फी ', 'Active', '2025-09-15'),
(143, 17, 'कारखान्यांकडून करांऐवजी ठोक रक्कमेच्या स्वरूपात अंशदान देण्यासंबंधी', 'Active', '2025-09-15'),
(144, 17, 'सरपंचाची थेट निवडणुक', 'Active', '2025-09-15'),
(145, 17, 'महाराष्ट्र ग्रामपंचायत आणि प्रादेशिक नियोजन व नगररचना (सुधारणा) अधिनियम, 2014 ', 'Active', '2025-09-15'),
(146, 17, 'ग्रामपंचायत लेखा संहिता', 'Active', '2025-09-15'),
(147, 17, 'जिल्हा ग्राम विकास निधी ', 'Active', '2025-09-15'),
(148, 17, 'महाराष्ट्र जिल्हा परिषदा आणि पंचायत समित्या (पदांचे आरक्षण व निवडणूक) नियम, 1962', 'Active', '2025-09-15'),
(149, 17, 'महाराष्ट्र जिल्हा परिषद व पंचायत समिती', 'Active', '2025-09-15'),
(150, 17, 'महाराष्ट्र स्थानिक प्राधिकरण सदस्य अनर्हता अधिनियम, 1986', 'Active', '2025-09-15'),
(151, 18, 'शाळा न्यायाधिकरण', 'Active', '2025-09-15'),
(152, 18, 'महाराष्ट्र खाजगी शाळांतील कर्मचारी    (सेवेच्या शर्ती) ', 'Active', '2025-09-15'),
(153, 18, 'शालार्थ प्रणाली', 'Active', '2025-09-15'),
(154, 18, 'सेवाप्रवेश नियम', 'Active', '2025-09-15'),
(155, 18, 'महाराष्ट्र स्वयंअर्थसहाय्यित शाळा (स्थापना व विनियमन) नियम, 2020.', 'Active', '2025-09-15'),
(156, 18, 'विना अनुदानित वरुन अंशत अनुदानित किंवा अनुदानित शाळा किंवा तुकडीवर बदली', 'Active', '2025-09-15'),
(157, 18, 'शिक्षकेत्तर कर्मचाऱ्यांची किमान अर्हता', 'Active', '2025-09-15'),
(158, 18, 'महाराष्ट्र शैक्षणिक संस्था (शुल्क विनिमन) अधिनियम, 2011', 'Active', '2025-09-15'),
(159, 18, 'बालकांचा मोफत व सक्तीच्या शिक्षणाचा हक्क कायदा, 2009', 'Active', '2025-09-15'),
(160, 18, 'लोकसेवा', 'Active', '2025-09-15'),
(161, 18, 'शालेय शिक्षण विभागाच्या योजना अधिसूचित करण्याबाबत', 'Active', '2025-09-15'),
(162, 19, 'राज्य कौशल्य विद्यापीठ', 'Active', '2025-09-15'),
(163, 20, 'लोकसेवा', 'Active', '2025-09-15'),
(164, 20, 'राज्य मागासवर्ग आयोग', 'Active', '2025-09-15'),
(165, 20, 'महाराष्ट्र आधार अधिनियम, 2016', 'Active', '2025-09-15'),
(166, 21, 'शासकीय कार्यालये व कर्मचाऱ्यांचे निवासस्थान', 'Active', '2025-09-15'),
(167, 22, 'लोकसेवा', 'Active', '2025-09-15'),
(168, 23, 'सेवा प्रवेश नियम', 'Active', '2025-09-15'),
(169, 23, 'महाराष्ट्र जलसपंत्ती नियमन प्राधिकरण (सुधारणा)', 'Active', '2025-09-15'),
(170, 24, 'सेवाप्रवेश', 'Active', '2025-09-15'),
(171, 24, 'महाराष्ट्र भूजल (विकास व व्यवस्थापन)', 'Active', '2025-09-15'),
(172, 122, 'महसूल विभाग', 'Active', '2025-09-15'),
(173, 122, 'ग्रामविकास व पंचायत राज विभाग', 'Active', '2025-09-15'),
(174, 122, ' कामगार विभाग', 'Active', '2025-09-15'),
(175, 122, 'जलसंपदा विभाग', 'Active', '2025-09-15'),
(176, 122, ' उद्योग विभाग', 'Active', '2025-09-15'),
(177, 122, ' वन विभाग', 'Active', '2025-09-15'),
(178, 122, ' सहकार, पणन आणि वस्त्रोद्योग विभाग', 'Active', '2025-09-15'),
(179, 122, 'विधि व न्याय विभाग', 'Active', '2025-09-15'),
(180, 122, ' गृह विभाग', 'Active', '2025-09-15'),
(181, 122, 'परिवहन विभाग', 'Active', '2025-09-15'),
(182, 122, ' उद्योग विभाग', 'Active', '2025-09-15'),
(183, 122, 'बृहन्मुंबई महानगरपालिका', 'Active', '2025-09-15'),
(184, 122, 'गृहनिर्माण विभाग - म्हाडा', 'Active', '2025-09-15'),
(185, 122, ' गृहनिर्माण विभाग - मुंबई इमारत दुरुस्ती व पुनरबांधणी मंडळ', 'Active', '2025-09-15'),
(186, 122, 'गृहनिर्माण विभाग - झोपडपट्टी पुनर्वसन प्राधिकरण', 'Active', '2025-09-15'),
(187, 122, ' महाराष्ट्र जीवन प्राधिकरण विभाग', 'Active', '2025-09-15'),
(188, 122, 'नगर विकास', 'Active', '2025-09-15'),
(189, 122, 'सामाजिक न्याय व विशेष सहाय्य विभाग', 'Active', '2025-09-15'),
(190, 122, 'वैद्यकीय शिक्षण आणि औषध विभाग - आयुष', 'Active', '2025-09-15'),
(191, 122, ' उच्च व तंत्रशिक्षण विभाग', 'Active', '2025-09-15'),
(192, 122, 'गृह विभाग - महाराष्ट्र मेरीटाईम बोर्ड', 'Active', '2025-09-15'),
(193, 122, 'पर्यटन व सांस्कृतीक कार्य विभाग - पुराभिलेख संचालनालय', 'Active', '2025-09-15'),
(194, 122, 'सार्वजनिक आरोग्य विभाग', 'Active', '2025-09-15'),
(195, 122, 'आदिवासी विकास विभाग', 'Active', '2025-09-15'),
(196, 122, 'कृषी, पशुसंवर्धन व दुग्धव्यवसाय विकास विभाग', 'Active', '2025-09-15'),
(197, 122, 'मत्स्यव्यवसाय विभाग', 'Active', '2025-09-15'),
(198, 122, ' शालेय शिक्षण व क्रीडा विभाग', 'Active', '2025-09-15'),
(199, 122, ' कृषी', 'Active', '2025-09-15'),
(200, 122, ' वित्त विभाग', 'Active', '2025-09-15'),
(201, 122, ' अन्न, नागरी पुरवठा व ग्राहक संरक्षण विभाग', 'Active', '2025-09-15'),
(202, 122, ' पर्यटन व सांस्कृतीक कार्य विभाग', 'Active', '2025-09-15'),
(203, 122, 'भूमि अभिलेख विभाग', 'Active', '2025-09-15'),
(204, 122, 'उर्जा विभाग', 'Active', '2025-09-15'),
(205, 122, 'राज्य उत्पादन शुल्क विभाग', 'Active', '2025-09-15'),
(206, 122, ' सार्वजनिक बांधकाम विभाग', 'Active', '2025-09-15'),
(207, 123, 'महावितरण', 'Active', '2025-09-15'),
(208, 123, 'महाट्रान्स्को', 'Active', '2025-09-15'),
(209, 124, 'गोदावरी ', 'Active', '2025-09-15'),
(210, 124, 'वि .पा.वि.म -वार्षिक अहवाल', 'Active', '2025-09-15'),
(211, 124, 'म.कृ.खो.वि.मं.', 'Active', '2025-09-15'),
(212, 124, 'जललेखा अहवाल', 'Active', '2025-09-15'),
(213, 124, 'सिंचन स्थिती अहवाल', 'Active', '2025-09-15'),
(214, 138, 'बायोडिझेल', 'Active', '2025-09-15'),
(215, 138, 'वजन माप उत्पादक, दुरुस्तक व विक्रेता यांना परवाना', 'Active', '2025-09-15'),
(216, 138, 'जीवनावश्यक वस्तू ', 'Active', '2025-09-15'),
(217, 138, 'फ्री-सेल केरोसिन', 'Active', '2025-09-15'),
(218, 138, 'रॉकेल वितरण, पुरवठा ', 'Active', '2025-09-15'),
(219, 138, 'बाजार व देखरेख फी', 'Active', '2025-09-15'),
(220, 138, 'सार्वजनिक वितरण व्यवस्थेच्या सर्वसाधारण धोरण विषयक बाबी ', 'Active', '2025-09-15'),
(221, 139, 'धर्मक्षेत्र व परिसर विकास', 'Active', '2025-09-15'),
(222, 139, 'प्रतिनियुक्तीने पदे भरण्याबाबतचे धोरण', 'Active', '2025-09-15'),
(223, 139, 'उर्दू घरासंदर्भात धोरण', 'Active', '2025-09-15'),
(224, 139, 'राज्य वक्फ मंडळ निवडणूक अनुदान', 'Active', '2025-09-15'),
(225, 139, 'हज हाऊस', 'Active', '2025-09-15'),
(226, 140, 'काम नाही, वेतन नाही धोरण ', 'Active', '2025-09-15'),
(227, 140, 'शासकीय कर्तव्य पार पाडतांना होणा-या विलंबास प्रतिबंध घालण्याचे धोरण', 'Active', '2025-09-15'),
(228, 140, 'आदिवासी क्षेत्राच्या प्रशासनाचे बळंकटीकरण ', 'Active', '2025-09-15'),
(229, 140, 'आदिवासी आश्रमशाळेंची प्रवेश नियमावली', 'Active', '2025-09-15'),
(230, 140, 'आदिवासी उपयोजना', 'Active', '2025-09-15'),
(231, 141, 'अनुकंपा नियुक्ती', 'Active', '2025-09-15'),
(232, 142, 'राष्ट्रीय शैक्षणिक धोरण-2020', 'Active', '2025-09-15'),
(233, 142, 'तृतीयपंथीयांसाठीचे धोरण', 'Active', '2025-09-15'),
(234, 142, 'आंतरवासिता उपक्रम ', 'Active', '2025-09-15'),
(235, 142, 'अनुकंपा धोरण', 'Active', '2025-09-15'),
(236, 142, 'महाराष्ट्र राज्य सांस्कृतिक धोरण', 'Active', '2025-09-15'),
(237, 142, 'शिका व कमवा धोरण', 'Active', '2025-09-15'),
(238, 142, 'अध्यासन केंद्र', 'Active', '2025-09-15'),
(239, 142, 'अध्यापक संवर्गातील आरक्षण', 'Active', '2025-09-15'),
(240, 142, 'स्वीय प्रपंजी लेखा', 'Active', '2025-09-15'),
(241, 142, 'योग शिक्षणाबाबतचे धोरण', 'Active', '2025-09-15'),
(242, 142, 'नविन राष्ट्रीय शैक्षणिक धोरण', 'Active', '2025-09-15'),
(243, 142, 'कॉरपोरेट सोशल रिस्पॉंन्ससिबिलिटि संबंधात धोरण', 'Active', '2025-09-15'),
(244, 142, 'राज्य क्रिडा व युवा धोरण', 'Active', '2025-09-15'),
(245, 142, 'व्यवसाय शिक्षण', 'Active', '2025-09-15'),
(246, 142, 'अध्यापक महाविद्यालय शिक्षण', 'Active', '2025-09-15'),
(247, 142, 'व्यवसाय शिक्षण', 'Active', '2025-09-15'),
(248, 142, 'अभियांत्रिकी महाविद्यालय', 'Active', '2025-09-15'),
(249, 143, 'महाराष्ट्र राज्य निर्यात प्रोत्साहन धोरण', 'Active', '2025-09-15'),
(250, 143, 'धोरण कालावधी', 'Active', '2025-09-15'),
(251, 143, 'महाराष्ट्र हरित हायड्रोजन धोरण', 'Active', '2025-09-15'),
(252, 143, 'अपारंपरिक ऊर्जा निर्मिती धोरण-2020 ', 'Active', '2025-09-15'),
(253, 143, 'अपारंपरिक ऊर्जा निर्मिती धोरण-2008', 'Active', '2025-09-15'),
(254, 143, 'अपारंपरिक ऊर्जा स्त्रोत यापासून वीज निर्मिती 2015', 'Active', '2025-09-15'),
(255, 143, 'अपारंपरिक ऊर्जा स्त्रोत यापासून वीज निर्मिती 2016', 'Active', '2025-09-15'),
(256, 143, 'अति उच्चदाब पारेषण वाहिन्या', 'Active', '2025-09-15'),
(257, 143, 'माहिती तंत्रज्ञान व माहिती तंत्रज्ञान सहाय्यभूत सेवा धोरण', 'Active', '2025-09-15'),
(258, 143, 'खरेदी धोरण', 'Active', '2025-09-15'),
(259, 143, 'लॉजिस्टीक धोरण', 'Active', '2025-09-15'),
(260, 143, 'वस्त्रोद्योग धोरण ', 'Active', '2025-09-15'),
(261, 143, 'इलेक्ट्रीक वाहन धोरण', 'Active', '2025-09-15'),
(262, 143, 'औद्योगिक धोरण, 2019', 'Active', '2025-09-15'),
(263, 143, 'औद्योगिक धोरण, 2013', 'Active', '2025-09-15'),
(264, 143, 'महाराष्ट्र इलेक्ट्रॉनिक्स धोरण', 'Active', '2025-09-15'),
(265, 143, 'इलेक्ट्रीक व्हेईकल प्रोत्साहन धोरण', 'Active', '2025-09-15'),
(266, 143, 'सौर कृषी पंप', 'Active', '2025-09-15'),
(267, 143, 'काथ्या उद्योग धोरण', 'Active', '2025-09-15'),
(268, 143, 'महिला उद्योजकांसाठी विशेष धोरण', 'Active', '2025-09-15'),
(269, 143, 'फ्लॅटेड गाळायुक्त औद्योगिक संकुले (Parks) धोरण- 2018', 'Active', '2025-09-15'),
(270, 143, 'महाराष्ट्राचे अवकाश व संरक्षण क्षेत्र उत्पादन धोरण-2018', 'Active', '2025-09-15'),
(271, 143, 'राज्याचे ऊर्जा संवर्धन धोरण,2017.', 'Active', '2025-09-15'),
(272, 143, 'विद्युत निर्मिती प्रकल्पातील राखेच्या वापरासंबंधीचे धोरण', 'Active', '2025-09-15'),
(273, 143, 'राज्याचे किरकोळ व्यापार धोरण- 2016.', 'Active', '2025-09-15'),
(274, 143, 'महाराष्ट्राचे जैव तंत्रज्ञान धोरण-२००१', 'Active', '2025-09-15'),
(275, 143, 'खनिजाच्या डम्पसची निर्गतीबाबत धोरण', 'Active', '2025-09-15'),
(276, 143, 'विशेष आर्थिक क्षेत्रात स्‍टॅम्‍प डयुटी व रजिस्‍ट्रेशन फी यामध्‍ये सुट', 'Active', '2025-09-15'),
(277, 143, 'सिंधुदुर्ग जिल्ह्यामध्ये उद्योग उभारणीबाबतचे धोरण', 'Active', '2025-09-15'),
(278, 143, 'विशाल प्रकल्प धोरण', 'Active', '2025-09-15'),
(279, 143, 'ऊसाच्या चिपाडावर आधारित सहवीज  आणि लघुजल विद्युत निर्मितीबाबतचे  धोरण-2014', 'Active', '2025-09-15'),
(280, 143, 'ईज ऑफ डुईंग बिजनेस', 'Active', '2025-09-15'),
(281, 143, 'मुंबई महानगर प्राधिकरण क्षेत्रातील स्थान निश्चयन धोरण', 'Active', '2025-09-15'),
(282, 143, 'अनुकंपा', 'Active', '2025-09-15'),
(283, 143, 'महाराष्‍ट्र औदयोगिक गुंतवणूक व पायाभूत सुविधा धोरण 2006', 'Active', '2025-09-15'),
(284, 143, 'पवन ऊर्जा निर्मिती धोरण, २००४', 'Active', '2025-09-15'),
(285, 143, 'वीज भांडवल', 'Active', '2025-09-15'),
(286, 143, 'महाराष्ट्राचे द्राक्ष प्रक्रिया उद्योग धोरण २००१', 'Active', '2025-09-15'),
(287, 144, 'कृषि-कृत्रिम बुद्धिमत्ता (MahaAgri-AI) धोरण २०२५', 'Active', '2025-09-15'),
(288, 144, 'शिक्षकीय पदांच्या संवर्गनिहाय आरक्षण धोरण', 'Active', '2025-09-15'),
(289, 144, 'अन्न प्रक्रिया धोरण २०१७ ', 'Active', '2025-09-15'),
(290, 144, 'कृषि शिक्षण धोरण', 'Active', '2025-09-15'),
(291, 144, 'विकेल ते पिकेल धोरण', 'Active', '2025-09-15'),
(292, 144, 'प्रशिक्षण धोरण ', 'Active', '2025-09-15'),
(293, 144, 'सेंद्रीय शेती धोरण', 'Active', '2025-09-15'),
(294, 145, 'खरेदी धोरण', 'Active', '2025-09-15'),
(295, 145, ' प्रशिक्षण धोरण', 'Active', '2025-09-15'),
(296, 145, 'शिक्षकीय पदांच्या संवर्गनिहाय आरक्षण धोरण', 'Active', '2025-09-15'),
(297, 145, ' शैक्षणिक विशेषज्ञता विचारात घेऊन विवक्षित पदांवर पदस्थापना', 'Active', '2025-09-15'),
(298, 145, 'राष्ट्रीय आपत्ती निवारण धोरणामधील निकषानुसार अर्थसहाय्य', 'Active', '2025-09-15'),
(299, 145, 'वराह पैदास धोरण', 'Active', '2025-09-15'),
(300, 145, 'बांधा, वापरा व हस्तांतर करा यासंबंधीचे धोरण', 'Active', '2025-09-15'),
(301, 145, 'आरे दुग्ध वसाहत धोरण', 'Active', '2025-09-15'),
(302, 146, 'बांधकाम प्रकल्पांमुळे बाधित होणाऱ्या मच्छिमारांना नुकसान भरपाई अदा करण्यासाठी धोरण ', 'Active', '2025-09-15'),
(303, 146, 'पिंजरा पध्दतीने मत्स्यसंवर्धन करण्याबाबत धोरण', 'Active', '2025-09-15'),
(304, 146, 'मत्स्यबीज/ कोळंबीबीज उत्पादन व संवर्धन केंद्र भाडेपट्टीने देण्याबाबत धोरण', 'Active', '2025-09-15'),
(305, 146, 'मत्स्य व्यवसायाकरीता जलाशय/तलाव ठेक्याने देण्यासाठी  धोरण', 'Active', '2025-09-15'),
(306, 146, 'निमखा-या पाण्‍यावर मत्‍स्‍योत्‍पादन करण्‍यासाठी शासकीय खाजण जमिनी भाडेपट्टीने देण्‍याबाबत शासकीय धोरण', 'Active', '2025-09-15'),
(307, 147, 'शासकिय औद्योगिक प्रशिक्षण संस्थांचे अद्यावतीकरण धोरण', 'Active', '2025-09-15'),
(308, 147, 'कौशल्य श्रेणी वर्धन धोरण', 'Active', '2025-09-15'),
(309, 147, ' सामाजिक दायित्व निधी (CSR व स्वेच्छा देणगी धोरण', 'Active', '2025-09-15'),
(310, 147, 'नाविन्यपूर्ण स्टार्टअप धोरण, 2018', 'Active', '2025-09-15'),
(311, 147, 'रोजगार व स्वंयरोजगार धोरण', 'Active', '2025-09-15'),
(312, 148, 'गट-क (वर्ग-३) व गट-ड (वर्ग-४) च्या कर्मचाऱ्यांच्या बदल्यांच्या धोरण', 'Active', '2025-09-15'),
(313, 148, 'शिक्षकांच्या जिल्हांतर्गत बदली', 'Active', '2025-09-15'),
(314, 148, 'शिक्षक संवर्गाच्या आंतरजिल्हा बदल्यां', 'Active', '2025-09-15'),
(315, 148, 'केंद्रप्रमुख पदाच्या पदोन्नती प्रक्रीयेबाबत', 'Active', '2025-09-15'),
(316, 148, ' ग्रामीण रस्ते परिरक्षा धोरण', 'Active', '2025-09-15'),
(317, 148, 'बाळासाहेब ठाकरे स्मृती मातोश्री ग्रामपंचायत बांधणी प्रचलीत धोरण', 'Active', '2025-09-15'),
(318, 148, 'ग्रामीण व इतर ग्रामीण गृहनिर्माण योजनां', 'Active', '2025-09-15'),
(319, 148, 'सर्वांसाठी घरे 2022 या धोरण', 'Active', '2025-09-15'),
(320, 148, 'आमदार आदर्श ग्राम योजनेंतर्गत अनुज्ञेय जोडनिधीचे प्रमाण निश्चित करण्याबाबतचे धोरण.', 'Active', '2025-09-15'),
(321, 148, 'महिलांच्या स्वयंसहायता गटांना देण्यात यांणा-या कर्जाच्या व्याजासाठी अनुदान देण्याच्या धोरणाची ', 'Active', '2025-09-15'),
(322, 149, 'महाराष्ट्र इलेक्ट्रिक वाहन धोरण-2025', 'Active', '2025-09-15'),
(323, 149, 'app-based वाहनांसाठी समुच्चयक धोरण', 'Active', '2025-09-15'),
(324, 149, 'महाराष्ट्र जहाजबांधणी, जहाजदुरुस्ती आणि जहाज पुनर्वापर सुविधा विकास धोरण-२०२5', 'Active', '2025-09-15'),
(325, 149, 'कैद्याच्या कोठडी मृत्युप्रकरणी नुकसानभरपाई देण्याचे धोरण', 'Active', '2025-09-15'),
(326, 149, 'परिवहन महामंडळाच्या ताब्यातील अतिरिक्त जमिनींचा व्यापारी तत्वावर उपयोग करण्यासाठी धोरण', 'Active', '2025-09-15'),
(327, 149, 'महाराष्ट्र सागरी विकास धोरण, 2023', 'Active', '2025-09-15'),
(328, 149, 'महाराष्ट्र इलेक्ट्रिक वा़हन धोरण 2021', 'Active', '2025-09-15'),
(329, 149, ' ई प्रशासन धोरण', 'Active', '2025-09-15'),
(330, 149, ' विदेशी मद्यनिर्मिती करण्यासाठी धोरण', 'Active', '2025-09-15'),
(331, 149, 'निरा लागवड, उत्पादन, प्रक्रिया व विक्री याबाबत सुधारीत धोरण.', 'Active', '2025-09-15'),
(332, 149, 'नवीन ताडी धोरण', 'Active', '2025-09-15'),
(333, 149, 'बंदर विकास धोरण 2016.', 'Active', '2025-09-15'),
(334, 149, 'क्षमतेपेक्षा अधिक भार वाहणाऱ्या वाहनांवर कारवाई करणेबाबतचे धोरण....', 'Active', '2025-09-15'),
(335, 149, 'रुफ टॉप धोरण', 'Active', '2025-09-15'),
(336, 149, 'ज्येष्ठ नागरिक धोरण', 'Active', '2025-09-15'),
(337, 149, 'मद्यार्क निर्मिती धोरण', 'Active', '2025-09-15'),
(338, 149, 'ई-रिक्षा परवाने देण्याबाबतचे धोरण', 'Active', '2025-09-15'),
(339, 149, ' हेल्मेट नाही तर पेट्रोल नाही धोरण', 'Active', '2025-09-15'),
(340, 149, 'अनधिकृत प्रार्थना स्थळाचे बांधकाम निष्कासित / नियमित करणे / स्थलांतरीत करणे यासंबंधी धोरण', 'Active', '2025-09-15'),
(341, 149, 'लहान बंदरे/बहुद्देशिय जेट्टी/कार्गो टर्मिनल्स(रो-रो सर्व्हिसेस)यांच्या विकास धोरण', 'Active', '2025-09-15'),
(342, 149, 'शस्त्र अधिनियम व नियम, धोरण', 'Active', '2025-09-15'),
(343, 149, 'महिला विषयक धोरण', 'Active', '2025-09-15'),
(344, 149, 'गृह निर्माण धोरण', 'Active', '2025-09-15'),
(345, 150, 'प्रकल्पबाधित व्यक्तींसाठी सदनिका  वितरीत करण्याबाबतचे धोरण', 'Active', '2025-09-15'),
(346, 150, 'बदली धोरण ', 'Active', '2025-09-15'),
(347, 150, 'शासनाच्या वाट्याच्या १० कोट्यातील सदनिकांच्या वितरणाबाबतचे धोरण', 'Active', '2025-09-15'),
(348, 150, 'ज्येष्ठ नागरिक धोरण - 2013', 'Active', '2025-09-15'),
(349, 150, 'संयुक्त भागीदारी धोरण', 'Active', '2025-09-15'),
(350, 150, 'शासकीय गृहनिर्माण योजनेत दुसरे घर अनुज्ञेय न करण्याबाबतचे धोरण', 'Active', '2025-09-15'),
(351, 150, 'दि. 1.1.1995 च्या मतदार यादीत नावे असलेल्या पुनर्वसन करण्याबाबतचे धोरण', 'Active', '2025-09-15'),
(352, 150, 'मुख्यमंत्री वाटपातील गृहनिर्माण मंडळांची २ टक्के निवासस्थान वाटपासंबंधी धोरण', 'Active', '2025-09-15'),
(353, 150, 'बंदर विकास धोरण', 'Active', '2025-09-15'),
(354, 150, ' गृहनिर्माण योजना राबविण्याबाबतचे धोरण', 'Active', '2025-09-15'),
(355, 151, 'बांधा, वापरा व हस्तांतरण करा (BOT) तत्वावर विकसन धोरण', 'Active', '2025-09-15'),
(356, 151, 'सौर/इतर अक्षय ऊर्जा संकरित प्रकल्पांच्या विकासासाठी धोरण', 'Active', '2025-09-15'),
(357, 151, 'नलिकेद्वारे वितरण प्रणाली धोरण', 'Active', '2025-09-15'),
(358, 151, 'अधिसूचित नद्यांची वहन क्षमता पुन:स्थापित करण्याचे धोरण ', 'Active', '2025-09-15'),
(359, 151, 'चर योजना मापदंड व कार्यपध्दती धोरण', 'Active', '2025-09-15'),
(360, 151, 'लहान जलविद्युत प्रकल्पांच्या विकासाचे खाजगीकरण विषयक धोरण', 'Active', '2025-09-15'),
(361, 151, 'CSR अंतर्गत कामे करण्यासाठी धोरण', 'Active', '2025-09-15'),
(362, 151, 'पुनर्वसित गावांना देण्यात येणा-या नागरी सुविधांच्या देखभाल दुरुस्तीबाबतच्या धोरण', 'Active', '2025-09-15'),
(363, 151, 'खारवट /पाणथळ जमिनीची सुधारणा करणेसाठी उपाय योजना राबविणेबाबतचे धोरण', 'Active', '2025-09-15'),
(364, 151, 'पूरसंरक्षक', 'Active', '2025-09-15'),
(365, 151, 'विशेष दुरुस्ती/विस्तार व सुधारणा ', 'Active', '2025-09-15'),
(366, 151, 'बिगर सिंचनासाठी पाणी आरक्षणबाबत धोरण', 'Active', '2025-09-15'),
(367, 151, ' Public Private Partnership या तत्वावर खासगी यंत्रणांकडून विकसित करणे व व्यवस्थापन', 'Active', '2025-09-15'),
(368, 151, 'नदीजोड प्रकल्प धोरण', 'Active', '2025-09-15'),
(369, 151, 'मोठया पाटबंधारे प्रकल्पातून गाळ व गाळमिश्रित वाळू / रेती निष्कासनाबाबतचे धोरण', 'Active', '2025-09-15'),
(370, 151, 'खाजगी सहभागान्वये लहान जलविद्युत प्रकल्प विकसित करण्यासंदर्भात धोरण', 'Active', '2025-09-15'),
(371, 151, 'लहान जलविद्युत प्रकल्पांच्या विकासाचे खाजगीकरण विषयक धोरण', 'Active', '2025-09-15'),
(372, 151, 'सिंचन प्रकल्पांच्या लाभक्षेत्रात वितरण व्यवस्था करण्याचे धोरण', 'Active', '2025-09-15'),
(373, 151, 'सिंचन प्रकल्पांच्या (250 हे. वरील) व्याप्तीतील बदलाबाबतचे धोरण', 'Active', '2025-09-15'),
(374, 151, 'मोठ्या उपसा सिंचन योजना शासकीय खर्चाने हाती घेण्याबाबत शासनाचे धोरण ', 'Active', '2025-09-15'),
(375, 151, 'प्रकल्प नियोजन व बांधकाम व्यवस्थापनाबाबतचे धोरण', 'Active', '2025-09-15'),
(376, 151, 'कार्यालयाची पुर्नरचना व कार्यात्मक बदलाचे नवीन धोरण', 'Active', '2025-09-15'),
(377, 151, 'पाणीपट्टी ठरविण्याबाबतचे धोरण', 'Active', '2025-09-15'),
(378, 151, 'खाजगी प्रवर्तकाचा सहभाग वाढविण्याबाबत जलविद्युत धोरण', 'Active', '2025-09-15'),
(379, 152, 'दिव्यांग उपक्रमांना अनुदान तत्वावर मान्यता ', 'Active', '2025-09-15'),
(380, 153, 'सौर ऊर्जा प्रकल्प उभारण्यासाठी अर्थसहाय्य करण्याबाबतचे धोरण ', 'Active', '2025-09-15'),
(381, 153, 'व्यवसाय सुलभता धोरण', 'Active', '2025-09-15'),
(382, 153, 'मुंबई मेट्रो लाईन-1 (वर्सोवा-अंधेरी-घाटकोपर) धोरणात्मक अधिग्रहण', 'Active', '2025-09-15'),
(383, 153, 'रेसकोर्स, विविध जिमखाने व तत्सम भूभागांचे नुतनीकरण करण्याबाबतचे धोरण', 'Active', '2025-09-15'),
(384, 153, 'आंतरराष्ट्रीय वित्तीय आणि व्यापार केंद्र / वित्तीय व्यापार क्षेत्र', 'Active', '2025-09-15'),
(385, 153, 'भूमि संपादनाचा मोबदला ठरविण्यासाठी धोरण', 'Active', '2025-09-15'),
(386, 153, 'इलेक्ट्रीक वाहन धोरण-2021', 'Active', '2025-09-15'),
(387, 153, 'नागरी भागातील सांडपाण्यावर प्राधान्याने प्रक्रिया करण्याच्या धोरण ', 'Active', '2025-09-15'),
(388, 153, 'मुद्रांक शुल्क अधिभाराची रक्कम नागरी परिवहन प्रकल्पांच्या अंमलबजावणी यंत्रणेस वितरीत करण्यासाठीचे धोरण', 'Active', '2025-09-15'),
(389, 153, 'सर्वांसाठी घरे -2022 धोरण', 'Active', '2025-09-15'),
(390, 153, 'ज्येष्ठ नागरिक धोरण- 2013', 'Active', '2025-09-15'),
(391, 153, 'महाराष्ट्र राज्य सांस्कृतिक धोरण 2010', 'Active', '2025-09-15'),
(392, 153, 'पर्यटन धोरण- 2016', 'Active', '2025-09-15'),
(393, 153, 'बदली धोरण ', 'Active', '2025-09-15'),
(394, 153, 'राज्य विवाद धोरण', 'Active', '2025-09-15'),
(395, 153, 'नवनिर्मित नगरपरिषदा/नगरपंचायतीमध्ये ग्रामपंचायतीच्या कर्मचाऱ्यांचे समावेशन करण्याबाबत धोरण', 'Active', '2025-09-15'),
(396, 153, 'सदनिका वाटपाबाबतचे  धोरण', 'Active', '2025-09-15'),
(397, 153, ' आकाशचिन्‍ह जाहिरात धोरण-2010', 'Active', '2025-09-15'),
(398, 153, 'मोबाईल टॉवर उभारणी संदर्भात धोरण', 'Active', '2025-09-15'),
(399, 153, ' विशेष आर्थिक क्षेत्र धोरणांतर्गत सेझ प्रकल्‍पांना जकात करातून सूट/माफी', 'Active', '2025-09-15'),
(400, 153, 'राष्‍ट्रीय फेरीवाला धोरण', 'Active', '2025-09-15'),
(401, 153, 'कमाल धारणा व विनियमन)अधिनियम 1976 अंतर्गत शासनाने ताब्यात घेतलेल्या जमिनीचे वाटप करण्यासंदर्भातील धोरण', 'Active', '2025-09-15'),
(402, 153, 'शहरी स्वर्ण जयंती रोजगार योजना', 'Active', '2025-09-15'),
(403, 153, 'सरकारी जागेवरील आरक्षित भुखंडाच्या टीडीआर/एफ.एस.आय मंजूर करणेबाबत धोरणात्मक निर्णय', 'Active', '2025-09-15'),
(404, 154, 'महाराष्ट्र राज्य आधारसामग्री धोरण - 2024', 'Active', '2025-09-15'),
(405, 154, 'मराठी भाषा धोरण', 'Active', '2025-09-15'),
(406, 154, 'मनरेगातंर्गत कामांना प्रशासकीय व तांत्रिक मंजुरीचे धोरण', 'Active', '2025-09-15'),
(407, 154, 'बदली धोरण', 'Active', '2025-09-15'),
(408, 154, 'पुरवठादार व्यवस्थापन धोरण', 'Active', '2025-09-15'),
(409, 154, 'राज्यातील तीर्थक्षेत्र, पर्यटनस्थळ-परिसर विकास आराखडा अंतिम करणे व अंमलबजावणीसाठी धोरण ', 'Active', '2025-09-15'),
(410, 154, 'कंत्राटी पध्दतीने घेतलेल्या मनुष्यबळ व्यवस्थापन धोरण', 'Active', '2025-09-15'),
(411, 154, 'तिबेटीयन पुनर्वसन धोरण - 2014 ', 'Active', '2025-09-15'),
(412, 154, 'ई-प्रशासन धोरण', 'Active', '2025-09-15'),
(413, 154, 'राज्य क्रीडा धोरण, 2012 ', 'Active', '2025-09-15'),
(414, 154, 'वैयक्तिक लाभदायक योजनांना लोकसंख्‍या धोरण लागू करणेबाबत', 'Active', '2025-09-15'),
(415, 155, 'पर्यटन धोरण 2024', 'Active', '2025-09-15'),
(416, 155, 'महाराष्ट्र राज्य सांस्कृतिक धोरण, 2024', 'Active', '2025-09-15'),
(417, 155, 'चित्रपट धोरण', 'Active', '2025-09-15'),
(418, 155, 'सार्वजनिक-खाजगी सहभाग द्वारे म.प.वि.म. (MTDC) कडील जमिनींच्या धोरण', 'Active', '2025-09-15'),
(419, 155, 'आई महिला केंद्रित / लिंग समावेशक पर्यटन धोरण', 'Active', '2025-09-15'),
(420, 155, 'साहसी पर्यटन उपक्रम धोरण', 'Active', '2025-09-15'),
(421, 155, 'कृषी पर्यटन धोरण', 'Active', '2025-09-15'),
(422, 155, 'कॅरॅव्हॅन पर्यटन धोरण', 'Active', '2025-09-15'),
(423, 155, 'बीच शॅक्स धोरण', 'Active', '2025-09-15'),
(424, 155, 'पर्यटन प्रकल्पांना अनुज्ञेय वित्तीय प्रोत्साहन', 'Active', '2025-09-15'),
(425, 155, 'पर्यटन धोरण 2016', 'Active', '2025-09-15'),
(426, 155, 'पर्यटन धोरण 2000', 'Active', '2025-09-15'),
(427, 155, 'पर्यटन धोरण - २००६', 'Active', '2025-09-15'),
(428, 155, 'आंतरराष्ट्रीय चित्रपट महोत्सवांचे आयोजन करणाऱ्या संस्थांना अर्थसहाय्य देण्याबाबतचे धोरण', 'Active', '2025-09-15'),
(429, 156, 'कार्बन क्रेडिट्स संदर्भात राष्ट्रीय धोरण', 'Active', '2025-09-15'),
(430, 156, 'महाराष्ट्र इलेक्ट्रिक वाहन धोरण 2021', 'Active', '2025-09-15'),
(431, 156, 'महाराष्ट्र राज्याचे वातावरणीय बदल अनुकूलन धोरण', 'Active', '2025-09-15'),
(432, 156, 'नद्यांच्‍या पाणी गुणवत्‍तेमध्‍ये सुधारणा करण्‍याबाबत धोरण', 'Active', '2025-09-15'),
(433, 157, 'जिल्ह्यांचा गुणवत्ता क्रमांक सुनिश्चित करण्यासाठी तीन टप्पे पडताळणी धोरण', 'Active', '2025-09-15'),
(434, 157, 'पाणी गुणवत्ता तपासणीकरिता जैविक FTK - H2S vials चा वापर, खरेदी व वितरणाबाबतचे धोरण', 'Active', '2025-09-15'),
(435, 157, 'पर्यटन धोरण -2016 - पाणीपट्‌टी', 'Active', '2025-09-15'),
(436, 157, 'पर्यटन धोरण -2006 - पाणीपट्‌टी', 'Active', '2025-09-15'),
(437, 157, 'खाजगी नमुने FTK द्वारे प्राथमिक तपासणीसाठी धोरण ', 'Active', '2025-09-15'),
(438, 157, 'राज्यातील ग्रामीण पाणी पुरवठा योजनांसाठी लोकवर्गणीचे सुधारित धोरण', 'Active', '2025-09-15'),
(439, 157, 'ग्रामीण पाणी पुरवठा योजनांसाठी हागणदारी मुक्तीचे धोरण', 'Active', '2025-09-15'),
(440, 157, 'ग्रामीण पाणी पुरवठा कार्यक्रमाची धोरण', 'Active', '2025-09-15'),
(441, 157, 'धनकचरा व सांडपाणी व्यवस्थापन धोरण', 'Active', '2025-09-15'),
(442, 157, 'भारत निर्माण कर्यक्रमांतर्गत अंमलबजावणीचे धोरण', 'Active', '2025-09-15'),
(443, 157, 'पाणीपुरवठा व स्‍व‍च्‍छता कार्यक्रमांसाठी सेवाभावी संस्‍थाची निवड करण्‍यासाठी धोरण', 'Active', '2025-09-15'),
(444, 157, 'पाणी गुणवत्ता नियंत्रण', 'Active', '2025-09-15'),
(445, 158, 'प्रशिक्षण धोरण ', 'Active', '2025-09-15'),
(446, 158, 'मृद व जलसंधारण विभागांतर्गत योजनांच्या भुसंपादनाविषयी धोरण', 'Active', '2025-09-15'),
(447, 158, 'ई-प्रशासन धोरण', 'Active', '2025-09-15'),
(448, 159, 'महाराष्ट्र राज्याचे मराठी भाषा धोरण', 'Active', '2025-09-15'),
(449, 159, 'धोरणात्मक शासन आदेश/निर्णय यांचे संकलन असलेली ई-पुस्तिका', 'Active', '2025-09-15'),
(450, 159, 'महाराष्ट्र राज्य सांस्कृतिक धोरण, 2010', 'Active', '2025-09-15'),
(451, 160, ' धुळ प्रदुषणाने नुकसान झालेल्या शेती पिकाला  नुकसान भरपाई देण्याकरिता धोरण', 'Active', '2025-09-15'),
(452, 160, 'कृत्रिम वाळूचा वापर करण्याकरीता धोरण', 'Active', '2025-09-15'),
(453, 160, 'अनुकंपा धोरण', 'Active', '2025-09-15'),
(454, 160, 'वाळू/रेती निर्गती धोरण-2025', 'Active', '2025-09-15'),
(455, 160, 'सागरी किनारपट्टी विनियमन क्षेत्रातून नौकानयन मार्ग सुकर करण्यासाठी वाळू/रेती निर्गती धोरण', 'Active', '2025-09-15'),
(456, 160, 'कृषि उत्पन्न बाजार समित्यांना शासकीय जमीन प्रदान करण्याबाबत धोरण', 'Active', '2025-09-15'),
(457, 160, ' ऑनलाईन बदली धोरण', 'Active', '2025-09-15'),
(458, 160, 'औद्योगिक प्रयोजनासाठी संपादित जमिनीच्या विक्री/वापर बदलाच्या अनुषंगाने सुधारित धोरण', 'Active', '2025-09-15'),
(459, 160, 'शासनाने प्रदान केलेल्या जमिनीचे / भूखंडाचे हस्तांतरण', 'Active', '2025-09-15'),
(460, 160, ' क्रीडा धोरण -2012', 'Active', '2025-09-15'),
(461, 160, 'शासकीय जमिनीतील मोकळी जागा विविध तात्पुरत्या प्रयोजनाकरीता भाडयाने देण्याबाबतचे धोरण', 'Active', '2025-09-15'),
(462, 160, 'मोकळंया जागा विविध तात्पुरत्या प्रयोजनाकरीता भाडयाने देण्याचे धोरण', 'Active', '2025-09-15'),
(463, 160, 'न्मुंबईतील शासकीय जमिनीवरील संपुष्टात आलेल्या भाडेपट्ट्याचे नुतनीकरण करण्यासंबंधीचे धोरण ', 'Active', '2025-09-15'),
(464, 160, 'उर्वरित महाराष्ट्रामधील शासकीय जमिनीवरील संपुष्टात आलेल्या व यापुढे संपणाऱ्या भाडेपट्ट्यांचे नुतनीकरण करण्यासंबंधीचे धोरण ', 'Active', '2025-09-15'),
(465, 160, ' राज्यातील किनाऱ्यालगत महसूली गावांच्या महसूल दप्तर तयार न झालेल्या अशा जमिनींचे सर्वेक्षण, मोजणी व वापराबाबत धोरण', 'Active', '2025-09-15'),
(466, 160, 'प्रकल्पबाधित व्यक्तींना वाटप केलेल्या पर्यायी जमिनीचे भोगवटादार वर्ग-1 मध्ये रुपांतर करण्याबाबत', 'Active', '2025-09-15'),
(467, 160, 'कब्जेहक्काने अथवा भाडेपट्टयाने प्रदान करण्यात आलेल्या शासकीय जमिनीवरील इमारत बांधकामासाठी मुदतवाढ देण्याबाबत धोरणात्मक निर्देश', 'Active', '2025-09-15'),
(468, 160, 'शासकीय जमिनीच्या संदर्भात भाडेपट्टयांचे नुतनीकरणाचे धोरण', 'Active', '2025-09-15'),
(469, 160, 'शासकीय जमिनीवरील आढळून आलेले शर्तभंग नियमानुकूल करण्याबाबत धोरण', 'Active', '2025-09-15'),
(470, 160, 'भाडेपट्टयाने/कब्जेहक्काने दिलेल्या जमिनीच्या पुनर्विकासास/ पुनर्बांधकामास परवानगी देण्याबाबत', 'Active', '2025-09-15'),
(471, 160, 'बंदर विकास धोरण-2016 ', 'Active', '2025-09-15'),
(472, 160, 'करमणूक शुल्काच्या आकारणीतून सवलत प्रदान करण्याबाबत', 'Active', '2025-09-15'),
(473, 160, ' पर्यटन प्रकल्पांना बिगरशेती करातून संपूर्ण सूट देणेबाबत', 'Active', '2025-09-15'),
(474, 160, 'मुंबईतील घोडागाडी व्यवसायिकांचे पुनर्वसन', 'Active', '2025-09-15'),
(475, 160, 'नागपूर व अमरावती विभागातील नझूल जमिनीबाबत सुधारित धोरण', 'Active', '2025-09-15'),
(476, 160, 'सहकारी गृहनिर्माण संस्थांना शासकीय जमीन देण्यासंदर्भातील धोरण', 'Active', '2025-09-15'),
(477, 160, 'आधि पुनर्वसन मग धरण धोरण', 'Active', '2025-09-15'),
(478, 160, ' भूसंपादन मोबदल्‍याचे देवस्‍थान व कुळ यांच्‍यामध्‍ये विभाजन करण्‍याबाबतच्‍या प्रचलित शासन निर्णयात धोरणात सुधारणा', 'Active', '2025-09-15'),
(479, 160, 'शासकीय जमिनींवरील जिमखान्यांच्या भाडेपट्टयांचे नुतनीकरण करण्याबाबतचे धोरण', 'Active', '2025-09-15'),
(480, 160, ' भूसंपादन मोबदल्‍याचे देवस्‍थान व कुळ यांच्‍यामध्‍ये विभाजन करण्‍याबाबतच्‍या प्रचलित शासन निर्णयात धोरणात सुधारणा', 'Active', '2025-09-15'),
(481, 160, 'अनधिकृत अकृषिक वापर  केल्यामुळे आकारण्यात येणाऱ्या दंडाच्या रकमेविषयी धोरण ठरविणे', 'Active', '2025-09-15'),
(482, 160, 'सन 1984 च्या शीख दंगलीत मालमत्तेचे नुकसान झालेल्या ज्या आपद्ग्रस्तांना केंद्र शासनाच्या धोरणानुसार मदत', 'Active', '2025-09-15'),
(483, 160, 'अंध अंपगाना निवासासाठी,वाणिज्यिक/औद्योगिक प्रयोजनासाठी विनांलिलावाने जमीन देण्‍यासंबंधातील धोरण', 'Active', '2025-09-15'),
(484, 160, 'ऑप्‍टीक फायबर केबल नेटवर्क पुरविणा-या कंपन्‍यांना शासनाचे धोरण', 'Active', '2025-09-15'),
(485, 160, 'गृहनिर्माण आणि क्षेत्र विकास प्राधिकरणास प्रदान करावयाच्‍या जमीनीसाठी आकारावयाच्‍या किंमतीबाबतचे सुधारीत धोरण', 'Active', '2025-09-15'),
(486, 160, 'भूईभाज्‍याच्‍या अधिक दरासंबंधीचे धोरण', 'Active', '2025-09-15'),
(487, 160, 'जमीन म्‍हाडाला दिलेल्‍या जमीनीच्‍या किंमतीबाबत सुधारीत धोरण', 'Active', '2025-09-15'),
(488, 161, 'तेंदू संकलन धोरण', 'Active', '2025-09-15'),
(489, 161, 'पाटबंधारे प्रकल्‍पांना वन जमीन उपलब्‍ध करुन देण्‍यामध्‍ये येणा-या अडचणीवर धोरणात्‍मक निर्णय ', 'Active', '2025-09-15'),
(490, 161, 'कालबध्द तांत्रिक प्रशिक्षण देण्याबाबतचे धोरण ', 'Active', '2025-09-15'),
(491, 161, 'अभयारण्ये, राष्ट्रीय उद्याने तथा अन्य वन प्रकल्पामुळे बाधित होणाऱ्या कुटूंबाचे पुनर्वसनाबाबत धोरण', 'Active', '2025-09-15'),
(492, 162, 'महिला धोरण', 'Active', '2025-09-15'),
(493, 162, 'अनाथ आरक्षण धोरण', 'Active', '2025-09-15'),
(494, 162, 'पुर्व बाल्यावस्थेतील संगोपन व शिक्षण धोरण ', 'Active', '2025-09-15'),
(495, 162, 'अंगणवाडी दत्तक धोरण', 'Active', '2025-09-15'),
(496, 163, 'दूरसंचार पायाभूत सुविधा धोरण', 'Active', '2025-09-15'),
(497, 163, 'क्लाऊड कम्प्युटिंग धोरण', 'Active', '2025-09-15'),
(498, 163, 'ग्लोबल फिनटेक हब आणि फिनटेक धोरण', 'Active', '2025-09-15'),
(499, 163, 'दूरसंचार पायाभूत सुविधा धोरण', 'Active', '2025-09-15'),
(500, 163, 'महाराष्ट्र शासनाचे ई-प्रशासन धोरण', 'Active', '2025-09-15'),
(501, 163, 'आय. टी. सव्हीसेस, प्रोव्हायडरचे धोरण', 'Active', '2025-09-15'),
(502, 163, 'संगणक व इतर तदनुषंगीक बाबींच्या देखभाली बाबतचे धोरण', 'Active', '2025-09-15'),
(503, 163, 'माहिती तंत्रज्ञान संबंधी पद निर्मिती (माहिती तंत्रज्ञान संचालनालय सोडून), नियुक्तीचे धोरण', 'Active', '2025-09-15'),
(504, 163, 'माहिती व तंत्रज्ञान धोरण', 'Active', '2025-09-15'),
(505, 164, 'अवयवदान व अवयव प्रत्यारोपण', 'Active', '2025-09-15'),
(506, 164, 'पदभरतीसाठीच्या स्वतंत्र धोरणाबाबत', 'Active', '2025-09-15'),
(507, 164, 'सेंटर्स ऑफ़ एक्सलंस धोरण -२०२३', 'Active', '2025-09-15'),
(508, 164, 'मालमत्तांच्या व्यवस्थापनासाठी व्यवस्थापन आणि शाश्वत धोरण, २०२३', 'Active', '2025-09-15'),
(509, 164, 'आरोग्य विज्ञान अभ्यासक्रमाचे शैक्षणिक धोरण', 'Active', '2025-09-15'),
(510, 165, 'शासनाच्या विविध विभागांमध्ये महाराष्ट्र वित्त व लेखा सेवेतील अधिकाऱ्यांच्या नियुक्तीचे सर्वंकष धोरण', 'Active', '2025-09-15'),
(511, 165, 'महाराष्ट्र राज्य शासकीय हमी धोरण ', 'Active', '2025-09-15'),
(512, 165, 'शासकीय निधी केवळ राष्ट्रीयकृत बँकामध्येच ठेवणेबाबत शासनाचे धोरण', 'Active', '2025-09-15'),
(513, 165, 'शासकीय/निमशासकीय सेवेतील खेळाडंच्या पालकांना रजा सवलती देण्याबाबत', 'Active', '2025-09-15'),
(514, 165, 'बीम्‍स, डी. सी. पी. एस., सेवार्थ या प्रणालीच्‍या पासवर्डबाबतचे धोरण', 'Active', '2025-09-15'),
(515, 165, 'शासकीय वाहनांचे किंमत मर्यादा धोरण', 'Active', '2025-09-15'),
(516, 165, 'राज्य लोकसंख्या धोरण', 'Active', '2025-09-15'),
(517, 165, 'पुर्व-हैद्राबाद राज्‍य जीवन बीमा निधी धोरण', 'Active', '2025-09-15'),
(518, 166, 'जिल्हा सरकारी वकील आणि अतिरिक्त अथवा सहायक सरकारी वकील नेमणेबाबत धोरण ', 'Active', '2025-09-15'),
(519, 166, 'न्यायालयांकरिता पायाभूत सुविधा धोरण', 'Active', '2025-09-15'),
(520, 166, 'लवाद धोरण', 'Active', '2025-09-15'),
(521, 166, 'राज्य विवाद धोरण ', 'Active', '2025-09-15'),
(522, 166, 'विशेष समुपदेशी/ वरीष्ठ विधिज्ञ यांची नियुक्ती करण्याबाबतचे धोरण', 'Active', '2025-09-15'),
(523, 167, 'राज्याचे क्रीडा धोरण, 2012', 'Active', '2025-09-15'),
(524, 167, 'महाराष्ट्र राज्याचे युवा धोरण, २०१२', 'Active', '2025-09-15'),
(525, 167, 'क्रीडा संकुल धोरण', 'Active', '2025-09-15'),
(526, 167, 'द्योजकांचे सामाजिक उत्तरदायित्व धोरण', 'Active', '2025-09-15'),
(527, 167, 'खेळाडूंना शासन सेवेत थेट नियुक्ती देण्यासंदर्भात सुधारीत धोरण', 'Active', '2025-09-15'),
(528, 168, 'राष्ट्रीय शैक्षणिक धोरण, 2020', 'Active', '2025-09-15'),
(529, 168, 'राज्यातील अल्पसंख्यांक समाजाचे शैक्षणिक धोरण', 'Active', '2025-09-15'),
(530, 168, ' अंशकालीन निदेशकांची नियुक्ती', 'Active', '2025-09-15'),
(531, 168, 'राज्यातील सैनिकी शाळांच्या धोरण', 'Active', '2025-09-15'),
(532, 168, 'विद्यार्थ्यांच्या सुरक्षिततेबाबत धोरण', 'Active', '2025-09-15'),
(533, 168, 'ई-शैक्षणिक साहित्य दाखविण्याबाबतचे धोरण ', 'Active', '2025-09-15'),
(534, 168, 'रात्रशाळेतील सर्वकष धोरण', 'Active', '2025-09-15'),
(535, 168, 'कायमस्वरुपी समावेशन करण्याबाबतचे धोरण', 'Active', '2025-09-15'),
(536, 168, 'राज्यातील शाळांच्या स्थलांतर धोरणात सुधारणा', 'Active', '2025-09-15'),
(537, 168, 'तंबाखूमुक्त शाळा धोरण-2020', 'Active', '2025-09-15'),
(538, 168, 'खाजगी स्पर्धा परीक्षा,टॅलेंट सर्च परीक्षांच्या आयोजनाबाबतचे धोरण', 'Active', '2025-09-15'),
(539, 168, 'नवीन शाळा स्थापन विद्यमान शाळेचा दर्जावाढ व राज्यात फक्त A ग्रेड च्या शाळा संचालित होतील याचे धोरण निश्चीत करणे बाबत.', 'Active', '2025-09-15'),
(540, 168, 'विनाअनुदान कायम विनाअनुदान व स्वयंअर्थसहाय्यित शाळांच्या धोरणा', 'Active', '2025-09-15'),
(541, 168, 'सामाजिक उत्तरदायित्व (CSR) धोरण', 'Active', '2025-09-15'),
(542, 168, 'शैक्षणिक सहलींचे आयोजन', 'Active', '2025-09-15'),
(543, 168, ' प्रशिक्षण धोरण', 'Active', '2025-09-15'),
(544, 168, 'राज्य विवाद धोरण', 'Active', '2025-09-15'),
(545, 168, 'नाहरकत प्रमाणपत्रा देण्यासंदर्भातील धोरण', 'Active', '2025-09-15'),
(546, 168, 'शिक्षक व शिक्षकेतर कर्मचारी नियुक्तीमध्ये आरक्षण धोरण', 'Active', '2025-09-15'),
(547, 169, ' भांडवली खर्च व खेळत्या भांडवलासाठी कर्ज मंजूर करण्याबाबतचे सुधारित धोरण', 'Active', '2025-09-15'),
(548, 169, 'एफ.आर.पी. प्रमाणे ऊस दर अदा करावयाचे धोरण', 'Active', '2025-09-15'),
(549, 169, 'राज्यातील आर्थिक अडचणीतील सहकारी साखर कारखान्यांना शासन हमीवर मुदती कर्ज उपलब्ध करून देण्याबाबतचे धोरण', 'Active', '2025-09-15'),
(550, 169, 'राष्ट्रीय सहकार धोरण २०२३', 'Active', '2025-09-15'),
(551, 169, ' हमीभावाने कडधान्ये व तेलबिया खरेदीसाठी धोरण निश्चित करणेबाबत', 'Active', '2025-09-15'),
(552, 169, 'खांडसरी उद्योगांना मान्यता व उत्पादन परवाना देण्याबाबतचे धोरण ', 'Active', '2025-09-15'),
(553, 169, 'राज्याचे कृषि निर्यात धोरण', 'Active', '2025-09-15'),
(554, 169, 'ऊस गळीत हंगामाचा आढावा व धोरण', 'Active', '2025-09-15'),
(555, 169, ' FRP निश्चिती करण्यासाठीचे धोरण', 'Active', '2025-09-15'),
(556, 169, 'सहकारी साखर कारखान्यांना राज्य शासनामार्फत शासन हमी देण्याबाबत ', 'Active', '2025-09-15'),
(557, 169, 'सहकारी सूतगिरण्यांच्या नोंदणीस मान्यता देण्याकरिता सुधारित धोरण', 'Active', '2025-09-15'),
(558, 169, 'बँकांबाबत धोरणात्मक निर्णय घेणेबाबत', 'Active', '2025-09-15'),
(559, 169, ' विभागातील कालबाहय व नादुरुस्त संगंणक संचांची विल्हेवाट लावणेबाबत', 'Active', '2025-09-15'),
(560, 169, 'सहकारी सूतगिरण्यांबाबतचे धोरण', 'Active', '2025-09-15'),
(561, 169, 'सहकारी सूत गिरण्यांची  प्रकल्प अहवाल किंमत निश्चित करणे व प्रकल्प किंमती संदर्भात निकष / धोरण', 'Active', '2025-09-15'),
(562, 169, 'कापूस खरेदी धोरण', 'Active', '2025-09-15'),
(563, 169, 'सहकारी कर्ज वसूलीचे धोरण', 'Active', '2025-09-15'),
(564, 169, 'सहकारी पीक संस्थांकडून करावयाची पीक कर्ज वसूलीचे धोरण', 'Active', '2025-09-15'),
(565, 170, 'एकात्मिक व शाश्वत वस्त्रोद्योग धोरण 2023-28', 'Active', '2025-09-15'),
(566, 170, 'राज्याचे वस्त्रोद्योग धोरण 2018--23', 'Active', '2025-09-15'),
(567, 170, 'महाराष्ट्र राज्याचे वस्त्रोद्योग धोरण सन 2011-17', 'Active', '2025-09-15'),
(568, 170, ' फॉर्म A शासनास सादर करण्यासाठी मुदतवाढ ', 'Active', '2025-09-15'),
(569, 170, 'खरेदी धोरणाची अंमलबजावणी', 'Active', '2025-09-15'),
(570, 170, 'भांडवली सवलत योजना', 'Active', '2025-09-15'),
(571, 170, 'व्याज अनुदानाऐवजी भांडवली अनुदान', 'Active', '2025-09-15'),
(572, 171, 'परदेश शिष्यवृत्ती', 'Active', '2025-09-15'),
(573, 171, 'खुल्या प्रवर्गातील महिला, आर्थिकदृष्टया मागास प्रवर्गातील उमेदवार, SEBC क्षेत्रातील आरक्षणबाबत धोरण', 'Active', '2025-09-15'),
(574, 171, 'तृतीयपंथीयांसाठीचे धोरण', 'Active', '2025-09-15'),
(575, 171, ' इमारतींच्या पुर्नविकासाचे धोरण', 'Active', '2025-09-15'),
(576, 171, 'अनुदानित वसतिगृह ईमारतीबाबत भाडे धोरण', 'Active', '2025-09-15'),
(577, 171, 'व्यसनमुक्ती धोरण', 'Active', '2025-09-15'),
(578, 171, 'दिव्यांग धोरण', 'Active', '2025-09-15'),
(579, 171, 'ज्येष्ठ नागरिक धोरण', 'Active', '2025-09-15'),
(580, 171, 'काम नाही, वेतन नाही धोरण', 'Active', '2025-09-15'),
(581, 171, 'अपंगाच्या पदनिश्चितीबाबत ', 'Active', '2025-09-15'),
(582, 171, 'अंध अपंगांना निवासाठी वाणिज्यिक / औद्योगिक प्रयोजनासाठी विनालिलावाने जमीन देण्यासंबंधातील धोरण', 'Active', '2025-09-15'),
(583, 172, 'आणीबाणी कालावधीत बंदिवास व्यक्तींचा बंदिवास सन्मान/यथोचित गौरव करण्यासंबंधी धोरण', 'Active', '2025-09-15'),
(584, 172, 'दूरसंचार पायाभूत सुविधा धोरण ', 'Active', '2025-09-15'),
(585, 172, 'सायबर सुरक्षा धोरण', 'Active', '2025-09-15'),
(586, 172, 'कृत्रीम बुद्धीमत्ता', 'Active', '2025-09-15'),
(587, 172, 'कायमस्वरुपी समावेशन धोरण', 'Active', '2025-09-15'),
(588, 172, 'अखिल भारतीय सेवा तसेच केंद्रीय नागरी सेवेतील प्रतिनियुक्तीबाबत धोरण', 'Active', '2025-09-15'),
(589, 172, 'प्रतिनियुक्ती', 'Active', '2025-09-15'),
(590, 172, 'समुपदेशनाद्वारे बदलीबाबतचे धोरण', 'Active', '2025-09-15'),
(591, 172, 'राज्य प्रशिक्षण धोरण', 'Active', '2025-09-15'),
(592, 172, 'अनुकंपा नियुक्ती धोरण', 'Active', '2025-09-15'),
(593, 172, 'एकत्रित परिवीक्षाधीन प्रशिक्षण धोरण', 'Active', '2025-09-15'),
(594, 172, 'शासकीय जाहिरात वितरण धोरण', 'Active', '2025-09-15'),
(595, 172, 'विभागीय परीक्षांसंदर्भातील सामाईक बाबींबाबतचे धोरण', 'Active', '2025-09-15'),
(596, 172, 'महिला धोरण', 'Active', '2025-09-15'),
(597, 172, 'बृहन्मुंबईतील शासकीय निवासस्थान वाटपाबाबतचे  धोरण', 'Active', '2025-09-15'),
(598, 172, 'शासकीय पत्राचा नमुना,बोधचिन्ह घोषवाक्य  मुद्रित करण्याबाबतचे धोरण', 'Active', '2025-09-15'),
(599, 172, 'हेलिपॅड धोरण', 'Active', '2025-09-15'),
(600, 172, 'अतिथीगृहांतील कक्षबंध आरक्षण धोरण', 'Active', '2025-09-15'),
(601, 172, 'ज्येष्ठ नागरिक धोरण', 'Active', '2025-09-15'),
(602, 172, 'निवडणूक', 'Active', '2025-09-15'),
(603, 172, ' विमानतळ विकास ', 'Active', '2025-09-15'),
(604, 172, 'महाराष्ट्र धोरण संशोधन संस्था', 'Active', '2025-09-15'),
(605, 172, 'पुतळा धोरण', 'Active', '2025-09-15'),
(606, 172, 'समांतर आरक्षण', 'Active', '2025-09-15'),
(607, 172, 'अचानक बेपत्ता कर्मचारी /अधिकारी यांच्या शासकीय निवासस्थानासंबंधी धोरण ', 'Active', '2025-09-15'),
(608, 172, 'पुनर्नियुक्त अधिका-यांना निवासस्थानाचे वाटप', 'Active', '2025-09-15'),
(609, 172, 'ऑनलाईन लायब्ररी', 'Active', '2025-09-15'),
(610, 172, 'ज्‍येष्‍ठतासूची', 'Active', '2025-09-15'),
(611, 172, 'अल्पसंख्याक शैक्षणिक संस्थामधील शिक्षक व शिक्षकेतर कर्मचारी भरतीकरिताचे  आरक्षण ', 'Active', '2025-09-15'),
(612, 172, 'शासन व्यवहारात राजभाषा मराठीचा वापर', 'Active', '2025-09-15'),
(613, 172, 'आरक्षण', 'Active', '2025-09-15'),
(614, 172, 'आदिवासी विकास प्रकल्‍प क्षेत्रात गोपनीय अहवाल', 'Active', '2025-09-15'),
(615, 173, 'राज्य आरोग्य धोरण', 'Active', '2025-09-15'),
(616, 173, 'व्यावसायिक क्षेत्रातील सामाजिक बांधिलकी  संदर्भात धोरण ', 'Active', '2025-09-15'),
(617, 173, 'तृतीयपंथीयांसाठीचे धोरण', 'Active', '2025-09-15'),
(618, 173, 'शासकिय अधिकारी व कर्मचारी  वैद्यकीय तपासणी धोरण', 'Active', '2025-09-15'),
(619, 173, 'राष्ट्रीय रक्त धोरण', 'Active', '2025-09-15'),
(620, 173, 'दुर्मिळ आजारावरील औषधोपचारासाठी राष्ट्रीय धोरण', 'Active', '2025-09-15'),
(621, 173, 'मानसिक आरोग्याशी संबंधित अभ्यासक्रम ', 'Active', '2025-09-15'),
(622, 173, 'राज्‍य लोकसंख्‍या धोरण', 'Active', '2025-09-15'),
(623, 174, 'प्रकल्प आकस्मिक खर्चाचे शासन धोरण', 'Active', '2025-09-15'),
(624, 174, 'सार्वजनिक खाजगी सहभाग धोरण', 'Active', '2025-09-15'),
(625, 174, 'शासकीय भुखंड खाजगीकरण', 'Active', '2025-09-15'),
(626, 174, 'बांधकाम साहित्याच्या किंमत वाढ', 'Active', '2025-09-15'),
(627, 174, 'अपघातस्थळांची निश्चिती व सुधारणा', 'Active', '2025-09-15'),
(628, 174, 'पायाभूत सुविधा प्रकल्प ', 'Active', '2025-09-15'),
(629, 174, 'महाराष्ट्र राज्य विवाद धोरण', 'Active', '2025-09-15'),
(630, 174, 'पथकर विषयक धोरण', 'Active', '2025-09-15'),
(631, 175, 'E-Peek Pahani', 'Active', '2025-09-15'),
(632, 175, 'MSAMB', 'Active', '2025-09-15'),
(633, 175, 'MahaDBT Farmer', 'Active', '2025-09-15'),
(634, 175, 'PMKISAN GoI', 'Active', '2025-09-15'),
(635, 176, 'NextGen mParivahan', 'Active', '2025-09-15'),
(636, 176, 'MSRTC', 'Active', '2025-09-15'),
(637, 176, 'Rajmargyatra ', 'Active', '2025-09-15'),
(638, 176, 'CRIS', 'Active', '2025-09-15'),
(639, 177, 'Indian Post Mobile Banking', 'Active', '2025-09-15'),
(640, 177, 'DAK SEWA', 'Active', '2025-09-15'),
(641, 178, 'eCourts Services', 'Active', '2025-09-15'),
(642, 178, 'E Sakshya', 'Active', '2025-09-15'),
(643, 178, 'E Summon', 'Active', '2025-09-15'),
(644, 178, 'e-Prosecution', 'Active', '2025-09-15'),
(645, 178, 'Bal Suraksha', 'Active', '2025-09-15'),
(646, 179, 'MahaTrafficapp', 'Active', '2025-09-15'),
(647, 179, 'NCRB SANKALAN of Criminal Laws', 'Active', '2025-09-15'),
(648, 179, 'e-Acadamy Maharashtra Police', 'Active', '2025-09-15'),
(649, 180, 'DIKSHA', 'Active', '2025-09-15'),
(650, 180, 'MSBSHSE', 'Active', '2025-09-15'),
(651, 180, 'ePathshala', 'Active', '2025-09-15'),
(652, 180, 'myCBSEguide', 'Active', '2025-09-15'),
(653, 180, 'NAS-NCERT', 'Active', '2025-09-15'),
(654, 180, 'Rashtriya e-Pustkalaya', 'Active', '2025-09-15'),
(655, 180, 'National Digital Library India', 'Active', '2025-09-15'),
(656, 181, 'Mera Ration App', 'Active', '2025-09-15'),
(657, 181, 'Maha egram Citizen Conect', 'Active', '2025-09-15'),
(658, 181, 'Meri Panchayat', 'Active', '2025-09-15'),
(659, 182, 'Aarogya Setu ', 'Active', '2025-09-15'),
(660, 182, 'Ayushman', 'Active', '2025-09-15'),
(661, 182, 'FIT india', 'Active', '2025-09-15'),
(662, 182, 'ABHA', 'Active', '2025-09-15'),
(663, 183, 'CAP Sachet', 'Active', '2025-09-15'),
(664, 183, 'Damini Lightning ', 'Active', '2025-09-15'),
(665, 183, 'Bhookamp', 'Active', '2025-09-15'),
(666, 183, 'Mausam', 'Active', '2025-09-15'),
(667, 183, 'Meghdoot', 'Active', '2025-09-15'),
(668, 184, 'ECINET', 'Active', '2025-09-15'),
(669, 184, 'KYC-ECI', 'Active', '2025-09-15'),
(670, 184, 'SUVIDHA', 'Active', '2025-09-15'),
(671, 184, 'Encore Nodal App', 'Active', '2025-09-15'),
(672, 184, 'Voter Turnout', 'Active', '2025-09-15'),
(673, 184, 'cVIGIL', 'Active', '2025-09-15'),
(674, 184, 'Voter Helpline', 'Active', '2025-09-15'),
(675, 184, 'Saksham-ECI', 'Active', '2025-09-15'),
(676, 184, 'ESMS', 'Active', '2025-09-15'),
(677, 185, 'Aaple Sarkar ', 'Active', '2025-09-15'),
(678, 185, 'RTS Maharashtra', 'Active', '2025-09-15'),
(679, 186, 'Maha Vanya Jeev Bharpai', 'Active', '2025-09-15'),
(680, 186, 'National Green Tribunal', 'Active', '2025-09-15'),
(681, 187, 'UDID', 'Active', '2025-09-15'),
(682, 187, 'Prashast', 'Active', '2025-09-15'),
(683, 188, 'Maha EGS Horticalture/Well App', 'Active', '2025-09-15'),
(684, 188, 'Janmanrega', 'Active', '2025-09-15'),
(685, 188, 'Area Officer', 'Active', '2025-09-15'),
(686, 189, 'e-Jagriti', 'Active', '2025-09-15'),
(687, 190, 'GRAS', 'Active', '2025-09-15'),
(688, 191, 'NPS', 'Active', '2025-09-15'),
(689, 192, 'iGOT Karmayogi', 'Active', '2025-09-15'),
(690, 193, 'Mahavitran', 'Active', '2025-09-15'),
(691, 194, 'mahakhanij MahaSand', 'Active', '2025-09-15'),
(692, 195, 'My Sarita', 'Active', '2025-09-15');
INSERT INTO `sub_category_master` (`sub_category_id`, `category_id`, `sub_category_name`, `status`, `timestamp`) VALUES
(693, 196, 'Maha PWD Rest House', 'Active', '2025-09-15'),
(694, 197, 'UMANG', 'Active', '2025-09-15'),
(695, 198, 'DigiLockar', 'Active', '2025-09-15'),
(696, 199, 'm Passport Seva', 'Active', '2025-09-15'),
(697, 200, 'mAadhaar', 'Active', '2025-09-15'),
(698, 201, 'Bhashini', 'Active', '2025-09-15'),
(699, 202, 'BHIM', 'Active', '2025-09-15'),
(700, 203, 'Sanchar Saathi', 'Active', '2025-09-15'),
(701, 204, 'Sandesh', 'Active', '2025-09-15'),
(702, 205, 'Sampark ', 'Active', '2025-09-15'),
(703, 206, 'AIS for Taxpayer', 'Active', '2025-09-15'),
(704, 207, 'Digipravesh', 'Active', '2025-09-15');

-- --------------------------------------------------------

--
-- Table structure for table `suggestions`
--

CREATE TABLE `suggestions` (
  `suggestion_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `contact` text DEFAULT NULL,
  `status` enum('pending','reviewed','implemented') DEFAULT 'pending',
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `email` text DEFAULT NULL,
  `mobile` text DEFAULT NULL,
  `user_type` text DEFAULT NULL,
  `district_id` int(11) DEFAULT NULL,
  `password` text DEFAULT NULL,
  `status` enum('Active','Inactive') DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_users`
--
ALTER TABLE `admin_users`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `email` (`email`) USING HASH;

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD KEY `department_id` (`department_id`),
  ADD KEY `idx_department_status` (`department_id`,`status`);

--
-- Indexes for table `category_master`
--
ALTER TABLE `category_master`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `districts`
--
ALTER TABLE `districts`
  ADD PRIMARY KEY (`district_id`);

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`document_id`),
  ADD KEY `uploaded_by` (`uploaded_by`),
  ADD KEY `idx_category_status` (`category_id`,`status`),
  ADD KEY `idx_upload_date` (`upload_date`),
  ADD KEY `idx_gr_date` (`gr_date`(768));

--
-- Indexes for table `document_access_logs`
--
ALTER TABLE `document_access_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `document_id` (`document_id`);

--
-- Indexes for table `gr_master`
--
ALTER TABLE `gr_master`
  ADD PRIMARY KEY (`gr_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `related_document_id` (`related_document_id`);

--
-- Indexes for table `shared_links`
--
ALTER TABLE `shared_links`
  ADD PRIMARY KEY (`share_id`),
  ADD UNIQUE KEY `unique_link_token` (`unique_link_token`),
  ADD KEY `document_id` (`document_id`);

--
-- Indexes for table `subject_master`
--
ALTER TABLE `subject_master`
  ADD PRIMARY KEY (`subject_id`);

--
-- Indexes for table `sub_category_master`
--
ALTER TABLE `sub_category_master`
  ADD PRIMARY KEY (`sub_category_id`);

--
-- Indexes for table `suggestions`
--
ALTER TABLE `suggestions`
  ADD PRIMARY KEY (`suggestion_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`) USING HASH,
  ADD UNIQUE KEY `mobile` (`mobile`) USING HASH;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_users`
--
ALTER TABLE `admin_users`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `category_master`
--
ALTER TABLE `category_master`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=260;

--
-- AUTO_INCREMENT for table `districts`
--
ALTER TABLE `districts`
  MODIFY `district_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `document_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `document_access_logs`
--
ALTER TABLE `document_access_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gr_master`
--
ALTER TABLE `gr_master`
  MODIFY `gr_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=241;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shared_links`
--
ALTER TABLE `shared_links`
  MODIFY `share_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subject_master`
--
ALTER TABLE `subject_master`
  MODIFY `subject_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `sub_category_master`
--
ALTER TABLE `sub_category_master`
  MODIFY `sub_category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=705;

--
-- AUTO_INCREMENT for table `suggestions`
--
ALTER TABLE `suggestions`
  MODIFY `suggestion_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `documents`
--
ALTER TABLE `documents`
  ADD CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  ADD CONSTRAINT `documents_ibfk_2` FOREIGN KEY (`uploaded_by`) REFERENCES `admin_users` (`admin_id`);

--
-- Constraints for table `document_access_logs`
--
ALTER TABLE `document_access_logs`
  ADD CONSTRAINT `document_access_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `document_access_logs_ibfk_2` FOREIGN KEY (`document_id`) REFERENCES `documents` (`document_id`);

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`related_document_id`) REFERENCES `documents` (`document_id`);

--
-- Constraints for table `shared_links`
--
ALTER TABLE `shared_links`
  ADD CONSTRAINT `shared_links_ibfk_1` FOREIGN KEY (`document_id`) REFERENCES `documents` (`document_id`);

--
-- Constraints for table `suggestions`
--
ALTER TABLE `suggestions`
  ADD CONSTRAINT `suggestions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
