/* SQL operators are symbols or keywords used in SQL statements to perform operations on data.
 They are used to specify conditions, perform calculations, and manipulate data in SQL queries.*/
 
 CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Country VARCHAR(50),
    City VARCHAR(50)
);


INSERT INTO Customers (FirstName, LastName, Email, Phone, Country, City) VALUES
('John', 'Doe', 'john.doe@example.com', '123-456-7890', 'USA', 'New York'),
('Jane', 'Smith', 'jane.smith@example.com', '234-567-8901', 'Canada', 'Toronto'),
('Michael', 'Brown', 'michael.brown@example.com', '345-678-9012', 'UK', 'London'),
('Emily', 'Davis', 'emily.davis@example.com', '456-789-0123', 'Australia', 'Sydney'),
('David', 'Wilson', 'david.wilson@example.com', '567-890-1234', 'USA', 'Los Angeles');

 CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    Stock INT
);

INSERT INTO Products (ProductName, Category, Price, Stock) VALUES
('Laptop', 'Electronics', 799.99, 50),
('Smartphone', 'Electronics', 499.99, 100),
('Desk Chair', 'Furniture', 150.00, 25),
('Coffee Maker', 'Appliances', 89.99, 75),
('Running Shoes', 'Apparel', 120.00, 200);

CREATE TABLE Order_Details (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    TotalPrice DECIMAL(10, 2),
    OrderDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
ALTER TABLE order_details ADD COLUMN Customer_id INT ;
ALTER TABLE order_details ADD CONSTRAINT c_id FOREIGN KEY (customer_id) references Customer (customer_id);
-- Create the Order_Details table
CREATE TABLE Order_Details (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    TotalPrice DECIMAL(10, 2),
    OrderDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert 8 rows into the Order_Details table
INSERT INTO Order_Details (ProductID, Quantity, UnitPrice, TotalPrice, OrderDate) VALUES
(1, 2, 799.99, 1599.98, '2024-01-10'),
(2, 1, 499.99, 499.99, '2024-01-12'),
(3, 4, 150.00, 600.00, '2024-01-14'),
(4, 3, 89.99, 269.97, '2024-01-15'),
(5, 2, 120.00, 240.00, '2024-01-18'),
(1, 1, 799.99, 799.99, '2024-01-20'),
(3, 2, 150.00, 300.00, '2024-01-22'),
(4, 5, 89.99, 449.95, '2024-01-25');



 -- Arithmetic operators
 SELECT 30 + 20;
 SELECT 30 - 20;
 SELECT 30 * 20;
 SELECT 30 / 20;
 SELECT 30 % 20;
 
 -- Bitwise operators  -> works on the bits of data
 SELECT 30 & 20;  -- bitwise AND
 SELECT 30 | 20; -- bitwise OR
 SELECT 30 ^ 20; -- bitwise exclusive OR
 
 -- comparison operators --> evaluate a condition and filters data accordingly
 SELECT * FROM Products
WHERE Price = 150;

 SELECT * FROM Products
WHERE Price < 150;

 SELECT * FROM Products
WHERE Price > 150;

 SELECT * FROM Products
WHERE Price >= 150;

 SELECT * FROM Products
WHERE Price <= 150;

SELECT * FROM Products
WHERE Price <> 18;  -- not equal to

 -- LOGICAL OPERATORS-> evaluate condition 
 -- ALL -> TRUE if all of the subquery values meet the condition
SELECT ProductName 
FROM Products
WHERE ProductID = ALL (SELECT ProductID FROM Order_details WHERE Quantity = 10);

-- AND -> TRUE if all the conditions separated by AND is TRUE
SELECT * FROM Customers
WHERE City = "London" AND Country = "UK";

-- ANY -> TRUE if any of the subquery values meet the condition
SELECT * FROM Products
WHERE Price > ANY (SELECT Price FROM Products WHERE Price > 50);

-- BETWEEN -> 	TRUE if the operand is within the range of comparisons
SELECT * FROM Products
WHERE Price BETWEEN 50 AND 60;

-- EXISTS -> TRUE if the subquery returns one or more records
SELECT FirstName, LastName, Email
FROM Customers c
WHERE EXISTS (
    SELECT *
    FROM Orders o
    WHERE o.CustomerID = c.CustomerID
);
-- IN -> 	TRUE if the operand is equal to one of a list of expressions
SELECT * FROM Customers
WHERE City IN ('Paris','London');
-- LIKE -> TRUE if the operand matches a pattern
SELECT * FROM Customers
WHERE City LIKE 's%';
-- NOT -> TRUE if the operand matches a pattern
SELECT * FROM Customers
WHERE City NOT LIKE 's%';
-- OR-> TRUE if any of the conditions separated by OR is TRUE
SELECT * FROM Customers
WHERE City = "London" OR Country = "UK";
-- SOME -> TRUE if any of the subquery values meet the condition
SELECT * FROM Products
WHERE Price > SOME (SELECT Price FROM Products WHERE Price > 20);
