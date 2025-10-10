
-- 1. All combinations of product and supplier names (Cartesian product)
SELECT p.ProductName, s.SupplierName
FROM Products p
CROSS JOIN Suppliers s;

-- 2. All combinations of departments and employees
SELECT d.DepartmentName, e.Name AS EmployeeName
FROM Departments d
CROSS JOIN Employees e;

-- 3. Only combinations where supplier supplies the product
SELECT s.SupplierName, p.ProductName
FROM Products p
INNER JOIN Suppliers s ON s.SupplierID = p.SupplierID;

-- 4. Customer names and their Order IDs
SELECT c.FirstName, c.LastName, o.OrderID
FROM Orders o
INNER JOIN Customers c ON c.CustomerID = o.CustomerID;

-- 5. All combinations of students and courses
SELECT st.Name AS StudentName, c.CourseName
FROM Students st
CROSS JOIN Courses c;

-- 6. Product names and orders where ProductIDs match
SELECT p.ProductName, o.OrderID
FROM Orders o
INNER JOIN Products p ON p.ProductID = o.ProductID;

-- 7. Employees whose DepartmentID matches the department
SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON d.DepartmentID = e.DepartmentID;

-- 8. Student names and their enrolled CourseIDs
SELECT s.Name AS StudentName, e.CourseID
FROM Students s
INNER JOIN Enrollments e ON e.StudentID = s.StudentID;

-- 9. Orders that have matching payments
SELECT o.OrderID, p.PaymentID, p.Amount
FROM Orders o
INNER JOIN Payments p ON p.OrderID = o.OrderID;

-- 10. Orders where product price > 100
SELECT o.OrderID, p.ProductName, p.Price
FROM Orders o
INNER JOIN Products p ON p.ProductID = o.ProductID
WHERE p.Price > 100;

/* =====================
   MEDIUM (11–20)
   ===================== */

-- 11. Employee–Department pairs where IDs are NOT equal (mismatches)
SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID <> d.DepartmentID;

-- 12. Orders where ordered quantity > stock quantity
SELECT o.OrderID, o.Quantity, p.StockQuantity, p.ProductName
FROM Orders o
INNER JOIN Products p ON p.ProductID = o.ProductID
WHERE o.Quantity > p.StockQuantity;

-- 13. Customer names and product IDs where sale amount >= 500
SELECT c.FirstName, c.LastName, s.ProductID, s.SaleAmount
FROM Sales s
INNER JOIN Customers c ON c.CustomerID = s.CustomerID
WHERE s.SaleAmount >= 500;

-- 14. Student names and the course names they’re enrolled in
SELECT st.Name AS StudentName, c.CourseName
FROM Enrollments e
INNER JOIN Students st ON st.StudentID = e.StudentID
INNER JOIN Courses  c  ON c.CourseID   = e.CourseID;

-- 15. Product and supplier names where supplier name contains 'Tech'
SELECT p.ProductName, s.SupplierName
FROM Products p
INNER JOIN Suppliers s ON s.SupplierID = p.SupplierID
WHERE s.SupplierName LIKE '%Tech%';

-- 16. Orders where payment amount < total amount
SELECT o.OrderID, o.TotalAmount, p.Amount AS PaidAmount
FROM Orders o
INNER JOIN Payments p ON p.OrderID = o.OrderID
WHERE p.Amount < o.TotalAmount;

-- 17. Department name for each employee
SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON d.DepartmentID = e.DepartmentID;

-- 18. Products where category is 'Electronics' or 'Furniture' (use Categories)
SELECT p.ProductName, c.CategoryName
FROM Products p
INNER JOIN Categories c ON c.CategoryID = p.Category
WHERE c.CategoryName IN ('Electronics', 'Furniture');

-- 19. All sales from customers who are from 'USA'
SELECT s.*
FROM Sales s
INNER JOIN Customers c ON c.CustomerID = s.CustomerID
WHERE c.Country = 'USA';

-- 20. Orders made by customers from 'Germany' AND total > 100
SELECT o.OrderID, o.TotalAmount, c.FirstName, c.LastName
FROM Orders o
INNER JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE c.Country = 'Germany'
  AND o.TotalAmount > 100;

/* =====================
   HARD (21–25)
   ===================== */

-- 21. All pairs of employees from different departments
SELECT e1.EmployeeID AS Emp1ID, e1.Name AS Emp1Name, e1.DepartmentID AS Emp1Dept,
       e2.EmployeeID AS Emp2ID, e2.Name AS Emp2Name, e2.DepartmentID AS Emp2Dept
FROM Employees e1
INNER JOIN Employees e2
  ON e1.EmployeeID < e2.EmployeeID -- avoid duplicates/self-pairs
 AND e1.DepartmentID <> e2.DepartmentID;

-- 22. Payments where paid amount != (Quantity × Product Price)
SELECT pay.PaymentID, pay.OrderID, pay.Amount AS PaidAmount,
       o.Quantity, pr.Price, (o.Quantity * pr.Price) AS ExpectedAmount
FROM Payments pay
INNER JOIN Orders o   ON o.OrderID   = pay.OrderID
INNER JOIN Products pr ON pr.ProductID = o.ProductID
WHERE pay.Amount <> (o.Quantity * pr.Price);

-- 23. Students NOT enrolled in any course (anti-join using NOT EXISTS; no OUTER JOIN used)
SELECT s.StudentID, s.Name
FROM Students s
WHERE NOT EXISTS (
  SELECT 1 FROM Enrollments e WHERE e.StudentID = s.StudentID
);

-- 24. Managers of someone whose salary <= the person they manage
SELECT m.EmployeeID AS ManagerID, m.Name AS ManagerName, m.Salary AS ManagerSalary,
       e.EmployeeID AS EmployeeID, e.Name AS EmployeeName, e.Salary AS EmployeeSalary
FROM Employees e
INNER JOIN Employees m ON m.EmployeeID = e.ManagerID
WHERE m.Salary <= e.Salary;

-- 25. Customers who have made an order but NO payment recorded for that order
SELECT DISTINCT c.CustomerID, c.FirstName, c.LastName
FROM Orders o
INNER JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE NOT EXISTS (
  SELECT 1 FROM Payments p WHERE p.OrderID = o.OrderID
);

-- End of hw_lesson9.sql
