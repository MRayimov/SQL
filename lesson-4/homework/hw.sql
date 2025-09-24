


-- 1) Employees jadvalidan TOP 5 xodimni tanlash
SELECT TOP (5) *
FROM Employees;  -- ORDER BY EmployeeID ham qo'shish mumkin

-- 2) Products jadvalidan noyob (unique) Category qiymatlari
SELECT DISTINCT Category
FROM Products;

-- 3) Products: Price > 100 bo‘lgan mahsulotlar
SELECT *
FROM Products
WHERE Price > 100;

-- 4) Customers: FirstName 'A' harfi bilan boshlanuvchi mijozlar (LIKE)
SELECT *
FROM Customers
WHERE FirstName LIKE 'A%';

-- 5) Products: Price bo‘yicha o‘sish tartibida (ASC) saralash
SELECT *
FROM Products
ORDER BY Price ASC;

-- 6) Employees: Salary >= 60000 VA DepartmentName = 'HR'
SELECT *
FROM Employees
WHERE Salary >= 60000
  AND DepartmentName = 'HR';

-- 7) Employees: Email NULL bo‘lsa, 'noemail@example.com' bilan almashtirish (ISNULL)
SELECT EmployeeID,
       FirstName,
       LastName,
       DepartmentName,
       Salary,
       HireDate,
       Age,
       ISNULL(Email, 'noemail@example.com') AS Email,
       Country
FROM Employees;

-- 8) Products: Price BETWEEN 50 AND 100
SELECT *
FROM Products
WHERE Price BETWEEN 50 AND 100;

-- 9) Products: DISTINCT Category, ProductName juftliklari
SELECT DISTINCT Category, ProductName
FROM Products;

-- 10) 9-band natijasini ProductName DESC bo‘yicha tartiblash
SELECT DISTINCT Category, ProductName
FROM Products
ORDER BY ProductName DESC;



-- 11) Products: TOP(10) Price DESC bo‘yicha eng qimmatlari
SELECT TOP (10) *
FROM Products
ORDER BY Price DESC;

-- 12) Employees: COALESCE — FirstName yoki LastName dan birinchi NULL bo‘lmagan qiymat
SELECT EmployeeID,
       COALESCE(FirstName, LastName) AS FirstNonNullName,
       DepartmentName,
       Salary
FROM Employees;

-- 13) Products: DISTINCT Category va Price kombinatsiyalari
SELECT DISTINCT Category, Price
FROM Products;

-- 14) Employees: (Age 30–40 orasida) YOKI DepartmentName = 'Marketing'
SELECT *
FROM Employees
WHERE (Age BETWEEN 30 AND 40)
   OR DepartmentName = 'Marketing';

-- 15) Employees: Salary DESC bo‘yicha 11–20-qatordan OFFSET-FETCH
SELECT *
FROM Employees
ORDER BY Salary DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;

-- 16) Products: Price <= 1000 va StockQuantity > 50; StockQuantity bo‘yicha o‘sish tartibida
SELECT *
FROM Products
WHERE Price <= 1000
  AND StockQuantity > 50
ORDER BY StockQuantity ASC;

-- 17) Products: ProductName ichida 'e' harfi mavjud (LIKE)
SELECT *
FROM Products
WHERE ProductName LIKE '%e%';

-- 18) Employees: DepartmentName IN ('HR','IT','Finance')
SELECT *
FROM Employees
WHERE DepartmentName IN ('HR','IT','Finance');

-- 19) Customers: ORDER BY City ASC, PostalCode DESC
SELECT *
FROM Customers
ORDER BY City ASC, PostalCode DESC;



-- 20) TOP(5) eng katta savdoga ega mahsulotlar: Sales jadvali bo‘yicha
-- Eslatma: Bu yerda mahsulot bo‘yicha umumiy savdo summasi hisoblanadi.
SELECT TOP (5)
       s.ProductID,
       p.ProductName,
       SUM(s.SaleAmount) AS TotalSales
FROM Sales AS s
JOIN Products AS p
  ON p.ProductID = s.ProductID
GROUP BY s.ProductID, p.ProductName
ORDER BY TotalSales DESC;

-- 21) Employees: FullName (faqat SELECT ichida birlashtirish)
SELECT EmployeeID,
       LTRIM(RTRIM(
         CONCAT(ISNULL(FirstName, ''),
                CASE WHEN FirstName IS NOT NULL AND LastName IS NOT NULL THEN ' ' ELSE '' END,
                ISNULL(LastName, ''))
       )) AS FullName,
       DepartmentName,
       Salary
FROM Employees;

-- 22) Products: DISTINCT Category, ProductName, Price (Price > 50)
SELECT DISTINCT Category, ProductName, Price
FROM Products
WHERE Price > 50;

-- 23) Products: Narxi o‘rtacha narxning 10%idan kichik bo‘lgan mahsulotlar
SELECT *
FROM Products
WHERE Price < 0.1 * (SELECT AVG(Price) FROM Products);

-- 24) Employees: Age < 30 VA DepartmentName IN ('HR','IT')
SELECT *
FROM Employees
WHERE Age < 30
  AND DepartmentName IN ('HR','IT');

-- 25) Customers: Email '@gmail.com' domenini o‘z ichiga olganlar (LIKE + wildcard)
SELECT *
FROM Customers
WHERE Email LIKE '%@gmail.com%';

-- 26) Employees: Salary 'Sales' bo‘limidagi barcha xodimlarga nisbatan KATTA (ALL operatori)
-- Eslatma: Agar 'Sales' bo‘limida xodim bo‘lmasa, ALL bo‘sh to‘plamga taqqoslash TRUE bo‘lishi mumkin.
SELECT *
FROM Employees
WHERE Salary > ALL (
    SELECT Salary
    FROM Employees
    WHERE DepartmentName = 'Sales'
);

-- 27) Orders: Oxirgi 180 kun ichida berilgan buyurtmalar
-- Talab: BETWEEN va jadvaldagi ENG SO‘NGGI SANA (LATEST_DATE) dan foydalanish.
-- LATEST_DATE sifatida MAX(OrderDate) olinadi.
SELECT *
FROM Orders
WHERE OrderDate BETWEEN DATEADD(DAY, -180, (SELECT MAX(OrderDate) FROM Orders))
                    AND       (SELECT MAX(OrderDate) FROM Orders);
