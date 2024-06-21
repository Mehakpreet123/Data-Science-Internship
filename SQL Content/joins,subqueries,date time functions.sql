-- Drop tables if they exist
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS orders;

-- Create departments table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

-- Create employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department_id INT,
    manager_id INT,
    salary DECIMAL(10, 2),
    hire_date DATE,
    birth_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

-- Create orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    total_amount DECIMAL(10, 2)
);

-- Insert sample data into departments table
INSERT INTO departments (department_id, department_name) VALUES
    (1, 'Sales'),
    (2, 'Marketing'),
    (3, 'Finance'),
    (4, 'IT');

-- Insert sample data into employees table
INSERT INTO employees (employee_id, employee_name, department_id, manager_id, salary, hire_date, birth_date) VALUES
    (1, 'John Doe', 1, NULL, 50000.00, '2015-01-15', '1985-05-10'),
    (2, 'Jane Smith', 1, 1, 60000.00, '2016-03-20', '1988-09-25'),
    (3, 'Michael Johnson', 2, NULL, 55000.00, '2017-07-10', '1990-11-15'),
    (4, 'Emily Brown', 2, 3, 52000.00, '2018-02-05', '1992-04-30'),
    (5, 'David Lee', 3, NULL, 58000.00, '2019-04-25', '1987-07-05'),
    (6, 'Sarah Wilson', 3, 5, 62000.00, '2020-09-15', '1993-01-20'),
    (7, 'Robert Green', 4, NULL, 54000.00, '2015-11-30', '1986-03-12');

-- Insert sample data into orders table
INSERT INTO orders (order_id, order_date, total_amount) VALUES
    (101, '2023-05-15', 250.00),
    (102, '2023-06-20', 320.50),
    (103, '2023-07-10', 180.75),
    (104, '2023-08-05', 420.00);

-- Exercise 1: Inner Join with Aggregation
SELECT d.department_name, COUNT(e.employee_id) AS num_employees, AVG(e.salary) AS avg_salary
FROM departments d
INNER JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;

-- Exercise 2: Left Join with Filtering
SELECT d.department_name, COUNT(e.employee_id) AS num_employees
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id AND e.salary > 55000.00
GROUP BY d.department_name;

-- Exercise 3: Self Join
SELECT e1.employee_name AS employee1, e2.employee_name AS manager
FROM employees e1
INNER JOIN employees e2 ON e1.manager_id = e2.employee_id;

-- Exercise 4: Right Join with Aggregation
SELECT d.department_name, COUNT(e.employee_id) AS num_employees, AVG(e.salary) AS avg_salary
FROM employees e
RIGHT JOIN departments d ON d.department_id = e.department_id
GROUP BY d.department_name;

-- Exercise 5: join
SELECT e.employee_id, e.employee_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- Exercise 6: Subquery in SELECT Clause
SELECT department_name,
    (SELECT COUNT(*) FROM employees e2 WHERE e1.department_id = e2.department_id) AS num_employees,
    (SELECT AVG(salary) FROM employees e3 WHERE e1.department_id = e3.department_id) AS avg_salary
FROM departments e1;

-- Exercise 7: Subquery in WHERE Clause
SELECT employee_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Exercise 8: Correlated Subquery
SELECT department_name, AVG(salary) AS avg_salary
FROM departments d
INNER JOIN employees e ON d.department_id = e.department_id
GROUP BY department_name
HAVING AVG(salary) > (SELECT AVG(salary) FROM employees);

-- Exercise 9: Scalar Subquery
SELECT order_id, order_date, total_amount,
    (SELECT department_name FROM departments WHERE department_id = 1) AS department_name
FROM orders;

-- Exercise 10: Extract Function
SELECT order_id, order_date, EXTRACT(DAYOFWEEK FROM order_date) AS day_of_week
FROM orders;

-- Exercise 11: Date Arithmetic
SELECT employee_name, DATEDIFF(CURDATE(), birth_date) AS age_in_years
FROM employees;

-- Exercise 12: Formatting Dates
SELECT order_id, DATE_FORMAT(order_date, '%Y-%m-%d') AS formatted_order_date
FROM orders;

-- Exercise 13: Date Comparison
SELECT employee_name, hire_date
FROM employees
WHERE hire_date > '2018-01-01';

-- Find employees whose salary is greater than the average salary of their department
SELECT employee_name, salary, department_id
FROM employees e
WHERE salary > (SELECT AVG(salary) FROM employees WHERE department_id = e.department_id);

-- Subquery with EXISTS
-- Find departments that have at least one employee earning more than $100,000
SELECT department_name
FROM departments d
WHERE EXISTS (SELECT 1 FROM employees e WHERE e.department_id = d.department_id AND e.salary > 100000);

-- Subquery with IN
-- Find orders where the customer has also made a purchase in the last month
SELECT order_id, order_date, customer_id
FROM orders o
WHERE customer_id IN (SELECT customer_id FROM orders WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH));

-- Subquery with JOIN
-- Find customers who have made more than 2 orders in total
SELECT customer_id, customer_name
FROM customers c
WHERE (SELECT COUNT(*) FROM orders WHERE customer_id = c.customer_id) > 2;

-- Subquery with GROUP BY and HAVING
-- Find departments where the average salary is higher than the average salary of all departments
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
HAVING AVG(salary) > (SELECT AVG(salary) FROM employees);

--  Age Calculation
-- Calculate age of customers based on birthdate
SELECT customer_id, customer_name, birthdate, TIMESTAMPDIFF(YEAR, birthdate, CURDATE()) AS age
FROM customers;

--  Timezone Conversion
-- Convert order_date from UTC to local time (assuming UTC is stored)
SELECT order_id, CONVERT_TZ(order_date, '+00:00', @@global.time_zone) AS local_order_date
FROM orders;

--  Grouping data by weekdays or months:
SELECT DAYOFWEEK(order_date) AS day_of_week, SUM(amount) AS total_amount
FROM orders
GROUP BY DAYOFWEEK(order_date)
ORDER BY day_of_week;


