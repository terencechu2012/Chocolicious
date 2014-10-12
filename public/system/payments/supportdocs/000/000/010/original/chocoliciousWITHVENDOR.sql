-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 28, 2014 at 10:21 AM
-- Server version: 5.5.24-log
-- PHP Version: 5.4.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `chocolicious`
--

-- --------------------------------------------------------

--
-- Table structure for table `archive_budgets`
--

CREATE TABLE IF NOT EXISTS `archive_budgets` (
  `id` int(11) NOT NULL DEFAULT '0',
  `clubid` varchar(255) DEFAULT NULL,
  `year` varchar(255) DEFAULT NULL,
  `semester` int(11) DEFAULT NULL,
  `event` varchar(255) DEFAULT NULL,
  `startdate` date DEFAULT NULL,
  `enddate` date DEFAULT NULL,
  `estnopar` int(11) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `requestsac` decimal(10,2) DEFAULT '0.00',
  `requestreserves` decimal(10,2) DEFAULT '0.00',
  `projectedincome` decimal(10,2) DEFAULT '0.00',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `explanation` longtext,
  `poster_file_name` varchar(255) DEFAULT NULL,
  `poster_content_type` varchar(255) DEFAULT NULL,
  `poster_file_size` int(11) DEFAULT NULL,
  `poster_updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `archive_budget_expenses`
--

CREATE TABLE IF NOT EXISTS `archive_budget_expenses` (
  `id` int(11) NOT NULL DEFAULT '0',
  `budget_id` int(11) DEFAULT NULL,
  `item` varchar(255) DEFAULT NULL,
  `requestsac` decimal(10,2) DEFAULT '0.00',
  `requestreserves` decimal(10,2) DEFAULT '0.00',
  `unitcost` decimal(10,2) DEFAULT '0.00',
  `quantity` int(11) DEFAULT '0',
  `justification` varchar(255) DEFAULT NULL,
  `quotation` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `archive_budget_incomes`
--

CREATE TABLE IF NOT EXISTS `archive_budget_incomes` (
  `id` int(11) NOT NULL DEFAULT '0',
  `budget_id` int(11) DEFAULT NULL,
  `item` varchar(255) DEFAULT NULL,
  `income` decimal(10,2) DEFAULT NULL,
  `incomebreakdown` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `archive_claims`
--

CREATE TABLE IF NOT EXISTS `archive_claims` (
  `id` int(11) NOT NULL DEFAULT '0',
  `userid` varchar(255) DEFAULT NULL,
  `clubid` varchar(255) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `supportdoc_file_name` varchar(255) DEFAULT NULL,
  `supportdoc_content_type` varchar(255) DEFAULT NULL,
  `supportdoc_file_size` int(11) DEFAULT NULL,
  `supportdoc_updated_at` datetime DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `nric` varchar(255) DEFAULT NULL,
  `event` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `archive_clubs`
--

CREATE TABLE IF NOT EXISTS `archive_clubs` (
  `clubid` varchar(255) NOT NULL DEFAULT '',
  `finsecid` varchar(255) DEFAULT NULL,
  `presidentid` varchar(255) DEFAULT NULL,
  `clubtype` varchar(255) DEFAULT NULL,
  `clubname` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `clubcode` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `archive_clubusers`
--

CREATE TABLE IF NOT EXISTS `archive_clubusers` (
  `id` int(11) NOT NULL DEFAULT '0',
  `userid` varchar(255) DEFAULT NULL,
  `clubid` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `archive_deposits`
--

CREATE TABLE IF NOT EXISTS `archive_deposits` (
  `id` int(11) NOT NULL DEFAULT '0',
  `userid` varchar(255) DEFAULT NULL,
  `clubid` varchar(255) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `receipts` varchar(255) DEFAULT NULL,
  `donorname` varchar(255) DEFAULT NULL,
  `donoradd` varchar(255) DEFAULT NULL,
  `donoric` varchar(255) DEFAULT NULL,
  `purpose` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `archive_expenditure_accounts`
--

CREATE TABLE IF NOT EXISTS `archive_expenditure_accounts` (
  `id` int(11) NOT NULL DEFAULT '0',
  `clubid` varchar(255) DEFAULT NULL,
  `Category1Balance` decimal(10,2) DEFAULT '0.00',
  `Category2Balance` decimal(10,2) DEFAULT '0.00',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `archive_requests`
--

CREATE TABLE IF NOT EXISTS `archive_requests` (
  `id` int(11) NOT NULL DEFAULT '0',
  `userid` varchar(255) DEFAULT NULL,
  `clubid` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `archive_reserve_accounts`
--

CREATE TABLE IF NOT EXISTS `archive_reserve_accounts` (
  `id` int(11) NOT NULL DEFAULT '0',
  `clubid` varchar(255) DEFAULT NULL,
  `balance` decimal(10,2) DEFAULT NULL,
  `limit` decimal(10,2) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `justification` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `archive_users`
--

CREATE TABLE IF NOT EXISTS `archive_users` (
  `userid` varchar(255) NOT NULL DEFAULT '',
  `passwordhash` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `nric` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) NOT NULL DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `confirmation_token` varchar(255) DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `confirmation_sent_at` datetime DEFAULT NULL,
  `unconfirmed_email` varchar(255) DEFAULT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `contactno` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `budgets`
--

CREATE TABLE IF NOT EXISTS `budgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clubid` varchar(255) DEFAULT NULL,
  `year` varchar(255) DEFAULT NULL,
  `semester` int(11) DEFAULT NULL,
  `event` varchar(255) DEFAULT NULL,
  `startdate` date DEFAULT NULL,
  `enddate` date DEFAULT NULL,
  `estnopar` int(11) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `requestsac` decimal(10,2) DEFAULT '0.00',
  `requestreserves` decimal(10,2) DEFAULT '0.00',
  `projectedincome` decimal(10,2) DEFAULT '0.00',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `explanation` longtext,
  `poster_file_name` varchar(255) DEFAULT NULL,
  `poster_content_type` varchar(255) DEFAULT NULL,
  `poster_file_size` int(11) DEFAULT NULL,
  `poster_updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `budgets`
--

INSERT INTO `budgets` (`id`, `clubid`, `year`, `semester`, `event`, `startdate`, `enddate`, `estnopar`, `category`, `requestsac`, `requestreserves`, `projectedincome`, `created_at`, `updated_at`, `explanation`, `poster_file_name`, `poster_content_type`, `poster_file_size`, `poster_updated_at`) VALUES
(1, 'ICON', 'AY2014-2015', 1, 'driving', '2014-08-20', '2014-08-21', 43, '1,3', '440.00', '100.00', '0.00', '2014-08-12 08:03:13', '2014-08-12 08:04:13', 'driving is fun', NULL, NULL, NULL, NULL),
(3, 'ICON', 'AY2014-2015', 1, 'testinglogic', '2014-08-25', '2014-08-27', 23, '1', '220.00', '200.00', '0.00', '2014-08-24 13:00:33', '2014-08-31 12:07:24', '11', NULL, NULL, NULL, NULL),
(4, 'communications', 'AY2014-2015', 1, 'Movie', '2014-09-18', '2014-09-18', 10, '11', '300000.90', '0.00', '0.00', '2014-09-15 09:27:47', '2014-09-17 13:58:17', '', NULL, NULL, NULL, NULL),
(5, 'fcp', 'AY2014-2015', 1, 'aaa', '2014-09-18', '2014-09-12', 12, '3', '0.00', '0.00', '0.00', '2014-09-15 13:52:14', '2014-09-15 13:52:14', '', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `budget_controls`
--

CREATE TABLE IF NOT EXISTS `budget_controls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `open` tinyint(1) DEFAULT NULL,
  `year` varchar(255) DEFAULT NULL,
  `semester` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `budget_controls`
--

INSERT INTO `budget_controls` (`id`, `open`, `year`, `semester`, `created_at`, `updated_at`) VALUES
(1, 1, 'AY2014-2015', 1, '2014-08-02 13:17:03', '2014-08-12 08:02:14'),
(2, 1, 'AY2014-2015', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `budget_expenses`
--

CREATE TABLE IF NOT EXISTS `budget_expenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `budget_id` int(11) DEFAULT NULL,
  `item` varchar(255) DEFAULT NULL,
  `requestsac` decimal(10,2) DEFAULT '0.00',
  `requestreserves` decimal(10,2) DEFAULT '0.00',
  `unitcost` decimal(10,2) DEFAULT '0.00',
  `quantity` int(11) DEFAULT '0',
  `justification` varchar(255) DEFAULT NULL,
  `quotation` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_budget_expenses_on_budget_id` (`budget_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `budget_expenses`
--

INSERT INTO `budget_expenses` (`id`, `budget_id`, `item`, `requestsac`, `requestreserves`, `unitcost`, `quantity`, `justification`, `quotation`, `created_at`, `updated_at`) VALUES
(1, 1, 'petrol', '140.00', '0.00', '0.00', 0, '', '', '2014-08-12 08:03:55', '2014-08-12 08:03:55'),
(2, 1, 'wheel', '300.00', '0.00', '0.00', 0, '', '', '2014-08-12 08:04:13', '2014-08-12 08:04:13'),
(6, 3, 'sdf', '200.00', '0.00', '0.00', 0, '', '', '2014-08-24 13:02:25', '2014-08-24 13:02:25'),
(7, 3, 'asd', '20.00', '0.00', '0.00', 0, '', '', '2014-08-31 12:07:23', '2014-08-31 12:07:23'),
(9, 4, 'flyers', '300000.90', '0.00', '11.00', 31, '', '', '2014-09-17 13:58:17', '2014-09-17 13:58:17');

-- --------------------------------------------------------

--
-- Table structure for table `budget_incomes`
--

CREATE TABLE IF NOT EXISTS `budget_incomes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `budget_id` int(11) DEFAULT NULL,
  `item` varchar(255) DEFAULT NULL,
  `income` decimal(10,2) DEFAULT NULL,
  `incomebreakdown` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_budget_incomes_on_budget_id` (`budget_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `claims`
--

CREATE TABLE IF NOT EXISTS `claims` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(255) DEFAULT NULL,
  `clubid` varchar(255) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `supportdoc_file_name` varchar(255) DEFAULT NULL,
  `supportdoc_content_type` varchar(255) DEFAULT NULL,
  `supportdoc_file_size` int(11) DEFAULT NULL,
  `supportdoc_updated_at` datetime DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `nric` varchar(255) DEFAULT NULL,
  `event` varchar(255) DEFAULT NULL,
  `expense` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `claims`
--

INSERT INTO `claims` (`id`, `userid`, `clubid`, `amount`, `status`, `category`, `created_at`, `updated_at`, `supportdoc_file_name`, `supportdoc_content_type`, `supportdoc_file_size`, `supportdoc_updated_at`, `remarks`, `nric`, `event`, `expense`) VALUES
(7, 'zhenjie.ng.2012', 'fcp', '33.90', 4, '1', '2014-08-24 11:49:58', '2014-09-28 09:26:41', 'cache_miss_in_deployed_db.txt', 'text/plain', 448, '2014-09-15 13:10:37', 'Invalid\r\n', 'S9111111Z', NULL, NULL),
(8, 'trecia.koh.2012', 'communications', '47.00', 16, '1', '2014-09-01 13:02:54', '2014-09-01 13:14:41', 'transaction_types.txt', 'text/plain', 129, '2014-09-01 13:02:54', NULL, 'S1234567Z', NULL, NULL),
(9, 'zhenjie.ng.2012', 'fcp', '55.00', 5, 'B', '2014-09-01 13:56:26', '2014-09-15 14:36:04', 'transaction_types.txt', 'text/plain', 129, '2014-09-01 13:56:26', NULL, 'S9111111Z', NULL, '5'),
(11, 'zhenjie.ng.2012', 'fcp', '13.00', 1, 'B', '2014-09-15 13:36:39', '2014-09-15 13:36:47', 'cache_miss_in_deployed_db.txt', 'text/plain', 448, '2014-09-15 13:36:39', NULL, 'S9111111Z', NULL, '2'),
(12, 'jinqyi.lee.2012', 'icon', '22.00', 9, 'A', '2014-09-15 14:13:48', '2014-09-15 14:48:51', 'cache_miss_in_deployed_db.txt', 'text/plain', 448, '2014-09-15 14:13:48', NULL, 'S1234567Z', 'driving', '1'),
(13, 'zhenjie.ng.2012', 'fcp', '450.00', 0, 'C', '2014-09-17 14:01:42', '2014-09-17 14:01:42', 'cache_miss_in_deployed_db.txt', 'text/plain', 448, '2014-09-17 14:01:42', NULL, 'S9111111Z', 'aaa', '6');

-- --------------------------------------------------------

--
-- Table structure for table `claim_times`
--

CREATE TABLE IF NOT EXISTS `claim_times` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `claimid` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `claim_times`
--

INSERT INTO `claim_times` (`id`, `claimid`, `status`, `date`, `created_at`, `updated_at`) VALUES
(1, 7, 4, '2014-09-28', '2014-09-28 09:26:41', '2014-09-28 09:26:41'),
(2, 7, 4, '2014-09-28', '2014-09-28 09:29:29', '2014-09-28 09:29:29'),
(3, 7, 4, '2014-09-28', '2014-09-28 09:35:24', '2014-09-28 09:35:24');

-- --------------------------------------------------------

--
-- Table structure for table `clubs`
--

CREATE TABLE IF NOT EXISTS `clubs` (
  `clubid` varchar(255) NOT NULL DEFAULT '',
  `finsecid` varchar(255) DEFAULT NULL,
  `presidentid` varchar(255) DEFAULT NULL,
  `clubtype` varchar(255) DEFAULT NULL,
  `clubname` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `clubcode` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`clubid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `clubs`
--

INSERT INTO `clubs` (`clubid`, `finsecid`, `presidentid`, `clubtype`, `clubname`, `created_at`, `updated_at`, `clubcode`) VALUES
('ACF', NULL, NULL, 'cbd', 'Arts & Cultural Fraternity', '2014-08-26 08:37:50', '2014-08-26 09:34:55', 'ACF'),
('aiesec', NULL, NULL, 'SICS', 'AIESEC', '2014-08-26 09:01:30', '2014-08-26 09:01:30', 'SICS001'),
('aikido', NULL, NULL, 'SSU', 'Aikido', '2014-08-26 09:14:43', '2014-08-26 09:14:43', 'SSU018'),
('alkhaleej', NULL, NULL, 'ICON', 'Al Khaleej', '2014-08-26 09:22:00', '2014-08-26 09:22:00', 'SAC113'),
('apsara', NULL, NULL, 'ICON', 'Apsara Cambodia', '2014-08-26 09:22:50', '2014-08-26 09:22:50', 'SAC113'),
('aquathlon', NULL, NULL, 'SSU', 'Aquathlon', '2014-08-26 09:33:48', '2014-08-26 09:33:48', 'SSU043'),
('aquaticsharks', NULL, NULL, 'SSU', 'Aquatic Sharks', '2014-08-26 09:10:34', '2014-08-26 09:10:34', 'SSU012'),
('archery', NULL, NULL, 'SSU', 'Archery', '2014-08-26 09:10:58', '2014-08-26 09:10:58', 'SSU013'),
('ardiente', NULL, NULL, 'ACF', 'Ardiente', '2014-08-26 08:51:23', '2014-08-26 08:51:23', 'ACF029'),
('artdicted', NULL, NULL, 'ACF', 'Artdicted', '2014-08-26 08:44:17', '2014-08-26 08:44:17', 'ACF001'),
('ASOC', NULL, NULL, 'cbd', 'Accountancy', '2014-08-26 08:40:06', '2014-08-26 08:40:06', 'SAC106'),
('assets', NULL, NULL, 'smusa', 'Assets Department', '2014-09-01 12:58:49', '2014-09-01 12:58:49', 'SAC101'),
('badminton', NULL, NULL, 'SSU', 'Badminton', '2014-08-26 09:18:02', '2014-08-26 09:18:02', 'SSU021'),
('ballare', NULL, NULL, 'ACF', 'Ballare', '2014-08-26 08:51:09', '2014-08-26 08:51:09', 'ACF028'),
('barkada', NULL, NULL, 'ICON', 'SMU Barkada', '2014-08-26 09:20:49', '2014-08-26 09:20:49', 'SAC113'),
('barworks', NULL, NULL, 'SICS', 'Barworks', '2014-08-26 09:09:27', '2014-08-26 09:09:27', 'SICS030'),
('basketball', NULL, NULL, 'SSU', 'Basketball', '2014-08-26 08:53:46', '2014-08-26 08:53:46', 'SSU001'),
('bike', NULL, NULL, 'SMUX', 'Biking Team', '2014-08-26 09:11:55', '2014-08-26 09:11:55', 'SMUX004'),
('BONDUE', NULL, NULL, 'cbd', 'Business', '2014-08-26 08:40:50', '2014-08-26 08:40:50', 'SAC107'),
('bowling', NULL, NULL, 'SSU', 'Bowling', '2014-08-26 08:54:03', '2014-08-26 08:54:03', 'SSU002'),
('bpm', NULL, NULL, 'SICS', 'BP-Mentoring', '2014-08-26 09:05:36', '2014-08-26 09:05:36', 'SICS021'),
('caderas', NULL, NULL, 'ACF', 'Caderas Latinas', '2014-08-26 08:46:53', '2014-08-26 08:46:53', 'ACF007'),
('capoeira', NULL, NULL, 'SSU', 'Capoeira', '2014-08-26 09:33:07', '2014-08-26 09:33:07', 'SSU042'),
('caretalyst', NULL, NULL, 'SICS', 'Caretalyst', '2014-08-26 09:09:53', '2014-08-26 09:09:53', 'SICS032'),
('chamberc', NULL, NULL, 'ACF', 'Chamber Choir', '2014-08-26 08:47:43', '2014-08-26 08:47:43', 'ACF011'),
('chaovietnam', NULL, NULL, 'ICON', 'Chao Vietnam', '2014-08-26 09:20:22', '2014-08-26 09:20:22', 'SAC113'),
('climbteam', NULL, NULL, 'SSU', 'Climb Team', '2014-08-26 09:31:19', '2014-08-26 09:31:19', 'SSU038'),
('communications', NULL, NULL, 'smusa', 'Communications Department', '2014-09-01 12:59:36', '2014-09-01 12:59:36', 'SAC101'),
('connectchina', NULL, NULL, 'ICON', 'Connect China', '2014-08-26 09:20:03', '2014-08-26 09:20:03', 'SAC113'),
('cricket', NULL, NULL, 'SSU', 'Cricket', '2014-08-26 09:18:57', '2014-08-26 09:18:57', 'SSU023'),
('debate', NULL, NULL, 'SICS', 'Debating Society', '2014-08-26 09:02:23', '2014-08-26 09:02:23', 'SICS008'),
('dive', NULL, NULL, 'SMUX', 'Diving Team', '2014-08-26 09:11:43', '2014-08-26 09:11:43', 'SMUX003'),
('dragonboat', NULL, NULL, 'SSU', 'Dragon Boat', '2014-08-26 09:29:47', '2014-08-26 09:29:47', 'SSU036'),
('esports', NULL, NULL, 'SICS', 'e-Sports', '2014-08-26 09:01:50', '2014-08-26 09:01:50', 'SICS003'),
('eurhythmix', NULL, NULL, 'ACF', 'Eurhythmix', '2014-08-26 08:47:09', '2014-08-26 08:47:09', 'ACF008'),
('events', NULL, NULL, 'smusa', 'Events Department', '2014-09-01 12:59:05', '2014-09-01 12:59:05', 'SAC101'),
('fcp', NULL, NULL, 'ICON', 'Francophiles', '2014-08-26 09:21:46', '2014-08-26 09:21:46', 'SAC113'),
('fencing', NULL, NULL, 'SSU', 'Fencing', '2014-08-26 09:22:05', '2014-08-26 09:22:05', 'SSU027'),
('filmsociety', NULL, NULL, 'ACF', 'Film Society', '2014-08-26 08:49:53', '2014-08-26 08:49:53', 'ACF021'),
('finance', NULL, NULL, 'smusa', 'Finance Department', '2014-09-01 12:59:23', '2014-09-01 12:59:23', 'SAC101'),
('fishing', NULL, NULL, 'SICS', 'Recreational Fishing', '2014-08-26 09:03:44', '2014-08-26 09:03:44', 'SICS012'),
('fitnessworks', NULL, NULL, 'SICS', 'Fitness Works', '2014-08-26 09:10:26', '2014-08-26 09:10:26', 'SICS034'),
('flare', NULL, NULL, 'SSU', 'Flare', '2014-08-26 09:34:41', '2014-08-26 09:34:41', 'SSU045'),
('floorball', NULL, NULL, 'SSU', 'Floorball', '2014-08-26 08:54:45', '2014-08-26 08:54:45', 'SSU003'),
('frisbee', NULL, NULL, 'SSU', 'Frisbee', '2014-08-26 09:15:40', '2014-08-26 09:15:40', 'SSU019'),
('funk', NULL, NULL, 'ACF', 'Funk Movement', '2014-08-26 08:51:34', '2014-08-26 08:51:34', 'ACF030'),
('golf', NULL, NULL, 'SSU', 'Golf', '2014-08-26 09:22:38', '2014-08-26 09:22:38', 'SSU028'),
('gourmet', NULL, NULL, 'SICS', 'Gourmet Club', '2014-08-26 09:02:45', '2014-08-26 09:02:45', 'SICS010'),
('guitarissimo', NULL, NULL, 'ACF', 'Guitarissimo', '2014-08-26 08:48:15', '2014-08-26 08:48:15', 'ACF013'),
('habitat', NULL, NULL, 'SICS', 'Habitat for Humanity', '2014-08-26 09:10:41', '2014-08-26 09:10:41', 'SICS035'),
('handball', NULL, NULL, 'SSU', 'Handball', '2014-08-26 09:30:20', '2014-08-26 09:30:20', 'SSU037'),
('ICON', NULL, 'trecia.koh.2012', 'cbd', 'International Connections', '2014-08-26 08:42:12', '2014-09-15 14:44:02', 'SAC113'),
('ics', NULL, NULL, 'ACF', 'Indian Cultural Society', '2014-08-26 08:45:47', '2014-08-26 08:45:47', 'ACF002'),
('idc', NULL, NULL, 'ACF', 'InDanCity', '2014-08-26 08:47:25', '2014-08-26 08:47:25', 'ACF010'),
('ise', NULL, NULL, 'SICS', 'ISE', '2014-08-26 09:03:32', '2014-08-26 09:03:32', 'SICS011'),
('ivorykeys', NULL, NULL, 'ACF', 'Ivory Keys', '2014-08-26 08:50:30', '2014-08-26 08:50:30', 'ACF025'),
('jcc', NULL, NULL, 'ICON', 'Japanese Cultural Club', '2014-08-26 09:21:20', '2014-08-26 09:21:20', 'SAC113'),
('judo', NULL, NULL, 'SSU', 'Judo', '2014-08-26 09:05:00', '2014-08-26 09:05:00', 'SSU004'),
('kayak', NULL, NULL, 'SMUX', 'Kayaking Team', '2014-08-26 09:11:19', '2014-08-26 09:11:19', 'SMUX001'),
('kendo', NULL, NULL, 'SSU', 'Kendo', '2014-08-26 09:26:26', '2014-08-26 09:26:26', 'SSU031'),
('literati', NULL, NULL, 'ACF', 'Literati', '2014-08-26 08:50:43', '2014-08-26 08:50:43', 'ACF026'),
('mic', NULL, NULL, 'ACF', 'MIC', '2014-08-26 08:48:29', '2014-08-26 08:48:29', 'ACF014'),
('mindsports', NULL, NULL, 'SICS', 'Mindsports', '2014-08-26 09:06:03', '2014-08-26 09:06:03', 'SICS023'),
('mlcc', NULL, NULL, 'ACF', 'Malay Language Cultural Club', '2014-08-26 08:46:12', '2014-08-26 08:46:12', 'ACF004'),
('muaythai', NULL, NULL, 'SSU', 'Muaythai', '2014-08-26 09:28:28', '2014-08-26 09:28:28', 'SSU034'),
('myanmarcommunity', NULL, NULL, 'ICON', 'Myanmar Community', '2014-08-26 09:22:17', '2014-08-26 09:22:17', 'SAC113'),
('netball', NULL, NULL, 'SSU', 'Netball', '2014-08-26 09:14:09', '2014-08-26 09:14:09', 'SSU017'),
('OIKOS', NULL, NULL, 'cbd', 'Economics', '2014-08-26 08:41:04', '2014-08-26 08:41:04', 'SAC108'),
('pfaw', NULL, NULL, 'SICS', 'People for Animal Welfare', '2014-08-26 09:02:08', '2014-08-26 09:02:08', 'SICS006'),
('pool', NULL, NULL, 'SSU', 'Pool', '2014-08-26 09:11:42', '2014-08-26 09:11:42', 'SSU014'),
('redcross', NULL, NULL, 'SICS', 'Red Cross', '2014-08-26 09:05:49', '2014-08-26 09:05:49', 'SICS022'),
('rgc', NULL, NULL, 'SICS', 'Recreational Gaming Club', '2014-08-26 09:09:13', '2014-08-26 09:09:13', 'SICS028'),
('roots', NULL, NULL, 'ICON', 'SMU Roots', '2014-08-26 09:21:34', '2014-08-26 09:21:34', 'SAC113'),
('rotaract', NULL, NULL, 'SICS', 'Rotaract', '2014-08-26 09:05:21', '2014-08-26 09:05:21', 'SICS020'),
('rugby', NULL, NULL, 'SSU', 'Rugby', '2014-08-26 09:08:48', '2014-08-26 09:08:48', 'SSU010'),
('rugbywomen', NULL, NULL, 'SSU', 'Women''s Rugby', '2014-08-26 09:27:37', '2014-08-26 09:27:37', 'SSU033'),
('runteam', NULL, NULL, 'SSU', 'Run Team', '2014-08-26 09:13:12', '2014-08-26 09:13:12', 'SSU016'),
('sailing', NULL, NULL, 'SSU', 'Sailing', '2014-08-26 09:23:52', '2014-08-26 09:23:52', 'SSU029'),
('sambam', NULL, NULL, 'ACF', 'Samba Masala', '2014-08-26 08:48:45', '2014-08-26 08:48:45', 'ACF016'),
('secretariat', NULL, NULL, 'smusa', 'Secretariat', '2014-09-01 13:00:04', '2014-09-01 13:00:04', 'SAC101'),
('sf', NULL, NULL, 'ACF', 'Sound Foundry', '2014-08-26 08:49:07', '2014-08-26 08:49:07', 'ACF017'),
('shooting', NULL, NULL, 'SSU', 'Shooting', '2014-08-26 09:29:17', '2014-08-26 09:29:17', 'SSU035'),
('SICS', NULL, NULL, 'cbd', 'Special Interest & Community Service Sodality', '2014-08-26 08:38:47', '2014-08-26 08:38:47', 'SICS'),
('silat', NULL, NULL, 'SSU', 'Silat', '2014-08-26 09:31:52', '2014-08-26 09:31:52', 'SSU039'),
('SISS', NULL, NULL, 'cbd', 'Information Systems', '2014-08-26 08:41:33', '2014-08-26 08:41:33', 'SAC110'),
('skate', NULL, NULL, 'SMUX', 'Skating Team', '2014-08-26 09:12:17', '2014-08-26 09:12:17', 'SMUX006'),
('smube', NULL, NULL, 'ACF', 'SMUBE', '2014-08-26 08:50:05', '2014-08-26 08:50:05', 'ACF022'),
('smuco', NULL, NULL, 'ACF', 'SMU Chinese Orchestra', '2014-08-26 08:50:55', '2014-08-26 08:50:55', 'ACF027'),
('smuki', NULL, NULL, 'ACF', 'SMUKI', '2014-08-26 08:46:27', '2014-08-26 08:46:27', 'ACF005'),
('smumma', NULL, NULL, 'SICS', 'SMUMMA', '2014-08-26 09:09:39', '2014-08-26 09:09:39', 'SICS031'),
('smurb', NULL, NULL, 'SICS', 'SMU Real Business', '2014-08-26 09:10:05', '2014-08-26 09:10:05', 'SICS033'),
('smusa', 'terence.chu.2012', 'zhenjie.ng.2012', 'infinity', 'SMUSA', NULL, '2014-09-01 12:42:37', 'SAC'),
('smusaic', NULL, NULL, 'ACF', 'SMUSAIC', '2014-08-26 08:50:16', '2014-08-26 08:50:16', 'ACF023'),
('SMUX', NULL, NULL, 'cbd', 'SMUXtremists', '2014-08-26 08:39:06', '2014-08-26 08:39:06', 'SMUX'),
('soccermen', NULL, NULL, 'SSU', 'Men''s Soccer', '2014-08-26 09:06:00', '2014-08-26 09:06:00', 'SSU007'),
('soccerwomen', NULL, NULL, 'SSU', 'Women''s Soccer', '2014-08-26 09:21:18', '2014-08-26 09:21:18', 'SSU026'),
('softball', NULL, NULL, 'SSU', 'Softball', '2014-08-26 09:32:26', '2014-08-26 09:32:26', 'SSU040'),
('SOSCIETY', NULL, NULL, 'cbd', 'Social Sciences', '2014-08-26 08:41:55', '2014-08-26 08:41:55', 'SAC111'),
('squash', NULL, NULL, 'SSU', 'Squash', '2014-08-26 09:07:13', '2014-08-26 09:07:13', 'SSU008'),
('SSU', NULL, NULL, 'cbd', 'SMU Sports Union', '2014-08-26 08:38:12', '2014-08-26 08:38:12', 'SSU'),
('stageit', NULL, NULL, 'ACF', 'StageIt', '2014-08-26 08:46:40', '2014-08-26 08:46:40', 'ACF006'),
('stereometa', NULL, NULL, 'ACF', 'Stereometa', '2014-08-26 08:49:23', '2014-08-26 08:49:23', 'ACF018'),
('strategica', NULL, NULL, 'SICS', 'Strategica', '2014-08-26 09:05:05', '2014-08-26 09:05:05', 'SICS018'),
('symphonia', NULL, NULL, 'ACF', 'Symphonia', '2014-08-26 08:49:34', '2014-08-26 08:49:34', 'ACF019'),
('tabletennis', NULL, NULL, 'SSU', 'Table Tennis', '2014-08-26 09:19:38', '2014-08-26 09:19:38', 'SSU024'),
('taekwando', NULL, NULL, 'SSU', 'Taekwando', '2014-08-26 09:20:16', '2014-08-26 09:20:16', 'SSU025'),
('tchoukball', NULL, NULL, 'SSU', 'Tchouk Ball', '2014-08-26 09:36:32', '2014-08-26 09:36:32', 'SSU046'),
('tennis', NULL, NULL, 'SSU', 'Tennis', '2014-08-26 09:07:58', '2014-08-26 09:07:58', 'SSU009'),
('THE BAR', NULL, NULL, 'cbd', 'Law', '2014-08-26 08:41:17', '2014-08-26 08:41:17', 'SAC109'),
('toastmasters', NULL, NULL, 'SICS', 'Toastmasters', '2014-08-26 09:03:57', '2014-08-26 09:03:57', 'SICS013'),
('tracknfield', NULL, NULL, 'SSU', 'Track & Field', '2014-08-26 09:25:57', '2014-08-26 09:25:57', 'SSU030'),
('trek', NULL, NULL, 'SMUX', 'Trekking Team', '2014-08-26 09:11:31', '2014-08-26 09:11:31', 'SMUX002'),
('trulymalaysia', NULL, NULL, 'ICON', 'Truly Malaysia', '2014-08-26 09:22:29', '2014-08-26 09:22:29', 'SAC113'),
('uniy', NULL, NULL, 'SICS', 'Uni-Y', '2014-08-26 09:06:19', '2014-08-26 09:06:19', 'SICS025'),
('unsa', NULL, NULL, 'SICS', 'UNSA', '2014-08-26 09:08:39', '2014-08-26 09:08:39', 'SICS026'),
('verts', NULL, NULL, 'SICS', 'Verts', '2014-08-26 09:04:50', '2014-08-26 09:04:50', 'SICS017'),
('voix', NULL, NULL, 'ACF', 'Voix', '2014-08-26 08:47:54', '2014-08-26 08:47:54', 'ACF012'),
('volleyball', NULL, NULL, 'SSU', 'Volleyball', '2014-08-26 09:09:29', '2014-08-26 09:09:29', 'SSU011'),
('wakeboarders', NULL, NULL, 'SSU', 'Wakeboarders', '2014-08-26 09:12:40', '2014-08-26 09:12:40', 'SSU015'),
('welfare', NULL, NULL, 'smusa', 'Welfare Department', '2014-09-01 12:59:49', '2014-09-01 12:59:49', 'SAC101'),
('windsurf', NULL, NULL, 'SSU', 'Windsurf', '2014-08-26 09:17:13', '2014-08-26 09:17:13', 'SSU020'),
('wineappreciation', NULL, NULL, 'SICS', 'Wine Appreciation', '2014-08-26 09:09:00', '2014-08-26 09:09:00', 'SICS027'),
('womensconnection', NULL, NULL, 'SICS', 'Women''s Connection', '2014-08-26 09:04:36', '2014-08-26 09:04:36', 'SICS016'),
('woorisayi', NULL, NULL, 'ICON', 'Woori Sayi', '2014-08-26 09:20:37', '2014-08-26 09:20:37', 'SAC113'),
('wushu', NULL, NULL, 'SSU', 'Wushu', '2014-08-26 09:34:16', '2014-08-26 09:34:16', 'SSU044'),
('xseed', NULL, NULL, 'SMUX', 'X-Seed Team', '2014-08-26 09:12:07', '2014-08-26 09:12:07', 'SMUX005'),
('yimsiam', NULL, NULL, 'ICON', 'Yim Siam', '2014-08-26 09:21:01', '2014-08-26 09:21:01', 'SAC113');

-- --------------------------------------------------------

--
-- Table structure for table `clubusers`
--

CREATE TABLE IF NOT EXISTS `clubusers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(255) DEFAULT NULL,
  `clubid` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userid` (`userid`,`clubid`,`role`),
  KEY `fk_1_idx` (`clubid`),
  KEY `fk_2_idx` (`userid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

--
-- Dumping data for table `clubusers`
--

INSERT INTO `clubusers` (`id`, `userid`, `clubid`, `role`, `created_at`, `updated_at`) VALUES
(1, 'terence.chu.2012', 'smusa', 'smusafinsec', NULL, NULL),
(2, 'mmphang.2012', 'ICON', 'cbdfinsec', '2014-08-12 06:36:38', '2014-08-12 06:36:38'),
(8, 'jinqyi.lee.2012', 'ICON', 'cbdmc', '2014-08-22 05:29:56', '2014-08-22 05:29:56'),
(12, 'zhenjie.ng.2012', 'ICON', 'president', '2014-08-23 05:21:12', '2014-08-23 05:21:12'),
(13, 'trecia.koh.2012', 'fcp', 'clubfinsec', '2014-08-24 11:46:58', '2014-08-24 11:46:58'),
(14, 'jinqyi.lee.2012', 'fcp', 'president', '2014-08-24 11:48:04', '2014-08-24 11:48:04'),
(15, 'zhenjie.ng.2012', 'fcp', 'normal', '2014-08-24 11:48:13', '2014-08-24 11:48:13'),
(16, 'zhenjie.ng.2012', 'smusa', 'president', '2014-09-01 12:42:37', '2014-09-01 12:42:37'),
(17, 'mmphang.2012', 'assets', 'smusasec', '2014-09-01 13:00:22', '2014-09-01 13:00:22'),
(19, 'trecia.koh.2012', 'communications', 'smusasec', '2014-09-01 13:00:49', '2014-09-01 13:00:49'),
(20, 'trecia.koh.2012', 'icon', 'president', '2014-09-15 14:44:02', '2014-09-15 14:44:02');

-- --------------------------------------------------------

--
-- Table structure for table `contributions`
--

CREATE TABLE IF NOT EXISTS `contributions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rate` decimal(5,2) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `contributions`
--

INSERT INTO `contributions` (`id`, `rate`, `created_at`, `updated_at`) VALUES
(1, '10.00', NULL, '2014-09-11 13:55:47');

-- --------------------------------------------------------

--
-- Table structure for table `deposits`
--

CREATE TABLE IF NOT EXISTS `deposits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(255) DEFAULT NULL,
  `clubid` varchar(255) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `receipts` varchar(255) DEFAULT NULL,
  `donorname` varchar(255) DEFAULT NULL,
  `donoradd` varchar(255) DEFAULT NULL,
  `donoric` varchar(255) DEFAULT NULL,
  `purpose` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `deposits`
--

INSERT INTO `deposits` (`id`, `userid`, `clubid`, `amount`, `status`, `remarks`, `date`, `receipts`, `donorname`, `donoradd`, `donoric`, `purpose`, `created_at`, `updated_at`) VALUES
(3, 'jinqyi.lee.2012', 'icon', '34.00', 9, NULL, '2014-08-26', '33', '', '', '', 'testingpurposes', '2014-08-23 05:16:59', '2014-08-23 05:21:47'),
(4, 'trecia.koh.2012', 'fcp', '34.00', 3, NULL, '2014-08-25', '1234', '', '', '', 'nil', '2014-08-24 11:48:49', '2014-09-15 14:05:54'),
(5, 'trecia.koh.2012', 'communications', '23.00', 13, NULL, '2222-02-22', 'asdf234', '', '', '', 'for fun', '2014-09-03 14:38:34', '2014-09-15 14:07:22'),
(6, 'trecia.koh.2012', 'fcp', '23.00', 1, NULL, '2014-09-17', 'smusa_welfare', '', '', '', 'aa', '2014-09-15 10:05:36', '2014-09-15 10:05:36'),
(7, 'trecia.koh.2012', 'fcp', '34.00', 1, NULL, '2014-09-19', 'R1001', 'Sony', 'Eastpoint', 'S9146278D', 'aa', '2014-09-15 13:14:35', '2014-09-15 13:14:35'),
(8, 'jinqyi.lee.2012', 'icon', '42.00', 7, NULL, '2014-09-17', 'R1001', 'Sony', 'Eastpoint', 'S9146278D', 'a', '2014-09-15 14:15:36', '2014-09-15 14:17:04');

-- --------------------------------------------------------

--
-- Table structure for table `ereceipts`
--

CREATE TABLE IF NOT EXISTS `ereceipts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `issuerid` varchar(255) DEFAULT NULL,
  `issuername` varchar(255) DEFAULT NULL,
  `payeename` varchar(255) DEFAULT NULL,
  `payeemail` varchar(255) DEFAULT NULL,
  `amount` decimal(10,0) DEFAULT NULL,
  `gst` decimal(10,0) DEFAULT NULL,
  `paytype` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `clubid` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `ereceipts`
--

INSERT INTO `ereceipts` (`id`, `issuerid`, `issuername`, `payeename`, `payeemail`, `amount`, `gst`, `paytype`, `description`, `clubid`, `created_at`, `updated_at`) VALUES
(1, 'trecia.koh.2012', 'jinq', 'ying', 'yy@gmail.com', '34', '4', 'Cheque', 't', 'communications', '2014-09-23 07:37:21', '2014-09-23 07:37:21'),
(2, 'trecia.koh.2012', 'trecia', 'ying', 'yingying@gmail.com', '34', '5', 'Cash', 'car', 'communications', '2014-09-23 07:38:03', '2014-09-23 07:38:03'),
(3, '', 'dafs', 'test', 'terence.chu.2012@sis.smu.edu.sg', '11', '0', 'Cash', 'dsaf', '', '2014-09-27 13:09:07', '2014-09-27 13:09:07'),
(4, '', 'lol', 'terence', 'terence.chu.2012@sis.smu.edu.sg', '33', '0', 'Cash', 'ddfd', '', '2014-09-27 13:16:17', '2014-09-27 13:16:17'),
(5, '', 'lol', 'terence', 'terence.chu.2012@sis.smu.edu.sg', '33', '0', 'Cash', 'ddfd', '', '2014-09-27 13:16:27', '2014-09-27 13:16:27'),
(6, '', 'lol', 'terence', 'terence.chu.2012@sis.smu.edu.sg', '33', '0', 'Cash', 'ddfd', '', '2014-09-27 13:16:41', '2014-09-27 13:16:41'),
(7, 'terence.chu.2012', 'Terence', 'Phang Ming Min', 'mmphang.2012@sis.smu.edu.sg', '444', '0', 'Cheque', 'testing my email', 'smusa', '2014-09-27 13:18:38', '2014-09-27 13:18:38');

-- --------------------------------------------------------

--
-- Table structure for table `expenditure_accounts`
--

CREATE TABLE IF NOT EXISTS `expenditure_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clubid` varchar(255) DEFAULT NULL,
  `Category1Balance` decimal(10,2) DEFAULT '0.00',
  `Category2Balance` decimal(10,2) DEFAULT '0.00',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `EA_fk` (`clubid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=128 ;

--
-- Dumping data for table `expenditure_accounts`
--

INSERT INTO `expenditure_accounts` (`id`, `clubid`, `Category1Balance`, `Category2Balance`, `created_at`, `updated_at`) VALUES
(1, 'ACF', '0.00', '0.00', '2014-08-26 08:37:50', '2014-09-11 08:49:41'),
(2, 'SSU', '0.00', '0.00', '2014-08-26 08:38:12', '2014-09-11 08:38:42'),
(3, 'SICS', '0.00', '0.00', '2014-08-26 08:38:47', '2014-09-11 08:38:41'),
(4, 'SMUX', '0.00', '0.00', '2014-08-26 08:39:07', '2014-09-11 08:38:42'),
(5, 'ASOC', '0.00', '0.00', '2014-08-26 08:40:06', '2014-09-11 08:48:53'),
(6, 'BONDUE', '0.00', '0.00', '2014-08-26 08:40:50', '2014-09-11 08:48:53'),
(7, 'OIKOS', '0.00', '0.00', '2014-08-26 08:41:04', '2014-09-11 08:48:53'),
(8, 'THE BAR', '0.00', '0.00', '2014-08-26 08:41:17', '2014-09-11 08:48:54'),
(9, 'SISS', '0.00', '0.00', '2014-08-26 08:41:33', '2014-09-11 08:48:53'),
(10, 'SOSCIETY', '0.00', '0.00', '2014-08-26 08:41:55', '2014-09-11 08:48:54'),
(11, 'ICON', '960.00', '366.00', '2014-08-26 08:42:12', '2014-09-11 13:33:54'),
(12, 'artdicted', '0.00', '0.00', '2014-08-26 08:44:17', '2014-09-11 08:48:46'),
(13, 'ics', '0.00', '0.00', '2014-08-26 08:45:47', '2014-09-11 08:48:46'),
(14, 'mlcc', '0.00', '0.00', '2014-08-26 08:46:13', '2014-09-11 08:48:46'),
(15, 'smuki', '0.00', '0.00', '2014-08-26 08:46:27', '2014-09-11 08:48:46'),
(16, 'stageit', '0.00', '0.00', '2014-08-26 08:46:40', '2014-09-11 08:48:46'),
(17, 'caderas', '0.00', '0.00', '2014-08-26 08:46:53', '2014-09-11 08:48:46'),
(18, 'eurhythmix', '0.00', '0.00', '2014-08-26 08:47:09', '2014-09-11 08:48:46'),
(19, 'idc', '0.00', '0.00', '2014-08-26 08:47:25', '2014-09-11 08:48:46'),
(20, 'chamberc', '0.00', '0.00', '2014-08-26 08:47:43', '2014-09-11 08:48:46'),
(21, 'voix', '0.00', '0.00', '2014-08-26 08:47:54', '2014-09-11 08:48:47'),
(22, 'guitarissimo', '0.00', '0.00', '2014-08-26 08:48:15', '2014-09-11 08:48:47'),
(23, 'mic', '0.00', '0.00', '2014-08-26 08:48:29', '2014-09-11 08:48:47'),
(24, 'sambam', '0.00', '0.00', '2014-08-26 08:48:45', '2014-09-11 08:48:47'),
(25, 'sf', '0.00', '0.00', '2014-08-26 08:49:07', '2014-09-11 08:48:47'),
(26, 'stereometa', '0.00', '0.00', '2014-08-26 08:49:23', '2014-09-11 08:48:47'),
(27, 'symphonia', '0.00', '0.00', '2014-08-26 08:49:34', '2014-09-11 08:48:47'),
(28, 'filmsociety', '0.00', '0.00', '2014-08-26 08:49:53', '2014-09-11 08:48:47'),
(29, 'smube', '0.00', '0.00', '2014-08-26 08:50:05', '2014-09-11 08:48:47'),
(30, 'smusaic', '0.00', '0.00', '2014-08-26 08:50:16', '2014-09-11 08:48:47'),
(31, 'ivorykeys', '0.00', '0.00', '2014-08-26 08:50:30', '2014-09-11 08:48:47'),
(32, 'literati', '0.00', '0.00', '2014-08-26 08:50:43', '2014-09-11 08:48:48'),
(33, 'smuco', '0.00', '0.00', '2014-08-26 08:50:55', '2014-09-11 08:48:48'),
(34, 'ballare', '0.00', '0.00', '2014-08-26 08:51:09', '2014-09-11 08:48:48'),
(35, 'ardiente', '0.00', '0.00', '2014-08-26 08:51:23', '2014-09-11 08:48:48'),
(36, 'funk', '0.00', '0.00', '2014-08-26 08:51:34', '2014-09-11 08:48:48'),
(37, 'basketball', '0.00', '0.00', '2014-08-26 08:53:46', '2014-09-11 08:48:50'),
(38, 'bowling', '0.00', '0.00', '2014-08-26 08:54:03', '2014-09-11 08:48:50'),
(39, 'floorball', '0.00', '0.00', '2014-08-26 08:54:45', '2014-09-11 08:48:50'),
(40, 'aiesec', '0.00', '0.00', '2014-08-26 09:01:30', '2014-09-11 08:48:48'),
(41, 'esports', '0.00', '0.00', '2014-08-26 09:01:50', '2014-09-11 08:48:48'),
(42, 'pfaw', '0.00', '0.00', '2014-08-26 09:02:08', '2014-09-11 08:48:48'),
(43, 'debate', '0.00', '0.00', '2014-08-26 09:02:23', '2014-09-11 08:48:48'),
(44, 'gourmet', '0.00', '0.00', '2014-08-26 09:02:45', '2014-09-11 08:48:48'),
(45, 'ise', '0.00', '0.00', '2014-08-26 09:03:32', '2014-09-11 08:48:48'),
(46, 'fishing', '0.00', '0.00', '2014-08-26 09:03:44', '2014-09-11 08:48:48'),
(47, 'toastmasters', '0.00', '0.00', '2014-08-26 09:03:57', '2014-09-11 08:48:48'),
(48, 'womensconnection', '0.00', '0.00', '2014-08-26 09:04:37', '2014-09-11 08:48:48'),
(49, 'verts', '0.00', '0.00', '2014-08-26 09:04:50', '2014-09-11 08:48:48'),
(50, 'judo', '0.00', '0.00', '2014-08-26 09:05:00', '2014-09-11 08:48:50'),
(51, 'strategica', '0.00', '0.00', '2014-08-26 09:05:05', '2014-09-11 08:48:49'),
(52, 'rotaract', '0.00', '0.00', '2014-08-26 09:05:21', '2014-09-11 08:48:49'),
(53, 'bpm', '0.00', '0.00', '2014-08-26 09:05:36', '2014-09-11 08:48:49'),
(54, 'redcross', '0.00', '0.00', '2014-08-26 09:05:49', '2014-09-11 08:48:49'),
(55, 'soccermen', '0.00', '0.00', '2014-08-26 09:06:00', '2014-09-11 08:48:50'),
(56, 'mindsports', '0.00', '0.00', '2014-08-26 09:06:03', '2014-09-11 08:48:49'),
(57, 'uniy', '0.00', '0.00', '2014-08-26 09:06:19', '2014-09-11 08:48:49'),
(58, 'squash', '0.00', '0.00', '2014-08-26 09:07:13', '2014-09-11 08:48:50'),
(59, 'tennis', '0.00', '0.00', '2014-08-26 09:07:58', '2014-09-11 08:48:50'),
(60, 'unsa', '0.00', '0.00', '2014-08-26 09:08:39', '2014-09-11 08:48:49'),
(61, 'rugby', '0.00', '0.00', '2014-08-26 09:08:48', '2014-09-11 08:48:50'),
(62, 'wineappreciation', '0.00', '0.00', '2014-08-26 09:09:00', '2014-09-11 08:48:49'),
(63, 'rgc', '0.00', '0.00', '2014-08-26 09:09:13', '2014-09-11 08:48:49'),
(64, 'barworks', '0.00', '0.00', '2014-08-26 09:09:27', '2014-09-11 08:48:49'),
(65, 'volleyball', '0.00', '0.00', '2014-08-26 09:09:29', '2014-09-11 08:48:51'),
(66, 'smumma', '0.00', '0.00', '2014-08-26 09:09:39', '2014-09-11 08:48:49'),
(67, 'caretalyst', '0.00', '0.00', '2014-08-26 09:09:53', '2014-09-11 08:48:49'),
(68, 'smurb', '0.00', '0.00', '2014-08-26 09:10:05', '2014-09-11 08:48:49'),
(69, 'fitnessworks', '0.00', '0.00', '2014-08-26 09:10:26', '2014-09-11 08:48:49'),
(70, 'aquaticsharks', '0.00', '0.00', '2014-08-26 09:10:34', '2014-09-11 08:48:51'),
(71, 'habitat', '0.00', '0.00', '2014-08-26 09:10:41', '2014-09-11 08:48:49'),
(72, 'archery', '0.00', '0.00', '2014-08-26 09:10:58', '2014-09-11 08:48:51'),
(73, 'kayak', '0.00', '0.00', '2014-08-26 09:11:19', '2014-09-11 08:48:50'),
(74, 'trek', '0.00', '0.00', '2014-08-26 09:11:31', '2014-09-11 08:48:50'),
(75, 'pool', '0.00', '0.00', '2014-08-26 09:11:42', '2014-09-11 08:48:51'),
(76, 'dive', '0.00', '0.00', '2014-08-26 09:11:43', '2014-09-11 08:48:50'),
(77, 'bike', '0.00', '0.00', '2014-08-26 09:11:55', '2014-09-11 08:48:50'),
(78, 'xseed', '0.00', '0.00', '2014-08-26 09:12:07', '2014-09-11 08:48:50'),
(79, 'skate', '0.00', '0.00', '2014-08-26 09:12:17', '2014-09-11 08:48:50'),
(80, 'wakeboarders', '0.00', '0.00', '2014-08-26 09:12:40', '2014-09-11 08:48:51'),
(81, 'runteam', '0.00', '0.00', '2014-08-26 09:13:12', '2014-09-11 08:48:51'),
(82, 'netball', '0.00', '0.00', '2014-08-26 09:14:09', '2014-09-11 08:48:51'),
(83, 'aikido', '0.00', '0.00', '2014-08-26 09:14:43', '2014-09-11 08:48:51'),
(84, 'frisbee', '0.00', '0.00', '2014-08-26 09:15:40', '2014-09-11 08:48:51'),
(85, 'windsurf', '0.00', '0.00', '2014-08-26 09:17:13', '2014-09-11 08:48:51'),
(86, 'badminton', '0.00', '0.00', '2014-08-26 09:18:02', '2014-09-11 08:48:51'),
(87, 'cricket', '0.00', '0.00', '2014-08-26 09:18:57', '2014-09-11 08:48:51'),
(88, 'tabletennis', '0.00', '0.00', '2014-08-26 09:19:38', '2014-09-11 08:48:51'),
(89, 'connectchina', '0.00', '0.00', '2014-08-26 09:20:04', '2014-09-11 08:48:52'),
(90, 'taekwando', '0.00', '0.00', '2014-08-26 09:20:16', '2014-09-11 08:48:51'),
(91, 'chaovietnam', '0.00', '0.00', '2014-08-26 09:20:22', '2014-09-11 08:48:53'),
(92, 'woorisayi', '0.00', '0.00', '2014-08-26 09:20:37', '2014-09-11 08:48:53'),
(93, 'barkada', '0.00', '0.00', '2014-08-26 09:20:49', '2014-09-11 08:48:53'),
(94, 'yimsiam', '0.00', '0.00', '2014-08-26 09:21:01', '2014-09-11 08:48:53'),
(95, 'soccerwomen', '0.00', '0.00', '2014-08-26 09:21:18', '2014-09-11 08:48:51'),
(96, 'jcc', '0.00', '0.00', '2014-08-26 09:21:20', '2014-09-11 08:48:53'),
(97, 'roots', '0.00', '0.00', '2014-08-26 09:21:34', '2014-09-11 08:48:53'),
(98, 'fcp', '2945.00', '1000.00', '2014-08-26 09:21:46', '2014-09-15 14:36:04'),
(99, 'alkhaleej', '0.00', '0.00', '2014-08-26 09:22:00', '2014-09-11 08:48:53'),
(100, 'fencing', '0.00', '0.00', '2014-08-26 09:22:05', '2014-09-11 08:48:51'),
(101, 'myanmarcommunity', '0.00', '0.00', '2014-08-26 09:22:17', '2014-09-11 08:48:53'),
(102, 'trulymalaysia', '0.00', '0.00', '2014-08-26 09:22:29', '2014-09-11 08:48:53'),
(103, 'golf', '0.00', '0.00', '2014-08-26 09:22:38', '2014-09-11 08:48:51'),
(104, 'apsara', '0.00', '0.00', '2014-08-26 09:22:50', '2014-09-11 08:48:53'),
(105, 'sailing', '0.00', '0.00', '2014-08-26 09:23:52', '2014-09-11 08:48:51'),
(106, 'tracknfield', '0.00', '0.00', '2014-08-26 09:25:57', '2014-09-11 08:48:52'),
(107, 'kendo', '0.00', '0.00', '2014-08-26 09:26:26', '2014-09-11 08:48:52'),
(108, 'rugbywomen', '0.00', '0.00', '2014-08-26 09:27:37', '2014-09-11 08:48:52'),
(109, 'muaythai', '0.00', '0.00', '2014-08-26 09:28:28', '2014-09-11 08:48:52'),
(110, 'shooting', '0.00', '0.00', '2014-08-26 09:29:17', '2014-09-11 08:48:52'),
(111, 'dragonboat', '0.00', '0.00', '2014-08-26 09:29:47', '2014-09-11 08:48:52'),
(112, 'handball', '0.00', '0.00', '2014-08-26 09:30:20', '2014-09-11 08:48:52'),
(113, 'climbteam', '0.00', '0.00', '2014-08-26 09:31:19', '2014-09-11 08:48:52'),
(114, 'silat', '0.00', '0.00', '2014-08-26 09:31:52', '2014-09-11 08:48:52'),
(115, 'softball', '0.00', '0.00', '2014-08-26 09:32:26', '2014-09-11 08:48:52'),
(116, 'capoeira', '0.00', '0.00', '2014-08-26 09:33:07', '2014-09-11 08:48:52'),
(117, 'aquathlon', '0.00', '0.00', '2014-08-26 09:33:48', '2014-09-11 08:48:52'),
(118, 'wushu', '0.00', '0.00', '2014-08-26 09:34:16', '2014-09-11 08:48:52'),
(119, 'flare', '0.00', '0.00', '2014-08-26 09:34:41', '2014-09-11 08:48:52'),
(120, 'tchoukball', '0.00', '0.00', '2014-08-26 09:36:32', '2014-09-11 08:48:52'),
(121, 'smusa', '365359.00', '0.00', NULL, '2014-09-11 13:33:54'),
(122, 'assets', '0.00', '0.00', '2014-09-01 12:58:49', '2014-09-11 08:48:54'),
(123, 'events', '0.00', '0.00', '2014-09-01 12:59:05', '2014-09-11 08:48:54'),
(124, 'finance', '0.00', '0.00', '2014-09-01 12:59:23', '2014-09-11 08:48:54'),
(125, 'communications', '0.00', '0.00', '2014-09-01 12:59:36', '2014-09-11 08:48:54'),
(126, 'welfare', '0.00', '0.00', '2014-09-01 12:59:50', '2014-09-11 08:48:54'),
(127, 'secretariat', '0.00', '0.00', '2014-09-01 13:00:04', '2014-09-11 08:48:54');

-- --------------------------------------------------------

--
-- Table structure for table `funds_transfers`
--

CREATE TABLE IF NOT EXISTS `funds_transfers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(255) DEFAULT NULL,
  `clubidfrom` varchar(255) DEFAULT NULL,
  `clubidto` varchar(255) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `purpose` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `requests`
--

CREATE TABLE IF NOT EXISTS `requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(255) DEFAULT NULL,
  `clubid` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userid` (`userid`,`clubid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `requests`
--

INSERT INTO `requests` (`id`, `userid`, `clubid`, `created_at`, `updated_at`) VALUES
(2, 'zhenjie.ng.2012', 'tm', '2014-08-22 06:03:47', '2014-08-22 06:03:47'),
(3, 'zhenjie.ng.2012', 'aikido', '2014-09-15 13:31:08', '2014-09-15 13:31:08');

-- --------------------------------------------------------

--
-- Table structure for table `reserve_accounts`
--

CREATE TABLE IF NOT EXISTS `reserve_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clubid` varchar(255) DEFAULT NULL,
  `balance` decimal(10,2) DEFAULT NULL,
  `limit` decimal(10,2) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `justification` longtext,
  PRIMARY KEY (`id`),
  KEY `RA_fk` (`clubid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=121 ;

--
-- Dumping data for table `reserve_accounts`
--

INSERT INTO `reserve_accounts` (`id`, `clubid`, `balance`, `limit`, `created_at`, `updated_at`, `justification`) VALUES
(1, 'ACF', '1650.00', '20000.00', '2014-08-26 08:37:51', '2014-09-11 08:49:41', NULL),
(2, 'SSU', '0.00', '20000.00', '2014-08-26 08:38:12', '2014-08-26 08:38:12', NULL),
(3, 'SICS', '0.00', '20000.00', '2014-08-26 08:38:47', '2014-08-26 08:38:47', NULL),
(4, 'SMUX', '0.00', '20000.00', '2014-08-26 08:39:07', '2014-08-26 08:39:07', NULL),
(5, 'ASOC', '0.00', '20000.00', '2014-08-26 08:40:06', '2014-08-26 08:40:06', NULL),
(6, 'BONDUE', '0.00', '20000.00', '2014-08-26 08:40:50', '2014-08-26 08:40:50', NULL),
(7, 'OIKOS', '0.00', '20000.00', '2014-08-26 08:41:04', '2014-08-26 08:41:04', NULL),
(8, 'THE BAR', '0.00', '20000.00', '2014-08-26 08:41:18', '2014-08-26 08:41:18', NULL),
(9, 'SISS', '0.00', '20000.00', '2014-08-26 08:41:33', '2014-08-26 08:41:33', NULL),
(10, 'SOSCIETY', '0.00', '20000.00', '2014-08-26 08:41:55', '2014-08-26 08:41:55', NULL),
(11, 'ICON', '634.00', '20000.00', '2014-08-26 08:42:12', '2014-09-11 13:33:54', NULL),
(12, 'artdicted', '230.00', '20000.00', '2014-08-26 08:44:17', '2014-08-30 03:52:43', NULL),
(13, 'ics', '0.00', '20000.00', '2014-08-26 08:45:47', '2014-08-26 08:45:47', NULL),
(14, 'mlcc', '0.00', '20000.00', '2014-08-26 08:46:13', '2014-08-26 08:46:13', NULL),
(15, 'smuki', '0.00', '20000.00', '2014-08-26 08:46:27', '2014-08-26 08:46:27', NULL),
(16, 'stageit', '0.00', '20000.00', '2014-08-26 08:46:40', '2014-08-26 08:46:40', NULL),
(17, 'caderas', '0.00', '20000.00', '2014-08-26 08:46:53', '2014-08-26 08:46:53', NULL),
(18, 'eurhythmix', '0.00', '20000.00', '2014-08-26 08:47:09', '2014-08-26 08:47:09', NULL),
(19, 'idc', '0.00', '20000.00', '2014-08-26 08:47:25', '2014-08-26 08:47:25', NULL),
(20, 'chamberc', '0.00', '20000.00', '2014-08-26 08:47:43', '2014-08-26 08:47:43', NULL),
(21, 'voix', '0.00', '20000.00', '2014-08-26 08:47:54', '2014-08-26 08:47:54', NULL),
(22, 'guitarissimo', '0.00', '20000.00', '2014-08-26 08:48:15', '2014-08-26 08:48:15', NULL),
(23, 'mic', '0.00', '20000.00', '2014-08-26 08:48:29', '2014-08-26 08:48:29', NULL),
(24, 'sambam', '0.00', '20000.00', '2014-08-26 08:48:45', '2014-08-26 08:48:45', NULL),
(25, 'sf', '0.00', '20000.00', '2014-08-26 08:49:07', '2014-08-26 08:49:07', NULL),
(26, 'stereometa', '0.00', '20000.00', '2014-08-26 08:49:23', '2014-08-26 08:49:23', NULL),
(27, 'symphonia', '0.00', '20000.00', '2014-08-26 08:49:34', '2014-08-26 08:49:34', NULL),
(28, 'filmsociety', '0.00', '20000.00', '2014-08-26 08:49:54', '2014-08-26 08:49:54', NULL),
(29, 'smube', '0.00', '20000.00', '2014-08-26 08:50:05', '2014-08-26 08:50:05', NULL),
(30, 'smusaic', '0.00', '20000.00', '2014-08-26 08:50:16', '2014-08-26 08:50:16', NULL),
(31, 'ivorykeys', '0.00', '20000.00', '2014-08-26 08:50:30', '2014-08-26 08:50:30', NULL),
(32, 'literati', '0.00', '20000.00', '2014-08-26 08:50:43', '2014-08-26 08:50:43', NULL),
(33, 'smuco', '0.00', '20000.00', '2014-08-26 08:50:55', '2014-08-26 08:50:55', NULL),
(34, 'ballare', '0.00', '20000.00', '2014-08-26 08:51:09', '2014-08-26 08:51:09', NULL),
(35, 'ardiente', '0.00', '20000.00', '2014-08-26 08:51:23', '2014-08-26 08:51:23', NULL),
(36, 'funk', '0.00', '20000.00', '2014-08-26 08:51:34', '2014-08-26 08:51:34', NULL),
(37, 'basketball', '0.00', '20000.00', '2014-08-26 08:53:46', '2014-08-26 08:53:46', NULL),
(38, 'bowling', '0.00', '20000.00', '2014-08-26 08:54:03', '2014-08-26 08:54:03', NULL),
(39, 'floorball', '0.00', '20000.00', '2014-08-26 08:54:45', '2014-08-26 08:54:45', NULL),
(40, 'aiesec', '0.00', '20000.00', '2014-08-26 09:01:30', '2014-08-26 09:01:30', NULL),
(41, 'esports', '0.00', '20000.00', '2014-08-26 09:01:50', '2014-08-26 09:01:50', NULL),
(42, 'pfaw', '0.00', '20000.00', '2014-08-26 09:02:08', '2014-08-26 09:02:08', NULL),
(43, 'debate', '0.00', '20000.00', '2014-08-26 09:02:23', '2014-08-26 09:02:23', NULL),
(44, 'gourmet', '0.00', '20000.00', '2014-08-26 09:02:45', '2014-08-26 09:02:45', NULL),
(45, 'ise', '0.00', '20000.00', '2014-08-26 09:03:32', '2014-08-26 09:03:32', NULL),
(46, 'fishing', '0.00', '20000.00', '2014-08-26 09:03:44', '2014-08-26 09:03:44', NULL),
(47, 'toastmasters', '0.00', '20000.00', '2014-08-26 09:03:57', '2014-08-26 09:03:57', NULL),
(48, 'womensconnection', '0.00', '20000.00', '2014-08-26 09:04:37', '2014-08-26 09:04:37', NULL),
(49, 'verts', '0.00', '20000.00', '2014-08-26 09:04:50', '2014-08-26 09:04:50', NULL),
(50, 'judo', '0.00', '20000.00', '2014-08-26 09:05:00', '2014-08-26 09:05:00', NULL),
(51, 'strategica', '0.00', '20000.00', '2014-08-26 09:05:05', '2014-08-26 09:05:05', NULL),
(52, 'rotaract', '0.00', '20000.00', '2014-08-26 09:05:21', '2014-08-26 09:05:21', NULL),
(53, 'bpm', '0.00', '20000.00', '2014-08-26 09:05:36', '2014-08-26 09:05:36', NULL),
(54, 'redcross', '0.00', '20000.00', '2014-08-26 09:05:49', '2014-08-26 09:05:49', NULL),
(55, 'soccermen', '0.00', '20000.00', '2014-08-26 09:06:00', '2014-08-26 09:06:00', NULL),
(56, 'mindsports', '0.00', '20000.00', '2014-08-26 09:06:03', '2014-08-26 09:06:03', NULL),
(57, 'uniy', '0.00', '20000.00', '2014-08-26 09:06:19', '2014-08-26 09:06:19', NULL),
(58, 'squash', '0.00', '20000.00', '2014-08-26 09:07:13', '2014-08-26 09:07:13', NULL),
(59, 'tennis', '0.00', '20000.00', '2014-08-26 09:07:58', '2014-08-26 09:07:58', NULL),
(60, 'unsa', '0.00', '20000.00', '2014-08-26 09:08:40', '2014-08-26 09:08:40', NULL),
(61, 'rugby', '0.00', '20000.00', '2014-08-26 09:08:48', '2014-08-26 09:08:48', NULL),
(62, 'wineappreciation', '0.00', '20000.00', '2014-08-26 09:09:00', '2014-08-26 09:09:00', NULL),
(63, 'rgc', '0.00', '20000.00', '2014-08-26 09:09:13', '2014-08-26 09:09:13', NULL),
(64, 'barworks', '0.00', '20000.00', '2014-08-26 09:09:28', '2014-08-26 09:09:28', NULL),
(65, 'volleyball', '0.00', '20000.00', '2014-08-26 09:09:29', '2014-08-26 09:09:29', NULL),
(66, 'smumma', '0.00', '20000.00', '2014-08-26 09:09:39', '2014-08-26 09:09:39', NULL),
(67, 'caretalyst', '0.00', '20000.00', '2014-08-26 09:09:53', '2014-08-26 09:09:53', NULL),
(68, 'smurb', '0.00', '20000.00', '2014-08-26 09:10:05', '2014-08-26 09:10:05', NULL),
(69, 'fitnessworks', '0.00', '20000.00', '2014-08-26 09:10:26', '2014-08-26 09:10:26', NULL),
(70, 'aquaticsharks', '0.00', '20000.00', '2014-08-26 09:10:34', '2014-08-26 09:10:34', NULL),
(71, 'habitat', '0.00', '20000.00', '2014-08-26 09:10:41', '2014-08-26 09:10:41', NULL),
(72, 'archery', '0.00', '20000.00', '2014-08-26 09:10:58', '2014-08-26 09:10:58', NULL),
(73, 'kayak', '0.00', '20000.00', '2014-08-26 09:11:19', '2014-08-26 09:11:19', NULL),
(74, 'trek', '0.00', '20000.00', '2014-08-26 09:11:32', '2014-08-26 09:11:32', NULL),
(75, 'pool', '0.00', '20000.00', '2014-08-26 09:11:42', '2014-08-26 09:11:42', NULL),
(76, 'dive', '0.00', '20000.00', '2014-08-26 09:11:44', '2014-08-26 09:11:44', NULL),
(77, 'bike', '0.00', '20000.00', '2014-08-26 09:11:56', '2014-08-26 09:11:56', NULL),
(78, 'xseed', '0.00', '20000.00', '2014-08-26 09:12:07', '2014-08-26 09:12:07', NULL),
(79, 'skate', '0.00', '20000.00', '2014-08-26 09:12:17', '2014-08-26 09:12:17', NULL),
(80, 'wakeboarders', '0.00', '20000.00', '2014-08-26 09:12:40', '2014-08-26 09:12:40', NULL),
(81, 'runteam', '0.00', '20000.00', '2014-08-26 09:13:13', '2014-08-26 09:13:13', NULL),
(82, 'netball', '0.00', '20000.00', '2014-08-26 09:14:09', '2014-08-26 09:14:09', NULL),
(83, 'aikido', '0.00', '20000.00', '2014-08-26 09:14:44', '2014-08-26 09:14:44', NULL),
(84, 'frisbee', '0.00', '20000.00', '2014-08-26 09:15:40', '2014-08-26 09:15:40', NULL),
(85, 'windsurf', '0.00', '20000.00', '2014-08-26 09:17:13', '2014-08-26 09:17:13', NULL),
(86, 'badminton', '0.00', '20000.00', '2014-08-26 09:18:02', '2014-08-26 09:18:02', NULL),
(87, 'cricket', '0.00', '20000.00', '2014-08-26 09:18:57', '2014-08-26 09:18:57', NULL),
(88, 'tabletennis', '0.00', '20000.00', '2014-08-26 09:19:38', '2014-08-26 09:19:38', NULL),
(89, 'connectchina', '0.00', '20000.00', '2014-08-26 09:20:04', '2014-08-26 09:20:04', NULL),
(90, 'taekwando', '0.00', '20000.00', '2014-08-26 09:20:16', '2014-08-26 09:20:16', NULL),
(91, 'chaovietnam', '0.00', '20000.00', '2014-08-26 09:20:22', '2014-08-26 09:20:22', NULL),
(92, 'woorisayi', '0.00', '20000.00', '2014-08-26 09:20:37', '2014-08-26 09:20:37', NULL),
(93, 'barkada', '0.00', '20000.00', '2014-08-26 09:20:49', '2014-08-26 09:20:49', NULL),
(94, 'yimsiam', '230.00', '20000.00', '2014-08-26 09:21:01', '2014-08-30 03:52:02', NULL),
(95, 'soccerwomen', '0.00', '20000.00', '2014-08-26 09:21:18', '2014-08-26 09:21:18', NULL),
(96, 'jcc', '0.00', '20000.00', '2014-08-26 09:21:20', '2014-08-26 09:21:20', NULL),
(97, 'roots', '0.00', '20000.00', '2014-08-26 09:21:34', '2014-08-26 09:21:34', NULL),
(98, 'fcp', '0.00', '21000.00', '2014-08-26 09:21:46', '2014-08-30 02:18:16', NULL),
(99, 'alkhaleej', '0.00', '20000.00', '2014-08-26 09:22:00', '2014-08-26 09:22:00', NULL),
(100, 'fencing', '0.00', '20000.00', '2014-08-26 09:22:05', '2014-08-26 09:22:05', NULL),
(101, 'myanmarcommunity', '0.00', '20000.00', '2014-08-26 09:22:17', '2014-08-26 09:22:17', NULL),
(102, 'trulymalaysia', '0.00', '20000.00', '2014-08-26 09:22:29', '2014-08-26 09:22:29', NULL),
(103, 'golf', '0.00', '20000.00', '2014-08-26 09:22:38', '2014-08-26 09:22:38', NULL),
(104, 'apsara', '0.00', '20000.00', '2014-08-26 09:22:50', '2014-08-26 09:22:50', NULL),
(105, 'sailing', '0.00', '20000.00', '2014-08-26 09:23:52', '2014-08-26 09:23:52', NULL),
(106, 'tracknfield', '0.00', '20000.00', '2014-08-26 09:25:57', '2014-08-26 09:25:57', NULL),
(107, 'kendo', '0.00', '20000.00', '2014-08-26 09:26:26', '2014-08-26 09:26:26', NULL),
(108, 'rugbywomen', '0.00', '20000.00', '2014-08-26 09:27:37', '2014-08-26 09:27:37', NULL),
(109, 'muaythai', '0.00', '20000.00', '2014-08-26 09:28:28', '2014-08-26 09:28:28', NULL),
(110, 'shooting', '0.00', '20000.00', '2014-08-26 09:29:17', '2014-08-26 09:29:17', NULL),
(111, 'dragonboat', '0.00', '20000.00', '2014-08-26 09:29:47', '2014-08-26 09:29:47', NULL),
(112, 'handball', '0.00', '20000.00', '2014-08-26 09:30:21', '2014-08-26 09:30:21', NULL),
(113, 'climbteam', '0.00', '20000.00', '2014-08-26 09:31:20', '2014-08-26 09:31:20', NULL),
(114, 'silat', '0.00', '20000.00', '2014-08-26 09:31:52', '2014-08-26 09:31:52', NULL),
(115, 'softball', '0.00', '20000.00', '2014-08-26 09:32:26', '2014-08-26 09:32:26', NULL),
(116, 'capoeira', '0.00', '20000.00', '2014-08-26 09:33:07', '2014-08-26 09:33:07', NULL),
(117, 'aquathlon', '0.00', '20000.00', '2014-08-26 09:33:48', '2014-08-26 09:33:48', NULL),
(118, 'wushu', '0.00', '20000.00', '2014-08-26 09:34:16', '2014-08-26 09:34:16', NULL),
(119, 'flare', '0.00', '20000.00', '2014-08-26 09:34:41', '2014-08-26 09:34:41', NULL),
(120, 'tchoukball', '0.00', '20000.00', '2014-08-26 09:36:32', '2014-08-26 09:36:32', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `reserve_limits`
--

CREATE TABLE IF NOT EXISTS `reserve_limits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clubid` varchar(255) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `remarks` longtext,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `reserve_limits`
--

INSERT INTO `reserve_limits` (`id`, `clubid`, `amount`, `remarks`, `created_at`, `updated_at`) VALUES
(3, 'ICON', '32000.00', 'testing\r\n', '2014-08-30 02:20:01', '2014-08-30 02:20:01');

-- --------------------------------------------------------

--
-- Table structure for table `reserve_withdrawals`
--

CREATE TABLE IF NOT EXISTS `reserve_withdrawals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(255) DEFAULT NULL,
  `clubid` varchar(255) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `purpose` varchar(255) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `schema_migrations`
--

CREATE TABLE IF NOT EXISTS `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `schema_migrations`
--

INSERT INTO `schema_migrations` (`version`) VALUES
('20140612023858'),
('20140612024011'),
('20140612024529'),
('20140612032615'),
('20140612035308'),
('20140612065920'),
('20140612080144'),
('20140614053916'),
('20140617023407'),
('20140619064452'),
('20140629094211'),
('20140629095102'),
('20140701091410'),
('20140802030138'),
('20140802032120'),
('20140802100451'),
('20140802123621'),
('20140802124543'),
('20140802124729'),
('20140802125120'),
('20140802125748'),
('20140802131406'),
('20140802133251'),
('20140821070725'),
('20140822050306'),
('20140823024618'),
('20140829072415'),
('20140829072942'),
('20140831095849'),
('20140901133421'),
('20140903012550'),
('20140911092539'),
('20140919141741'),
('20140921014704'),
('20140923060808'),
('20140923073525'),
('20140928081820'),
('20140928083238');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE IF NOT EXISTS `transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clubid` varchar(255) DEFAULT NULL,
  `clubcode` varchar(255) DEFAULT NULL,
  `year` varchar(255) DEFAULT NULL,
  `semester` int(11) DEFAULT NULL,
  `typeoftransaction` varchar(255) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `depositid` int(11) DEFAULT NULL,
  `claimid` int(11) DEFAULT NULL,
  `event` varchar(255) DEFAULT NULL,
  `purpose` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `userid` varchar(255) NOT NULL DEFAULT '',
  `passwordhash` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `nric` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) NOT NULL DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `confirmation_token` varchar(255) DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `confirmation_sent_at` datetime DEFAULT NULL,
  `unconfirmed_email` varchar(255) DEFAULT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `contactno` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userid`, `passwordhash`, `created_at`, `updated_at`, `nric`, `email`, `encrypted_password`, `reset_password_token`, `reset_password_sent_at`, `remember_created_at`, `sign_in_count`, `current_sign_in_at`, `last_sign_in_at`, `current_sign_in_ip`, `last_sign_in_ip`, `confirmation_token`, `confirmed_at`, `confirmation_sent_at`, `unconfirmed_email`, `fullname`, `contactno`) VALUES
('jinqyi.lee.2012', NULL, '2014-08-12 06:40:04', '2014-09-15 14:07:32', 'S1234567Z', 'jinqyi.lee.2012@sis.smu.edu.sg', '$2a$10$uQ/67L231N7cdQfQ4jPILulx/gOd/Rt/8dKMNIx4T5QtWWr4KjpZC', NULL, NULL, NULL, 12, '2014-09-15 14:07:32', '2014-09-15 13:58:11', '127.0.0.1', '127.0.0.1', NULL, '2014-08-12 06:40:23', '2014-08-12 06:40:04', NULL, 'jinq', '273109831'),
('mmphang.2012', NULL, '2014-08-12 06:33:50', '2014-09-28 09:24:29', 'S1234567Z', 'mmphang.2012@sis.smu.edu.sg', '$2a$10$Ln27lDy3gfBip3h0B2Ugt.J/LkBhMp18nAjLWKLBfREgjwSe6k7C.', NULL, NULL, NULL, 29, '2014-09-28 09:24:29', '2014-09-15 14:47:13', '127.0.0.1', '127.0.0.1', NULL, '2014-08-12 06:35:28', '2014-08-12 06:33:50', NULL, 'mm', '23132312'),
('terence.chu.2012', NULL, '2014-08-12 06:28:40', '2014-09-27 13:17:52', NULL, 'terence.chu.2012@sis.smu.edu.sg', '$2a$10$w8kqWtb7qWWKiWfkklZjUueAmfoHikV2Y1B.OCIsfnrwQCxjGuGIu', NULL, NULL, NULL, 31, '2014-09-27 13:17:52', '2014-09-15 13:08:29', '127.0.0.1', '127.0.0.1', NULL, '2014-08-12 06:30:42', '2014-08-12 06:28:41', NULL, NULL, NULL),
('trecia.koh.2012', NULL, '2014-08-12 06:37:51', '2014-09-23 06:15:40', 'S1234567Z', 'trecia.koh.2012@sis.smu.edu.sg', '$2a$10$BpLTvaJXIkpi1tmC1OfKQ.3ccbi3qAyYPJthZ1drIKRMfXIlgBMny', NULL, NULL, NULL, 43, '2014-09-23 06:15:40', '2014-09-17 13:55:18', '127.0.0.1', '127.0.0.1', NULL, '2014-08-12 06:38:08', '2014-08-12 06:37:51', NULL, 'ying', '730710310'),
('zhenjie.ng.2012', NULL, '2014-08-16 03:26:15', '2014-09-17 14:01:21', 'S9111111Z', 'zhenjie.ng.2012@sis.smu.edu.sg', '$2a$10$.MriCk6Yndnfj4F5cREM6uopgFaM4gpxH.JHQoqJ4P7OhfyinLAE.', NULL, NULL, NULL, 23, '2014-09-17 14:01:21', '2014-09-15 13:30:11', '127.0.0.1', '127.0.0.1', NULL, '2014-08-16 03:27:14', '2014-08-16 03:26:15', NULL, 'hdoajdaoja', '7237013');

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE IF NOT EXISTS `vendors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  `price` decimal(5,4) DEFAULT NULL,
  `quality` decimal(5,4) DEFAULT NULL,
  `punctuality` decimal(5,4) DEFAULT NULL,
  `customerservice` decimal(5,4) DEFAULT NULL,
  `overall` decimal(5,4) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `reviewers` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `vendors`
--

INSERT INTO `vendors` (`id`, `name`, `contact`, `address`, `category`, `price`, `quality`, `punctuality`, `customerservice`, `overall`, `created_at`, `updated_at`, `reviewers`) VALUES
(1, 'terence', '999', 'sengkang', 1, '4.6667', '3.6667', '4.0000', '4.3333', '5.0000', '2014-09-28 08:43:35', '2014-09-28 09:20:03', 3),
(2, 'mm', '999', 'punggol', 1, '5.0000', '5.0000', '5.0000', '5.0000', '5.0000', '2014-09-28 09:18:08', '2014-09-28 09:18:08', 1),
(3, 'suck', '111', 'ss', 1, '1.0000', '1.0000', '1.0000', '1.0000', '1.0000', '2014-09-28 09:18:38', '2014-09-28 09:18:38', 1);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `clubusers`
--
ALTER TABLE `clubusers`
  ADD CONSTRAINT `fk_1` FOREIGN KEY (`clubid`) REFERENCES `clubs` (`clubid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `expenditure_accounts`
--
ALTER TABLE `expenditure_accounts`
  ADD CONSTRAINT `EA_fk` FOREIGN KEY (`clubid`) REFERENCES `clubs` (`clubid`);

--
-- Constraints for table `reserve_accounts`
--
ALTER TABLE `reserve_accounts`
  ADD CONSTRAINT `RA_fk` FOREIGN KEY (`clubid`) REFERENCES `clubs` (`clubid`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
