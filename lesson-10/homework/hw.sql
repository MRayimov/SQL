
-- 1
SELECT e.Name AS EmployeeName, e.Salary, d.DepartmentName
FROM Employees e
LEFT JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE e.Salary > 50000;

-- 2
SELECT c.FirstName, c.LastName, o.OrderDate
FROM Orders o
INNER JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) = 2023;

-- 3
SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e
LEFT JOIN Departments d ON d.DepartmentID = e.DepartmentID;

-- 4
SELECT s.SupplierName, p.ProductName
FROM Suppliers s
LEFT JOIN Products p ON p.SupplierID = s.SupplierID;

-- 5
SELECT o.OrderID, o.OrderDate, p.PaymentDate, p.Amount
FROM Orders o
FULL OUTER JOIN Payments p ON p.OrderID = o.OrderID;

-- 6
SELECT e.Name AS EmployeeName, m.Name AS ManagerName
FROM Employees e
LEFT JOIN Employees m ON m.EmployeeID = e.ManagerID;

-- 7
SELECT s.Name AS StudentName, c.CourseName
FROM Enrollments e
JOIN Students s ON s.StudentID = e.StudentID
JOIN Courses  c ON c.CourseID = e.CourseID
WHERE c.CourseName = 'Math 101';

-- 8
SELECT c.FirstName, c.LastName, o.Quantity
FROM Orders o
JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE o.Quantity > 3;

-- 9
SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e
JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE d.DepartmentName = 'Human Resources';


/* ========== MEDIUM (10–18) ========== */
-- 10
SELECT d.DepartmentName, COUNT(*) AS EmployeeCount
FROM Employees e
JOIN Departments d ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName
HAVING COUNT(*) > 5;

-- 11
SELECT p.ProductID, p.ProductName
FROM Products p
LEFT JOIN Sales s ON s.ProductID = p.ProductID
WHERE s.ProductID IS NULL;

-- 12
SELECT c.FirstName, c.LastName, COUNT(*) AS TotalOrders
FROM Customers c
JOIN Orders o ON o.CustomerID = c.CustomerID
GROUP BY c.FirstName, c.LastName;

-- 13
SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e
JOIN Departments d ON d.DepartmentID = e.DepartmentID;

-- 14
SELECT e1.Name AS Employee1, e2.Name AS Employee2, e1.ManagerID
FROM Employees e1
JOIN Employees e2
  ON e1.ManagerID = e2.ManagerID
 AND e1.EmployeeID < e2.EmployeeID;

-- 15
SELECT o.OrderID, o.OrderDate, c.FirstName, c.LastName
FROM Orders o
JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) = 2022;

-- 16
SELECT e.Name AS EmployeeName, e.Salary, d.DepartmentName
FROM Employees e
JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE d.DepartmentName = 'Sales' AND e.Salary > 60000;

-- 17
SELECT o.OrderID, o.OrderDate, p.PaymentDate, p.Amount
FROM Orders o
JOIN Payments p ON p.OrderID = o.OrderID;

-- 18
SELECT p.ProductID, p.ProductName
FROM Products p
LEFT JOIN Orders o ON o.ProductID = p.ProductID
WHERE o.ProductID IS NULL;


/* ========== HARD (19–27) ========== */
-- 19
SELECT e.Name AS EmployeeName, e.Salary
FROM Employees e
JOIN (
    SELECT DepartmentID, AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY DepartmentID
) a ON a.DepartmentID = e.DepartmentID
WHERE e.Salary > a.AvgSalary;

-- 20
SELECT o.OrderID, o.OrderDate
FROM Orders o
LEFT JOIN Payments p ON p.OrderID = o.OrderID
WHERE o.OrderDate < '2020-01-01' AND p.OrderID IS NULL;

-- 21
SELECT p.ProductID, p.ProductName
FROM Products p
LEFT JOIN Categories c ON c.CategoryID = p.Category
WHERE c.CategoryID IS NULL;

-- 22
SELECT e1.Name AS Employee1,
       e2.Name AS Employee2,
       e1.ManagerID,
       CASE WHEN e1.Salary <= e2.Salary THEN e1.Salary ELSE e2.Salary END AS Salary
FROM Employees e1
JOIN Employees e2
  ON e1.ManagerID = e2.ManagerID
 AND e1.EmployeeID < e2.EmployeeID
WHERE e1.Salary > 60000 AND e2.Salary > 60000;

-- 23
SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e
JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE d.DepartmentName LIKE 'M%';

-- 24
SELECT s.SaleID, p.ProductName, s.SaleAmount
FROM Sales s
JOIN Products p ON p.ProductID = s.ProductID
WHERE s.SaleAmount > 500;

-- 25
SELECT s.StudentID, s.Name AS StudentName
FROM Students s
WHERE NOT EXISTS (
  SELECT 1
  FROM Enrollments e
  JOIN Courses c ON c.CourseID = e.CourseID
  WHERE e.StudentID = s.StudentID
    AND c.CourseName = 'Math 101'
);

-- 26
SELECT o.OrderID, o.OrderDate, p.PaymentID
FROM Orders o
LEFT JOIN Payments p ON p.OrderID = o.OrderID
WHERE p.PaymentID IS NULL;

-- 27
SELECT p.ProductID, p.ProductName, c.CategoryName
FROM Products p
JOIN Categories c ON c.CategoryID = p.Category
WHERE c.CategoryName IN ('Electronics','Furniture');
