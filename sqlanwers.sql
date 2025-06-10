 -- Project Coverage by SQL Topics (50–70 Queries)
--  1. DDL (Create/Alter Tables)
sql
Copy
Edit
CREATE TABLE customers (...);
CREATE TABLE orders (...);
ALTER TABLE products ADD COLUMN is_active BOOLEAN DEFAULT TRUE;
-- 2. DML (Insert, Update, Delete)
sql
Copy
Edit
INSERT INTO customers (...) VALUES (...);
UPDATE inventory SET quantity = quantity - 5 WHERE product_id = 101;
DELETE FROM reviews WHERE rating < 2;
-- 3. SELECT with Filters & Sorting
sql
Copy
Edit
SELECT * FROM products WHERE price > 500 ORDER BY price DESC;
SELECT * FROM customers WHERE city = 'Mumbai' AND gender = 'F';

. JOINs (All Types)
sql
Copy
Edit
-- Inner Join
SELECT o.order_id, c.name FROM orders o JOIN customers c ON o.customer_id = c.customer_id;

-- Left Join for orders with or without payments
SELECT o.order_id, p.payment_id FROM orders o LEFT JOIN payments p ON o.order_id = p.order_id;

-- Self Join to get employees who report to same manager
SELECT e1.name, e2.name FROM employees e1 JOIN employees e2 ON e1.manager_id = e2.employee_id;
🔹 5. Aggregate Functions + GROUP BY + HAVING
sql
Copy
Edit
SELECT customer_id, COUNT(*) AS total_orders FROM orders GROUP BY customer_id;
SELECT store_id, AVG(price) FROM products GROUP BY store_id HAVING AVG(price) > 200;
🔹 6. Subqueries
sql
Copy
Edit
SELECT name FROM products WHERE price > (SELECT AVG(price) FROM products);
SELECT * FROM customers WHERE customer_id IN (SELECT customer_id FROM orders WHERE order_date > '2024-12-01');
🔹 7. Window Functions (Advanced)
sql
Copy
Edit
SELECT order_id, customer_id, RANK() OVER (PARTITION BY customer_id ORDER BY total_amount DESC) AS rank
FROM orders;

SELECT *, ROW_NUMBER() OVER (PARTITION BY store_id ORDER BY rating DESC) AS row_num
FROM reviews;
🔹 8. Set Operations
sql
Copy
Edit
SELECT name FROM online_customers
UNION
SELECT name FROM offline_customers;

SELECT product_id FROM products
EXCEPT
SELECT product_id FROM order_items;
🔹 9. Views
sql
Copy
Edit
CREATE VIEW monthly_sales AS
SELECT store_id, SUM(total_amount) AS revenue FROM orders
WHERE order_date BETWEEN '2025-01-01' AND '2025-01-31'
GROUP BY store_id;
🔹 10. Indexes
sql
Copy
Edit
CREATE INDEX idx_customer_city ON customers(city);
CREATE INDEX idx_product_price ON products(price);
🔹 11. Constraints
sql
Copy
Edit
PRIMARY KEY (order_id), FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
CHECK (rating BETWEEN 1 AND 5)
🔹 12. Transactions and TCL
sql
Copy
Edit
BEGIN;
UPDATE inventory SET quantity = quantity - 2 WHERE product_id = 10;
INSERT INTO order_items VALUES (...);
COMMIT;