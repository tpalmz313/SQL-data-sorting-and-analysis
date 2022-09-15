SELECT * FROM transaction;
SELECT * FROM card_holder;
SELECT * FROM credit_card;
SELECT * FROM merchant;
SELECT * FROM merchant_category;

-- loading data for card holder 2 and 18 from the database
SELECT cr.cardholder_id, tr.date, tr.amount 
FROM transaction AS tr 
JOIN credit_card AS cr ON cr.card = tr.card 
WHERE cr.cardholder_id = 2 OR cr.cardholder_id = 18;

--Create view
CREATE VIEW cardholder_transactions AS
SELECT cr.cardholder_id, COUNT(tr.id) AS num_transactions
FROM transaction AS tr
JOIN credit_card AS cr
ON cr.card = tr.card
GROUP BY cr.cardholder_id
ORDER BY cr.cardholder_id ASC;

--Test view
SELECT *
FROM cardholder_transactions;

-- transactions count that is less than $2.00 per cardholder
SELECT cr.cardholder_id, COUNT(tr.id) AS small_num_transactions
FROM transaction AS tr
JOIN credit_card AS cr
ON cr.card = tr.card
WHERE amount < 2.00
GROUP BY cr.cardholder_id
ORDER BY small_num_transactions ASC;

--Create view
CREATE VIEW small_transactions AS
SELECT cr.cardholder_id, COUNT(tr.id) AS small_num_transactions
FROM transaction AS tr
JOIN credit_card AS cr
ON cr.card = tr.card
WHERE amount < 2.00
GROUP BY cr.cardholder_id
ORDER BY small_num_transactions;

--Test view
SELECT *
FROM small_transactions;

-- individual transactions and amounts for cardholders
SELECT cr.cardholder_id, tr.id, tr.date, tr.amount
FROM transaction AS tr
JOIN credit_card AS cr
ON cr.card = tr.card
ORDER BY cr.cardholder_id ASC;

--Top 100 highest transactions between 7:00 am and 9:00 am
SELECT *
FROM transaction AS tr
WHERE date_part('hour', tr.date) >= 7 AND date_part('hour',tr.date) <= 9
ORDER BY amount DESC, tr.amount, tr.date
LIMIT 100;

--Create view
CREATE VIEW morning_transactions AS
SELECT *
FROM transaction AS tr
WHERE date_part('hour', tr.date) >= 7 AND date_part('hour', tr.date) <= 9
ORDER BY amount DESC
LIMIT 100;

--Test view
SELECT *
FROM morning_transactions;

--count transactions that are less than $2.00 per card holder,
SELECT COUNT(tr.amount) AS "Transactions less that $2.00"
FROM transaction AS tr
WHERE tr.amount < 2;

SELECT *
FROM transaction AS tr
WHERE tr.amount < 2
ORDER BY tr.card, tr.amount DESC;

--Create view
CREATE VIEW count_micro_transactions AS
  SELECT COUNT(tr.amount) AS "Transactions less that $2.00"
  FROM transaction AS tr
  WHERE tr.amount < 2;

-- What are the top 5 merchant categories that are more prone to be hacked
-- using small transactions?
SELECT tr.id_merchant, me.name, COUNT(tr.id) AS num_transaction
FROM transaction AS tr
JOIN merchant AS me
ON tr.id_merchant = me.id
WHERE amount < 2
GROUP BY tr.id_merchant, me.name
ORDER BY num_transaction DESC
LIMIT 5;

--Create view
CREATE VIEW top5_merchants_hacked AS
SELECT tr.id_merchant, me.name, COUNT(tr.id) AS num_transaction
FROM transaction AS tr
JOIN merchant AS me
ON tr.id_merchant = me.id
WHERE amount < 2.
GROUP BY tr.id_merchant, me.name
ORDER BY num_transaction DESC
LIMIT 5;

--Test View
SELECT *
FROM top5_merchants_hacked;

--Data for cardholder IDs 2 and 18
SELECT cr.cardholder_id, tr.date, tr.amount
FROM transaction AS tr
JOIN credit_card AS cr
ON cr.card = tr.card
WHERE cr.cardholder_id = 18
OR cr.cardholder_id = 2;

--Data from January 2018 to June 2018 for cardholder ID 25
SELECT cr.cardholder_id, date_part('month', tr.date) AS month, date_part('day', tr.date) as day, tr.amount
FROM transaction AS tr
JOIN credit_card AS cr
ON cr.card = tr.card
WHERE cr.cardholder_id = 25
AND date_part('month', tr.date) >= 1 
AND date_part('month', tr.date) <= 6;