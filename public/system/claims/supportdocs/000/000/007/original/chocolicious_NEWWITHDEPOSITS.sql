-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 23, 2014 at 05:28 AM
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `budgets`
--

INSERT INTO `budgets` (`id`, `clubid`, `year`, `semester`, `event`, `startdate`, `enddate`, `estnopar`, `category`, `requestsac`, `requestreserves`, `projectedincome`, `created_at`, `updated_at`, `explanation`, `poster_file_name`, `poster_content_type`, `poster_file_size`, `poster_updated_at`) VALUES
(1, 'ICON', 'AY2014-2015', 1, 'driving', '2014-08-20', '2014-08-21', 43, '1,3', '440.00', '0.00', '0.00', '2014-08-12 08:03:13', '2014-08-12 08:04:13', 'driving is fun', NULL, NULL, NULL, NULL),
(2, 'fcp', 'AY2014-2015', 1, 'french lessons', NULL, NULL, NULL, '2,3,4', '500.00', '0.00', '45.00', '2014-08-16 03:19:45', '2014-08-16 03:20:19', '', NULL, NULL, NULL, NULL);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `budget_expenses`
--

INSERT INTO `budget_expenses` (`id`, `budget_id`, `item`, `requestsac`, `requestreserves`, `unitcost`, `quantity`, `justification`, `quotation`, `created_at`, `updated_at`) VALUES
(1, 1, 'petrol', '140.00', '0.00', '0.00', 0, '', '', '2014-08-12 08:03:55', '2014-08-12 08:03:55'),
(2, 1, 'wheel', '300.00', '0.00', '0.00', 0, '', '', '2014-08-12 08:04:13', '2014-08-12 08:04:13'),
(3, 2, 'teacher', '200.00', '0.00', '0.00', 0, '', '', '2014-08-16 03:19:58', '2014-08-16 03:19:58'),
(4, 2, 'teacher2', '345.00', '0.00', '0.00', 0, '', '', '2014-08-16 03:20:08', '2014-08-16 03:20:08');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `budget_incomes`
--

INSERT INTO `budget_incomes` (`id`, `budget_id`, `item`, `income`, `incomebreakdown`, `created_at`, `updated_at`) VALUES
(1, 2, 'tea', '45.00', '', '2014-08-16 03:20:19', '2014-08-16 03:20:19');

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `claims`
--

