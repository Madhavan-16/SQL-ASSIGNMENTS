-- MySQL Workbench Forward Engineering

-- Create banking schema if not exists
CREATE SCHEMA IF NOT EXISTS `banking` DEFAULT CHARACTER SET utf8;
USE `banking`;

-- Create customer table
CREATE TABLE IF NOT EXISTS `banking`.`customer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NULL,
  `dob` DATE NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- Create account table
CREATE TABLE IF NOT EXISTS `banking`.`account` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `account_type` VARCHAR(45) NULL,
  `balance` DOUBLE NULL,
  `accountcol` VARCHAR(45) NULL,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`id`, `customer_id`),
  INDEX `fk_account_customer_idx` (`customer_id` ASC),
  CONSTRAINT `fk_account_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `banking`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Create transaction table
CREATE TABLE IF NOT EXISTS `banking`.`transaction` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `transaction_type` VARCHAR(45) NULL,
  `amount` DOUBLE NULL,
  `transaction_date` DATE NULL,
  `account_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_transaction_account1_idx` (`account_id` ASC),
  CONSTRAINT `fk_transaction_account1`
    FOREIGN KEY (`account_id`)
    REFERENCES `banking`.`account` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Insert sample data into customer table
INSERT INTO customer(first_name, last_name, dob) VALUES 
('harry', 'potter', '2002-03-21'),
('ronald', 'weasley', '2001-02-10'),
('hermione', 'granger', '2002-11-15');

-- Insert sample data into account table
INSERT INTO account(account_type, balance, customer_id) VALUES 
('savings', 50000, 1),
('current', 120000, 2),
('zero_balance', 100000, 3),
('current', 150000, 1),
('savings', 30000, 3);

-- Insert sample data into transaction table
INSERT INTO transaction(transaction_type, amount, transaction_date, account_id) VALUES 
('deposit', 10000, '2024-02-01', 1),
('withdrawal', 5000, '2024-02-02', 1),
('deposit', 20000, '2024-02-02', 2),
('withdrawal', 8000, '2024-02-02', 3),
('transfer', 20000, '2024-02-01', 4),
('transfer', 7000, '2024-02-05', 5);

/*------ TASK-2 ------- */

#Retrieve the name, account type, and email of all customers:

SELECT c.first_name, c.last_name, a.account_type, c.email
FROM customer c
JOIN account a ON c.id = a.customer_id;
#List all transactions corresponding to each customer:

SELECT c.first_name, c.last_name, t.transaction_type, t.amount, t.transaction_date
FROM customer c
JOIN account a ON c.id = a.customer_id
JOIN transaction t ON a.id = t.account_id;
#Increase the balance of a specific account by a certain amount:

UPDATE account
SET balance = balance + 1000
WHERE id = 1;
#Combine first and last names of customers as a full_name:

SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM customer;
#Remove accounts with a balance of zero where the account type is savings:

DELETE FROM account
WHERE balance = 0 AND account_type = 'savings';
#Find customers living in a specific city:

SELECT c.first_name, c.last_name
FROM customer c
WHERE c.city = '<specific_city>';
#Get the account balance for a specific account:

SELECT balance
FROM account WHERE id = 3;
#List all current accounts with a balance greater than $1,000:

SELECT *
FROM account
WHERE account_type = 'current' AND balance > 1000;
#Retrieve all transactions for a specific account:

SELECT *
FROM transaction
WHERE account_id = 2;
#Calculate the interest accrued on savings accounts based on a given interest rate:

SELECT account_id, balance * <interest_rate> AS interest_accrued
FROM account
WHERE account_type = 'savings';
#Identify accounts where the balance is less than a specified overdraft limit:

SELECT *
FROM account
WHERE balance < overdraft_limit;


-- Task 3------

/* 1. Write a SQL query to Find the average account balance for all customers.  */

select customer_id, AVG(balance)
from account 
group by customer_id; 

/* 

2. Write a SQL query to Retrieve the top 10 highest account balances.
*/
select balance 
from account
order by balance DESC
limit 0,3; 

/* 3. Write a SQL query to Calculate Total Deposits for All Customers in specific date. Also display name of the customer  */

select c.first_name,c.last_name,t.transaction_type, t.amount, t.transaction_date
from transaction t JOIN account a ON a.id = t.account_id JOIN customer c ON c.id = a.customer_id
where t.transaction_date = '2024-02-02' AND t.transaction_type='withdrawal';

/* 4. Write a SQL query to Find the Oldest and Newest Customers. */

(select first_name,dob,'oldest' as status from customer order by dob limit 0,1)
UNION
(select first_name,dob,'youngest' as status from customer order by dob DESC limit 0,1);



