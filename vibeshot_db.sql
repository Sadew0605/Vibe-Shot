-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 20, 2025 at 06:13 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vibeshot_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `AdminID` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Email` varchar(150) NOT NULL,
  `Password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`AdminID`, `Name`, `Email`, `Password`) VALUES
(2, 'Main Admin', 'vibeshot@admin.com', '$2y$10$EHg.0IyqhSFzG6rw8FuMfONKX.Gh1rqxbc.JcVMx9Z8kTnbIw.lyO');

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `BookingID` int(11) NOT NULL,
  `ClientID` int(11) NOT NULL,
  `PhotographerID` int(11) NOT NULL,
  `ThemeID` int(11) DEFAULT NULL,
  `SessionType` enum('Indoor','Outdoor') NOT NULL,
  `OutdoorCategory` varchar(100) DEFAULT NULL,
  `Location` varchar(255) DEFAULT NULL,
  `ShootDate` date NOT NULL,
  `StartTime` time NOT NULL,
  `DurationMin` int(11) NOT NULL,
  `Status` enum('Pending','Confirmed','Completed','Cancelled','Declined') DEFAULT 'Pending',
  `Amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `PaymentStatus` enum('Unpaid','Paid','Refunded') DEFAULT 'Unpaid',
  `PaymentRef` varchar(100) DEFAULT NULL,
  `CreatedAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`BookingID`, `ClientID`, `PhotographerID`, `ThemeID`, `SessionType`, `OutdoorCategory`, `Location`, `ShootDate`, `StartTime`, `DurationMin`, `Status`, `Amount`, `PaymentStatus`, `PaymentRef`, `CreatedAt`) VALUES
(3, 5, 1, 4, 'Indoor', '', '', '2025-08-29', '14:00:00', 60, 'Confirmed', 18000.00, 'Paid', 'VS20250815141227-85f9b612', '2025-08-15 17:42:27'),
(5, 5, 3, 4, 'Indoor', '', '', '2025-08-28', '16:00:00', 60, 'Completed', 18000.00, 'Paid', 'VS20250818101724-aa65c718', '2025-08-18 13:47:24'),
(6, 5, 3, 4, 'Indoor', '', '', '2025-08-29', '09:00:00', 60, 'Confirmed', 18000.00, 'Paid', 'VS20250818142707-4e3cc9e5', '2025-08-18 17:57:07'),
(7, 5, 1, 6, 'Indoor', '', '', '2025-08-18', '23:45:00', 60, 'Confirmed', 3000.00, 'Paid', 'VS20250818200031-d85f1923', '2025-08-18 23:30:31');

-- --------------------------------------------------------

--
-- Table structure for table `chatmessage`
--

