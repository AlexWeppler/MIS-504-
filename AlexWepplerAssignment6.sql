-- Alex Weppler
-- Assignment 6

--1. Show the category IDs and names of categories with products ([INNER] JOIN, DISTINCT) (8 records).

SELECT  Distinct Categories.CategoryID,
       Categories.CategoryName
FROM Categories
JOIN Products ON products.CategoryID = categories.CategoryID
ORDER BY CategoryID ASC

--2. Show the category IDs, names of categories, and product names for categories with products. Only include discontinued products with non-zero units in stock. Order by categories' categoryID ([INNER] JOIN)  (4 records).

SELECT Categories.CategoryID,
       Categories.CategoryName,
       Products.ProductName
FROM Products 
JOIN Categories ON products.CategoryID = categories.CategoryID 
WHERE products.discontinued= 1 
AND products.UnitsInStock > 0
ORDER BY CategoryID 

--3. We need a report that tells us everything we need to place an order. This should be only non-discontinued products whose (unitsInstock + unitsOnOrder) is less than or equal to the Reorderlevel. As the final column, it should show how many to order. We usually order twice the reorderlevel. Columns should be CategoryID, CategoryName, productID, productName, and amount to order. Order by CategoryID ([INNER] JOIN) (2 records).

SELECT c.CategoryID,
       c.CategoryName,
       p.ProductID,
       p.ProductName,
       p.reorderlevel * 2 AS [To Order]
FROM Categories c 
JOIN Products p ON c.CategoryID = p.CategoryID 
WHERE p.discontinued = 0
AND reorderlevel >= (p.unitsinstock + p.unitsonorder)
ORDER BY CategoryID

--4. Do # 4 again, but also add the cost, which will be the order amount multiplied by the unit price (2 records).

SELECT c.CategoryID,
       c.CategoryName,
       p.ProductID,
       p.ProductName,
       p.reorderlevel * 2 AS [To Order],
       (p.reorderlevel * 2) * unitprice AS [Cost]
FROM Categories c 
JOIN Products p ON c.CategoryID = p.CategoryID 
WHERE p.discontinued = 0
AND reorderlevel >= (p.unitsinstock + p.unitsonorder)
ORDER BY CategoryID

--5. Show the category IDs and names of categories. Include categories even if they don't have any products in them (LEFT [OUTER] JOIN, DISTINCT) (10 records).

SELECT  Distinct Categories.CategoryID,
       Categories.CategoryName
FROM Categories LEFT OUTER JOIN Products 
    ON products.CategoryID = categories.CategoryID
ORDER BY CategoryID ASC

--6. Show the category IDs and names of categories that do not have products in them. (LEFT  [OUTER]  JOIN, WHERE IS NULL) (2 records).
SELECT  Distinct Categories.CategoryID,
       Categories.CategoryName
FROM Categories LEFT OUTER JOIN Products 
    ON products.CategoryID = categories.CategoryID
WHERE Categories.Description IS NULL
ORDER BY CategoryID ASC
