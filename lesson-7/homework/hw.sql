

-- 1. MIN price of a product (Products)
SELECT MIN(Price) AS MinPrice FROM Products;

-- 2. MAX Salary (Employees)
SELECT MAX(Salary) AS MaxSalary FROM Employees;

-- 3. Count rows in Customers
SELECT COUNT(*) AS CustomerCount FROM Customers;

-- 4. Count unique product categories
SELECT COUNT(DISTINCT Category) AS UniqueCategoryCount FROM Products;

-- 5. Total sales amount for product with id 7 (Sales)
SELECT SUM(SaleAmount) AS TotalSales_Product7
FROM Sales
WHERE ProductID = 7;

-- 6. Average age of employees
SELECT AVG(CAST(Age AS DECIMAL(10,2))) AS AvgEmployeeAge
FROM Employees;

-- 7. Number of employees in each department
SELECT DepartmentName, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName;

-- 8. Min and Max Price of products grouped by Category (Products)
SELECT Category, MIN(Price) AS MinPrice, MAX(Price) AS MaxPrice
FROM Products
GROUP BY Category;

-- 9. Total sales per Customer (Sales)
SELECT CustomerID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID;

-- 10. Departments having more than 5 employees (DeptName only)
SELECT DepartmentName, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName
HAVING COUNT(*) > 5;

-- 11. Total and Average sales per product category (Sales + Products)
SELECT p.Category,
       SUM(s.SaleAmount) AS TotalSales,
       AVG(s.SaleAmount) AS AvgSaleAmount
FROM Sales s
JOIN Products p ON p.ProductID = s.ProductID
GROUP BY p.Category;

-- 12. Count number of employees from Department HR
SELECT COUNT(*) AS HR_EmployeeCount
FROM Employees
WHERE DepartmentName = 'HR';

-- 13. Highest and lowest Salary by department
SELECT DepartmentName,
       MAX(Salary) AS MaxSalary,
       MIN(Salary) AS MinSalary
FROM Employees
GROUP BY DepartmentName;

-- 14. Average salary per Department
SELECT DepartmentName, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName;

-- 15. AVG salary and COUNT(*) per Department
SELECT DepartmentName,
       AVG(Salary) AS AvgSalary,
       COUNT(*)     AS EmployeeCount
FROM Employees
GROUP BY DepartmentName;

-- 16. Product categories with average price > 400
SELECT Category, AVG(Price) AS AvgPrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 400;

-- 17. Total sales for each year (Sales)
SELECT YEAR(SaleDate) AS SaleYear,
       SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY YEAR(SaleDate)
ORDER BY SaleYear;

-- 18. Customers who placed at least 3 orders (Orders)
SELECT CustomerID, COUNT(*) AS OrderCount
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) >= 3;

-- 19. Departments with average salary > 60000
SELECT DepartmentName, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName
HAVING AVG(Salary) > 60000;

-- 20. Avg price per category, filter > 150 (Products)
SELECT Category, AVG(Price) AS AvgPrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 150;

-- 21. Total sales per Customer, filter total > 1500 (Sales)
SELECT CustomerID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID
HAVING SUM(SaleAmount) > 1500;

-- 22. Total and average salary per department, filter avg > 65000
SELECT DepartmentName,
       SUM(Salary) AS TotalSalary,
       AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName
HAVING AVG(Salary) > 65000;


SELECT
  YEAR(OrderDate) AS OrderYear,
  MONTH(OrderDate) AS OrderMonth,
  SUM(TotalAmount) AS MonthlyTotalSales,
  COUNT(DISTINCT ProductID) AS UniqueProductsSold
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
HAVING COUNT(DISTINCT ProductID) >= 2
ORDER BY OrderYear, OrderMonth;

-- 26. MIN and MAX order quantity per Year (Orders)
SELECT YEAR(OrderDate) AS OrderYear,
       MIN(Quantity)   AS MinQty,
       MAX(Quantity)   AS MaxQty
FROM Orders
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear;