INSERT INTO `claims` (`id`, `userid`, `clubid`, `amount`, `status`, `category`, `created_at`, `updated_at`, `supportdoc_file_name`, `supportdoc_content_type`, `supportdoc_file_size`, `supportdoc_updated_at`, `remarks`, `nric`, `event`) VALUES
(1, 'zhenjie.ng.2012', 'fcp', '12.33', 4, '4', '2014-08-12 07:57:52', '2014-08-12 07:59:49', 'includevsjoin.txt', 'text/plain', 276, '2014-08-12 07:57:52', NULL, 'S9111111Z', NULL),
(2, 'zhenjie.ng.2012', 'fcp', '12.00', 4, '2', '2014-08-16 03:29:07', '2014-08-16 05:15:14', 'somecreatestatements.sql', 'application/octet-stream', 1087, '2014-08-16 03:29:07', NULL, 'S9111111Z', NULL),
(3, 'trecia.koh.2012', 'fcp', '14.00', 0, '1', '2014-08-16 03:40:36', '2014-08-16 03:40:36', 'somecreatestatements.sql', 'application/octet-stream', 1087, '2014-08-16 03:40:36', NULL, 'S1234567Z', NULL),
(4, 'zhenjie.ng.2012', 'fcp', '31.00', 0, '1', '2014-08-16 05:16:04', '2014-08-16 05:18:32', 'somecreatestatements.sql', 'application/octet-stream', 1087, '2014-08-16 05:16:04', NULL, 'S9111111Z', NULL),
(5, 'trecia.koh.2012', 'fcp', '23.00', 0, '1', '2014-08-22 10:18:56', '2014-08-22 10:18:56', 'chocolicious.sql', 'application/octet-stream', 26507, '2014-08-22 10:18:56', NULL, 'S1234567Z', 'french lessons'),
(6, 'mmphang.2012', 'marketing', '34.00', 14, '1', '2014-08-22 11:10:21', '2014-08-22 11:12:07', 'claim_code_statuses.txt', 'text/plain', 528, '2014-08-22 11:10:21', NULL, 'S1234567Z', NULL);

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
('ACF', 'terence.chu.2012', NULL, 'cbd', 'Arts and Cultural Fraternity', NULL, '2014-07-03 07:02:35', NULL),
('ASOC', 'cbdfinsec', NULL, 'cbd', 'SMU Accounting Society', NULL, '2014-07-03 06:44:58', NULL),
('BONDUE', 'cbdfinsec', NULL, 'cbd', 'SMU Business Society', NULL, '2014-07-03 06:44:54', NULL),
('fcp', 'trecia.koh.2012', 'jinqyi.lee.2012', 'ICON', 'francophiles', NULL, '2014-08-12 06:40:42', NULL),
('ICON', 'mmphang.2012', 'zhenjie.ng.2012', 'cbd', 'International Connections', NULL, '2014-08-12 06:36:38', NULL),
('marketing', NULL, NULL, 'smusa', 'Marketing Department', '2014-08-22 10:28:48', '2014-08-22 10:28:48', NULL),
('OIKOS', 'cbdfinsec', NULL, 'cbd', 'SMU Economics Society', NULL, '2014-07-03 06:47:57', NULL),
('SICS', 'cbdfinsec', NULL, 'cbd', 'Special Interest and Community Service Sodality', NULL, '2014-07-03 06:48:15', NULL),
('SISS', 'cbdfinsec', NULL, 'cbd', 'School of Information Systems Students'' Society', NULL, '2014-07-03 06:48:39', NULL),
('smusa', 'terencechu.x1', NULL, 'infinite', 'smusa', NULL, NULL, NULL),
('SMUX', 'cbdfinsec', NULL, 'cbd', 'SMUXtremists', NULL, '2014-07-03 06:57:34', NULL),
('SOSCI', 'cbdfinsec', NULL, 'cbd', 'SMU Social Sciences Society', NULL, '2014-07-03 06:48:35', NULL),
('SSU', 'cbdfinsec', NULL, 'cbd', 'SMU Sports Union', NULL, '2014-07-03 06:48:31', NULL),
('THE BAR', 'cbdfinsec', NULL, 'cbd', 'SMU Law Society', NULL, '2014-07-03 06:48:25', NULL),
('tm', 'mmphang.2012', 'terence', 'ICON', 'truly malaysia', NULL, '2014-07-03 07:25:58', NULL),
('welfare2', NULL, NULL, 'smusa', 'The Real Welfare', '2014-08-02 10:10:55', '2014-08-02 10:10:55', NULL);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `clubusers`
--

INSERT INTO `clubusers` (`id`, `userid`, `clubid`, `role`, `created_at`, `updated_at`) VALUES
(1, 'terence.chu.2012', 'smusa', 'smusafinsec', NULL, NULL),
(2, 'mmphang.2012', 'ICON', 'cbdfinsec', '2014-08-12 06:36:38', '2014-08-12 06:36:38'),
(3, 'trecia.koh.2012', 'fcp', 'clubfinsec', '2014-08-12 06:39:00', '2014-08-12 06:39:00'),
(4, 'jinqyi.lee.2012', 'fcp', 'president', '2014-08-12 06:40:42', '2014-08-12 06:40:42'),
(7, 'trecia.koh.2012', 'fcp', 'normal', '2014-08-16 03:39:17', '2014-08-16 03:39:17'),
(8, 'jinqyi.lee.2012', 'ICON', 'cbdmc', '2014-08-22 05:29:56', '2014-08-22 05:29:56'),
(10, 'mmphang.2012', 'marketing', 'smusasec', '2014-08-22 11:07:02', '2014-08-22 11:07:02'),
(11, 'jinqyi.lee.2012', 'welfare2', 'smusasec', '2014-08-22 11:07:11', '2014-08-22 11:07:11'),
(12, 'zhenjie.ng.2012', 'ICON', 'president', '2014-08-23 05:21:12', '2014-08-23 05:21:12');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `deposits`
--

