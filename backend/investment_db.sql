-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 03, 2026 at 11:17 AM
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
-- Database: `investment_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `account_upgrades`
--

CREATE TABLE `account_upgrades` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `requested_account_type` varchar(50) NOT NULL,
  `current_account_type` varchar(50) NOT NULL,
  `note` text DEFAULT NULL,
  `proof_filename` varchar(255) DEFAULT NULL,
  `status` enum('pending','approved','declined') NOT NULL DEFAULT 'pending',
  `admin_note` text DEFAULT NULL,
  `approved_by` bigint(20) DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `declined_by` bigint(20) DEFAULT NULL,
  `declined_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `account_upgrades`
--

INSERT INTO `account_upgrades` (`id`, `user_id`, `requested_account_type`, `current_account_type`, `note`, `proof_filename`, `status`, `admin_note`, `approved_by`, `approved_at`, `declined_by`, `declined_at`, `created_at`, `updated_at`) VALUES
(1, 5, 'vip', '', 'i want vip', NULL, 'declined', NULL, NULL, NULL, 1, '2026-01-03 08:34:22', '2026-01-03 08:33:39', '2026-01-03 08:34:22'),
(2, 5, 'vip', '', 'i want vip', 'upgrade-5-1767458066954-196251605.jpg', 'pending', NULL, NULL, NULL, NULL, NULL, '2026-01-03 08:34:27', '2026-01-03 08:34:27');

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `name` varchar(120) NOT NULL,
  `email` varchar(190) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `email`, `password_hash`, `created_at`) VALUES
(1, 'Super Admin', 'admin@admin.com', '$2b$12$MwcdGDzPoQLnSvQZj1m/rOHFKI/jjRX3qWoft0YuOXSDAkk2jEcve', '2026-01-02 20:08:23');

-- --------------------------------------------------------

--
-- Table structure for table `app_settings`
--

