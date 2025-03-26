-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 26, 2025 at 01:59 PM
-- Server version: 5.7.24
-- PHP Version: 7.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ticketmaster`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateDynamicPricingQuantity` ()   BEGIN
    -- Update ticket prices by 8% for tickets with inventory below 50
    UPDATE ticket_inventory ti
    JOIN pricing_strategy ps ON ti.inventory_id = ps.inventory_id
    SET ps.pricing_amount = ps.pricing_amount * 1.08
    WHERE ti.total_quantity< 50;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `all orders with their tickets`
-- (See below for the actual view)
--
CREATE TABLE `all orders with their tickets` (
`order_id` int(11)
,`customer_id` int(11)
,`ticket_id` int(11)
,`event_id` int(11)
,`seat_id` int(11)
,`price` decimal(10,2)
,`ticket_type_id` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `billing_details`
--

CREATE TABLE `billing_details` (
  `billing_details_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `card_provider` varchar(255) NOT NULL,
  `card_number` bigint(11) NOT NULL,
  `card_name` varchar(255) NOT NULL,
  `expiry_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `billing_details`
--

INSERT INTO `billing_details` (`billing_details_id`, `customer_id`, `card_provider`, `card_number`, `card_name`, `expiry_date`) VALUES
(1, 1, 'VISA', 1111222233334444, 'Mark Monaghan', '2028-11-15'),
(2, 2, 'Mastercard', 9999888877771111, 'Laura McCann', '2027-11-18'),
(3, 3, 'Mastercard', 5555333399991111, 'Nigel Brannigan', '2029-08-13'),
(4, 4, 'VISA', 1111999922223333, 'Judith Eccles', '2024-12-06'),
(5, 5, 'Visa', 1234123412341234, 'John Doe', '2028-10-10');

-- --------------------------------------------------------

--
-- Table structure for table `contact_details`
--

CREATE TABLE `contact_details` (
  `contact_details_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email_address` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `contact_number` varchar(255) NOT NULL,
  `email_updates` tinyint(1) NOT NULL,
  `text_alerts` tinyint(1) NOT NULL,
  `ticket_alerts` tinyint(1) NOT NULL,
  `performer_alerts` tinyint(1) NOT NULL,
  `personalisation` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `contact_details`
--

INSERT INTO `contact_details` (`contact_details_id`, `customer_id`, `first_name`, `last_name`, `email_address`, `password`, `contact_number`, `email_updates`, `text_alerts`, `ticket_alerts`, `performer_alerts`, `personalisation`) VALUES
(1, 1, 'Mark', 'Monaghan', 'mmonaghan@outlook.com', 'cafea45ba0172a749e82b209fe0fd02f768a8528082d00b29434f33d3df3d5409f8f9253d669c4b9', '07934561234', 0, 0, 1, 1, 0),
(2, 2, 'Laura', 'McCann', 'lmccann96@gmail.com', 'ilovemydog12', '07842761833', 1, 1, 1, 1, 0),
(3, 3, 'Nigel', 'Brannigan', 'nbran@yahoo.com', '1m3m5m2m2', '07933461374', 0, 0, 1, 1, 1),
(4, 4, 'Judith', 'Eccles', 'judeccles@gmail.com', 'omaghse21', '07922357111', 1, 1, 1, 1, 1),
(5, 5, 'John', 'Doe', 'john.doe@example.com', 'c22ee002b2ef19914ef2122907c95cfe04c16214d4166dd714cfc69d03f74a9b8bd297f45ec887a9', '1234567890', 1, 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `currency`
--

CREATE TABLE `currency` (
  `currency_id` int(11) NOT NULL,
  `currency_code` varchar(255) NOT NULL,
  `currency_name` varchar(255) NOT NULL,
  `symbol` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `currency`
--

INSERT INTO `currency` (`currency_id`, `currency_code`, `currency_name`, `symbol`) VALUES
(1, 'GBP', 'Pound sterling', '£'),
(2, 'EUR', 'Euro', '€');

-- --------------------------------------------------------

--
-- Table structure for table `currency_country`
--

CREATE TABLE `currency_country` (
  `currency_id` int(11) NOT NULL,
  `country` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `currency_country`
--

INSERT INTO `currency_country` (`currency_id`, `country`) VALUES
(1, 'United Kingdom'),
(2, 'Ireland');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL,
  `contact_details_id` int(11) NOT NULL,
  `billing_details_id` int(11) NOT NULL,
  `country` varchar(255) NOT NULL,
  `account_status` varchar(255) NOT NULL,
  `recents_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `contact_details_id`, `billing_details_id`, `country`, `account_status`, `recents_id`) VALUES
(1, 1, 1, 'Ireland', 'Active', 1),
(2, 2, 2, 'Ireland', 'Active', 2),
(3, 3, 3, 'United Kingdom', 'Active', 3),
(4, 4, 4, 'United Kingdom', 'Active', 4),
(5, 5, 5, 'United Kingdom', 'Active', 5);

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `event_id` int(11) NOT NULL,
  `event_name` varchar(255) NOT NULL,
  `venue_id` int(11) NOT NULL,
  `event_schedule_id` int(11) NOT NULL,
  `event_status_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`event_id`, `event_name`, `venue_id`, `event_schedule_id`, `event_status_id`) VALUES
(1, 'Coldplay: Music of The Spheres World Tour', 1, 1, 1),
(2, 'England vs Germany Football Match', 3, 2, 1),
(3, 'Taylor Swift: Eras Tour', 2, 3, 1),
(4, 'Belfast Giants vs Sheffield Steelers', 1, 4, 1),
(5, 'The Art of Banksy', 6, 5, 1),
(6, 'Wimbledon 1st round: Novak Djokovic vs Carlos Alcarez', 5, 6, 1);

-- --------------------------------------------------------

--
-- Table structure for table `event_performers`
--

CREATE TABLE `event_performers` (
  `event_id` int(11) NOT NULL,
  `performer_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `event_performers`
--

INSERT INTO `event_performers` (`event_id`, `performer_id`) VALUES
(1, 1),
(3, 2),
(5, 8);

-- --------------------------------------------------------

--
-- Table structure for table `event_schedule`
--

CREATE TABLE `event_schedule` (
  `event_schedule_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `event_schedule`
--

INSERT INTO `event_schedule` (`event_schedule_id`, `event_id`, `start_date`, `end_date`, `start_time`, `end_time`) VALUES
(1, 3, '2025-06-01', '2025-06-01', '18:00:00', '22:00:00'),
(2, 2, '2025-07-01', '2025-07-01', '19:00:00', '23:00:00'),
(3, 1, '2025-08-01', '2025-08-01', '20:00:00', '22:00:00'),
(4, 4, '2025-09-01', '2025-09-01', '20:00:00', '22:00:00'),
(5, 5, '2025-10-01', '2025-10-01', '19:00:00', '21:00:00'),
(6, 6, '2025-11-01', '2025-11-01', '14:00:00', '18:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `event_status`
--

CREATE TABLE `event_status` (
  `event_status_id` int(11) NOT NULL,
  `event_status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `event_status`
--

INSERT INTO `event_status` (`event_status_id`, `event_status`) VALUES
(1, 'Active'),
(2, 'Cancelled');

-- --------------------------------------------------------

--
-- Table structure for table `event_teams`
--

CREATE TABLE `event_teams` (
  `event_id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `event_teams`
--

INSERT INTO `event_teams` (`event_id`, `team_id`) VALUES
(2, 1),
(1, 2),
(4, 3),
(4, 4);

-- --------------------------------------------------------

--
-- Table structure for table `image`
--

CREATE TABLE `image` (
  `image_id` int(11) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `image_alt_text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `image`
--

INSERT INTO `image` (`image_id`, `image_path`, `image_alt_text`) VALUES
(1, '/images/taylorswift.jpg', 'Taylor Swift image'),
(2, '/images/coldplay.jpg', 'Coldplay image'),
(3, '/images/brucespringsteen.jpg', 'Bruce Springsteen image'),
(4, '/images/oasis.jpg', 'Oasis image'),
(5, '/images/england.jpg', 'England image'),
(6, '/images/germany.jpg', 'Germany image'),
(7, '/images/belfastgiants.jpg', 'Belfast Giants image'),
(8, '/images/sheffieldsteelersimage.jpg', 'Sheffield Steelers image'),
(9, '/images/jimmycarr.jpg', 'Jimmy Carr image'),
(10, '/images/novakdjokovic.jpg', '/images/novakdjokovic.jpg'),
(11, '/images/carlosalcaraz.jpg', 'Carlos Alcaraz image'),
(12, '/images/banskyart.jpg', 'Banksy art'),
(13, '/image/ssearena.jpg', 'SSE Arena image'),
(14, '/image/3arena.jpg', '3Arena images'),
(15, '/image/wembley.jpg', 'Wembley image'),
(16, '/image/crokepark.jpg', 'Croke Park image'),
(17, '/images/allenglandlawntennisandcroquetclub.jpg', 'All England Lawn Tennis and Croquet club'),
(18, '/images/nationalgallery.jpg', 'National Gallery image');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `currency_id` int(11) NOT NULL,
  `order_date` date NOT NULL,
  `total` double NOT NULL,
  `billing_details_id` int(11) NOT NULL,
  `payment_status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `customer_id`, `currency_id`, `order_date`, `total`, `billing_details_id`, `payment_status`) VALUES
(1, 1, 1, '2023-10-19', 90, 1, 1),
(2, 2, 1, '2024-05-02', 130, 2, 1),
(3, 3, 2, '2024-09-10', 70, 3, 1),
(4, 5, 1, '2024-11-22', 104, 5, 1);

--
-- Triggers `orders`
--
DELIMITER $$
CREATE TRIGGER `check_currency` BEFORE INSERT ON `orders` FOR EACH ROW BEGIN
    DECLARE customer_country VARCHAR(50);
    DECLARE valid_currency INT;

    -- Get the customer's country
    SELECT country INTO customer_country
    FROM customer
    WHERE customer_id = NEW.customer_id;

    -- Check if the currency is valid for that country
    SELECT COUNT(*) INTO valid_currency
    FROM currency_country
    WHERE currency_id = NEW.currency_id AND country = customer_country;

    IF valid_currency = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid currency for the customer's country';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `validate_currency` BEFORE INSERT ON `orders` FOR EACH ROW BEGIN
    DECLARE valid_currency_count INT;

    -- Check if the customer's country allows the selected currency
    SELECT COUNT(*) INTO valid_currency_count
    FROM currency_country cc
    JOIN customer cu ON cu.country = cc.country
    WHERE cu.customer_id = NEW.customer_id 
      AND cc.currency_id = NEW.currency_id;

    -- If no valid currency found, raise an error
    IF valid_currency_count = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Invalid currency for the customer's country';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `order_ticket`
--

CREATE TABLE `order_ticket` (
  `order_ticket_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `order_ticket`
--

INSERT INTO `order_ticket` (`order_ticket_id`, `order_id`, `ticket_id`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `performer`
--

CREATE TABLE `performer` (
  `performer_id` int(11) NOT NULL,
  `performer_name` varchar(255) NOT NULL,
  `performer_genre` varchar(255) NOT NULL,
  `performer_description` varchar(255) NOT NULL,
  `image_id` int(11) NOT NULL,
  `performer_type_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `performer`
--

INSERT INTO `performer` (`performer_id`, `performer_name`, `performer_genre`, `performer_description`, `image_id`, `performer_type_id`) VALUES
(1, 'Coldplay', 'Rock', 'British rock band known for energetic live performances', 2, 2),
(2, 'Taylor Swift', 'Pop', 'American singer-songwriter', 1, 2),
(3, 'Bruce Springsteen', 'Rock ', 'American signer songwriter', 3, 2),
(4, 'Jimmy Carr', 'Comedy', 'English comedian', 9, 3),
(5, 'Oasis', 'Rock', 'English rock band', 4, 2),
(6, 'Novak Djokovic', 'Sports', 'Tennis player', 10, 1),
(7, 'Carlos Alcaraz', 'Sports', 'Tennis player', 11, 1),
(8, 'Banksy', 'Art', 'Famous street artist', 12, 3);

-- --------------------------------------------------------

--
-- Table structure for table `performer_type`
--

CREATE TABLE `performer_type` (
  `performer_type_id` int(11) NOT NULL,
  `performer_type_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `performer_type`
--

INSERT INTO `performer_type` (`performer_type_id`, `performer_type_name`) VALUES
(1, 'Sports'),
(2, 'Music'),
(3, 'Arts'),
(4, 'Family');

-- --------------------------------------------------------

--
-- Table structure for table `pricing_strategy`
--

CREATE TABLE `pricing_strategy` (
  `pricing_strategy_id` int(11) NOT NULL,
  `ticket_id` int(11) DEFAULT NULL,
  `percentage_increase` decimal(5,2) DEFAULT NULL,
  `quantity_dynamic_increase` decimal(5,2) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `interval_days` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pricing_strategy`
--

INSERT INTO `pricing_strategy` (`pricing_strategy_id`, `ticket_id`, `percentage_increase`, `quantity_dynamic_increase`, `start_time`, `interval_days`) VALUES
(1, 1, '4.00', '0.00', '2024-11-19 10:00:00', 30);

-- --------------------------------------------------------

--
-- Table structure for table `recents`
--

CREATE TABLE `recents` (
  `recents_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `event_id` int(11) DEFAULT NULL,
  `performer_type_id` int(11) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `recents`
--

INSERT INTO `recents` (`recents_id`, `customer_id`, `event_id`, `performer_type_id`, `team_id`) VALUES
(1, 1, 1, 2, 2),
(2, 2, 3, 1, 4),
(3, 3, 5, 1, 4),
(4, 1, 1, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `seat`
--

CREATE TABLE `seat` (
  `seat_id` int(11) NOT NULL,
  `venue_id` int(11) NOT NULL,
  `section` varchar(255) NOT NULL,
  `row` varchar(255) NOT NULL,
  `seat_number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `seat`
--

INSERT INTO `seat` (`seat_id`, `venue_id`, `section`, `row`, `seat_number`) VALUES
(1, 3, 'U', '42', 121),
(2, 2, 'K', '1', 2),
(3, 5, 'A', '45', 58),
(4, 1, 'R', '1', 55),
(5, 4, 'UL (UPPER TIER)', 'F', 13),
(6, 1, 'B', '1', 1),
(7, 1, 'B', '1', 2);

-- --------------------------------------------------------

--
-- Table structure for table `team`
--

CREATE TABLE `team` (
  `team_id` int(11) NOT NULL,
  `team_name` varchar(255) DEFAULT NULL,
  `image_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `team`
--

INSERT INTO `team` (`team_id`, `team_name`, `image_id`) VALUES
(1, 'Germany ', 6),
(2, 'England', 5),
(3, 'Sheffield Steelers', 8),
(4, 'Belfast Giants', 7);

-- --------------------------------------------------------

--
-- Table structure for table `ticket`
--

CREATE TABLE `ticket` (
  `ticket_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `seat_id` int(11) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `ticket_type_id` int(11) NOT NULL,
  `inventory_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ticket`
--

INSERT INTO `ticket` (`ticket_id`, `order_id`, `event_id`, `seat_id`, `price`, `ticket_type_id`, `inventory_id`) VALUES
(1, 1, 1, 1, '104.00', 1, 1),
(2, 2, 2, 2, '130.00', 2, 2),
(3, 3, 3, 3, '90.00', 2, 3),
(4, 4, 1, 6, '104.00', 2, 101);

--
-- Triggers `ticket`
--
DELIMITER $$
CREATE TRIGGER `update_ticket_inventory` AFTER INSERT ON `ticket` FOR EACH ROW BEGIN
    -- Update the ticket inventory table to decrease the availability
    UPDATE ticket_inventory
    SET tickets_sold = tickets_sold + 1
    WHERE inventory_id = NEW.inventory_id;

    -- Optional: Check if tickets are sold out
    IF (SELECT total_quantity - tickets_sold FROM ticket_inventory WHERE inventory_id = NEW.inventory_id) <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tickets are sold out for this event';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_inventory`
--

CREATE TABLE `ticket_inventory` (
  `inventory_id` int(11) NOT NULL,
  `event_id` int(11) DEFAULT NULL,
  `ticket_type_id` int(11) DEFAULT NULL,
  `total_quantity` int(11) DEFAULT NULL,
  `tickets_sold` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ticket_inventory`
--

INSERT INTO `ticket_inventory` (`inventory_id`, `event_id`, `ticket_type_id`, `total_quantity`, `tickets_sold`) VALUES
(1, 1, 1, 99, 1),
(2, 1, 2, 100, 0),
(3, 2, 2, 100, 0),
(4, 3, 3, 100, 0),
(5, 3, 1, 100, 0),
(6, 3, 2, 99, 1),
(7, 1, 5, 100, 0),
(8, 4, 2, 100, 0),
(9, 5, 1, 100, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ticket_type`
--

CREATE TABLE `ticket_type` (
  `ticket_type_id` int(11) NOT NULL,
  `ticket_description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ticket_type`
--

INSERT INTO `ticket_type` (`ticket_type_id`, `ticket_description`) VALUES
(1, 'Standing ticket'),
(2, 'Seated ticket'),
(3, 'Season ticket'),
(4, 'Golden Circle'),
(5, 'VIP');

-- --------------------------------------------------------

--
-- Stand-in structure for view `valid_orders`
-- (See below for the actual view)
--
CREATE TABLE `valid_orders` (
`order_id` int(11)
,`customer_id` int(11)
,`currency_id` int(11)
,`country` varchar(255)
);

-- --------------------------------------------------------

--
-- Table structure for table `venue`
--

CREATE TABLE `venue` (
  `venue_id` int(11) NOT NULL,
  `venue_name` varchar(255) NOT NULL,
  `venue_city` varchar(255) NOT NULL,
  `venue_country` varchar(255) NOT NULL,
  `venue_postcode` varchar(255) NOT NULL,
  `venue_type` varchar(255) NOT NULL,
  `capacity` int(11) NOT NULL,
  `image_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `venue`
--

INSERT INTO `venue` (`venue_id`, `venue_name`, `venue_city`, `venue_country`, `venue_postcode`, `venue_type`, `capacity`, `image_id`) VALUES
(1, 'SSE Arena', 'Belfast', 'United Kingdom', 'BT3 9QQ', 'Arena', 11000, 1),
(2, '3Arena', 'Dublin', 'Ireland', 'DO1 EW90', 'Arena', 13000, 2),
(3, 'Wembley ', 'London', 'United Kingdom', 'HA9 0WS', 'Stadium ', 90000, 3),
(4, 'Croke Park', 'Dublin', 'Ireland', 'D0 P6K7', 'Stadium', 82000, 4),
(5, 'All England Lawn Tennis and Croquet Club', 'Wimbledon, London', 'United Kingdom', 'SW19 5AE', 'Arena', 14979, 5),
(6, 'The National Gallery', 'London ', 'United Kingdom ', 'WC2N 5DN', 'Museum ', 1000, 6);

-- --------------------------------------------------------

--
-- Structure for view `all orders with their tickets`
--
DROP TABLE IF EXISTS `all orders with their tickets`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `all orders with their tickets`  AS SELECT `o`.`order_id` AS `order_id`, `o`.`customer_id` AS `customer_id`, `t`.`ticket_id` AS `ticket_id`, `t`.`event_id` AS `event_id`, `t`.`seat_id` AS `seat_id`, `t`.`price` AS `price`, `t`.`ticket_type_id` AS `ticket_type_id` FROM ((`orders` `o` join `order_ticket` `ot` on((`o`.`order_id` = `ot`.`order_id`))) join `ticket` `t` on((`ot`.`ticket_id` = `t`.`ticket_id`)))  ;

-- --------------------------------------------------------

--
-- Structure for view `valid_orders`
--
DROP TABLE IF EXISTS `valid_orders`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `valid_orders`  AS SELECT `o`.`order_id` AS `order_id`, `o`.`customer_id` AS `customer_id`, `o`.`currency_id` AS `currency_id`, `c`.`country` AS `country` FROM ((`orders` `o` join `customer` `c` on((`o`.`customer_id` = `c`.`customer_id`))) join `currency_country` `cc` on(((`o`.`currency_id` = `cc`.`currency_id`) and (`c`.`country` = `cc`.`country`))))  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `billing_details`
--
ALTER TABLE `billing_details`
  ADD PRIMARY KEY (`billing_details_id`),
  ADD KEY `FK_customer_customer_id4` (`customer_id`);

--
-- Indexes for table `contact_details`
--
ALTER TABLE `contact_details`
  ADD PRIMARY KEY (`contact_details_id`),
  ADD KEY `FK_customer_customer_id5` (`customer_id`);

--
-- Indexes for table `currency`
--
ALTER TABLE `currency`
  ADD PRIMARY KEY (`currency_id`);

--
-- Indexes for table `currency_country`
--
ALTER TABLE `currency_country`
  ADD PRIMARY KEY (`currency_id`,`country`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`),
  ADD KEY `fk_contact_details_contact_details_id` (`contact_details_id`),
  ADD KEY `fk_billing_details_billing_details_id` (`billing_details_id`),
  ADD KEY `recents_id` (`recents_id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`event_id`),
  ADD KEY `venue_id` (`venue_id`),
  ADD KEY `fk_event_status_status_id` (`event_status_id`),
  ADD KEY `fk_event_schedule_event_schedule_id` (`event_schedule_id`);

--
-- Indexes for table `event_performers`
--
ALTER TABLE `event_performers`
  ADD PRIMARY KEY (`event_id`) USING BTREE,
  ADD KEY `fk_performer_performer_id4` (`performer_id`);

--
-- Indexes for table `event_schedule`
--
ALTER TABLE `event_schedule`
  ADD PRIMARY KEY (`event_schedule_id`),
  ADD KEY `event_id` (`event_id`);

--
-- Indexes for table `event_status`
--
ALTER TABLE `event_status`
  ADD PRIMARY KEY (`event_status_id`);

--
-- Indexes for table `event_teams`
--
ALTER TABLE `event_teams`
  ADD PRIMARY KEY (`event_id`,`team_id`),
  ADD KEY `team_id` (`team_id`);

--
-- Indexes for table `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`image_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `fk_currency_currency_id` (`currency_id`),
  ADD KEY `fk_customer_customer_id3` (`customer_id`),
  ADD KEY `fk_billing_details_billing_details_id1` (`billing_details_id`);

--
-- Indexes for table `order_ticket`
--
ALTER TABLE `order_ticket`
  ADD PRIMARY KEY (`order_ticket_id`),
  ADD KEY `fk_order_order_id` (`order_id`),
  ADD KEY `fk_ticket_ticket_id` (`ticket_id`);

--
-- Indexes for table `performer`
--
ALTER TABLE `performer`
  ADD PRIMARY KEY (`performer_id`),
  ADD KEY `fk_image_image_id3` (`image_id`),
  ADD KEY `fk_performer_type_performer_type_id` (`performer_type_id`);

--
-- Indexes for table `performer_type`
--
ALTER TABLE `performer_type`
  ADD PRIMARY KEY (`performer_type_id`);

--
-- Indexes for table `pricing_strategy`
--
ALTER TABLE `pricing_strategy`
  ADD PRIMARY KEY (`pricing_strategy_id`),
  ADD KEY `fk_ticket_ticket_id3` (`ticket_id`);

--
-- Indexes for table `recents`
--
ALTER TABLE `recents`
  ADD PRIMARY KEY (`recents_id`),
  ADD KEY `FK_customer_customer_id1` (`customer_id`),
  ADD KEY `fk_events_event_id1` (`event_id`),
  ADD KEY `fk_performer_type_performer_type_id1` (`performer_type_id`),
  ADD KEY `fk_team_team_is` (`team_id`);

--
-- Indexes for table `seat`
--
ALTER TABLE `seat`
  ADD PRIMARY KEY (`seat_id`),
  ADD KEY `fk_venue_venue_id3` (`venue_id`);

--
-- Indexes for table `team`
--
ALTER TABLE `team`
  ADD PRIMARY KEY (`team_id`),
  ADD KEY `image_id` (`image_id`);

--
-- Indexes for table `ticket`
--
ALTER TABLE `ticket`
  ADD PRIMARY KEY (`ticket_id`),
  ADD KEY `fk_ticket_type_ticket_type_id` (`ticket_type_id`),
  ADD KEY `fk_orders_orders_order_id` (`order_id`),
  ADD KEY `fk_events_event_id2` (`event_id`),
  ADD KEY `fk_seat_seat_id` (`seat_id`),
  ADD KEY `fk_inventory_invetory_id` (`inventory_id`);

--
-- Indexes for table `ticket_inventory`
--
ALTER TABLE `ticket_inventory`
  ADD PRIMARY KEY (`inventory_id`),
  ADD KEY `event_id` (`event_id`),
  ADD KEY `ticket_type_id` (`ticket_type_id`);

--
-- Indexes for table `ticket_type`
--
ALTER TABLE `ticket_type`
  ADD PRIMARY KEY (`ticket_type_id`);

--
-- Indexes for table `venue`
--
ALTER TABLE `venue`
  ADD PRIMARY KEY (`venue_id`),
  ADD KEY `fk_image_image_id5` (`image_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `billing_details`
--
ALTER TABLE `billing_details`
  MODIFY `billing_details_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `contact_details`
--
ALTER TABLE `contact_details`
  MODIFY `contact_details_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `currency`
--
ALTER TABLE `currency`
  MODIFY `currency_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `event_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `event_schedule`
--
ALTER TABLE `event_schedule`
  MODIFY `event_schedule_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `event_status`
--
ALTER TABLE `event_status`
  MODIFY `event_status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `image`
--
ALTER TABLE `image`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `order_ticket`
--
ALTER TABLE `order_ticket`
  MODIFY `order_ticket_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `performer`
--
ALTER TABLE `performer`
  MODIFY `performer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `performer_type`
--
ALTER TABLE `performer_type`
  MODIFY `performer_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `pricing_strategy`
--
ALTER TABLE `pricing_strategy`
  MODIFY `pricing_strategy_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `recents`
--
ALTER TABLE `recents`
  MODIFY `recents_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `seat`
--
ALTER TABLE `seat`
  MODIFY `seat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `team`
--
ALTER TABLE `team`
  MODIFY `team_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ticket`
--
ALTER TABLE `ticket`
  MODIFY `ticket_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ticket_inventory`
--
ALTER TABLE `ticket_inventory`
  MODIFY `inventory_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `ticket_type`
--
ALTER TABLE `ticket_type`
  MODIFY `ticket_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `venue`
--
ALTER TABLE `venue`
  MODIFY `venue_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `contact_details`
--
ALTER TABLE `contact_details`
  ADD CONSTRAINT `FK_customer_customer_id5` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`);

--
-- Constraints for table `currency_country`
--
ALTER TABLE `currency_country`
  ADD CONSTRAINT `currency_country_ibfk_1` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`currency_id`);

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `fk_recents_recents_id1` FOREIGN KEY (`recents_id`) REFERENCES `recents` (`recents_id`);

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `fk_event_schedule_event_schedule_id` FOREIGN KEY (`event_schedule_id`) REFERENCES `event_schedule` (`event_schedule_id`),
  ADD CONSTRAINT `fk_event_status_status_id` FOREIGN KEY (`event_status_id`) REFERENCES `event_status` (`event_status_id`),
  ADD CONSTRAINT `fk_venue_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `venue` (`venue_id`);

--
-- Constraints for table `event_performers`
--
ALTER TABLE `event_performers`
  ADD CONSTRAINT `fk_events_events_id` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`),
  ADD CONSTRAINT `fk_performer_performer_id4` FOREIGN KEY (`performer_id`) REFERENCES `performer` (`performer_id`);

--
-- Constraints for table `event_schedule`
--
ALTER TABLE `event_schedule`
  ADD CONSTRAINT `fk_events_events_event_id` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`);

--
-- Constraints for table `event_teams`
--
ALTER TABLE `event_teams`
  ADD CONSTRAINT `event_teams_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `event_teams_ibfk_2` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_billing_details_billing_details_id1` FOREIGN KEY (`billing_details_id`) REFERENCES `billing_details` (`billing_details_id`),
  ADD CONSTRAINT `fk_currency_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`currency_id`),
  ADD CONSTRAINT `fk_customer_customer_id3` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`);

--
-- Constraints for table `order_ticket`
--
ALTER TABLE `order_ticket`
  ADD CONSTRAINT `fk_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `fk_ticket_ticket_id` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`ticket_id`);

--
-- Constraints for table `performer`
--
ALTER TABLE `performer`
  ADD CONSTRAINT `fk_image_image_id3` FOREIGN KEY (`image_id`) REFERENCES `image` (`image_id`),
  ADD CONSTRAINT `fk_performer_type_performer_type_id` FOREIGN KEY (`performer_type_id`) REFERENCES `performer_type` (`performer_type_id`);

--
-- Constraints for table `pricing_strategy`
--
ALTER TABLE `pricing_strategy`
  ADD CONSTRAINT `fk_ticket_ticket_id3` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`ticket_id`);

--
-- Constraints for table `recents`
--
ALTER TABLE `recents`
  ADD CONSTRAINT `FK_customer_customer_id1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  ADD CONSTRAINT `fk_events_event_id1` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`),
  ADD CONSTRAINT `fk_performer_type_performer_type_id1` FOREIGN KEY (`performer_type_id`) REFERENCES `performer_type` (`performer_type_id`),
  ADD CONSTRAINT `fk_team_team_is` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`);

--
-- Constraints for table `seat`
--
ALTER TABLE `seat`
  ADD CONSTRAINT `fk_venue_venue_id3` FOREIGN KEY (`venue_id`) REFERENCES `venue` (`venue_id`);

--
-- Constraints for table `team`
--
ALTER TABLE `team`
  ADD CONSTRAINT `fk_image_image_id4` FOREIGN KEY (`image_id`) REFERENCES `image` (`image_id`);

--
-- Constraints for table `ticket`
--
ALTER TABLE `ticket`
  ADD CONSTRAINT `fk_events_event_id2` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`),
  ADD CONSTRAINT `fk_inventory_invetory_id` FOREIGN KEY (`inventory_id`) REFERENCES `ticket_inventory` (`inventory_id`),
  ADD CONSTRAINT `fk_orders_orders_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `fk_seat_seat_id` FOREIGN KEY (`seat_id`) REFERENCES `seat` (`seat_id`),
  ADD CONSTRAINT `fk_ticket_type_ticket_type_id` FOREIGN KEY (`ticket_type_id`) REFERENCES `ticket_type` (`ticket_type_id`);

--
-- Constraints for table `ticket_inventory`
--
ALTER TABLE `ticket_inventory`
  ADD CONSTRAINT `ticket_inventory_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`),
  ADD CONSTRAINT `ticket_inventory_ibfk_2` FOREIGN KEY (`ticket_type_id`) REFERENCES `ticket_type` (`ticket_type_id`);

--
-- Constraints for table `venue`
--
ALTER TABLE `venue`
  ADD CONSTRAINT `fk_image_image_id5` FOREIGN KEY (`image_id`) REFERENCES `image` (`image_id`);

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `update_ticket_prices` ON SCHEDULE EVERY 1 DAY STARTS '2024-11-22 12:48:54' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE tickets t
JOIN pricing_strategy ps ON t.id = ps.ticket_id
JOIN events_schedule es ON t.event_id = es.event_id
SET t.price = t.price * (1 + ps.percentage_increase / 100)
WHERE NOW() >= ps.start_time
  AND NOW() <= es.start_date
  AND MOD(TIMESTAMPDIFF(DAY, ps.start_time, NOW()), ps.interval_days) = 0$$

CREATE DEFINER=`root`@`localhost` EVENT `DynamicPricingEventQuantity` ON SCHEDULE EVERY 1 HOUR STARTS '2024-11-21 12:46:34' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    CALL UpdateDynamicPricingQuantity();
END$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
