/* -----------------------------------------------------------
           MySQL Database Project by GOWTHAM G
                 Technologies Used - SQL
----------------------------------------------------------- */

-- ✅ Extra SQL Problems and Solutions for Online Store Project

-- 🔶 Problem 1: Which Product Has the Highest Stock?
SELECT 
    name, stock_quantity 
FROM products 
ORDER BY stock_quantity DESC 
LIMIT 1;

-- 🔶 Problem 2: Which Day Had the Highest Total Sales?
SELECT 
    DATE(order_date) AS sale_day,
    SUM(oi.quantity * oi.price) AS total_sales
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
GROUP BY DATE(order_date)
ORDER BY total_sales DESC
LIMIT 1;

-- 🔶 Problem 3: How Many Orders Were Placed Per Month?
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_month
ORDER BY order_month;

-- 🔶 Problem 4: List Customers Who Spent Over $1000
SELECT 
    c.id, c.first_name, c.last_name, SUM(oi.quantity * oi.price) AS total_spent
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_items oi ON o.id = oi.order_id
GROUP BY c.id
HAVING total_spent > 1000;

-- 🔶 Problem 5: Get Average Order Value for Each Customer
SELECT 
    c.id, c.first_name, c.last_name, 
    ROUND(AVG(o.total_amount), 2) AS average_order_value
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.id;

-- 🔶 Problem 6: Which Product Generated the Most Revenue?
SELECT 
    p.name,
    SUM(oi.quantity * oi.price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.id
GROUP BY oi.product_id
ORDER BY revenue DESC
LIMIT 1;

-- 🔶 Problem 7: Products That Are Out of Stock
SELECT 
    name 
FROM products 
WHERE stock_quantity = 0;

-- 🔶 Problem 8: Find Most Frequently Ordered Product per Customer
SELECT 
    c.id AS customer_id,
    c.first_name,
    p.name AS most_ordered_product,
    SUM(oi.quantity) AS total_quantity
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON p.id = oi.product_id
GROUP BY c.id, oi.product_id
ORDER BY total_quantity DESC;

-- 🔶 Problem 9: What Is the Average Order Size (Number of Items)?
SELECT 
    ROUND(AVG(product_count), 2) AS avg_items_per_order
FROM (
    SELECT COUNT(*) AS product_count
    FROM order_items
    GROUP BY order_id
) AS order_counts;

-- 🔶 Problem 10: Find Repeat Customers (Placed More Than One Order)
SELECT 
    c.id, c.first_name, c.last_name, COUNT(o.id) AS order_count
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.id
HAVING order_count > 1;