INSERT INTO `deposits` (`id`, `userid`, `clubid`, `amount`, `status`, `remarks`, `date`, `receipts`, `donorname`, `donoradd`, `donoric`, `purpose`, `created_at`, `updated_at`) VALUES
(1, 'trecia.koh.2012', 'fcp', '23.00', 1, 'yes', '2014-08-23', '3,4,5', '', '', '', 'ticket salessss', '2014-08-23 05:13:16', '2014-08-23 05:18:53'),
(2, 'mmphang.2012', 'marketing', '33.00', 14, NULL, '2014-08-21', '2', '', '', '', 'fff', '2014-08-23 05:15:54', '2014-08-23 05:23:25'),
(3, 'jinqyi.lee.2012', 'icon', '34.00', 9, NULL, '2014-08-26', '33', '', '', '', 'testingpurposes', '2014-08-23 05:16:59', '2014-08-23 05:21:47');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=17 ;

--
-- Dumping data for table `expenditure_accounts`
--

INSERT INTO `expenditure_accounts` (`id`, `clubid`, `Category1Balance`, `Category2Balance`, `created_at`, `updated_at`) VALUES
(1, 'ACF', '88.00', '0.00', NULL, '2014-07-02 05:59:56'),
(2, 'ASOC', '0.00', '0.00', NULL, NULL),
(3, 'BONDUE', '0.00', '0.00', NULL, NULL),
(5, 'ICON', '0.00', '0.00', NULL, NULL),
(6, 'OIKOS', '0.00', '0.00', NULL, NULL),
(7, 'SICS', '99.00', '0.00', NULL, '2014-07-02 06:41:17'),
(8, 'SISS', '0.00', '0.00', NULL, NULL),
(9, 'SMUX', '67.87', '12.34', NULL, NULL),
(10, 'SOSCI', '0.00', '0.00', NULL, NULL),
(11, 'SSU', '999.99', '888.88', NULL, NULL),
(12, 'THE BAR', '0.00', '0.00', NULL, NULL),
(13, 'fcp', '78.00', '98.00', NULL, '2014-07-02 07:12:40'),
(14, 'tm', '0.00', '0.00', NULL, NULL),
(15, 'welfare2', '0.00', '0.00', '2014-08-02 10:10:55', '2014-08-02 10:10:55'),
(16, 'marketing', '300.00', '0.00', '2014-08-22 10:28:48', '2014-08-22 11:06:17');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `requests`
--

INSERT INTO `requests` (`id`, `userid`, `clubid`, `created_at`, `updated_at`) VALUES
(2, 'zhenjie.ng.2012', 'tm', '2014-08-22 06:03:47', '2014-08-22 06:03:47');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `reserve_accounts`
--

