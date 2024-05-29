-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 13, 2024 at 11:44 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `garbage`
--

-- --------------------------------------------------------

--
-- Table structure for table `adminlogin`
--

CREATE TABLE `adminlogin` (
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `adminlogin`
--

INSERT INTO `adminlogin` (`username`, `password`) VALUES
('admin123', 'admin123');

-- --------------------------------------------------------

--
-- Table structure for table `bin`
--

CREATE TABLE `bin` (
  `binid` int(11) NOT NULL,
  `area` varchar(40) DEFAULT NULL,
  `locality` varchar(20) DEFAULT NULL,
  `landmark` varchar(70) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  `cycleperiod` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bin`
--

INSERT INTO `bin` (`binid`, `area`, `locality`, `landmark`, `city`, `cycleperiod`) VALUES
(102, 'Gandhipuram', 'ymr patti', 'bus stand', 'coimbatore', 'daily'),
(111, 'saibaba colony', 'venkatapuram', 'government college of technology', 'Coimbatore', 'cycleperiod'),
(112, 'saibaba colony', 'RSpuram', 'Government college of technology', 'coimbatore', 'daily'),
(113, 'saibaba colony', 'GP puram', 'bus stand', 'Coimbatore', 'cycleperiod'),
(115, 'saibaba colony', 'kumbakonam', 'suvathy house', 'ariyalur', 'cycleperiod');

-- --------------------------------------------------------

--
-- Table structure for table `driverdetails`
--

CREATE TABLE `driverdetails` (
  `driverid` varchar(5) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `address` varchar(60) DEFAULT NULL,
  `area` varchar(30) DEFAULT NULL,
  `aadhaar` mediumtext DEFAULT NULL,
  `location` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `driverdetails`
--

INSERT INTO `driverdetails` (`driverid`, `name`, `email`, `password`, `address`, `area`, `aadhaar`, `location`) VALUES
('Did1', 'Ram', 'ram123@gmail.com', 'ram@123', 'northeast street', 'saibaba colony', '9190234578902378', 'coimbatore'),
('Did2', 'vinoth', 'vino@gmail.com', 'vino', 'saibaba colony', 'kandhipuram', '938976524316', 'coimbatore');

-- --------------------------------------------------------

--
-- Table structure for table `driverwork`
--

CREATE TABLE `driverwork` (
  `driverid` varchar(5) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `binid` int(11) DEFAULT NULL,
  `area` varchar(40) DEFAULT NULL,
  `report` varchar(30) DEFAULT 'progress'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `driverwork`
--

INSERT INTO `driverwork` (`driverid`, `name`, `binid`, `area`, `report`) VALUES
('Did1', 'vasanthi', 112, 'saibaba colony', 'completed'),
('Did1', 'krishna', 102, 'Gandhipuram', 'completed'),
('Did1', 'krishna', 102, 'Gandhipuram', 'progress'),
('Did1', 'S. Vinothini', 113, 'saibaba colony', 'completed'),
('Did1', 'S. Vinothini', 113, 'saibaba colony', 'progress');

--
-- Triggers `driverwork`
--
DELIMITER $$
CREATE TRIGGER `complete` AFTER UPDATE ON `driverwork` FOR EACH ROW BEGIN
    
    IF EXISTS (SELECT 1 FROM registercomplaint WHERE binid = NEW.binid) THEN
        
        UPDATE registercomplaint
        SET status = 'completed'
        WHERE binid = NEW.binid;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_work` AFTER INSERT ON `driverwork` FOR EACH ROW BEGIN
    
    UPDATE registercomplaint
    SET work = 'assigned'
    WHERE binid = NEW.binid;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `registercomplaint`
--

CREATE TABLE `registercomplaint` (
  `binid` int(11) DEFAULT NULL,
  `area` varchar(40) DEFAULT NULL,
  `locality` varchar(20) DEFAULT NULL,
  `landmark` varchar(70) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  `complaint` varchar(400) DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL,
  `work` varchar(20) DEFAULT 'unassigned',
  `status` varchar(20) DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `registercomplaint`
--

INSERT INTO `registercomplaint` (`binid`, `area`, `locality`, `landmark`, `city`, `complaint`, `name`, `work`, `status`) VALUES
(112, 'saibaba colony', 'RSpuram', 'Government college of technology', 'coimbatore', 'full', 'vasanthi', 'assigned', 'completed'),
(102, 'Gandhipuram', 'ymr patti', 'bus stand', 'coimbatore', 'dustbin full', 'krishna', 'assigned', 'completed'),
(102, 'Gandhipuram', 'ymr patti', 'bus stand', 'coimbatore', 'full', 'vinayagar', 'assigned', 'pending'),
(113, 'saibaba colony', 'GP puram', 'bus stand', 'Coimbatore', 'full', 'S. Vinothini', 'assigned', 'completed'),
(113, 'saibaba colony', 'GP puram', 'bus stand', 'Coimbatore', 'admin has to be changed', 'suvathy', 'assigned', 'pending'),
(111, 'saibaba colony', 'venkatapuram', 'government college of technology', 'Coimbatore', 'dustbin full', 'preethi', 'unassigned', 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `userdetails`
--

CREATE TABLE `userdetails` (
  `name` varchar(30) NOT NULL,
  `email` varchar(70) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  `contact` mediumtext DEFAULT NULL,
  `area` varchar(40) DEFAULT NULL,
  `city` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `userdetails`
--

INSERT INTO `userdetails` (`name`, `email`, `password`, `contact`, `area`, `city`) VALUES
('vinayagar', 'vina@gmail.com', 'vina123', '7826026437', 'saibaba colony', 'coimbatore');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `adminlogin`
--
ALTER TABLE `adminlogin`
  ADD UNIQUE KEY `password` (`password`);

--
-- Indexes for table `bin`
--
ALTER TABLE `bin`
  ADD PRIMARY KEY (`binid`);

--
-- Indexes for table `driverdetails`
--
ALTER TABLE `driverdetails`
  ADD PRIMARY KEY (`driverid`),
  ADD UNIQUE KEY `password` (`password`);

--
-- Indexes for table `driverwork`
--
ALTER TABLE `driverwork`
  ADD KEY `driverid` (`driverid`),
  ADD KEY `binid` (`binid`);

--
-- Indexes for table `registercomplaint`
--
ALTER TABLE `registercomplaint`
  ADD KEY `binid` (`binid`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `driverwork`
--
ALTER TABLE `driverwork`
  ADD CONSTRAINT `driverwork_ibfk_1` FOREIGN KEY (`driverid`) REFERENCES `driverdetails` (`driverid`),
  ADD CONSTRAINT `driverwork_ibfk_2` FOREIGN KEY (`binid`) REFERENCES `bin` (`binid`);

--
-- Constraints for table `registercomplaint`
--
ALTER TABLE `registercomplaint`
  ADD CONSTRAINT `registercomplaint_ibfk_1` FOREIGN KEY (`binid`) REFERENCES `bin` (`binid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