CREATE TABLE `app_settings` (
  `setting_key` varchar(100) NOT NULL,
  `setting_value` varchar(255) NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`setting_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `app_settings`
--

INSERT INTO `app_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES
('registration_otp_enabled', '1', current_timestamp());

-- --------------------------------------------------------

--
-- Table structure for table `copy_traders`
--

CREATE TABLE `copy_traders` (
  `id` bigint(20) NOT NULL,
  `trader_name` varchar(120) NOT NULL,
  `win_rate_percent` decimal(6,2) NOT NULL DEFAULT 0.00,
  `profit_percent` decimal(6,2) NOT NULL DEFAULT 0.00,
  `image_filename` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `copy_traders`
--

INSERT INTO `copy_traders` (`id`, `trader_name`, `win_rate_percent`, `profit_percent`, `image_filename`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'light trader boy', 70.00, 30.00, 'trader-1767454612052-59002404.jpg', 1, '2026-01-03 07:36:52', '2026-01-03 07:36:52');

-- --------------------------------------------------------

--
-- Table structure for table `deposits`
--

CREATE TABLE `deposits` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `asset` enum('BTC','ETH','USDT','BNB','LTC','DOGE','XRP','SHIB','SOL') NOT NULL,
  `amount` decimal(36,18) NOT NULL,
  `proof_filename` varchar(255) NOT NULL,
  `status` enum('pending','approved','declined') NOT NULL DEFAULT 'pending',
  `admin_note` varchar(255) DEFAULT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `declined_by` int(11) DEFAULT NULL,
  `declined_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `deposits`
--

INSERT INTO `deposits` (`id`, `user_id`, `asset`, `amount`, `proof_filename`, `status`, `admin_note`, `approved_by`, `approved_at`, `declined_by`, `declined_at`, `created_at`, `updated_at`) VALUES
(1, 5, 'BTC', 100.000000000000000000, 'deposit_1767443047905_b67bf4099877b.png', 'approved', 'Payment verified successfully', 1, '2026-01-03 04:46:03', NULL, NULL, '2026-01-03 04:24:08', '2026-01-03 04:46:03');

-- --------------------------------------------------------

--
-- Table structure for table `email_logs`
--

CREATE TABLE `email_logs` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `to_email` varchar(190) NOT NULL,
  `subject` varchar(190) NOT NULL,
  `message` text NOT NULL,
  `status` enum('sent','failed') NOT NULL DEFAULT 'sent',
  `error` text DEFAULT NULL,
  `created_by` bigint(20) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `email_logs`
--

INSERT INTO `email_logs` (`id`, `user_id`, `to_email`, `subject`, `message`, `status`, `error`, `created_by`, `created_at`) VALUES
(1, 5, '8amlight@gmail.com', 'KYC Approved', 'Your KYC has been approved. You can now withdraw.', 'sent', NULL, 1, '2026-01-03 08:04:50');

-- --------------------------------------------------------

--
-- Table structure for table `email_otps`
--

CREATE TABLE `email_otps` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `email` varchar(190) NOT NULL,
  `otp` varchar(6) NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `investment_plans`
--

CREATE TABLE `investment_plans` (
  `id` bigint(20) NOT NULL,
  `name` varchar(120) NOT NULL,
  `roi_percent` decimal(6,2) NOT NULL DEFAULT 0.00,
  `accuracy_percent` decimal(6,2) NOT NULL DEFAULT 0.00,
  `price` decimal(18,2) NOT NULL DEFAULT 0.00,
  `duration_days` int(11) NOT NULL DEFAULT 1,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `investment_plans`
--

INSERT INTO `investment_plans` (`id`, `name`, `roi_percent`, `accuracy_percent`, `price`, `duration_days`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Gold Package', 25.00, 92.00, 500.00, 2, 1, '2026-01-03 07:03:06', '2026-01-03 07:03:23'),
(2, 'stater plan', 14.00, 80.00, 4000.00, 3, 1, '2026-01-05 03:00:22', '2026-01-05 03:00:22');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `type` enum('popup','notification') NOT NULL,
  `title` varchar(150) NOT NULL,
  `message` text NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  `created_by` bigint(20) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `type`, `title`, `message`, `expires_at`, `created_by`, `created_at`) VALUES
(1, NULL, 'notification', 'New Plan Added', 'A new investment plan has been added. Check it out!', NULL, 1, '2026-01-03 08:03:42'),
(2, NULL, 'popup', 'Withdrawal Notice', 'Withdrawals will be processed within 24 hours.', '2026-01-03 10:06:43', 1, '2026-01-03 08:06:43');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_otps`
--

CREATE TABLE `password_reset_otps` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `otp` varchar(10) NOT NULL,
  `expires_at` datetime NOT NULL,
  `used` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trades`
--

CREATE TABLE `trades` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `symbol` varchar(20) NOT NULL,
  `side` enum('buy','sell') NOT NULL,
  `amount` decimal(18,2) NOT NULL,
  `duration_seconds` int(11) NOT NULL,
  `entry_price` decimal(18,8) DEFAULT NULL,
  `exit_price` decimal(18,8) DEFAULT NULL,
  `pnl` decimal(18,2) DEFAULT NULL,
  `status` enum('open','closed') NOT NULL DEFAULT 'open',
  `opened_at` datetime NOT NULL DEFAULT current_timestamp(),
  `expires_at` datetime NOT NULL,
  `closed_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `trades`
--

INSERT INTO `trades` (`id`, `user_id`, `symbol`, `side`, `amount`, `duration_seconds`, `entry_price`, `exit_price`, `pnl`, `status`, `opened_at`, `expires_at`, `closed_at`) VALUES
(1, 5, 'AAPL', 'buy', 50.00, 30, 192.55000000, 192.55000000, 0.00, 'closed', '2026-01-03 06:48:56', '2026-01-03 06:49:26', '2026-01-03 06:49:41'),
(2, 5, 'XOM', 'buy', 200.00, 30, NULL, NULL, 0.00, 'closed', '2026-01-04 02:24:46', '2026-01-04 02:25:16', '2026-01-04 02:25:52');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `full_name` varchar(150) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(190) NOT NULL,
  `phone` varchar(40) NOT NULL,
  `address` text NOT NULL,
  `city` varchar(100) NOT NULL,
  `zipcode` varchar(20) DEFAULT NULL,
  `country` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `main_balance` decimal(18,2) NOT NULL DEFAULT 0.00,
  `profit_balance` decimal(18,2) NOT NULL DEFAULT 0.00,
  `investment_balance` decimal(18,2) NOT NULL DEFAULT 0.00,
  `account_type` varchar(50) DEFAULT NULL,
  `trade_progress` int(11) NOT NULL DEFAULT 0,
  `signal_strength` int(11) NOT NULL DEFAULT 0,
  `account_status` enum('active','block') NOT NULL DEFAULT 'active',
  `copy_trading_status` enum('active','lock') NOT NULL DEFAULT 'lock',
  `trading_status` enum('active','lock') NOT NULL DEFAULT 'lock',
  `pin_hash` varchar(255) DEFAULT NULL,
  `role` varchar(20) DEFAULT 'user',
  `is_verified` tinyint(1) DEFAULT 0,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `withdraw_hold` decimal(18,2) NOT NULL DEFAULT 0.00,
  `copied_trader_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `full_name`, `username`, `email`, `phone`, `address`, `city`, `zipcode`, `country`, `password_hash`, `main_balance`, `profit_balance`, `investment_balance`, `account_type`, `trade_progress`, `signal_strength`, `account_status`, `copy_trading_status`, `trading_status`, `pin_hash`, `role`, `is_verified`, `created_at`, `updated_at`, `withdraw_hold`, `copied_trader_id`) VALUES
(5, 'light potato', 'habibi', '8amlight@gmail.com', '+2347067073704', '12 Allen Avenue', 'Ikeja', '100271', 'Nigeria', '$2b$12$7JCr4uv9KU0p0I8nSTThf.gHaq5E5CJO29HeNJfVx4sGUk8KlTUe6', 2000.00, 89.70, 3000.00, NULL, 80, 40, 'active', 'active', 'lock', '123456', 'user', 1, '2026-01-02 19:22:32', '2026-03-14 00:30:02', 0.00, 1),
(6, 'John David Stone', 'johnstone', 'johnstone@mail.com', '+2347067073704', '12 Admiralty Way', 'Lagos', '100001', 'Nigeria', '$2b$12$y2tPqdnLg0fIk5u4QVxFruI/g4KGwTCjxMxw68nsXDWD13NZiGTGK', 1500.50, 220.75, 900.00, 'Premium', 65, 88, 'active', 'active', 'lock', NULL, 'user', 1, '2026-01-02 19:22:32', '2026-01-03 04:43:13', 0.00, NULL),
(7, 'Providence OSiobe', 'light-potato', '8amjoker@gmail.com', '+2348103594677', 'No 7 Jesus Is Lord Ojipata Layout', 'Udu', '330102', 'Nigeria', '$2b$12$qtZ.OZfGcGZU0zvaAOmsD.sbP00LqsToQrJ1C73LkG1irxGUekMe2', 0.00, 0.00, 0.00, NULL, 0, 0, 'active', 'lock', 'lock', NULL, 'user', 1, '2026-01-05 00:25:18', '2026-01-05 00:28:06', 0.00, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_crypto_balances`
--

CREATE TABLE `user_crypto_balances` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `asset` enum('BTC','ETH','USDT','BNB','LTC','DOGE','XRP','SHIB','SOL') NOT NULL,
  `balance` decimal(36,18) NOT NULL DEFAULT 0.000000000000000000,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_crypto_balances`
--

INSERT INTO `user_crypto_balances` (`id`, `user_id`, `asset`, `balance`, `updated_at`, `created_at`) VALUES
(1, 6, 'BTC', 0.250000000000000000, '2026-01-03 06:36:43', '2026-01-03 06:36:43'),
(2, 6, 'ETH', 1.750000000000000000, '2026-01-03 06:36:43', '2026-01-03 06:36:43'),
(3, 6, 'USDT', 9.000000000000000000, '2026-01-04 08:07:42', '2026-01-03 06:36:43'),
(4, 6, 'BNB', 2.000000000000000000, '2026-01-03 06:36:43', '2026-01-03 06:36:43'),
(5, 5, 'BTC', 0.250000000000000000, '2026-01-03 06:42:10', '2026-01-03 06:42:10'),
(6, 5, 'ETH', 1.750000000000000000, '2026-01-03 06:42:10', '2026-01-03 06:42:10'),
(7, 5, 'USDT', 1.000000000000000000, '2026-01-04 08:08:58', '2026-01-03 06:42:10'),
(8, 5, 'BNB', 2.000000000000000000, '2026-01-03 06:42:10', '2026-01-03 06:42:10'),
(9, 5, 'LTC', 0.000000000000000000, '2026-01-03 07:11:30', '2026-01-03 07:11:30'),
(10, 6, 'LTC', 0.000000000000000000, '2026-01-03 07:11:30', '2026-01-03 07:11:30'),
(11, 5, 'DOGE', 0.000000000000000000, '2026-01-03 07:11:30', '2026-01-03 07:11:30'),
(12, 6, 'DOGE', 0.000000000000000000, '2026-01-03 07:11:30', '2026-01-03 07:11:30'),
(13, 5, 'XRP', 0.000000000000000000, '2026-01-03 07:11:30', '2026-01-03 07:11:30'),
(14, 6, 'XRP', 0.000000000000000000, '2026-01-03 07:11:30', '2026-01-03 07:11:30'),
(15, 5, 'SHIB', 0.000000000000000000, '2026-01-03 07:11:30', '2026-01-03 07:11:30'),
(16, 6, 'SHIB', 0.000000000000000000, '2026-01-03 07:11:30', '2026-01-03 07:11:30'),
(17, 5, 'SOL', 0.000000000000000000, '2026-01-03 07:11:30', '2026-01-03 07:11:30'),
(18, 6, 'SOL', 0.000000000000000000, '2026-01-03 07:11:30', '2026-01-03 07:11:30'),
(19, 7, 'BTC', 0.000000000000000000, '2026-01-05 10:34:35', '2026-01-05 10:34:35'),
(20, 7, 'ETH', 0.000000000000000000, '2026-01-05 10:34:35', '2026-01-05 10:34:35'),
(21, 7, 'USDT', 0.000000000000000000, '2026-01-05 10:34:35', '2026-01-05 10:34:35'),
(22, 7, 'BNB', 0.000000000000000000, '2026-01-05 10:34:35', '2026-01-05 10:34:35'),
(23, 7, 'LTC', 0.000000000000000000, '2026-01-05 10:34:35', '2026-01-05 10:34:35'),
(24, 7, 'DOGE', 0.000000000000000000, '2026-01-05 10:34:35', '2026-01-05 10:34:35'),
(25, 7, 'XRP', 0.000000000000000000, '2026-01-05 10:34:35', '2026-01-05 10:34:35'),
(26, 7, 'SHIB', 0.000000000000000000, '2026-01-05 10:34:35', '2026-01-05 10:34:35'),
(27, 7, 'SOL', 0.000000000000000000, '2026-01-05 10:34:35', '2026-01-05 10:34:35');

-- --------------------------------------------------------

--
-- Table structure for table `user_investments`
--

CREATE TABLE `user_investments` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `plan_id` bigint(20) NOT NULL,
  `amount` decimal(18,2) NOT NULL,
  `roi_percent` decimal(6,2) NOT NULL,
  `expected_profit` decimal(18,2) NOT NULL,
  `expected_total` decimal(18,2) NOT NULL,
  `duration_days` int(11) NOT NULL,
  `status` enum('active','completed','cancelled') NOT NULL DEFAULT 'active',
  `started_at` datetime NOT NULL DEFAULT current_timestamp(),
  `ends_at` datetime NOT NULL,
  `completed_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_investments`
--

INSERT INTO `user_investments` (`id`, `user_id`, `plan_id`, `amount`, `roi_percent`, `expected_profit`, `expected_total`, `duration_days`, `status`, `started_at`, `ends_at`, `completed_at`, `created_at`, `updated_at`) VALUES
(1, 5, 1, 1000.00, 25.00, 250.00, 1250.00, 2, 'active', '2026-01-03 07:10:09', '2026-01-05 07:10:09', NULL, '2026-01-03 07:10:09', '2026-01-03 07:10:09'),
(2, 5, 1, 2000.00, 25.00, 500.00, 2500.00, 2, 'active', '2026-01-04 03:30:04', '2026-01-06 03:30:04', NULL, '2026-01-04 03:30:04', '2026-01-04 03:30:04');

-- --------------------------------------------------------

--
-- Table structure for table `user_kyc`
--

CREATE TABLE `user_kyc` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `selfie_filename` varchar(255) NOT NULL,
  `id_front_filename` varchar(255) NOT NULL,
  `id_back_filename` varchar(255) NOT NULL,
  `status` enum('pending','approved','declined') NOT NULL DEFAULT 'pending',
  `admin_note` text DEFAULT NULL,
  `approved_by` bigint(20) DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `declined_by` bigint(20) DEFAULT NULL,
  `declined_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_kyc`
--

INSERT INTO `user_kyc` (`id`, `user_id`, `selfie_filename`, `id_front_filename`, `id_back_filename`, `status`, `admin_note`, `approved_by`, `approved_at`, `declined_by`, `declined_at`, `created_at`, `updated_at`) VALUES
(1, 5, 'kyc-5-selfie-1767453778397-159554243.png', 'kyc-5-id_front-1767453778465-919914383.png', 'kyc-5-id_back-1767453778499-230963584.jpg', 'approved', 'Documents verified successfully.', 1, '2026-01-03 07:29:36', NULL, NULL, '2026-01-03 07:22:58', '2026-01-03 07:29:36');

-- --------------------------------------------------------

--
-- Table structure for table `wallet_addresses`
--

CREATE TABLE `wallet_addresses` (
  `id` int(11) NOT NULL,
  `asset` enum('BTC','ETH','USDT','BNB','LTC','DOGE','XRP','SHIB','SOL') NOT NULL,
  `address` varchar(255) NOT NULL,
  `qr_filename` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `wallet_addresses`
--

INSERT INTO `wallet_addresses` (`id`, `asset`, `address`, `qr_filename`, `created_at`, `updated_at`) VALUES
(1, 'BTC', 'bc1qwzjfhg4r3snd3lkttdn4sye25hlwm4r7t9sejx', 'qr_1767425548419_cdd7976abbfb9.jpg', '2026-01-02 23:32:28', '2026-01-02 23:32:28'),
(2, 'USDT', 'usdt************', 'qr_1767609754013_4c14254b92a18.png', '2026-01-05 02:42:34', '2026-01-05 02:42:34');

-- --------------------------------------------------------

--
-- Table structure for table `withdrawals`
--

CREATE TABLE `withdrawals` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `method` enum('bank','crypto') NOT NULL,
  `asset` varchar(20) DEFAULT NULL,
  `amount` decimal(18,2) NOT NULL,
  `status` enum('pending','approved','declined') NOT NULL DEFAULT 'pending',
  `crypto_address` varchar(120) DEFAULT NULL,
  `crypto_network` varchar(30) DEFAULT NULL,
  `bank_name` varchar(80) DEFAULT NULL,
  `bank_account_number` varchar(40) DEFAULT NULL,
  `bank_account_name` varchar(80) DEFAULT NULL,
  `bank_country` varchar(60) DEFAULT NULL,
  `admin_note` text DEFAULT NULL,
  `approved_by` bigint(20) DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `declined_by` bigint(20) DEFAULT NULL,
  `declined_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `withdrawals`
--

INSERT INTO `withdrawals` (`id`, `user_id`, `method`, `asset`, `amount`, `status`, `crypto_address`, `crypto_network`, `bank_name`, `bank_account_number`, `bank_account_name`, `bank_country`, `admin_note`, `approved_by`, `approved_at`, `declined_by`, `declined_at`, `created_at`, `updated_at`) VALUES
(1, 5, 'crypto', 'BTC', 50.00, 'approved', 'bc1qexampleaddressxxxxxxxxxxxxxxxxxxxxxx', 'BTC', NULL, NULL, NULL, NULL, 'Approved. Payout processing initiated.', 1, '2026-01-03 06:19:34', NULL, NULL, '2026-01-03 06:14:51', '2026-01-03 06:19:34'),
(2, 5, 'bank', NULL, 10.00, 'declined', NULL, NULL, 'UBA', '0123456789', 'Keating Woodman', 'Nigeria', 'Approved. Payout processing initiated.', NULL, NULL, 1, '2026-01-03 06:19:59', '2026-01-03 06:15:58', '2026-01-03 06:19:59');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account_upgrades`
--
ALTER TABLE `account_upgrades`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `status` (`status`),
  ADD KEY `requested_account_type` (`requested_account_type`),
  ADD KEY `created_at` (`created_at`);

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `copy_traders`
--
ALTER TABLE `copy_traders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_copy_traders_active` (`is_active`);

--
-- Indexes for table `deposits`
--
ALTER TABLE `deposits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `email_logs`
--
ALTER TABLE `email_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `created_at` (`created_at`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `email_otps`
--
ALTER TABLE `email_otps`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `investment_plans`
--
ALTER TABLE `investment_plans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_investment_plans_active` (`is_active`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `type` (`type`),
  ADD KEY `created_at` (`created_at`),
  ADD KEY `expires_at` (`expires_at`);

--
-- Indexes for table `password_reset_otps`
--
ALTER TABLE `password_reset_otps`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- Indexes for table `trades`
--
ALTER TABLE `trades`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `status` (`status`),
  ADD KEY `expires_at` (`expires_at`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_crypto_balances`
--
ALTER TABLE `user_crypto_balances`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_user_asset` (`user_id`,`asset`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- Indexes for table `user_investments`
--
ALTER TABLE `user_investments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `plan_id` (`plan_id`),
  ADD KEY `status` (`status`),
  ADD KEY `ends_at` (`ends_at`);

--
-- Indexes for table `user_kyc`
--
ALTER TABLE `user_kyc`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `wallet_addresses`
--
ALTER TABLE `wallet_addresses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_asset` (`asset`);

--
-- Indexes for table `withdrawals`
--
ALTER TABLE `withdrawals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `status` (`status`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account_upgrades`
--
ALTER TABLE `account_upgrades`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `copy_traders`
--
ALTER TABLE `copy_traders`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `deposits`
--
ALTER TABLE `deposits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `email_logs`
--
ALTER TABLE `email_logs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `email_otps`
--
ALTER TABLE `email_otps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `investment_plans`
--
ALTER TABLE `investment_plans`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `password_reset_otps`
--
ALTER TABLE `password_reset_otps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `trades`
--
ALTER TABLE `trades`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `user_crypto_balances`
--
ALTER TABLE `user_crypto_balances`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `user_investments`
--
ALTER TABLE `user_investments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_kyc`
--
ALTER TABLE `user_kyc`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `wallet_addresses`
--
ALTER TABLE `wallet_addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `withdrawals`
--
ALTER TABLE `withdrawals`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `email_otps`
--
ALTER TABLE `email_otps`
  ADD CONSTRAINT `email_otps_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `password_reset_otps`
--
ALTER TABLE `password_reset_otps`
  ADD CONSTRAINT `fk_password_reset_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_crypto_balances`
--
ALTER TABLE `user_crypto_balances`
  ADD CONSTRAINT `fk_ucb_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
