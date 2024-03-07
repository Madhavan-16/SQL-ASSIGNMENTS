
use ticketbooking_feb_hex_24;
-- Create Schema
CREATE SCHEMA IF NOT EXISTS `ticketbooking_feb_hex_24` DEFAULT CHARACTER SET utf8;
USE `ticketbooking_feb_hex_24`;

-- Create Venue Table
CREATE TABLE IF NOT EXISTS `ticketbooking_feb_hex_24`.`venue` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `venue_name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- Create Event Table
CREATE TABLE IF NOT EXISTS `ticketbooking_feb_hex_24`.`event` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `event_name` VARCHAR(45) NULL,
  `event_date` DATE NULL,
  `event_time` TIME NULL,
  `total_seats` INT NULL,
  `available_seats` INT NULL,
  `ticket_price` DOUBLE NULL,
  `event_type` VARCHAR(45) NULL,
  `venue_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_event_venue_idx` (`venue_id` ASC),
  CONSTRAINT `fk_event_venue`
    FOREIGN KEY (`venue_id`)
    REFERENCES `ticketbooking_feb_hex_24`.`venue` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Create Customer Table
CREATE TABLE IF NOT EXISTS `ticketbooking_feb_hex_24`.`customer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `customer_name` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `phone_number` VARCHAR(45) NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- Create Booking Table
CREATE TABLE IF NOT EXISTS `ticketbooking_feb_hex_24`.`booking` (
  `event_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `num_tickets` INT NULL,
  `total_cost` DOUBLE NULL,
  `booking_date` DATE NULL,
  PRIMARY KEY (`event_id`, `customer_id`),
  INDEX `fk_event_has_customer_customer1_idx` (`customer_id` ASC),
  INDEX `fk_event_has_customer_event1_idx` (`event_id` ASC),
  CONSTRAINT `fk_event_has_customer_event1`
    FOREIGN KEY (`event_id`)
    REFERENCES `ticketbooking_feb_hex_24`.`event` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_has_customer_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `ticketbooking_feb_hex_24`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Venue table
INSERT INTO venue (venue_name, address) VALUES
('Venue 1', 'Address 1'),
('Venue 2', 'Address 2'),
('Venue 3', 'Address 3'),
('Venue 4', 'Address 4'),
('Venue 5', 'Address 5'),
('Venue 6', 'Address 6'),
('Venue 7', 'Address 7'),
('Venue 8', 'Address 8'),
('Venue 9', 'Address 9'),
('Venue 10', 'Address 10');

-- Customer table
INSERT INTO customer (customer_name, email, phone_number) VALUES
('Customer 1', 'email1@example.com', '1234567890'),
('Customer 2', 'email2@example.com', '2345678901'),
('Customer 3', 'email3@example.com', '3456789012'),
('Customer 4', 'email4@example.com', '4567890123'),
('Customer 5', 'email5@example.com', '5678901234'),
('Customer 6', 'email6@example.com', '6789012345'),
('Customer 7', 'email7@example.com', '7890123456'),
('Customer 8', 'email8@example.com', '8901234567'),
('Customer 9', 'email9@example.com', '9012345678'),
('Customer 10', 'email10@example.com', '0123456789');

-- Event table
INSERT INTO event (event_name, event_date, event_time, total_seats, available_seats, ticket_price, event_type, venue_id) VALUES
('Event 1', '2024-03-15', '10:00', 200, 150, 1200, 'Concert', 1),
('Event 2', '2024-03-20', '15:00', 300, 250, 1500, 'Sports', 2),
('Event 3', '2024-03-25', '18:00', 400, 350, 1800, 'Conference', 3),
('Event 4', '2024-04-01', '19:30', 500, 400, 2000, 'Concert', 4),
('Event 5', '2024-04-05', '20:00', 600, 500, 2200, 'Theater', 5),
('Event 6', '2024-04-10', '17:00', 700, 600, 2400, 'Concert', 6),
('Event 7', '2024-04-15', '16:30', 800, 700, 2600, 'Sports', 7),
('Event 8', '2024-04-20', '14:00', 900, 800, 2800, 'Conference', 8),
('Event 9', '2024-04-25', '13:00', 1000, 900, 3000, 'Concert', 9),
('Event 10', '2024-04-30', '12:30', 1100, 1000, 3200, 'Theater', 10);

-- Booking table
INSERT INTO booking (event_id, customer_id, num_tickets, total_cost, booking_date) VALUES
(1, 1, 2, 2400, '2024-03-01'),
(2, 2, 3, 4500, '2024-03-02'),
(3, 3, 4, 7200, '2024-03-03'),
(4, 4, 5, 10000, '2024-03-04'),
(5, 5, 6, 13200, '2024-03-05'),
(6, 6, 7, 16800, '2024-03-06'),
(7, 7, 8, 20800, '2024-03-07'),
(8, 8, 9, 25200, '2024-03-08'),
(9, 9, 10, 30000, '2024-03-09'),
(10, 10, 11, 35200, '2024-03-10');

use ticketbooking_feb_hex_24;

/*----------- ---------------*/
#TASK-1

#Write a SQL query to list all Events.
SELECT * FROM event;

#Write a SQL query to select events with available tickets.
SELECT * FROM event WHERE available_seats > 0;

#Write a SQL query to select events name partial match with 'cup'.
SELECT * FROM event WHERE event_name LIKE '%cup%';

#Write a SQL query to select events with ticket price range between 1000 to 2500.
SELECT * FROM event WHERE ticket_price BETWEEN 1000 AND 2500;

#Write a SQL query to retrieve events with dates falling within a specific range.
SELECT * FROM event WHERE event_date BETWEEN '2024-03-03' AND '2024-07-03';


#Write a SQL query to retrieve events with available tickets that also have "Concert" in their name.
SELECT * FROM event WHERE available_seats > 0 AND event_name LIKE '%Concert%';

#Write a SQL query to retrieve users in batches of 5, starting from the 6th user.
SELECT * FROM customer LIMIT 5 OFFSET 5;

#Write a SQL query to retrieve bookings details containing booked number of tickets more than 4.
SELECT * FROM booking WHERE num_tickets > 4;

#Write a SQL query to retrieve customer information whose phone number ends with 'eee'.
SELECT * FROM customer WHERE phone_number LIKE '%eee';

#Write a SQL query to retrieve the events in order whose seat capacity is more than 15000.
SELECT * FROM event WHERE total_seats > 15000 ORDER BY total_seats;

#Write a SQL query to select events whose name does not start with 'x', 'y', or '2'.
SELECT * FROM event WHERE event_name NOT LIKE 'x%' AND event_name NOT LIKE 'y%' AND event_name NOT LIKE '2%';

/*----------- ---------------*/

#Task -2

#List Events and Their Average Ticket Prices:
SELECT event_name, AVG(ticket_price) AS avg_ticket_price
FROM event
GROUP BY event_name;

#Calculate the Total Revenue Generated by Events:
SELECT SUM(total_cost) AS total_revenue
FROM booking;

#Find the Event with the Highest Ticket Sales:
SELECT event_id, SUM(num_tickets) AS total_tickets_sold
FROM booking
GROUP BY event_id
ORDER BY total_tickets_sold DESC
LIMIT 1;

#Calculate the Total Number of Tickets Sold for Each Event:
SELECT event_id, SUM(num_tickets) AS total_tickets_sold
FROM booking
GROUP BY event_id;

#Find Events with No Ticket Sales:
SELECT event.id, event_name
FROM event
LEFT JOIN booking ON event.id = booking.event_id
WHERE booking.event_id IS NULL;

#Find the User Who Has Booked the Most Tickets:
SELECT customer_id, SUM(num_tickets) AS total_tickets_booked
FROM booking
GROUP BY customer_id
ORDER BY total_tickets_booked DESC
LIMIT 1;

#List Events and the Total Number of Tickets Sold for Each Month:
SELECT MONTH(booking_date) AS month, event_id, SUM(num_tickets) AS total_tickets_sold
FROM booking
GROUP BY month, event_id;

#Calculate the Average Ticket Price for Events in Each Venue:
SELECT venue_id, AVG(ticket_price) AS avg_ticket_price
FROM event
GROUP BY venue_id;

#Calculate the Total Number of Tickets Sold for Each Event Type:
SELECT event_type, SUM(num_tickets) AS total_tickets_sold
FROM event
JOIN booking ON event.id = booking.event_id
GROUP BY event_type;

#Calculate the Total Revenue Generated by Events in Each Year:
SELECT YEAR(booking_date) AS year, SUM(total_cost) AS total_revenue
FROM booking
GROUP BY year;

#List Users who have Booked Tickets for Multiple Events:
SELECT customer_id
FROM booking
GROUP BY customer_id
HAVING COUNT(DISTINCT event_id) > 1;

#Calculate the Total Revenue Generated by Events for Each User:
SELECT customer_id, SUM(total_cost) AS total_revenue
FROM booking
GROUP BY customer_id;

#Calculate the Average Ticket Price for Events in Each Category and Venue:
SELECT venue_id, event_type, AVG(ticket_price) AS avg_ticket_price
FROM event
GROUP BY venue_id, event_type;

#List Users and the Total Number of Tickets They've Purchased in the Last 30 Days:
SELECT customer_id, SUM(num_tickets) AS total_tickets_purchased
FROM booking
WHERE booking_date >= CURDATE() - INTERVAL 30 DAY
GROUP BY customer_id;

/*----------- ---------------*/

#TASK-3

#List Events and Their Average Ticket Prices:
SELECT event_name, AVG(ticket_price) AS avg_ticket_price
FROM event
GROUP BY event_name;

#Calculate the Total Revenue Generated by Events:
SELECT SUM(total_cost) AS total_revenue
FROM booking;

#Find the Event with the Highest Ticket Sales:
SELECT event_id, SUM(num_tickets) AS total_tickets_sold
FROM booking
GROUP BY event_id
ORDER BY total_tickets_sold DESC
LIMIT 1;

#Calculate the Total Number of Tickets Sold for Each Event:
SELECT event_id, SUM(num_tickets) AS total_tickets_sold
FROM booking
GROUP BY event_id;

#Find Events with No Ticket Sales:
SELECT event.id, event_name
FROM event
LEFT JOIN booking ON event.id = booking.event_id
WHERE booking.event_id IS NULL;

#Find the User Who Has Booked the Most Tickets:
SELECT customer_id, SUM(num_tickets) AS total_tickets_booked
FROM booking
GROUP BY customer_id
ORDER BY total_tickets_booked DESC
LIMIT 1;

#List Events and the total number of tickets sold for each month:
SELECT DATE_FORMAT(booking_date, '%Y-%m') AS month, event_id, SUM(num_tickets) AS total_tickets_sold
FROM booking
GROUP BY month, event_id;

#Calculate the Average Ticket Price for Events in Each Venue:
SELECT venue_id, AVG(ticket_price) AS avg_ticket_price
FROM event
GROUP BY venue_id;

#Calculate the Total Number of Tickets Sold for Each Event Type:
SELECT event_type, SUM(num_tickets) AS total_tickets_sold
FROM event
JOIN booking ON event.id = booking.event_id
GROUP BY event_type;

#Calculate the Total Revenue Generated by Events in Each Year:
SELECT YEAR(booking_date) AS year, SUM(total_cost) AS total_revenue
FROM booking
GROUP BY year;

#List Users who have Booked Tickets for Multiple Events:
SELECT customer_id
FROM booking
GROUP BY customer_id
HAVING COUNT(DISTINCT event_id) > 1;

#Calculate the Total Revenue Generated by Events for Each User:
SELECT customer_id, SUM(total_cost) AS total_revenue
FROM booking
GROUP BY customer_id;

#Calculate the Average Ticket Price for Events in Each Category and Venue:
SELECT venue_id, event_type, AVG(ticket_price) AS avg_ticket_price
FROM event
GROUP BY venue_id, event_type;

#List Users and the Total Number of Tickets They've Purchased in the Last 30 Days:
SELECT customer_id, SUM(num_tickets) AS total_tickets_purchased
FROM booking
WHERE booking_date >= CURDATE() - INTERVAL 30 DAY
GROUP BY customer_id;

/*----------- ---------------*/
#TASK-4

#Calculate the Average Ticket Price for Events in Each Venue Using a Subquery:
SELECT v.venue_name, 
       (SELECT AVG(e.ticket_price) 
        FROM event e 
        WHERE e.venue_id = v.id) AS avg_ticket_price
FROM venue v;

#Find Events with More Than 50% of Tickets Sold using subquery:
SELECT *
FROM event
WHERE (SELECT SUM(num_tickets) FROM booking WHERE booking.event_id = event.id) > (total_seats / 2);

#Find Events having ticket price more than average ticket price of all events:
SELECT *
FROM event
WHERE ticket_price > (SELECT AVG(ticket_price) FROM event);

#Find Customers Who Have Not Booked Any Tickets Using a NOT EXISTS Subquery:
SELECT *
FROM customer c
WHERE NOT EXISTS (
    SELECT 1
    FROM booking b
    WHERE b.customer_id = c.id
);

#If there is even 1 row in table t2 then the WHERE clause condition is evaluated to true:
SELECT *
FROM t1
WHERE EXISTS (
    SELECT 1
    FROM t2
);
