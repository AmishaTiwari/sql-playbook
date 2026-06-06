-- 1. Retrieve all customers along with their orders. Display NULL for customers who have never placed an order.

SELECT c.customer_id,
       c.name AS customer_name,
	   o.order_id,
	   o.order_date,
	   o.order_amount	   
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id;

-- 2. Retrieve customer_id and customer_name for customers who have placed at least one order

SELECT DISTINCT c.customer_id,
       c.name AS customer_name
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id;

-- OR

SELECT c.customer_id,
       c.name AS customer_name
FROM customers AS c
WHERE EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.customer_id
);

-- 3. Retrieve customer_id and customer_name for customers who have never placed an order

SELECT c.customer_id,
       c.name AS customer_name   
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- OR

SELECT c.customer_id,
       c.name AS customer_name
FROM customers AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.customer_id
);

-- 4. Retrieve customer_id, customer_name, and total_orders for each customer

SELECT c.customer_id,
       c.name AS customer_name,
	   COUNT(o.order_id) AS total_orders
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id,
         c.name;

-- 5. Retrieve customer_id, customer_name, and total_spent for each customer

SELECT c.customer_id,
       c.name AS customer_name,
	   COALESCE(SUM(o.order_amount), 0) AS total_spent
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id,
         c.name;

-- 6. Retrieve customer_id, customer_name, and latest_order_date for each customer. Display NULL for customers who have never placed an order.

SELECT c.customer_id,
       c.name AS customer_name,
	   MAX(o.order_date) AS latest_order_date
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id,
         c.name;

-- 7. Retrieve customer_id, customer_name, total_orders, and total_spent for customers who have placed more than one order

SELECT c.customer_id,
       c.name AS customer_name,
	   COUNT(o.order_id) AS total_orders,
	   SUM(o.order_amount) AS total_spent
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id,
         c.name
HAVING COUNT(o.order_id) > 1;

-- 8. Retrieve customer_id, customer_name, total_orders, total_spent, and average_order_value for customers whose total spending exceeds the overall average order amount

SELECT c.customer_id,
       c.name AS customer_name,
	   COUNT(o.order_id) AS total_orders,
	   SUM(o.order_amount) AS total_spent,
	   ROUND(AVG(o.order_amount), 2) AS average_order_value
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id,
         c.name
HAVING SUM(o.order_amount) > (

	SELECT AVG(order_amount) 
	FROM orders
); 

-- 9. Retrieve customer_id, customer_name, total_orders, total_spent, and average_order_value for customers whose total spending exceeds the overall average customer spending

SELECT c.customer_id,
       c.name AS customer_name,
	   COUNT(o.order_id) AS total_orders,
	   SUM(o.order_amount) AS total_spent,
	   ROUND(AVG(o.order_amount), 2) AS average_order_value
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id,
         c.name
HAVING SUM(o.order_amount) > (

	SELECT AVG(customer_total_spending) 
	FROM (
		SELECT SUM(order_amount) AS customer_total_spending
		FROM orders
		GROUP BY customer_id
	) AS customer_totals
); 

-- 10. Retrieve customer_id, customer_name, total_orders, and total_spent for customers whose total spending is above the average spending of customers in their country

SELECT c.customer_id,
       c.name AS customer_name,
	   COUNT(o.order_id) AS total_orders,
	   SUM(o.order_amount) AS total_spent
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id,
         c.name,
		 c.country
HAVING SUM(o.order_amount) > (

	SELECT AVG(country_customer_total) 
	FROM (
		SELECT SUM(o1.order_amount) AS country_customer_total
		FROM orders AS o1
		INNER JOIN customers AS c1
    		ON o1.customer_id = c1.customer_id 
		WHERE c1.country = c.country
		GROUP BY o1.customer_id
	) AS country_customer_totals
); 

-- 11. Find countries where the average customer spending exceeds the overall average order amount

SELECT DISTINCT c.country
FROM customers AS c
WHERE (

	SELECT AVG(country_customer_total) 
	FROM (
		SELECT SUM(o1.order_amount) AS country_customer_total
		FROM orders AS o1
		INNER JOIN customers AS c1
    		ON o1.customer_id = c1.customer_id 
		WHERE c1.country = c.country
		GROUP BY o1.customer_id
	) AS country_customer_totals
	
) > (
	SELECT AVG(order_amount) 
	FROM orders
	);

-- 12. Compare:
    -- Total customers
    -- Distinct customers after INNER JOIN
    -- Total rows produced by the INNER JOIN
	-- Total rows produced by the LEFT JOIN

