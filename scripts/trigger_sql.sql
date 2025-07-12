-- Create the Changelog table
CREATE TABLE Changelog (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    TableName NVARCHAR(50),
    Operation NVARCHAR(10),
    RecordID INT,
    ChangeDate DATETIME DEFAULT GETDATE(),
    ChangeBy NVARCHAR(100)
);
GO

-- Create trigger for INSERT on Products table
CREATE TRIGGER trg_Insert_Product 
ON Products
AFTER INSERT
AS 
BEGIN 
    INSERT INTO Changelog (TableName, Operation, RecordID, ChangeBy)
    SELECT 
        'Products',              -- TableName
        'INSERT',                -- Operation
        inserted.ProductID,      -- RecordID
        SYSTEM_USER              -- ChangeBy
    FROM inserted;

	--Display a message indicating that a trigger has fired.
	PRINT 'INSERT operation logged for Products table.';
END;
GO


--Try to insert one record into the product
INSERT INTO Products(ProductName,CategoryID,Price,Stock)
VALUES ('Mouse',1,4.99,20);

INSERT INTO Products(ProductName,CategoryID,Price,Stock)
VALUES ('Batman Multiverse COmic',3,2.50,150);

--Display product table
SELECT * FROM Products;

--Display ChangeLog table
SELECT * FROM Changelog;

--Trigger for UPDATE on Products table
CREATE OR ALTER TRIGGER trg_Update_Product
ON Products
AFTER UPDATE 
AS BEGIN
	--Update a record into the ChangeLog Table
	INSERT INTO Changelog(TableName,Operation,RecordID,ChangeBy)
	SELECT 'Products','UPDATE',inserted.ProductID,SYSTEM_USER
	FROM inserted;

	--Display a message indicating that the triggrt has fired
	PRINT 'UPDATE operation logged for Products table.';
END;
GO

--Try to update any record from Product table
UPDATE Products SET Price=550 WHERE ProductID=2

UPDATE Products SET Price=750 WHERE ProductID=7


SELECT * FROM Products 


--Trigger for DELETE a record from Product Tabale
CREATE OR ALTER TRIGGER trg_delete_Products
ON Products
AFTER UPDATE
AS 
BEGIN

	--INSERT A RECORD INTO THE CHANGING TABLE 
	INSERT INTO ChangeLog(TableName,Operation,RecordID,ChangeBy)
	SELECT 'Products','UPDATE',inserted.ProductID,SYSTEM_USER
	FROM inserted;

	--Display a mesage indicating thatthe trigger has failed
	PRINT 'DELETE operation logged for Products table.';
END;
GO

