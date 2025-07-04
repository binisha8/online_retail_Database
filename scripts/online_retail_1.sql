--Create  the database 
CREATE DATABASE OnlineRetailDB;
GO


--Use the database
USE OnlineRetailDB;
GO

--Create Customer Table
CREATE TABLE Customers(
CustomerID INT PRIMARY KEY IDENTITY(1,1),
FirstName NVARCHAR(50),
LastName NVARCHAR(50),
Email NVARCHAR(100),
Phone NVARCHAR(50),
Address NVARCHAR(255),
City NVARCHAR(50),
State NVARCHAR(50),
ZipCode NVARCHAR(50),
Coumtry NVARCHAR(50),
CreateDate DATETIME DEFAULT GETDATE()
);

-- Create the Products table
CREATE TABLE Products (
	ProductID INT PRIMARY KEY IDENTITY(1,1),
	ProductName NVARCHAR(100),
	CategoryID INT,
	Price DECIMAL(10,2),
	Stock INT,
	CreatedAt DATETIME DEFAULT GETDATE()
);


--Create Category Table
CREATE TABLE Categories(

	CategoryID INT PRIMARY KEY IDENTITY(1,1),
	CategoryName NVARCHAR(100),
	Description NVARCHAR (255)
	
);


--Create Order table
CREATE TABLE Orders(
	OrderID INT PRIMARY KEY IDENTITY(1,1),
	CustomerID INT,
	OrderDate DATETIME DEFAULT GETDATE(),
	TotalAmount DECIMAL(10,2),
	FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) 

);

-- Create the OrderItems Table
CREATE TABLE OrderItems(
	OrderItemID INT PRIMARY KEY IDENTITY(1,1),
	OrderID INT,
	ProductID INT,
	Quantity INT,
	Price DECIMAL(10,2),
	FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
	FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
	);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               


--If we want to Alter/Rename the Column Name 
EXEC sp_rename 'OnlineRetailDB.dbo.Customers.Coumtry', 'Country', 'COLUMN'; 


--Insert data into Categories Table
INSERT INTO Categories(CategoryName,Description)
VALUES
('Electronics','Devices and Gadets'),
('Clothing ','Apparel and Accessories'),
('Books','Printed and Electronics Books');

--Insert data into Products table
INSERT INTO Products(ProductName,CategoryID,Price,Stock)
VALUES
('Smartphone', 1, 699.99, 50),
('Laptop', 1, 999.99, 30),
('T-shirt', 2, 19.99, 100),
('Jeans', 2, 49.99, 60),
('Fiction Novel', 3, 14.99, 200),
('Science Journal', 3, 29.99, 150);

--Insert into Customers table
INSERT INTO Customers(FirstName,LastName,Email,Phone,Address,City,State,ZipCode,Country)
VALUES
	('Sameer', 'Khanna', 'sameer.khanna@example.com', '123-456-7890', '123 Elm St.', 'Springfield','IL', '62701', 'USA'),
	('Jane', 'Smith', 'jane.smith@example.com', '234-567-8901', '456 Oak St.', 'Madison','WI', '53703', 'USA'),
	('harshad', 'patel', 'harshad.patel@example.com', '345-678-9012', '789 Dalal St.', 'Mumbai', 'Maharashtra', '41520', 'INDIA');

--INSERT DATA INTO ORDER TABLE
INSERT INTO Orders( CustomerID,OrderDate,TotalAmount)
VALUES
    (1, GETDATE(), 719.98),
	(2, GETDATE(), 49.99),
	(3, GETDATE(), 44.98);


--Insert data into OrderItems
INSERT INTO OrderItems(OrderID,ProductID,Quantity,Price)
VALUES
	(1, 1, 1, 699.99),
	(1, 3, 1, 19.99),
	(2, 4, 1,  49.99),
	(3, 5, 1, 14.99),
	(3, 6, 1, 29.99);


--Retrive all orders for a specific Customers
SELECT o.OrderID,o.OrderDate,o.TotalAmount,oi.ProductID,p.ProductName,oi.Quantity,oi.Price
FROM Orders o
JOIN OrderItems oi ON o.OrderID=oi.OrderItemID
JOIN Products p ON oi.ProductID=p.ProductID
WHERE o.CustomerID=1;


--Find the total sales for each product
SELECT p.ProductID,p.ProductName,SUM(oi.Quantity*oi.Price) as TotalSales
FROM OrderItems oi
JOIN Products p ON oi.ProductID=p.ProductID
GROUP BY p.ProductID,p.ProductName
ORDER BY TotalSales DESC;


--Calculate the average order value
SELECT AVG(TotalAmount) AS AverageOrder_Value
FROM 
	Orders







































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































              