SELECT
    (SELECT COUNT(*) FROM customers) AS total_customers,

    (
        SELECT COUNT(DISTINCT c.customer_id)
        FROM customers c
        INNER JOIN orders o
            ON c.customer_id = o.customer_id
    ) AS customers_with_orders,

    (
        SELECT COUNT(*)
        FROM customers c
        INNER JOIN orders o
            ON c.customer_id = o.customer_id
    ) AS total_rows_inner_join,

    (
        SELECT COUNT(*)
        FROM customers c
        LEFT JOIN orders o
            ON c.customer_id = o.customer_id
    ) AS total_rows_left_join;

-- 13. Find the average_order_value, average_customer_spending for each country

SELECT c.country,
	   ROUND(AVG(o.order_amount), 2) AS average_order_value,
	   ROUND(
		   (
			SELECT AVG(country_customer_total) 
			FROM (
				SELECT SUM(o1.order_amount) AS country_customer_total
				FROM orders AS o1
				INNER JOIN customers AS c1
		    		ON o1.customer_id = c1.customer_id 
				WHERE c1.country = c.country
				GROUP BY o1.customer_id
			) AS country_customer_totals
		   ), 2
		   ) AS avg_customer_spending
	FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.country;

-- 14. Retrieve customer_id, customer_name, total_orders, and total_spent for customers whose total spending exceeds the average spending of the top 10 customers by spending

SELECT c.customer_id,
       c.name AS customer_name,
	   COUNT(o.order_id) AS total_orders,
	   SUM(o.order_amount) AS total_spent
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id,
         c.name
HAVING SUM(o.order_amount) > (

	SELECT AVG(customer_total_spending) 
	FROM (
		SELECT SUM(o1.order_amount) AS customer_total_spending
		FROM orders AS o1
		GROUP BY o1.customer_id
		ORDER BY customer_total_spending DESC
		FETCH FIRST 10 ROWS WITH TIES
	) AS customer_totals
); 

-- 15. Find customers whose total spending contributes more than 10% of the total revenue

SELECT c.customer_id,
       c.name AS customer_name,
	   SUM(o.order_amount) AS total_spent
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id,
         c.name
HAVING SUM(o.order_amount) > (

	SELECT 0.1 * SUM(order_amount) 
	FROM orders
); 


-- 16. Find countries where the top-spending customer contributes more than 40% of the country's total revenue

SELECT DISTINCT c.country
FROM customers AS c
WHERE (
	SELECT MAX(total_spent)
	FROM (
	
		SELECT SUM(o1.order_amount) AS total_spent
		FROM customers AS c1
		INNER JOIN orders AS o1
			ON c1.customer_id = o1.customer_id
		WHERE c1.country = c.country
		GROUP BY o1.customer_id
		
		) AS customer_total_spents	
) > (
		SELECT 0.4 * SUM(o2.order_amount) AS total_spent
		FROM customers AS c2
		INNER JOIN orders AS o2
			ON c2.customer_id = o2.customer_id
		WHERE c2.country = c.country
);

-- 17. For each country, return the top-spending customer if that customer's spending is more than 40% of the country's revenue

SELECT c.customer_id,
       c.name AS customer_name,
	   c.country,
	   SUM(o.order_amount) AS customer_total_spent
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id,
         c.name,
		 c.country
HAVING SUM(o.order_amount) = (

	SELECT MAX(total_spent)
	FROM (
	
		SELECT SUM(o1.order_amount) AS total_spent
		FROM customers AS c1
		INNER JOIN orders AS o1
			ON c1.customer_id = o1.customer_id
		WHERE c1.country = c.country
		GROUP BY o1.customer_id
		
		) AS customer_total_spents
)
	AND SUM(o.order_amount) > (
	
		SELECT 0.4 * SUM(o2.order_amount) AS total_spent
		FROM customers AS c2
		INNER JOIN orders AS o2
			ON c2.customer_id = o2.customer_id
		WHERE c2.country = c.country
	); 

-- 18. For each country, return the top-spending customer along with country's revenue if that customer's spending is more than 40% of the country's revenue

SELECT c.customer_id,
       c.name AS customer_name,
	   c.country,
	   SUM(o.order_amount) AS customer_total_spent,
	   (	   
	    SELECT SUM(o3.order_amount)
	    FROM customers c3
	    JOIN orders o3
	      ON c3.customer_id = o3.customer_id
	    WHERE c3.country = c.country		
	   ) AS country_revenue
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id,
         c.name,
		 c.country
HAVING SUM(o.order_amount) = (

	SELECT MAX(total_spent)
	FROM (
	
		SELECT SUM(o1.order_amount) AS total_spent
		FROM customers AS c1
		INNER JOIN orders AS o1
			ON c1.customer_id = o1.customer_id
		WHERE c1.country = c.country
		GROUP BY o1.customer_id
		
		) AS customer_total_spents
)
	AND SUM(o.order_amount) > (
	
		SELECT 0.4 * SUM(o2.order_amount) AS total_spent
		FROM customers AS c2
		INNER JOIN orders AS o2
			ON c2.customer_id = o2.customer_id
		WHERE c2.country = c.country
	);