/* 
5. Write a SQL query to Retrieve transaction details along with the account type.
*/

/* 
6. Write a SQL query to Get a list of customers along with their account details.
*/

/* 
7. Write a SQL query to Retrieve transaction details along with customer information for a 
specific account.
*/

/* 
8. Write a SQL query to Identify customers who have more than one account.
*/

select c.first_name,count(c.id) as Number_of_accounts
from customer c JOIN account a ON c.id = a.customer_id
-- where count(c.id) > 1 - 0	Invalid use of group function 
group by a.customer_id
having Number_of_accounts>1;


#9. Write a SQL query to Calculate the difference in transaction amounts between deposits and withdrawals.


select MAX(amount) - MIN(amount) as difference
from
((select transaction_type ,SUM(amount) as amount, 'deposit' as op
from transaction
where transaction_type ='deposit' ) 
union
(select transaction_type , SUM(amount) as amount, 'withdrawal' as op
from transaction
where transaction_type ='withdrawal')) AS T;


#Calculate the average daily balance for each account over a specified period:

SELECT account_id, AVG(balance) AS average_daily_balance
FROM transaction
WHERE transaction_date BETWEEN '<start_date>' AND '<end_date>'
GROUP BY account_id;

#Calculate the total balance for each account type:

SELECT account_type, SUM(balance) AS total_balance
FROM account
GROUP BY account_type;
#Identify accounts with the highest number of transactions order by descending order:

SELECT account_id, COUNT(*) AS transaction_count
FROM transaction
GROUP BY account_id
ORDER BY transaction_count DESC;
#List customers with high aggregate account balances, along with their account types:

SELECT c.first_name, c.last_name, a.account_type, SUM(a.balance) AS aggregate_balance
FROM customer c
JOIN account a ON c.id = a.customer_id
GROUP BY c.id
HAVING aggregate_balance > 1000;


#Identify and list duplicate transactions based on transaction amount, date, and account:

SELECT transaction_type, amount, transaction_date, account_id, COUNT(*) AS duplicate_count
FROM transaction
GROUP BY transaction_type, amount, transaction_date, account_id
HAVING duplicate_count > 1;

#--TASK-4----

#Retrieve the customer(s) with the highest account balance:

SELECT c.id, c.first_name, c.last_name, MAX(a.balance) AS highest_balance
FROM customer c
JOIN account a ON c.id = a.customer_id
GROUP BY c.id, c.first_name, c.last_name
ORDER BY highest_balance DESC
LIMIT 1;
#Calculate the average account balance for customers who have more than one account:

SELECT AVG(balance) AS average_balance
FROM (
    SELECT customer_id, COUNT(*) AS num_accounts
    FROM account
    GROUP BY customer_id
    HAVING num_accounts > 1
) AS multi_account_customers
JOIN account a ON multi_account_customers.customer_id = a.customer_id;
#Retrieve accounts with transactions whose amounts exceed the average transaction amount:

SELECT account_id, transaction_type, amount, transaction_date
FROM transaction
WHERE amount > (SELECT AVG(amount) FROM transaction);
#Identify customers who have no recorded transactions:

SELECT id, first_name, last_name
FROM customer
WHERE id NOT IN (SELECT DISTINCT account_customer_id FROM transaction);
#Calculate the total balance of accounts with no recorded transactions:

SELECT SUM(balance) AS total_balance
FROM account
WHERE id NOT IN (SELECT DISTINCT account_id FROM transaction);
#Retrieve transactions for accounts with the lowest balance:

SELECT t.*
FROM transaction t
JOIN (
    SELECT account_id, MIN(balance) AS lowest_balance
    FROM account
    GROUP BY account_id
) AS lowest_balances ON t.account_id = lowest_balances.account_id;
#Identify customers who have accounts of multiple types:

SELECT c.id, c.first_name, c.last_name
FROM customer c
JOIN (
    SELECT customer_id
    FROM account
    GROUP BY customer_id
    HAVING COUNT(DISTINCT account_type) > 1
) AS multi_type_accounts ON c.id = multi_type_accounts.customer_id;
#Calculate the percentage of each account type out of the total number of accounts:

SELECT account_type, COUNT(*) AS count,
    (COUNT(*) / (SELECT COUNT(*) FROM account)) * 100 AS percentage
FROM account
GROUP BY account_type;
#Retrieve all transactions for a customer with a given customer_id:

SELECT *
FROM transaction
WHERE account_customer_id = 5;
#Replace <customer_id> with the actual customer_id.

#Calculate the total balance for each account type, including a subquery within the SELECT clause:

SELECT account_type,
    (SELECT SUM(balance) FROM account WHERE account_type = a.account_type) AS total_balance
FROM account a
GROUP BY account_type;