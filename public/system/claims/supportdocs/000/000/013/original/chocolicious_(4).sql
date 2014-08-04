-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 22, 2014 at 03:24 AM
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `claims`
--

INSERT INTO `claims` (`id`, `userid`, `clubid`, `amount`, `status`, `category`, `created_at`, `updated_at`, `supportdoc_file_name`, `supportdoc_content_type`, `supportdoc_file_size`, `supportdoc_updated_at`, `remarks`) VALUES
(2, NULL, NULL, '23.23', NULL, '1', '2014-06-12 08:50:05', '2014-06-12 08:50:05', 'EIProposal.docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 1432699, '2014-06-12 08:50:05', NULL),
(3, NULL, NULL, '43.21', NULL, '9', '2014-06-12 08:53:16', '2014-06-12 08:53:16', 'EIProposal.docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 1432699, '2014-06-12 08:53:16', NULL),
(4, NULL, NULL, '43.21', NULL, '9', '2014-06-12 08:57:06', '2014-06-12 08:57:06', 'EIProposal.docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 1432699, '2014-06-12 08:57:06', NULL),
(5, 'normal', 'fcp', '14.34', NULL, '7', '2014-06-12 09:00:27', '2014-06-14 05:19:57', 'EIProposal.docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 1432699, '2014-06-12 09:00:27', NULL),
(6, 'normal', 'fcp', '12.50', 1, '3', '2014-06-14 06:26:14', '2014-07-03 03:04:13', NULL, NULL, NULL, NULL, 'bad'),
(7, 'normal', 'fcp', '13.00', 0, '2', '2014-06-14 06:26:22', '2014-06-14 06:26:22', NULL, NULL, NULL, NULL, NULL),
(8, 'normal', 'fcp', '23.34', 2, '4', '2014-06-17 02:15:32', '2014-07-14 14:30:12', 'EIProposal.docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 1432699, '2014-06-17 02:15:32', NULL),
(9, 'terencechu.x1', 'fcp', '22.00', 0, '1', '2014-06-20 09:12:05', '2014-07-14 14:28:39', 'timetable_(3).pdf', 'application/pdf', 2939, '2014-07-14 14:28:39', NULL),
(10, 'ngzhenjie91', 'fcp', '55.00', 0, '1', '2014-06-26 03:28:56', '2014-06-26 03:28:56', 'IMSLP02452-MacDowell-Op59.pdf', 'application/pdf', 1019502, '2014-06-26 03:28:56', NULL),
(11, 'terencechu.x1', 'fcp', '12.00', 0, '1', '2014-07-03 05:41:48', '2014-07-03 05:41:48', 'claim_code_statuses.txt', 'text/plain', 528, '2014-07-03 05:41:48', NULL);

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
  PRIMARY KEY (`clubid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `clubs`
--

INSERT INTO `clubs` (`clubid`, `finsecid`, `presidentid`, `clubtype`, `clubname`, `created_at`, `updated_at`) VALUES
('ACF', 'terence.chu.2012', NULL, 'cbd', 'Arts and Cultural Fraternity', NULL, '2014-07-03 07:02:35'),
('ASOC', 'cbdfinsec', NULL, 'cbd', 'SMU Accounting Society', NULL, '2014-07-03 06:44:58'),
('BONDUE', 'cbdfinsec', NULL, 'cbd', 'SMU Business Society', NULL, '2014-07-03 06:44:54'),
('fcp', 'ngzhenjie91', 'terence', 'ICON', 'francophiles', NULL, '2014-06-23 07:44:14'),
('ICON', 'terence.chu.2012', 'terence', 'cbd', 'International Connections', NULL, '2014-07-03 07:22:28'),
('marketing', NULL, NULL, 'smusa', 'Marketing Department', NULL, NULL),
('OIKOS', 'cbdfinsec', NULL, 'cbd', 'SMU Economics Society', NULL, '2014-07-03 06:47:57'),
('SICS', 'cbdfinsec', NULL, 'cbd', 'Special Interest and Community Service Sodality', NULL, '2014-07-03 06:48:15'),
('SISS', 'cbdfinsec', NULL, 'cbd', 'School of Information Systems Students'' Society', NULL, '2014-07-03 06:48:39'),
('smusa', 'terencechu.x1', NULL, 'infinite', 'smusa', NULL, NULL),
('SMUX', 'cbdfinsec', NULL, 'cbd', 'SMUXtremists', NULL, '2014-07-03 06:57:34'),
('SOSCI', 'cbdfinsec', NULL, 'cbd', 'SMU Social Sciences Society', NULL, '2014-07-03 06:48:35'),
('SSU', 'cbdfinsec', NULL, 'cbd', 'SMU Sports Union', NULL, '2014-07-03 06:48:31'),
('THE BAR', 'cbdfinsec', NULL, 'cbd', 'SMU Law Society', NULL, '2014-07-03 06:48:25'),
('tm', 'mmphang.2012', 'terence', 'ICON', 'truly malaysia', NULL, '2014-07-03 07:25:58'),
('welfare', NULL, NULL, 'smusa', 'Welfare Department', NULL, NULL);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=122 ;

--
-- Dumping data for table `clubusers`
--

INSERT INTO `clubusers` (`id`, `userid`, `clubid`, `role`, `created_at`, `updated_at`) VALUES
(1, 'terence', 'fcp', 'president', NULL, NULL),
(2, 'terence', 'tm', 'president', NULL, NULL),
(3, 'terencechu.x1', 'smusa', 'smusafinsec', NULL, NULL),
(5, 'normal', 'fcp', 'normal', NULL, NULL),
(16, 'terencechu.x1', 'fcp', 'normal', '2014-06-20 06:59:41', '2014-06-20 06:59:41'),
(20, 'terence.chu.2012', 'fcp', 'normal', '2014-06-20 08:05:28', '2014-06-20 08:05:28'),
(21, 'ngzhenjie91', 'fcp', 'normal', '2014-06-23 05:39:21', '2014-06-23 05:39:21'),
(24, 'ngzhenjie91', 'fcp', 'clubfinsec', '2014-06-23 07:19:42', '2014-06-23 07:19:42'),
(25, 'mmphang.2012', 'fcp', 'normal', '2014-06-23 07:21:17', '2014-06-23 07:21:17'),
(26, 'terencechu.x1', 'fcp', 'clubfinsec', '2014-06-23 07:34:18', '2014-06-23 07:34:18'),
(27, 'cbdfinsec', 'fcp', 'clubfinsec', '2014-06-23 07:34:25', '2014-06-23 07:34:25'),
(31, 'terencechu.x1', 'fcp', 'president', '2014-06-23 08:04:15', '2014-06-23 08:04:15'),
(60, 'terencechu.x1', 'welfare', 'smusasec', '2014-07-03 06:42:18', '2014-07-03 06:42:18'),
(65, 'terencechu.x1', 'marketing', 'smusasec', '2014-07-03 06:44:03', '2014-07-03 06:44:03'),
(114, 'zhenjie.ng.2012', 'fcp', 'normal', '2014-07-03 07:18:23', '2014-07-03 07:18:23'),
(115, 'cbdfinsec', 'fcp', 'normal', '2014-07-03 07:18:38', '2014-07-03 07:18:38'),
(116, 'terence.chu.2012', 'ICON', 'cbdfinsec', '2014-07-03 07:22:29', '2014-07-03 07:22:29'),
(117, 'mmphang.2012', 'tm', 'clubfinsec', '2014-07-03 07:25:58', '2014-07-03 07:25:58'),
(118, 'cbdfinsec', 'tm', 'normal', '2014-07-03 07:28:32', '2014-07-03 07:28:32'),
(119, 'terence.chu.2012', 'tm', 'president', '2014-07-03 07:28:43', '2014-07-03 07:28:43'),
(120, 'zhenjie.ng.2012', 'tm', 'normal', '2014-07-03 07:30:45', '2014-07-03 07:30:45'),
(121, 'mmphang.2012', 'ICON', 'cbdmc', '2014-07-14 14:34:25', '2014-07-14 14:34:25');

-- --------------------------------------------------------

--
-- Table structure for table `expenditure_accounts`
--

CREATE TABLE IF NOT EXISTS `expenditure_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clubid` varchar(255) DEFAULT NULL,
  `Category1Balance` decimal(10,2) DEFAULT '0.00',
  `Category2Balance` decimal(10,2) DEFAULT '0.00',
  `Category3Balance` decimal(10,2) DEFAULT '0.00',
  `Category4Balance` decimal(10,2) DEFAULT '0.00',
  `Category5Balance` decimal(10,2) DEFAULT '0.00',
  `Category6Balance` decimal(10,2) DEFAULT '0.00',
  `Category7Balance` decimal(10,2) DEFAULT '0.00',
  `Category8Balance` decimal(10,2) DEFAULT '0.00',
  `Category9Balance` decimal(10,2) DEFAULT '0.00',
  `Category10Balance` decimal(10,2) DEFAULT '0.00',
  `Category11Balance` decimal(10,2) DEFAULT '0.00',
  `Category12Balance` decimal(10,2) DEFAULT '0.00',
  `Category13Balance` decimal(10,2) DEFAULT '0.00',
  `MiscellaneousBalance` decimal(10,2) DEFAULT '0.00',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `EA_fk` (`clubid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;

--
-- Dumping data for table `expenditure_accounts`
--

INSERT INTO `expenditure_accounts` (`id`, `clubid`, `Category1Balance`, `Category2Balance`, `Category3Balance`, `Category4Balance`, `Category5Balance`, `Category6Balance`, `Category7Balance`, `Category8Balance`, `Category9Balance`, `Category10Balance`, `Category11Balance`, `Category12Balance`, `Category13Balance`, `MiscellaneousBalance`, `created_at`, `updated_at`) VALUES
(1, 'ACF', '88.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '60.87', NULL, '2014-07-02 05:59:56'),
(2, 'ASOC', '0.00', '0.00', '0.00', '0.00', '0.00', '23.00', '0.00', '0.00', '0.00', '0.00', '12.76', '0.00', '0.00', '0.00', NULL, NULL),
(3, 'BONDUE', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL),
(5, 'ICON', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '12.76', '0.00', '0.00', '234.89', '0.00', '0.00', '0.00', '3456.00', NULL, NULL),
(6, 'OIKOS', '0.00', '0.00', '0.00', '12.87', '67.98', '0.00', '0.00', '0.00', '0.00', '0.00', '88.88', '0.00', '0.00', '0.00', NULL, NULL),
(7, 'SICS', '99.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '77.00', NULL, '2014-07-02 06:41:17'),
(8, 'SISS', '0.00', '0.00', '543.98', '765.34', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '12.54', '0.00', '0.00', '5678.99', NULL, NULL),
(9, 'SMUX', '67.87', '12.34', '23.45', '34.56', '45.67', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1234.00', '0.00', NULL, NULL),
(10, 'SOSCI', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1234.99', NULL, NULL),
(11, 'SSU', '999.99', '888.88', '777.77', '666.66', '555.55', '444.44', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '111.11', NULL, NULL),
(12, 'THE BAR', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '9876.98', NULL, NULL),
(13, 'fcp', '78.00', '98.00', '67.00', '3.00', '0.00', '77.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '66.00', '88.00', NULL, '2014-07-02 07:12:40'),
(14, 'tm', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=53 ;

--
-- Dumping data for table `requests`
--

INSERT INTO `requests` (`id`, `userid`, `clubid`, `created_at`, `updated_at`) VALUES
(16, 'mmphang.2012', '', '2014-06-23 06:54:54', '2014-06-23 06:54:54'),
(47, 'terence.chu.2012', 'fcp', '2014-07-03 07:21:55', '2014-07-03 07:21:55'),
(50, 'mmphang.2012', 'fcp', '2014-07-03 07:24:27', '2014-07-03 07:24:27'),
(51, 'zhenjie.ng.2012', 'fcp', '2014-07-03 07:29:59', '2014-07-03 07:29:59'),
(52, 'terencechu.x1', 'tm', '2014-07-14 14:29:06', '2014-07-14 14:29:06');

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
  PRIMARY KEY (`id`),
  KEY `RA_fk` (`clubid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `reserve_accounts`
--

INSERT INTO `reserve_accounts` (`id`, `clubid`, `balance`, `limit`, `created_at`, `updated_at`) VALUES
(1, 'ACF', '344.23', '20000.00', '2014-07-02 13:13:04', '2014-07-02 13:29:08'),
(2, 'ASOC', '0.00', '20000.00', '2014-07-02 13:13:29', '2014-07-02 13:13:29'),
(3, 'BONDUE', '34.00', '20000.00', '2014-07-02 13:13:34', '2014-07-02 13:13:34'),
(4, 'ICON', '345.00', '20000.00', '2014-07-02 13:13:41', '2014-07-02 13:13:41'),
(5, 'OIKOS', '444.00', '20000.00', '2014-07-02 13:13:46', '2014-07-02 13:13:46'),
(6, 'SICS', '45.00', '20000.00', '2014-07-02 13:14:00', '2014-07-02 13:14:00'),
(7, 'SISS', '23.00', '20000.00', '2014-07-02 13:14:09', '2014-07-02 13:14:09'),
(8, 'SMUX', '2000.00', '20000.00', '2014-07-02 13:14:17', '2014-07-02 13:14:17'),
(9, 'SOSCI', '100.10', '20000.01', '2014-07-02 13:14:24', '2014-07-03 05:49:23'),
(10, 'SSU', '34.00', '20000.00', '2014-07-02 13:14:29', '2014-07-02 13:14:29'),
(11, 'THE BAR', '456.00', '20000.00', '2014-07-02 13:14:40', '2014-07-02 13:14:40'),
(12, 'fcp', '233.00', '20000.00', '2014-07-02 13:44:05', '2014-07-02 13:44:05');

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
('20140701091410');

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
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userid`, `passwordhash`, `created_at`, `updated_at`, `nric`, `email`, `encrypted_password`, `reset_password_token`, `reset_password_sent_at`, `remember_created_at`, `sign_in_count`, `current_sign_in_at`, `last_sign_in_at`, `current_sign_in_ip`, `last_sign_in_ip`, `confirmation_token`, `confirmed_at`, `confirmation_sent_at`, `unconfirmed_email`) VALUES
('cbdfinsec', 'password', NULL, NULL, 'S123E', '', '', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('clubfinsec', 'password', NULL, NULL, 'S123E', '', '', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('mmphang.2012', NULL, '2014-06-23 06:26:00', '2014-07-03 07:30:34', NULL, 'mmphang.2012@sis.smu.edu.sg', '$2a$10$oXm46Qb7Fy9fbnjH1uUE9.aWS9BdKeecT69VJzmvDB4ApAlkD73i2', NULL, NULL, NULL, 7, '2014-07-03 07:30:34', '2014-07-03 07:27:35', '192.168.1.4', '192.168.1.4', NULL, '2014-06-23 06:30:29', '2014-06-23 06:26:01', NULL),
('ngzhenjie91', NULL, '2014-06-20 06:20:09', '2014-07-02 14:04:51', NULL, 'ngzhenjie91@gmail.com', '$2a$10$/EAmjqq8ZE4TlY.ObTfXl.eZF5TzGKpsMPofv.MmOrc8HNH/pBLSm', NULL, NULL, NULL, 12, '2014-07-02 14:04:51', '2014-07-02 06:57:57', '127.0.0.1', '127.0.0.1', NULL, '2014-06-20 06:20:56', '2014-06-20 06:20:09', NULL),
('normal', 'password', NULL, NULL, 'S123E', '', '', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('terence', 'password', NULL, NULL, 'S123E', '', '', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('terence.chu.2012', NULL, '2014-06-17 06:30:46', '2014-07-14 14:32:42', NULL, 'terence.chu.2012@sis.smu.edu.sg', '$2a$10$h5ihzJQ.d.GqYLtyGP4GzexrvUX8RJgaZ1xsZ9Hf1Zin3Gzcz9AOC', NULL, NULL, NULL, 26, '2014-07-14 14:32:42', '2014-07-09 08:00:11', '127.0.0.1', '127.0.0.1', NULL, '2014-06-20 06:01:18', '2014-06-17 06:30:46', NULL),
('terencechu.x1', NULL, '2014-06-17 06:30:15', '2014-07-14 14:52:45', NULL, 'terencechu.x1@gmail.com', '$2a$10$AuEi7R.6xYzIHbFaAHQ01.IIp43Ap9CjjcSjysiv5IA76wUEeoOYu', NULL, NULL, NULL, 71, '2014-07-14 14:52:45', '2014-07-14 14:29:42', '127.0.0.1', '127.0.0.1', NULL, '2014-06-19 02:18:38', '2014-06-17 06:30:15', NULL),
('zhenjie.ng.2012', NULL, '2014-06-27 07:39:11', '2014-07-03 07:31:01', NULL, 'zhenjie.ng.2012@sis.smu.edu.sg', '$2a$10$P7H5n./gznol5RF.Zwewueh3jKmXEidjoLbknQAeNIOn61tttwToO', NULL, NULL, NULL, 4, '2014-07-03 07:31:01', '2014-07-03 07:29:42', '192.168.1.4', '192.168.1.4', NULL, '2014-06-27 07:39:55', '2014-06-27 07:39:12', NULL);

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
