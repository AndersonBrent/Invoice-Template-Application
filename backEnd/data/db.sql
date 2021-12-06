-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 07, 2021 at 12:07 AM
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

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `id` int(4) NOT NULL,
  `user_id` int(4) NOT NULL COMMENT 'ID of employee who does business with the client',
  `name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `addr_street` varchar(100) DEFAULT NULL,
  `addr_city` varchar(100) DEFAULT NULL,
  `addr_state` varchar(100) DEFAULT NULL,
  `phone` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `id` int(6) NOT NULL,
  `client_id` int(4) NOT NULL,
  `user_id` int(4) NOT NULL,
  `billing_date` date NOT NULL DEFAULT current_timestamp() COMMENT 'Date the invoice was created',
  `due_date` date DEFAULT NULL COMMENT 'Date bill is due',
  `charge` decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT 'Bill for services rendered owed by client',
  `is_paid` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Status indicating whether the bill has been paid or not'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` int(7) NOT NULL,
  `client_id` int(4) NOT NULL,
  `invoice_id` int(5) DEFAULT NULL,
  `description` varchar(500) NOT NULL,
  `rate` decimal(6,2) NOT NULL,
  `quantity` int(6) NOT NULL,
  `tax` decimal(6,2) NOT NULL,
  `note` varchar(500) NOT NULL COMMENT 'AKA "additionalDetails"'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(4) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id_fk2` (`user_id`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id_fk` (`client_id`),
  ADD KEY `user_id_fk` (`user_id`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id_items_fk` (`client_id`),
  ADD KEY `invoice_id_fk` (`invoice_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(7) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `clients`
--
ALTER TABLE `clients`
  ADD CONSTRAINT `user_id_fk2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `invoices`
--
ALTER TABLE `invoices`
  ADD CONSTRAINT `client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `client_id_items_fk` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `invoice_id_fk` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
