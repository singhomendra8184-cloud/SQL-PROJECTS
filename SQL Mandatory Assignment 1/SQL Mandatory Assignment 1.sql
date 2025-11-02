/**create database intellipat;
use intellipat;
CREATE TABLE Salesman (
SalesmanId INT,
Name VARCHAR(255),
Commission DECIMAL(10, 2),
City VARCHAR(255),
Age INT
);

INSERT INTO Salesman (SalesmanId, Name, Commission, City, Age)
VALUES
(101, 'Joe', 50, 'California', 17),
(102, 'Simon', 75, 'Texas', 25),
(103, 'Jessie', 105, 'Florida', 35),
(104, 'Danny', 100, 'Texas', 22),
(105, 'Lia', 65, 'New Jersey', 30);

CREATE TABLE Customer (
SalesmanId INT,
CustomerId INT,
CustomerName VARCHAR(255),
PurchaseAmount INT,
);

INSERT INTO Customer (SalesmanId, CustomerId, CustomerName, PurchaseAmount)
VALUES
(101, 2345, 'Andrew', 550),
(103, 1575, 'Lucky', 4500),
(104, 2345, 'Andrew', 4000),
(107, 3747, 'Remona', 2700),
(110, 4004, 'Julia', 4545);

CREATE TABLE Orders (OrderId int, CustomerId int, SalesmanId int, Orderdate Date, Amount
money);

INSERT INTO Orders Values
(5001,2345,101,'2021-07-01',550),
(5003,1234,105,'2022-02-15',1500);
**/
 
select * from dbo.Customer
select * from dbo.Orders
select * from dbo.Salesman;


-- Q1: Insert a new record in your Orders table
INSERT INTO Orders Values
(5002,1575,103,'2021-07-01',500);

-- Q2 : 
-- 1. Add Primary key constraint for SalesmanId column in Salesman table. 

ALTER TABLE Salesman                     
ALTER COLUMN SalesmanId INT NOT NULL;  - 
ALTER TABLE Salesman                                              
ADD CONSTRAINT PK_Salesman_SalesmanId PRIMARY KEY (SalesmanId);   

-- 2. Add default constraint for City column in Salesman table. 
ALTER TABLE Salesman
ADD CONSTRAINT DF_Salesman_City DEFAULT 'Unknown' FOR City;


-- 3. Add Foreign key constraint for SalesmanIdcolumn in Customer table. 
DELETE FROM Customer
WHERE SalesmanId NOT IN (SELECT SalesmanId FROM Salesman);  
ALTER TABLE Customer                                        
ADD CONSTRAINT FK_Customer_Salesman                             
FOREIGN KEY (SalesmanId) REFERENCES dbo.Salesman(SalesmanId);   

-- 4. Add not null constraint in Customer_name column for the Customer table.
SELECT * FROM Customer
WHERE CustomerName IS NULL;

ALTER TABLE Customer
ALTER COLUMN CustomerName VARCHAR(255) NOT NULL;

-- Q3 : Fetch the data where the Customer’s name is ending with ‘N’ also get the purchase
-- amount value greater than 500.
SELECT *
FROM Customer
WHERE CustomerName LIKE '%N'
  AND PurchaseAmount > 500;

-- Q4 :  Using SET operators, retrieve the first result with unique SalesmanId values from two
-- tables, and the other result containing SalesmanId with duplicates from two tables.

SELECT SalesmanId FROM Salesman
UNION
SELECT SalesmanId FROM Customer;

SELECT SalesmanId FROM Salesman
INTERSECT
SELECT SalesmanId FROM Customer;

-- Q5 : Display the below columns which has the matching data.
-- Orderdate, Salesman Name, Customer Name, Commission, and City which has the
-- range of Purchase Amount between 500 to 1500.
SELECT 
    s.Name AS SalesmanName,
    c.CustomerName,
    s.Commission,
    s.City,
    c.PurchaseAmount
FROM Customer c
JOIN Salesman s ON c.SalesmanId = s.SalesmanId
WHERE c.PurchaseAmount BETWEEN 500 AND 1500;


-- Q6 : Using right join fetch all the results from Salesman and Orders table

SELECT s.*, o.*
FROM Orders o
RIGHT JOIN Salesman s ON o.SalesmanId = s.SalesmanId;