CREATE TABLE `chatmessage` (
  `MessageID` int(11) NOT NULL,
  `ThreadID` int(11) NOT NULL,
  `SenderType` enum('Client','Photographer') NOT NULL,
  `SenderID` int(11) NOT NULL,
  `Body` text NOT NULL,
  `IsRead` tinyint(1) DEFAULT 0,
  `CreatedAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chatmessage`
--

INSERT INTO `chatmessage` (`MessageID`, `ThreadID`, `SenderType`, `SenderID`, `Body`, `IsRead`, `CreatedAt`) VALUES
(2, 5, 'Client', 5, 'hey', 1, '2025-08-18 16:13:38'),
(3, 5, 'Client', 5, 'how are you', 1, '2025-08-18 16:13:50'),
(4, 5, 'Client', 5, 'how are you', 1, '2025-08-18 17:39:39'),
(5, 6, 'Client', 5, 'hey', 1, '2025-08-18 17:57:26'),
(6, 6, 'Photographer', 3, 'hey', 1, '2025-08-18 17:58:42'),
(7, 7, 'Client', 5, 'hey', 0, '2025-08-19 15:03:08'),
(8, 2, 'Client', 5, 'can i', 0, '2025-08-19 15:03:24');

-- --------------------------------------------------------

--
-- Table structure for table `chatthread`
--

CREATE TABLE `chatthread` (
  `ThreadID` int(11) NOT NULL,
  `BookingID` int(11) NOT NULL,
  `ClientID` int(11) NOT NULL,
  `PhotographerID` int(11) NOT NULL,
  `CreatedAt` datetime DEFAULT current_timestamp(),
  `LastMsgAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chatthread`
--

INSERT INTO `chatthread` (`ThreadID`, `BookingID`, `ClientID`, `PhotographerID`, `CreatedAt`, `LastMsgAt`) VALUES
(2, 3, 5, 1, '2025-08-15 17:43:02', '2025-08-19 15:03:24'),
(5, 5, 5, 3, '2025-08-18 16:03:06', '2025-08-18 17:39:39'),
(6, 6, 5, 3, '2025-08-18 17:57:18', '2025-08-18 17:58:42'),
(7, 7, 5, 1, '2025-08-19 13:35:37', '2025-08-19 15:03:08');

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE `client` (
  `ClientID` int(11) NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Gender` varchar(20) DEFAULT NULL,
  `RegisterDate` date DEFAULT NULL,
  `IsActive` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `client`
--

INSERT INTO `client` (`ClientID`, `Name`, `Email`, `Password`, `Phone`, `Gender`, `RegisterDate`, `IsActive`) VALUES
(4, 'roshel perera', 'roshel@gmail.com', '$2y$10$fY5eMGNYjvMtieIpHaS7SuSkXsTGgF1EWkHFxtJUpYV9yZRySBXx6', '0768883067', 'Female', '2025-08-10', 1),
(5, 'pramoth piumal', 'pramothpiumal7@gmail.com', '$2y$10$63HEVVRuG1J.FmJi9tup..67qfcwRTZ9Vu1Fn0zncf980yD/WpUbO', '0768883067', 'Male', '2025-08-15', 1);

-- --------------------------------------------------------

--
-- Table structure for table `client_admin_chat_threads`
--

CREATE TABLE `client_admin_chat_threads` (
  `ThreadID` int(11) NOT NULL,
  `ClientID` int(11) NOT NULL,
  `CreatedAt` datetime DEFAULT current_timestamp(),
  `LastMsgAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `client_admin_chat_threads`
--

INSERT INTO `client_admin_chat_threads` (`ThreadID`, `ClientID`, `CreatedAt`, `LastMsgAt`) VALUES
(1, 5, '2025-08-19 16:52:25', '2025-08-19 16:59:41');

-- --------------------------------------------------------

--
-- Table structure for table `client_admin_messages`
--

CREATE TABLE `client_admin_messages` (
  `MessageID` int(11) NOT NULL,
  `ThreadID` int(11) NOT NULL,
  `SenderType` enum('Client','Admin') NOT NULL,
  `SenderID` int(11) NOT NULL,
  `Body` text NOT NULL,
  `IsRead` tinyint(1) DEFAULT 0,
  `CreatedAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `client_admin_messages`
--

INSERT INTO `client_admin_messages` (`MessageID`, `ThreadID`, `SenderType`, `SenderID`, `Body`, `IsRead`, `CreatedAt`) VALUES
(1, 1, 'Client', 5, 'hey', 0, '2025-08-19 16:52:39'),
(2, 1, 'Admin', 2, 'yes tell me', 0, '2025-08-19 16:59:41');

-- --------------------------------------------------------

--
-- Table structure for table `photographer`
--

CREATE TABLE `photographer` (
  `PhotographerID` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Phone` varchar(20) NOT NULL,
  `Gender` enum('Male','Female','Other') NOT NULL,
  `Age` int(11) NOT NULL,
  `Bio` text DEFAULT NULL,
  `ProfilePic` varchar(255) DEFAULT NULL,
  `Email` varchar(100) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `IsActive` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `photographer`
--

INSERT INTO `photographer` (`PhotographerID`, `Name`, `Phone`, `Gender`, `Age`, `Bio`, `ProfilePic`, `Email`, `Password`, `CreatedAt`, `IsActive`) VALUES
(1, 'Aria Stone', '0788227920', 'Female', 22, 'Capturing real moments with soft light and raw emotion. Specializing in lifestyle and portrait photography with a touch of cinematic beauty.', 'photo4_68a2d9944416a.png', 'photographer1@gmail.com', '$2y$10$yk5Q.bnnZWWmvdkJ.JhYC.oSB8H8yK.Z9fOeNCb2wxzo89IlrLi56', '2025-08-14 09:54:23', 1),
(3, 'Noah Blake', '0788228920', 'Male', 23, 'Minimalist by eye, storyteller by heart. I believe every frame deserves a voice. Let’s create magic in natural light.', 'photo1_68a2da9f058b5.jpg', 'noahblake@gmail.com', '$2y$10$5pQ8eDEyj757IQWTlq8IouOGyS8AWJJM90f1qkNEw6kVZxXvpZYhy', '2025-08-18 07:47:43', 1),
(4, 'Leo Carter', '0768883069', 'Male', 25, 'From candid weddings to styled shoots, I blend elegance with creativity. Your story, told through timeless images.', 'photo3_68a2dc32be687.jpg', 'leocarter@gmail.com', '$2y$10$X.MLd1WpNeapni0Dops19.ROmeEI6V/yB0OTn8E/MZR9iml.IAu3q', '2025-08-18 07:54:26', 1),
(5, 'Elara Skye', '0754445655', 'Female', 21, 'Inspired by nature and human connection. I photograph with soul — specializing in outdoor shoots and dreamy themes.', 'photo5_68a2dca289740.jpg', 'elaraskye@gmail.com', '$2y$10$.Jc/WdloExY5kz3AnvkG0uoVkWY66w0zEo4edd7CVCkMLp.TEZX0a', '2025-08-18 07:56:18', 1);

-- --------------------------------------------------------

--
-- Table structure for table `photographergallery`
--

CREATE TABLE `photographergallery` (
  `GalleryID` int(11) NOT NULL,
  `PhotographerID` int(11) NOT NULL,
  `ImagePath` varchar(255) NOT NULL,
  `Caption` varchar(255) DEFAULT NULL,
  `UploadedAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `photographergallery`
--

INSERT INTO `photographergallery` (`GalleryID`, `PhotographerID`, `ImagePath`, `Caption`, `UploadedAt`) VALUES
(13, 1, 'uploads/photographers/1/gallery/aria1_68a2de4ac0325.jpg', 'wedding couple', '2025-08-18 13:33:22'),
(14, 1, 'uploads/photographers/1/gallery/aria2_68a2de5d5dd55.jpg', 'inddor sun kissed', '2025-08-18 13:33:41'),
(15, 1, 'uploads/photographers/1/gallery/aria4_68a2de65c2d59.jpeg', 'mom with baby', '2025-08-18 13:33:49'),
(16, 1, 'uploads/photographers/1/gallery/aria5_68a2dea014467.jpg', 'natural solo', '2025-08-18 13:34:48'),
(17, 3, 'uploads/photographers/3/gallery/noa4_68a2dfa2ee641.jpg', 'happy family', '2025-08-18 13:39:06'),
(18, 3, 'uploads/photographers/3/gallery/noa3_68a2dfa2f0526.jpg', 'indoor solo', '2025-08-18 13:39:06'),
(19, 3, 'uploads/photographers/3/gallery/noa2_68a2dfa2f1562.jpg', 'lovely couple', '2025-08-18 13:39:06'),
(20, 3, 'uploads/photographers/3/gallery/noa1_68a2dfa2f1e19.jpg', 'window portrait', '2025-08-18 13:39:06'),
(21, 5, 'uploads/photographers/5/gallery/fam1_68a356324ee4f.jpg', 'vintage natural', '2025-08-18 22:04:58'),
(22, 5, 'uploads/photographers/5/gallery/wed1_68a3563250769.jpg', 'happy couple', '2025-08-18 22:04:58'),
(23, 5, 'uploads/photographers/5/gallery/eng1_68a3563253438.jpeg', 'indoor solo', '2025-08-18 22:04:58'),
(24, 5, 'uploads/photographers/5/gallery/nature1_68a3563254485.jpg', 'wedding shoot', '2025-08-18 22:04:58'),
(25, 5, 'uploads/photographers/5/gallery/pho1_68a3563254c25.jpeg', 'lovely family', '2025-08-18 22:04:58'),
(26, 5, 'uploads/photographers/5/gallery/indo1_68a3563255c30.jpg', 'portrait', '2025-08-18 22:04:58'),
(27, 5, 'uploads/photographers/5/gallery/portrait1_68a356325658f.jpeg', 'solo', '2025-08-18 22:04:58'),
(28, 1, 'uploads/photographers/1/gallery/fam2_68a356e6e5287.jpg', 'family ', '2025-08-18 22:07:58'),
(29, 1, 'uploads/photographers/1/gallery/wed2_68a356e6e7b90.jpg', 'couple', '2025-08-18 22:07:58'),
(30, 1, 'uploads/photographers/1/gallery/eng2_68a356e6e82a5.jpg', 'indoor ', '2025-08-18 22:07:58'),
(31, 1, 'uploads/photographers/1/gallery/nature2_68a356e6e89f9.jpg', 'natural solo', '2025-08-18 22:07:58'),
(32, 1, 'uploads/photographers/1/gallery/nigh2_68a356e6e99d8.jpeg', 'wedding', '2025-08-18 22:07:58'),
(33, 1, 'uploads/photographers/1/gallery/indoor2_68a356e6ea20c.jpg', 'night photography', '2025-08-18 22:07:58'),
(34, 1, 'uploads/photographers/1/gallery/portrait_2_68a356e6eaa0a.jpg', 'couple', '2025-08-18 22:07:58'),
(35, 3, 'uploads/photographers/3/gallery/fam3_68a357b1c46fc.jpg', 'wedding night', '2025-08-18 22:11:21'),
(36, 3, 'uploads/photographers/3/gallery/wed3_68a357b1c7344.jpeg', 'night street', '2025-08-18 22:11:21'),
(37, 3, 'uploads/photographers/3/gallery/eng3_68a357b1c7b3a.jpg', 'couple', '2025-08-18 22:11:21'),
(38, 3, 'uploads/photographers/3/gallery/nature3_68a357b1c8340.jpg', 'indoor shoot', '2025-08-18 22:11:21'),
(39, 3, 'uploads/photographers/3/gallery/night3_68a357b1c8bda.jpg', 'vintage natural family', '2025-08-18 22:11:21'),
(40, 3, 'uploads/photographers/3/gallery/indo3_68a357b1c9c9b.jpg', 'family ', '2025-08-18 22:11:21'),
(41, 3, 'uploads/photographers/3/gallery/portrait_3_68a357b1ca4a2.jpg', 'solo', '2025-08-18 22:11:21'),
(42, 4, 'uploads/photographers/4/gallery/fam4_68a35861e90d7.jpeg', 'wedding photography', '2025-08-18 22:14:17'),
(43, 4, 'uploads/photographers/4/gallery/wed4_68a35861ebd66.jpg', 'couple', '2025-08-18 22:14:17'),
(44, 4, 'uploads/photographers/4/gallery/eng4_68a35861ec526.jpg', 'natural couple ', '2025-08-18 22:14:17'),
(45, 4, 'uploads/photographers/4/gallery/nature4_68a35861ed4b9.jpeg', 'night photo shoot', '2025-08-18 22:14:17'),
(46, 4, 'uploads/photographers/4/gallery/night4_68a35861edd43.jpeg', 'family ', '2025-08-18 22:14:17'),
(47, 4, 'uploads/photographers/4/gallery/indo2_68a35861ee59b.jpg', 'indoor portrait', '2025-08-18 22:14:17'),
(48, 4, 'uploads/photographers/4/gallery/portrai4_68a35861eee40.jpg', 'vintage natural', '2025-08-18 22:14:17');

-- --------------------------------------------------------

--
-- Table structure for table `photographerslot`
--

CREATE TABLE `photographerslot` (
  `SlotID` int(11) NOT NULL,
  `PhotographerID` int(11) NOT NULL,
  `SlotDate` date NOT NULL,
  `StartTime` time NOT NULL,
  `EndTime` time NOT NULL,
  `IsAvailable` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `photographerslot`
--

INSERT INTO `photographerslot` (`SlotID`, `PhotographerID`, `SlotDate`, `StartTime`, `EndTime`, `IsAvailable`) VALUES
(1, 1, '2025-08-16', '09:00:00', '10:00:00', 1),
(2, 1, '2025-08-16', '10:30:00', '11:30:00', 1),
(3, 1, '2025-08-16', '14:00:00', '15:00:00', 1),
(9, 1, '2025-08-29', '10:00:00', '11:00:00', 0),
(10, 1, '2025-08-29', '14:00:00', '15:00:00', 0),
(11, 1, '2025-08-19', '15:00:00', '16:00:00', 0),
(13, 3, '2025-08-29', '09:00:00', '10:00:00', 0),
(14, 1, '2025-08-18', '23:45:00', '00:45:00', 0);

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `ReviewID` int(11) NOT NULL,
  `BookingID` int(11) NOT NULL,
  `ClientID` int(11) NOT NULL,
  `PhotographerID` int(11) NOT NULL,
  `Rating` tinyint(4) NOT NULL CHECK (`Rating` between 1 and 5),
  `Comment` text DEFAULT NULL,
  `CreatedAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `review`
--

INSERT INTO `review` (`ReviewID`, `BookingID`, `ClientID`, `PhotographerID`, `Rating`, `Comment`, `CreatedAt`) VALUES
(2, 5, 5, 3, 5, '', '2025-08-18 23:31:02');

-- --------------------------------------------------------

--
-- Table structure for table `theme`
--

CREATE TABLE `theme` (
  `ThemeID` int(11) NOT NULL,
  `Name` varchar(150) NOT NULL,
  `Type` enum('Indoor','Outdoor') NOT NULL,
  `Description` text DEFAULT NULL,
  `Price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `DefaultDurationMin` int(11) NOT NULL DEFAULT 60,
  `CoverImage` varchar(255) DEFAULT NULL,
  `Active` tinyint(4) DEFAULT 1,
  `CreatedAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `theme`
--

INSERT INTO `theme` (`ThemeID`, `Name`, `Type`, `Description`, `Price`, `DefaultDurationMin`, `CoverImage`, `Active`, `CreatedAt`) VALUES
(1, 'Cinematic Smoke Room', 'Indoor', 'Atmospheric fog, cool tones, and a dramatic mood ideal for portraits with depth.', 4000.00, 45, 'smoke_room_68a3396637922.jpg', 1, '2025-08-15 11:19:37'),
(2, 'Blush Baby Suite', 'Indoor', 'A charming pastel nursery setup for maternity or baby milestones.', 2500.00, 60, 'baby_room_68a33aeaea249.jpg', 1, '2025-08-15 11:19:37'),
(3, 'Botanical Garden Room', 'Indoor', 'Lush indoor greenery and natural wood elements — ideal for organic lifestyle photos.', 2500.00, 60, 'garden_room_68a33ae157c49.jpeg', 1, '2025-08-15 11:20:08'),
(4, 'Golden Hour Lounge', 'Indoor', 'Bask in warm tones and glowing vintage light — perfect for dreamy portraits and couple shots.', 3000.00, 60, 'vintage1_68a33ad5d2b57.jpg', 1, '2025-08-15 11:20:08'),
(5, 'Dark Noir Studio', 'Indoor', 'Shadow play, contrast lighting, and dramatic tones — perfect for high fashion or editorial shoots.', 3500.00, 60, 'dark_68a33cc99cc67.jpg', 1, '2025-08-18 20:11:38'),
(6, 'Cozy Nest Room', 'Indoor', 'Warm blankets, soft textures, and a homey vibe — great for newborn and family photos.', 3000.00, 60, 'famliy_68a33cc00e342.jpg', 1, '2025-08-18 20:12:48');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`AdminID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`BookingID`),
  ADD KEY `ClientID` (`ClientID`),
  ADD KEY `PhotographerID` (`PhotographerID`),
  ADD KEY `ThemeID` (`ThemeID`);

--
-- Indexes for table `chatmessage`
--
ALTER TABLE `chatmessage`
  ADD PRIMARY KEY (`MessageID`),
  ADD KEY `ix_thread` (`ThreadID`,`MessageID`),
  ADD KEY `ix_thread_time` (`ThreadID`,`CreatedAt`);

--
-- Indexes for table `chatthread`
--
ALTER TABLE `chatthread`
  ADD PRIMARY KEY (`ThreadID`),
  ADD UNIQUE KEY `uniq_booking` (`BookingID`),
  ADD KEY `ix_client` (`ClientID`),
  ADD KEY `ix_photographer` (`PhotographerID`);

--
-- Indexes for table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`ClientID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `client_admin_chat_threads`
--
ALTER TABLE `client_admin_chat_threads`
  ADD PRIMARY KEY (`ThreadID`),
  ADD UNIQUE KEY `ClientID` (`ClientID`);

--
-- Indexes for table `client_admin_messages`
--
ALTER TABLE `client_admin_messages`
  ADD PRIMARY KEY (`MessageID`),
  ADD KEY `ThreadID` (`ThreadID`);

--
-- Indexes for table `photographer`
--
ALTER TABLE `photographer`
  ADD PRIMARY KEY (`PhotographerID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `photographergallery`
--
ALTER TABLE `photographergallery`
  ADD PRIMARY KEY (`GalleryID`),
  ADD KEY `PhotographerID` (`PhotographerID`);

--
-- Indexes for table `photographerslot`
--
ALTER TABLE `photographerslot`
  ADD PRIMARY KEY (`SlotID`),
  ADD UNIQUE KEY `uq_slot` (`PhotographerID`,`SlotDate`,`StartTime`,`EndTime`);

--
-- Indexes for table `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`ReviewID`),
  ADD KEY `PhotographerID` (`PhotographerID`),
  ADD KEY `ClientID` (`ClientID`),
  ADD KEY `BookingID` (`BookingID`);

--
-- Indexes for table `theme`
--
ALTER TABLE `theme`
  ADD PRIMARY KEY (`ThemeID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `AdminID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `BookingID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `chatmessage`
--
ALTER TABLE `chatmessage`
  MODIFY `MessageID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `chatthread`
--
ALTER TABLE `chatthread`
  MODIFY `ThreadID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `client`
--
ALTER TABLE `client`
  MODIFY `ClientID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `client_admin_chat_threads`
--
ALTER TABLE `client_admin_chat_threads`
  MODIFY `ThreadID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `client_admin_messages`
--
ALTER TABLE `client_admin_messages`
  MODIFY `MessageID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `photographer`
--
ALTER TABLE `photographer`
  MODIFY `PhotographerID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `photographergallery`
--
ALTER TABLE `photographergallery`
  MODIFY `GalleryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `photographerslot`
--
ALTER TABLE `photographerslot`
  MODIFY `SlotID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `ReviewID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `theme`
--
ALTER TABLE `theme`
  MODIFY `ThemeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`ClientID`) REFERENCES `client` (`ClientID`),
  ADD CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`PhotographerID`) REFERENCES `photographer` (`PhotographerID`),
  ADD CONSTRAINT `booking_ibfk_3` FOREIGN KEY (`ThemeID`) REFERENCES `theme` (`ThemeID`);

--
-- Constraints for table `chatmessage`
--
ALTER TABLE `chatmessage`
  ADD CONSTRAINT `fk_chatmsg_thread` FOREIGN KEY (`ThreadID`) REFERENCES `chatthread` (`ThreadID`) ON DELETE CASCADE;

--
-- Constraints for table `chatthread`
--
ALTER TABLE `chatthread`
  ADD CONSTRAINT `fk_chatthread_booking` FOREIGN KEY (`BookingID`) REFERENCES `booking` (`BookingID`) ON DELETE CASCADE;

--
-- Constraints for table `client_admin_messages`
--
ALTER TABLE `client_admin_messages`
  ADD CONSTRAINT `client_admin_messages_ibfk_1` FOREIGN KEY (`ThreadID`) REFERENCES `client_admin_chat_threads` (`ThreadID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `photographergallery`
--
ALTER TABLE `photographergallery`
  ADD CONSTRAINT `photographergallery_ibfk_1` FOREIGN KEY (`PhotographerID`) REFERENCES `photographer` (`PhotographerID`) ON DELETE CASCADE;

--
-- Constraints for table `photographerslot`
--
ALTER TABLE `photographerslot`
  ADD CONSTRAINT `photographerslot_ibfk_1` FOREIGN KEY (`PhotographerID`) REFERENCES `photographer` (`PhotographerID`) ON DELETE CASCADE;

--
-- Constraints for table `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `fk_review_booking` FOREIGN KEY (`BookingID`) REFERENCES `booking` (`BookingID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_review_client` FOREIGN KEY (`ClientID`) REFERENCES `client` (`ClientID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_review_photographer` FOREIGN KEY (`PhotographerID`) REFERENCES `photographer` (`PhotographerID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
