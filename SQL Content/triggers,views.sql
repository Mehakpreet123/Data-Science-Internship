CREATE TABLE Inventory (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Quantity INT
);

CREATE TABLE Sales (
    SaleID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    QuantitySold INT,
    SaleDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Inventory(ProductID)
);

DELIMITER //
CREATE TRIGGER update_inventory_trigger
AFTER INSERT ON Sales
FOR EACH ROW
BEGIN
    UPDATE Inventory
    SET Quantity = Quantity - NEW.QuantitySold
    WHERE ProductID = NEW.ProductID;
END //
DELIMITER ;


CREATE VIEW EmployeeDetails AS
SELECT e.EmployeeID, e.FirstName, e.LastName, d.DepartmentName
FROM Employees e
JOIN EmployeeDepartments ed ON e.EmployeeID = ed.EmployeeID
JOIN Departments d ON ed.DepartmentID = d.DepartmentID;


CREATE VIEW SalesSummary AS
SELECT YEAR(SaleDate) AS Year, MONTH(SaleDate) AS Month, SUM(QuantitySold * UnitPrice) AS TotalSales
FROM Sales
GROUP BY YEAR(SaleDate), MONTH(SaleDate);


DELIMITER //

CREATE TRIGGER UpdateProductStock
AFTER INSERT ON Sales
FOR EACH ROW
BEGIN
    UPDATE Products
    SET Stock = Stock - NEW.QuantitySold
    WHERE ProductID = NEW.ProductID;
END //

DELIMITER ;

CREATE VIEW EmployeeDetails AS
SELECT EmployeeID, FirstName, LastName, Salary
FROM Employees;
CREATE VIEW DepartmentSales AS
SELECT d.DepartmentName, SUM(s.Amount) AS TotalSales
FROM Departments d
LEFT JOIN Sales s ON d.DepartmentID = s.DepartmentID
GROUP BY d.DepartmentName;
