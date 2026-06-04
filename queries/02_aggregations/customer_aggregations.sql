-- 1. Count the total number of customers

SELECT COUNT(*) AS total_customers
FROM customers;

-- 2. Count the number of customers and non-missing incomes in each country

SELECT country,
	   COUNT(*) AS customer_count,
	   COUNT(income) AS non_missing_incomes  
FROM customers
GROUP BY country
ORDER BY customer_count DESC;

-- 3. Calculate the average income by country

SELECT country,
	   ROUND(AVG(income), 2) AS avg_income
FROM customers
GROUP BY country;

-- 4. Find the percentage of customers with missing income in each country

SELECT country,
       ROUND(100.0 * COUNT(*) FILTER (WHERE INCOME IS NULL) / COUNT(*), 2) AS null_income_percent_customers
FROM customers
GROUP BY country;

-- 5. Count customers who signed up in each year

SELECT EXTRACT(YEAR FROM signup_date) AS signup_year,
	   COUNT(*) AS total_customers
FROM customers
GROUP BY EXTRACT(YEAR FROM signup_date)
ORDER BY signup_year DESC;

-- 6. Find countries having more than 3 customers and average income above 80000

SELECT country,
	   COUNT(*) AS total_customers,
	   ROUND(AVG(income),2) AS avg_income
FROM customers
GROUP BY country
HAVING COUNT(*) > 3
	AND AVG(income) > 80000;

-- 7. Find countries where the average income is between 70000 and 100000

SELECT country,
	   AVG(income) AS avg_income
FROM customers
GROUP BY country
HAVING AVG(income) BETWEEN 70000 AND 100000;

-- 8. Count distinct countries present in the dataset

SELECT COUNT(DISTINCT country) AS distinct_countries
FROM customers;

-- 9. Find the average income and average age by country

SELECT country,
	   ROUND(AVG(income), 2) AS avg_income,
	   ROUND(AVG(age), 2) AS avg_age
FROM customers
GROUP BY country;

-- 10. Find countries with at least 3 customers having non-missing income

SELECT country
FROM customers
WHERE income IS NOT NULL
GROUP BY country
HAVING COUNT(*) >= 3; 

-- 11. Find the number of customers in each age group:
    -- Below 30
    -- 30 to 40
    -- Above 40
	
SELECT 
      CASE
		  WHEN age < 30 THEN 'Below 30'
		  WHEN age BETWEEN 30 AND 40 THEN '30 to 40'
		  ELSE 'Above 40'
       END AS age_group,
	   COUNT(*)
FROM customers
GROUP BY age_group;  

-- 12. Find the percentage of customers in each country

SELECT country,
       COUNT(*) AS customer_count,
	   ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM customers), 2) AS customer_percent
FROM customers
GROUP BY country;

-- 13. Find the first signup date, latest signup date, and customer count for each country

SELECT country,
	   MIN(signup_date) AS first_signup_date,
	   MAX(signup_date) AS latest_signup_date,
	   COUNT(*) AS customer_count
FROM customers
GROUP BY country;

-- 14. Find countries where the maximum income exceeds 100000

SELECT country,
	   MAX(income) AS max_income
FROM customers
GROUP BY country
HAVING MAX(income) > 100000;

-- 15. Find the difference between the highest and lowest income in each country

SELECT country,
	   MAX(income) - MIN(income) AS income_range
FROM customers
GROUP BY country;

-- 16. Find signup years having at least 3 customers and average income above 80000

SELECT EXTRACT(YEAR FROM signup_date) AS signup_year,
       COUNT(*) AS customer_count,
	   ROUND(AVG(income), 2) AS avg_income
FROM customers
GROUP BY EXTRACT(YEAR FROM signup_date)
HAVING COUNT(*) >= 3
	AND AVG(income) > 80000;
	

-- 17. Find countries whose average income is higher than the overall average income

SELECT country,
	   ROUND(AVG(income), 2) AS avg_income
FROM customers
GROUP BY country
HAVING AVG(income) > (SELECT AVG(income) FROM customers);


-- 18. Find the country with the highest average income

SELECT country,
	   ROUND(AVG(income), 2) AS avg_income
FROM customers
GROUP BY country
ORDER BY avg_income DESC
FETCH FIRST 1 ROW WITH TIES;

-- 19. Find the signup year with the lowest number of customers

SELECT EXTRACT(YEAR FROM signup_date) AS signup_year,
       COUNT(*) AS customer_count
FROM customers
GROUP BY EXTRACT(YEAR FROM signup_date)
ORDER BY customer_count ASC
FETCH FIRST 1 ROW WITH TIES;

-- 20. Find countries whose average income is greater than the average income of customers who signed up on or after 2022-01-01

SELECT country,
	   ROUND(AVG(income), 2) AS avg_income
FROM customers
GROUP BY country
HAVING AVG(income) > (SELECT AVG(income)
                      FROM customers
					  WHERE signup_date >= DATE '2022-01-01');


-- 21. Find countries where the number of customers differs from the number of recorded incomes

SELECT country,
	   COUNT(*) AS customer_count,
	   COUNT(income) AS non_null_income_count
FROM customers
GROUP BY country
HAVING COUNT(*) > COUNT(income);