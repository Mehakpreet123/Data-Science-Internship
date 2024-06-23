-- Create a sample database
CREATE DATABASE IF NOT EXISTS PracticeDB;
USE PracticeDB;

-- Create sample tables
CREATE TABLE IF NOT EXISTS Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS Departments (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS EmployeeDepartments (
    EmployeeID INT,
    DepartmentID INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Insert sample data
INSERT INTO Employees (FirstName, LastName, Salary) VALUES 
('John', 'Doe', 50000),
('Jane', 'Smith', 60000),
('Mike', 'Johnson', 55000);

INSERT INTO Departments (DepartmentName) VALUES 
('HR'),
('Engineering'),
('Sales');

INSERT INTO EmployeeDepartments (EmployeeID, DepartmentID) VALUES 
(1, 1),
(2, 2),
(3, 3);

-- Stored Procedure: Increase Salary by Percentage
DELIMITER //

CREATE PROCEDURE IncreaseSalary(IN percentIncrease DECIMAL(5,2))
BEGIN
    UPDATE Employees SET Salary = Salary + (Salary * percentIncrease / 100);
END //

DELIMITER ;

-- Call the procedure
CALL IncreaseSalary(10);

-- Function: Get Full Name of Employee
DELIMITER //

CREATE FUNCTION GetFullName(EmployeeID INT) RETURNS VARCHAR(100)
BEGIN
    DECLARE fullName VARCHAR(100);
    SELECT CONCAT(FirstName, ' ', LastName) INTO fullName
    FROM Employees
    WHERE EmployeeID = EmployeeID;
    RETURN fullName;
END //

DELIMITER ;

-- Use the function
SELECT GetFullName(1) AS FullName;

-- Cursor: List Employees with Salaries Above a Certain Amount
DELIMITER //

CREATE PROCEDURE ListHighEarners(IN minSalary DECIMAL(10,2))
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE empID INT;
    DECLARE empFirstName VARCHAR(50);
    DECLARE empLastName VARCHAR(50);
    DECLARE empSalary DECIMAL(10,2);
    
    DECLARE cur CURSOR FOR 
    SELECT EmployeeID, FirstName, LastName, Salary 
    FROM Employees 
    WHERE Salary > minSalary;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO empID, empFirstName, empLastName, empSalary;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT empID AS 'Employee ID', 
               empFirstName AS 'First Name', 
               empLastName AS 'Last Name', 
               empSalary AS 'Salary';
    END LOOP;
    
    CLOSE cur;
END //

DELIMITER ;

-- Call the procedure
CALL ListHighEarners(55000);

-- Drop the database to clean up
-- DROP DATABASE PracticeDB;

DELIMITER //

CREATE PROCEDURE ListHighEarners(IN minSalary DECIMAL(10,2))
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE empID INT;
    DECLARE empFirstName VARCHAR(50);
    DECLARE empLastName VARCHAR(50);
    DECLARE empSalary DECIMAL(10,2);
    
-- Declare the cursor to select employees with salary above the given amount
DECLARE cur CURSOR FOR 
SELECT EmployeeID, FirstName, LastName, Salary 
FROM Employees 
WHERE Salary > minSalary;

 -- Declare a handler for the end of the result set
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
-- Open the cursor
OPEN cur;
    
-- Loop to fetch each row from the cursor
read_loop: LOOP
FETCH cur INTO empID, empFirstName, empLastName, empSalary;
IF done THEN
LEAVE read_loop;
END IF;

-- Display the fetched row
SELECT empID AS 'Employee ID', 
empFirstName AS 'First Name', 
empLastName AS 'Last Name', 
empSalary AS 'Salary';
    END LOOP;