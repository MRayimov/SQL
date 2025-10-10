

-- 1) Orders after 2022 with customer names
SELECT 
    o.OrderID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    o.OrderDate
FROM Orders o
JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE o.OrderDate >= '2023-01-01'
ORDER BY o.OrderDate, o.OrderID;

-- 2) Employees in Sales or Marketing
SELECT 
    e.Name AS EmployeeName,
    d.DepartmentName
FROM Employees e
JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE d.DepartmentName IN ('Sales', 'Marketing')
ORDER BY EmployeeName;

-- 3) Max salary per department
SELECT 
    d.DepartmentName,
    MAX(e.Salary) AS MaxSalary
FROM Departments d
JOIN Employees e ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
ORDER BY d.DepartmentName;

-- 4) USA customers who placed orders in 2023
SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    o.OrderID,
    o.OrderDate
FROM Orders o
JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA'
  AND YEAR(o.OrderDate) = 2023
ORDER BY o.OrderDate, o.OrderID;

-- 5) How many orders each customer has placed
SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o ON o.CustomerID = c.CustomerID
GROUP BY CONCAT(c.FirstName, ' ', c.LastName)
ORDER BY TotalOrders DESC, CustomerName;

-- 6) Products supplied by either Gadget Supplies or Clothing Mart
SELECT 
    p.ProductName,
    s.SupplierName
FROM Products p
JOIN Suppliers s ON s.SupplierID = p.SupplierID
WHERE s.SupplierName IN ('Gadget Supplies', 'Clothing Mart')
ORDER BY s.SupplierName, p.ProductName;

-- 7) Each customer's most recent order (include customers with none)
SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    mro.MostRecentOrderDate
FROM Customers c
OUTER APPLY (
    SELECT TOP (1) o.OrderDate AS MostRecentOrderDate
    FROM Orders o
    WHERE o.CustomerID = c.CustomerID
    ORDER BY o.OrderDate DESC, o.OrderID DESC
) AS mro
ORDER BY CustomerName;

/* ============================
   🟠 Medium-Level Tasks (8–13)
   ============================ */

-- 8) Customers with an order where total amount > 500 (show each qualifying order)
SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    o.TotalAmount AS OrderTotal
FROM Orders o
JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE o.TotalAmount > 500
ORDER BY OrderTotal DESC, CustomerName;

-- 9) Product sales in 2022 OR sale amount > 400
SELECT 
    p.ProductName,
    s.SaleDate,
    s.SaleAmount
FROM Sales s
JOIN Products p ON p.ProductID = s.ProductID
WHERE YEAR(s.SaleDate) = 2022
   OR s.SaleAmount > 400
ORDER BY s.SaleDate, p.ProductName;

-- 10) Each product with total amount sold
SELECT 
    p.ProductID,
    p.ProductName,
    COALESCE(SUM(s.SaleAmount), 0) AS TotalSalesAmount
FROM Products p
LEFT JOIN Sales s ON s.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY p.ProductID;

-- 11) HR employees earning > 60000
SELECT 
    e.Name AS EmployeeName,
    d.DepartmentName,
    e.Salary
FROM Employees e
JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE d.DepartmentName = 'Human Resources'
  AND e.Salary > 60000
ORDER BY e.Salary DESC, EmployeeName;

-- 12) Products sold in 2023 with more than 100 in stock (current stock assumed)
SELECT 
    p.ProductName,
    s.SaleDate,
    p.StockQuantity
FROM Sales s
JOIN Products p ON p.ProductID = s.ProductID
WHERE YEAR(s.SaleDate) = 2023
  AND p.StockQuantity > 100
ORDER BY s.SaleDate, p.ProductName;

-- 13) Employees in Sales OR hired after 2020
SELECT 
    e.Name AS EmployeeName,
    d.DepartmentName,
    e.HireDate
FROM Employees e
JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE d.DepartmentName = 'Sales'
   OR e.HireDate > '2020-12-31'
ORDER BY e.HireDate, EmployeeName;

/* ===========================
   🔴 Hard-Level Tasks (14–19)
   =========================== */

-- 14) USA orders where address starts with 4 digits
SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    o.OrderID,
    c.Address,
    o.OrderDate
FROM Orders o
JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA'
  AND c.Address LIKE '[0-9][0-9][0-9][0-9]%'
ORDER BY o.OrderDate, o.OrderID;

-- 15) Product sales for Electronics category OR sale amount > 350
-- Products.Category is INT (CategoryID) after the provided updates.
SELECT 
    p.ProductName,
    cat.CategoryName AS Category,
    s.SaleAmount
FROM Sales s
JOIN Products p ON p.ProductID = s.ProductID
LEFT JOIN Categories cat ON cat.CategoryID = p.Category
WHERE (cat.CategoryName = 'Electronics')
   OR (s.SaleAmount > 350)
ORDER BY s.SaleAmount DESC, p.ProductName;

-- 16) Number of products in each category
SELECT 
    cat.CategoryName,
    COUNT(p.ProductID) AS ProductCount
FROM Categories cat
LEFT JOIN Products p ON p.Category = cat.CategoryID
GROUP BY cat.CategoryName
ORDER BY cat.CategoryName;

-- 17) Orders: Los Angeles customers and amount > 300
SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    c.City,
    o.OrderID,
    o.TotalAmount AS Amount
FROM Orders o
JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE c.City = 'Los Angeles'
  AND o.TotalAmount > 300
ORDER BY o.TotalAmount DESC, o.OrderID;

-- 18) Employees in HR or Finance, OR name contains at least 4 vowels
WITH VowelCounts AS (
    SELECT 
        e.EmployeeID,
        e.Name AS EmployeeName,
        e.DepartmentID,
        (LEN(LOWER(e.Name)) - LEN(REPLACE(LOWER(e.Name), 'a', ''))
       + LEN(LOWER(e.Name)) - LEN(REPLACE(LOWER(e.Name), 'e', ''))
       + LEN(LOWER(e.Name)) - LEN(REPLACE(LOWER(e.Name), 'i', ''))
       + LEN(LOWER(e.Name)) - LEN(REPLACE(LOWER(e.Name), 'o', ''))
       + LEN(LOWER(e.Name)) - LEN(REPLACE(LOWER(e.Name), 'u', ''))) AS VowelCount
    FROM Employees e
)
SELECT 
    v.EmployeeName AS EmployeeName,
    d.DepartmentName
FROM VowelCounts v
JOIN Departments d ON d.DepartmentID = v.DepartmentID
WHERE d.DepartmentName IN ('Human Resources', 'Finance')
   OR v.VowelCount >= 4
ORDER BY d.DepartmentName, v.EmployeeName;

-- 19) Employees in Sales or Marketing with salary > 60000
SELECT 
    e.Name AS EmployeeName,
    d.DepartmentName,
    e.Salary
FROM Employees e
JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE d.DepartmentName IN ('Sales', 'Marketing')
  AND e.Salary > 60000
ORDER BY e.Salary DESC, e.Name;
