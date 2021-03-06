-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 07, 2021 at 12:08 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `invoice`
--
CREATE DATABASE IF NOT EXISTS `invoice` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `invoice`;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`id`, `user_id`, `name`, `email`, `addr_street`, `addr_city`, `addr_state`, `phone`) VALUES
(1, 1, 'Clint', 'clientemail@email.com', NULL, NULL, NULL, '1112223333'),
(2, 1, 'Clint\'s Brother', 'bro@email.com', NULL, NULL, NULL, '555555555'),
(3, 2, 'Guest client', 'guestclient@email.com', '123 Sesame St', 'Cityville', 'Some State', '1111111111');

--
-- Dumping data for table `invoices`
--

INSERT INTO `invoices` (`id`, `client_id`, `user_id`, `billing_date`, `due_date`, `charge`, `is_paid`) VALUES
(1, 2, 1, '2021-11-13', NULL, '1000.00', 0),
(2, 1, 1, '2021-11-13', NULL, '125.56', 0),
(3, 3, 2, '2021-11-14', '2021-11-15', '50.00', 0);

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `client_id`, `invoice_id`, `description`, `rate`, `quantity`, `tax`, `note`) VALUES
(1, 1, 1, 'thing', '19.99', 400, '0.07', 'it\'s an item'),
(2, 2, 2, 'another piece of junk', '56.50', 3, '0.09', 'Yup'),
(3, 2, 3, 'The only item for invoice 3', '44.00', 1, '120.00', '');

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `name`, `email`, `phone`) VALUES
(1, 'admin', 'pass', 'Admin', 'admin@email.com', '1555222333'),
(2, 'guest', 'guest', 'Guest', 'guest@email.com', '6514888888');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
