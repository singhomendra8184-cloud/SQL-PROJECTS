CREATE PROCEDURE GetRestaurantsWithBooking
AS
BEGIN
    SELECT RestaurantName, RestaurantType, CuisinesType
    FROM Jomato
    WHERE TableBooking != 0;
END;

EXEC GetRestaurantsWithBooking;




BEGIN TRANSACTION;

UPDATE Jomato
SET CuisinesType = 'Cafeteria'
WHERE CuisinesType = 'Cafe';

SELECT * FROM Jomato WHERE CuisinesType = 'Cafeteria';

ROLLBACK;

SELECT * FROM Jomato WHERE CuisinesType = 'Cafe';



WITH RankedAreas AS (
    SELECT Area,
           Rating,
           ROW_NUMBER() OVER (PARTITION BY Area ORDER BY Rating DESC) AS RowNum
    FROM Jomato
)
SELECT TOP 5 Area, Rating
FROM RankedAreas
WHERE RowNum = 1
ORDER BY Rating DESC;




DECLARE @i INT = 1;

WHILE @i <= 50
BEGIN
    PRINT @i;
    SET @i = @i + 1;
END;



CREATE VIEW TopRatingRestaurants AS
SELECT TOP 5 RestaurantName, Area, Rating
FROM Jomato
ORDER BY Rating DESC;

SELECT * FROM TopRatingRestaurants;




CREATE TRIGGER trg_NewRestaurantInsert
ON Jomato
AFTER INSERT
AS
BEGIN
    PRINT 'A new restaurant record has been inserted into Jomato!';
END;


CREATE TRIGGER trg_NewRestaurantInsert
ON Jomato
AFTER INSERT
AS
BEGIN
    PRINT 'A new restaurant record has been inserted into Jomato!';
END;

INSERT INTO Jomato (RestaurantName, RestaurantType, CuisinesType, TableBooking, Area, Rating)
VALUES ('Test Restaurant', 'Quick Bites', 'Indian', 1, 'Connaught Place', 4.5);





ALTER TABLE Jomato
ALTER COLUMN LocalAddress nvarchar(2000) NULL;
    

    select * from dbo.Jomato;