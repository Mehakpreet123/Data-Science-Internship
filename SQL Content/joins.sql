create database sql_practice;
use sql_practice;

-- Create Tables

-- Users Table: Stores user information.
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100),
    user_email VARCHAR(100)
);

-- Orders Table: Stores order information.
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Products Table: Stores product information.
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

-- OrderDetails Table: Stores details of each order.
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Sample Data Insertion

-- Insert Users
INSERT INTO Users (user_id, user_name, user_email) VALUES
(1, 'Alice', 'alice@example.com'),
(2, 'Bob', 'bob@example.com'),
(3, 'Charlie', 'charlie@example.com');

-- Insert Orders
INSERT INTO Orders (order_id, user_id, order_date, total_amount) VALUES
(1, 1, '2023-01-01', 150.00),
(2, 1, '2023-02-01', 200.00),
(3, 2, '2023-03-01', 50.00);

-- Insert Products
INSERT INTO Products (product_id, product_name, price) VALUES
(1, 'Laptop', 1000.00),
(2, 'Mouse', 20.00),
(3, 'Keyboard', 50.00);

-- Insert Order Details
INSERT INTO OrderDetails (order_detail_id, order_id, product_id, quantity) VALUES
(1, 1, 1, 1),
(2, 1, 2, 2),
(3, 2, 1, 1),
(4, 2, 3, 1),
(5, 3, 2, 1);

-- Practice Exercises

-- 1. Inner Join
-- Definition: Returns records that have matching values in both tables.
-- Description: Fetch the list of users along with their orders.
SELECT Users.user_name, Orders.order_id, Orders.order_date, Orders.total_amount
FROM Users
INNER JOIN Orders ON Users.user_id = Orders.user_id;

-- 2. Left Join
-- Definition: Returns all records from the left table, and the matched records from the right table. The result is NULL from the right side if there is no match.
-- Description: Fetch all users and their orders, including users who haven't placed any orders.
SELECT Users.user_name, Orders.order_id, Orders.order_date, Orders.total_amount
FROM Users
LEFT JOIN Orders ON Users.user_id = Orders.user_id;

-- 3. Right Join
-- Definition: Returns all records from the right table, and the matched records from the left table. The result is NULL from the left side if there is no match.
-- Description: Fetch all orders and the users who placed them, including orders that do not have a corresponding user.
SELECT Users.user_name, Orders.order_id, Orders.order_date, Orders.total_amount
FROM Users
RIGHT JOIN Orders ON Users.user_id = Orders.user_id;

-- 4. Full Outer Join (Not supported by SQL)
-- Definition: Returns all records when there is a match in either left or right table records.
-- Description: Fetch all users and their orders, including users without orders and orders without users.

-- Combine LEFT JOIN and RIGHT JOIN to simulate FULL OUTER JOIN
SELECT Users.user_name, Orders.order_id, Orders.order_date, Orders.total_amount
FROM Users
LEFT JOIN Orders ON Users.user_id = Orders.user_id
UNION
SELECT Users.user_name, Orders.order_id, Orders.order_date, Orders.total_amount
FROM Users
RIGHT JOIN Orders ON Users.user_id = Orders.user_id;


-- 5. Self Join
-- Definition: A self join is a regular join but the table is joined with itself.
-- Description: Fetch pairs of users.
SELECT u1.user_name AS User1, u2.user_name AS User2
FROM Users u1
INNER JOIN Users u2 ON u1.user_id <> u2.user_id;

-- 6. Cross Join
-- Definition: Returns the Cartesian product of the two tables.
-- Description: Fetch the Cartesian product of users and products.
SELECT Users.user_name, Products.product_name
FROM Users
CROSS JOIN Products;

-- 7. Joining Multiple Tables
-- Definition: Combines rows from two or more tables, based on a related column between them.
-- Description: Fetch order details along with user and product information.
SELECT Users.user_name, Orders.order_date, Products.product_name, OrderDetails.quantity
FROM OrderDetails
INNER JOIN Orders ON OrderDetails.order_id = Orders.order_id
INNER JOIN Users ON Orders.user_id = Users.user_id
INNER JOIN Products ON OrderDetails.product_id = Products.product_id;

-- 8. Using Aliases
-- Definition: Aliases are used to give a table or a column in a table a temporary name.
-- Description: Fetch the list of products and their order quantities using table aliases.
SELECT p.product_name, SUM(od.quantity) AS total_quantity
FROM Products p
INNER JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY p.product_name;

-- 9. Subqueries with Joins
-- Definition: A subquery is a query nested inside another query.
-- Description: Fetch users who have placed orders of more than $100.
SELECT u.user_name, u.user_email
FROM Users u
WHERE u.user_id IN (
    SELECT o.user_id
    FROM Orders o
    WHERE o.total_amount > 100
);
