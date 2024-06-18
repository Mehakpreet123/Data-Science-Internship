-- DDL and DML commands
-- DDL or Data Definition Language actually consists of the SQL commands that can be used to define the database schema. 
-- CREATE -> Create database or its objects (table, index, function, views, store procedure, and triggers)
-- DROP -> Delete objects from the database
-- ALTER -> Alter the structure of the database
-- TRUNCATE -> Remove all records from a table, including all spaces allocated for the records are removed
-- RENAME -> Rename an object existing in the database

-- to create database
CREATE DATABASE employee_db;
USE employee_db;

-- to create table in the database
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2)
);


-- The ALTER TABLE statement in SQL is used to add, remove, or modify columns in an existing table.
-- The ALTER TABLE statement is also used to add and remove various constraints on existing tables.

-- to add new column
ALTER TABLE employee ADD Email VARCHAR(45);

-- to view data and table
SELECT * from employee;

-- to rename table
ALTER TABLE Employee RENAME TO Employee_details;

-- to modify a column
ALTER TABLE employee_details MODIFY COLUMN Salary INT;

-- to drop a column
ALTER TABLE employee_details DROP COLUMN Salary;

-- Rename column
ALTER TABLE employee_details RENAME COLUMN employeeID TO ID;

-- Drop database
DROP database Employee_db;

-- Drop table
DROP TABLE Employee_details;

-- TRUNCATE statement is a Data Definition Language (DDL) operation that is used to mark the extent of a table for deallocation (empty for reuse).
TRUNCATE TABLE Employee_details;

-- SQL CONSTRAINTS
-- SQL constraints are used to specify rules for the data in a table.
/*
NOT NULL - Ensures that a column cannot have a NULL value
UNIQUE - Ensures that all values in a column are different
PRIMARY KEY - A combination of a NOT NULL and UNIQUE. Uniquely identifies each row in a table
FOREIGN KEY - Prevents actions that would destroy links between tables
CHECK - Ensures that the values in a column satisfies a specific condition
DEFAULT - Sets a default value for a column if no value is specified
*/

ALTER TABLE employee_details MODIFY COLUMN FirstName VARCHAR(45) NOT NULL;

ALTER TABLE employee ADD GENDER VARCHAR(45) check (GENDER in ("MALE","FEMALE","M","F"));

CREATE TABLE Departments(
	dept_id int primary key,
    dept_name VARCHAR(45),
    Manager_id int,
    FOREIGN KEY (manager_id) REFERENCES Manager_table(manager_id)
    );
    
CREATE TABLE Manager_table (
    manager_id INT PRIMARY KEY,
    manager_name VARCHAR(45),
    Email VARCHAR(45)
);

-- to add foreign key constraint using alter
ALTER TABLE Departments
ADD CONSTRAINT fk_manager
FOREIGN KEY (manager_id) REFERENCES Manager_table(manager_id);

-- DML -> The SQL commands that deal with the manipulation of data present in the database belong to DML or Data Manipulation Language and this includes most of the SQL statements 


INSERT INTO Employee_details (ID, FirstName, LastName, Department)
VALUES 
    (1, 'John', 'Doe', 'HR'),
    (2, 'Jane', 'Smith', 'Engineering'),
    (3, 'Jim', 'Brown', 'Marketing'),
    (4, 'Emily', 'Davis', 'Finance'),
    (5, 'Michael', 'Johnson', 'IT');
    
INSERT INTO Manager_table (manager_id, manager_name)
VALUES 
    (11, 'Alice Johnson'),
    (21, 'Bob Smith'),
    (31, 'Charlie Brown');
    
INSERT INTO Departments (dept_id, dept_name, manager_id)
VALUES 
    (4, 'Marketing', 11),
    (5, 'Sales', 21),
    (6, 'IT', 31);
    
UPDATE employee_details SET department = 'IT' WHERE ID = 4;

DELETE FROM Employee_details 
WHERE id = 1;
select * from employee_details;
select * from Manager_table;
select * from departments;