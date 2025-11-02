create database CaseStudy;

-- Q1: 
SELECT COUNT(DISTINCT State) AS NumOfStates
FROM LocationTable;


SELECT COUNT(*) AS RegularProducts
FROM ProductTable
WHERE Type = 'Regular';


SELECT SUM(Marketing) AS MarketingSpent
FROM FactTable
WHERE ProductID = 1;

SELECT MIN(Sales) AS MinSales
FROM FactTable;

SELECT MAX(COGS) AS MaxCOGS
FROM FactTable;


SELECT *
FROM ProductTable
WHERE Product_Type = 'Coffee';


SELECT *
FROM FactTable
WHERE Total_Expenses > 40;



SELECT AVG(Sales) AS AvgSales
FROM FactTable
WHERE Area_Code = 719;


SELECT SUM(F.Profit) AS TotalProfit
FROM FactTable F
JOIN LocationTable L ON F.Area_Code = L.Area_Code
WHERE L.State = 'Colorado';



SELECT ProductID, AVG(Inventory) AS AvgInventory
FROM FactTable
GROUP BY ProductID;


SELECT DISTINCT State
FROM LocationTable
ORDER BY State;



SELECT ProductID, AVG(Budget_Sales) AS AvgBudgetSales
FROM FactTable
GROUP BY ProductID
HAVING AVG(Budget_Margin) > 100;



SELECT SUM(Sales) AS TotalSales
FROM FactTable
WHERE Date = '2010-01-01';


SELECT Date, ProductID, AVG(Total_Expenses) AS AvgTotalExpense
FROM FactTable
GROUP BY Date, ProductID;


SELECT F.Date, F.ProductID, P.Product_Type, P.Product, F.Sales, F.Profit, L.State, F.Area_Code
FROM FactTable F
JOIN ProductTable P ON F.ProductID = P.ProductID
JOIN LocationTable L ON F.Area_Code = L.Area_Code;



SELECT F.Date, F.ProductID, F.Sales,
       DENSE_RANK() OVER (ORDER BY F.Sales DESC) AS SalesRank
FROM FactTable F;



SELECT L.State, SUM(F.Profit) AS TotalProfit, SUM(F.Sales) AS TotalSales
FROM FactTable F
JOIN LocationTable L ON F.Area_Code = L.Area_Code
GROUP BY L.State;




SELECT L.State, P.Product, SUM(F.Profit) AS TotalProfit, SUM(F.Sales) AS TotalSales
FROM FactTable F
JOIN LocationTable L ON F.Area_Code = L.Area_Code
JOIN ProductTable P ON F.ProductID = P.ProductID
GROUP BY L.State, P.Product;



SELECT ProductID, Sales, Sales * 1.05 AS IncreasedSales
FROM FactTable;




SELECT TOP 1 F.ProductID, P.Product_Type, F.Profit
FROM FactTable F
JOIN ProductTable P ON F.ProductID = P.ProductID
ORDER BY F.Profit DESC;


CREATE PROCEDURE GetProductsByType
    @Type VARCHAR(50)
AS
BEGIN
    SELECT *
    FROM ProductTable
    WHERE Product_Type = @Type;
END;


SELECT *, 
       CASE 
           WHEN Total_Expenses < 60 THEN 'Profit'
           ELSE 'Loss'
       END AS Status
FROM FactTable;



SELECT DATEPART(WEEK, Date) AS WeekNum, ProductID, SUM(Sales) AS TotalSales
FROM FactTable
GROUP BY ROLLUP(DATEPART(WEEK, Date), ProductID);


SELECT Area_Code FROM FactTable
UNION
SELECT Area_Code FROM LocationTable;

SELECT Area_Code FROM FactTable
INTERSECT
SELECT Area_Code FROM LocationTable;



CREATE FUNCTION GetProductByType(@Type VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM ProductTable
    WHERE Product_Type = @Type
);


BEGIN TRANSACTION;

UPDATE ProductTable
SET Product_Type = 'Tea'
WHERE ProductID = 1;
ROLLBACK;


SELECT Date, ProductID, Sales
FROM FactTable
WHERE Total_Expenses BETWEEN 100 AND 200;


DELETE FROM ProductTable
WHERE Type = 'Regular';


SELECT Product, ASCII(SUBSTRING(Product, 5, 1)) AS FifthCharASCII
FROM ProductTable;


