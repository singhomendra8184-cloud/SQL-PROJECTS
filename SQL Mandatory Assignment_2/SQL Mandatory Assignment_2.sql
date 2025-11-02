CREATE FUNCTION dbo.AddChickenToQuickBites(@input NVARCHAR(100))
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @result NVARCHAR(100);

    IF @input = 'Quick Bites'
        SET @result = 'Quick Chicken Bites';
    ELSE
        SET @result = @input;

    RETURN @result;
END;
GO


SELECT TOP 1 
    RestaurantName,
    CuisinesType,
    dbo.AddChickenToQuickBites(RestaurantType) AS UpdatedRestaurantType,
    Rating
FROM Restaurants
ORDER BY Rating DESC;


SELECT 
    RestaurantName,
    Rating,
    CASE 
        WHEN Rating > 4 THEN 'Excellent'
        WHEN Rating > 3.5 AND Rating <= 4 THEN 'Good'
        WHEN Rating > 3 AND Rating <= 3.5 THEN 'Average'
        ELSE 'Bad'
    END AS RatingStatus
FROM Restaurants;


SELECT 
    RestaurantName,
    Rating,
    CEILING(Rating) AS CeilValue,
    FLOOR(Rating) AS FloorValue,
    ABS(Rating) AS AbsoluteValue,
    GETDATE() AS CurrentDate,
    YEAR(GETDATE()) AS Year,
    DATENAME(MONTH, GETDATE()) AS MonthName,
    DAY(GETDATE()) AS Day
FROM Restaurants;


SELECT 
    ISNULL(RestaurantType, 'TOTAL') AS RestaurantType,
    SUM(AverageCost) AS TotalAverageCost
FROM Restaurants
GROUP BY ROLLUP(RestaurantType);



