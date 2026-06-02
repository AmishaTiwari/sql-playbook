-- 1. Customers from India

SELECT *
FROM customers
WHERE country = 'India';

-- 2. Customers with income > 80000

SELECT *
FROM customers
WHERE income > 80000;

-- 3. Customers signed up after 2022

SELECT *
FROM customers
WHERE signup_date >= DATE '2022-01-01'
ORDER BY signup_date ASC;

-- 4. Customers with missing income

SELECT *
FROM customers
WHERE income IS NULL;

-- 5. Customers from India with income > 70000

SELECT *
FROM customers
WHERE country = 'India'
AND income > 70000;

-- 6. Customers aged between 25 and 35

SELECT *
FROM customers
WHERE age BETWEEN 25 AND 35;

-- 7. Customers from India, USA, or UK

SELECT *
FROM customers
WHERE country IN ('India', 'UK', 'USA');

-- 8. Recently active customers

SELECT *
FROM customers
WHERE last_login_date >= CURRENT_DATE - 60
ORDER BY last_login_date ASC;

-- 9. Customers not from India

SELECT *
FROM customers
WHERE country != 'India';

-- 10. Customers whose income is less than 70000 or missing

SELECT *
FROM customers
WHERE income IS NULL
OR income < 70000;

-- 11. Customers whose age is greater than 30 and country is not USA

SELECT *
FROM customers
WHERE age > 30
AND country != 'USA';

-- 12. Customers with non-missing income

SELECT *
FROM customers
WHERE income IS NOT NULL;

-- 13. Customers ordered by income descending

SELECT *
FROM customers
ORDER BY income DESC;

-- 14. Top 3 highest income customers

SELECT *
FROM customers
ORDER BY income DESC
LIMIT 3;