INSERT INTO `reserve_accounts` (`id`, `clubid`, `balance`, `limit`, `created_at`, `updated_at`, `justification`) VALUES
(1, 'ACF', '344.23', '20000.00', '2014-07-02 13:13:04', '2014-07-02 13:29:08', NULL),
(2, 'ASOC', '0.00', '20000.00', '2014-07-02 13:13:29', '2014-07-02 13:13:29', NULL),
(3, 'BONDUE', '34.00', '20000.00', '2014-07-02 13:13:34', '2014-07-02 13:13:34', NULL),
(4, 'ICON', '345.00', '20000.00', '2014-07-02 13:13:41', '2014-07-02 13:13:41', NULL),
(5, 'OIKOS', '444.00', '20000.00', '2014-07-02 13:13:46', '2014-07-02 13:13:46', NULL),
(6, 'SICS', '45.00', '20000.00', '2014-07-02 13:14:00', '2014-07-02 13:14:00', NULL),
(7, 'SISS', '23.00', '20000.00', '2014-07-02 13:14:09', '2014-07-02 13:14:09', NULL),
(8, 'SMUX', '2000.00', '20000.00', '2014-07-02 13:14:17', '2014-07-02 13:14:17', NULL),
(9, 'SOSCI', '100.10', '20000.01', '2014-07-02 13:14:24', '2014-07-03 05:49:23', NULL),
(10, 'SSU', '34.00', '20000.00', '2014-07-02 13:14:29', '2014-07-02 13:14:29', NULL),
(11, 'THE BAR', '456.00', '20000.00', '2014-07-02 13:14:40', '2014-07-02 13:14:40', NULL),
(12, 'fcp', '233.00', '20000.00', '2014-07-02 13:44:05', '2014-07-02 13:44:05', NULL),
(13, 'tm', '0.00', '20000.00', NULL, '2014-08-03 12:12:41', '\r\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.');

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
('20140823024618');

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
('jinqyi.lee.2012', NULL, '2014-08-12 06:40:04', '2014-08-23 05:16:35', 'S1234567Z', 'jinqyi.lee.2012@sis.smu.edu.sg', '$2a$10$uQ/67L231N7cdQfQ4jPILulx/gOd/Rt/8dKMNIx4T5QtWWr4KjpZC', NULL, NULL, NULL, 8, '2014-08-23 05:16:35', '2014-08-23 05:13:54', '127.0.0.1', '127.0.0.1', NULL, '2014-08-12 06:40:23', '2014-08-12 06:40:04', NULL, 'jinq', '273109831'),
('mmphang.2012', NULL, '2014-08-12 06:33:50', '2014-08-23 05:22:49', 'S1234567Z', 'mmphang.2012@sis.smu.edu.sg', '$2a$10$Ln27lDy3gfBip3h0B2Ugt.J/LkBhMp18nAjLWKLBfREgjwSe6k7C.', NULL, NULL, NULL, 19, '2014-08-23 05:22:49', '2014-08-23 05:15:29', '127.0.0.1', '127.0.0.1', NULL, '2014-08-12 06:35:28', '2014-08-12 06:33:50', NULL, 'mm', '23132312'),
('terence.chu.2012', NULL, '2014-08-12 06:28:40', '2014-08-23 05:19:53', NULL, 'terence.chu.2012@sis.smu.edu.sg', '$2a$10$w8kqWtb7qWWKiWfkklZjUueAmfoHikV2Y1B.OCIsfnrwQCxjGuGIu', NULL, NULL, NULL, 11, '2014-08-23 05:19:53', '2014-08-23 02:36:21', '127.0.0.1', '127.0.0.1', NULL, '2014-08-12 06:30:42', '2014-08-12 06:28:41', NULL, NULL, NULL),
('trecia.koh.2012', NULL, '2014-08-12 06:37:51', '2014-08-23 05:10:26', 'S1234567Z', 'trecia.koh.2012@sis.smu.edu.sg', '$2a$10$BpLTvaJXIkpi1tmC1OfKQ.3ccbi3qAyYPJthZ1drIKRMfXIlgBMny', NULL, NULL, NULL, 18, '2014-08-23 05:10:26', '2014-08-22 11:32:02', '127.0.0.1', '127.0.0.1', NULL, '2014-08-12 06:38:08', '2014-08-12 06:37:51', NULL, 'ying', '730710310'),
('zhenjie.ng.2012', NULL, '2014-08-16 03:26:15', '2014-08-23 05:21:35', 'S9111111Z', 'zhenjie.ng.2012@sis.smu.edu.sg', '$2a$10$.MriCk6Yndnfj4F5cREM6uopgFaM4gpxH.JHQoqJ4P7OhfyinLAE.', NULL, NULL, NULL, 10, '2014-08-23 05:21:35', '2014-08-22 11:15:51', '127.0.0.1', '127.0.0.1', NULL, '2014-08-16 03:27:14', '2014-08-16 03:26:15', NULL, 'hdoajdaoja', '7237013');

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
