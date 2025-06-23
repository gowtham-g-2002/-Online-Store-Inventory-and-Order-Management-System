# 🛒 Online Store Inventory and Order Management System

## 📌 Overview

This project is a **MySQL-based inventory and order management system** for an online store. It enables efficient handling of product listings, customer information, order processing, stock updates, and reports.

---

## 🧰 Technologies Used

- MySQL
- SQL (DDL & DML)
- Relational Database Concepts

---

## 🗃️ Database Schema

### Tables:

- **categories**: Stores product categories.
- **products**: Stores product details with stock tracking.
- **customers**: Contains customer personal information.
- **orders**: Captures customer orders and statuses.
- **order_items**: Line items in each order, linking products to orders.

---

## 📂 Features & SQL Operations

### ✅ 1. Add a New Product & Link to a Category

```sql
INSERT INTO categories (name) VALUES ('Electronics');

INSERT INTO products (name, description, price, stock_quantity, category_id)
VALUES ('Smartphone', 'Latest model smartphone with 128GB storage', 699.99, 50, 1);
```

---

### ✅ 2. Place a New Order

```sql
INSERT INTO orders (customer_id, total_amount) VALUES (1, 1299.98);
SET @order_id = LAST_INSERT_ID();

INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES 
    (@order_id, 2, 1, 699.99),
    (@order_id, 3, 1, 599.99);

UPDATE products 
SET stock_quantity = stock_quantity - 1 
WHERE id IN (2, 3);
```

---

### ✅ 3. Track Orders and Their Status

```sql
SELECT 
    o.id AS order_id, 
    c.first_name, c.last_name, 
    o.order_date, o.status,
    SUM(oi.quantity * oi.price) AS total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.id
JOIN order_items oi ON o.id = oi.order_id
WHERE o.status != 'Canceled'
GROUP BY o.id;
```

---

### ✅ 4. Cancel Order and Update Stock

```sql
UPDATE orders 
SET status = 'Canceled' 
WHERE id = 1;

UPDATE products p
JOIN order_items oi ON p.id = oi.product_id
SET p.stock_quantity = p.stock_quantity + oi.quantity
WHERE oi.order_id = 1;
```

---

### ✅ 5. Report of Products That Need Restocking

```sql
SELECT 
    p.name, p.stock_quantity, p.price, c.name AS category
FROM products p
JOIN categories c ON p.category_id = c.id
WHERE p.stock_quantity < 10
ORDER BY p.stock_quantity ASC;
```

---

## 🧪 Getting Started

1. Create the database and tables using the schema.
2. Insert sample data to test the functionality.
3. Run the SQL operations to simulate real-world store workflows.

---

## 🙋 Author

**Gowtham G**  
📧 [ggowthambtechit@gmail.com]
🔗 [LinkedIn](https://www.linkedin.com/in/gowtham-gnanasekar/)

---
