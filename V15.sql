USE AdventureWorks2012;
GO

IF OBJECT_ID (N'Production.GetSumOfPriceByModelID') IS NOT NULL  
    DROP FUNCTION Production.GetSumOfPriceByModelID;  
GO  
CREATE FUNCTION Production.GetSumOfPriceByModelID(@id_model INT)
RETURNS MONEY AS
BEGIN
	DECLARE @sum_of_price MONEY;
	SELECT @sum_of_price = SUM(p.ListPrice) FROM Production.Product p WHERE p.ProductModelID = @id_model;
	IF (@sum_of_price IS NULL) SET @sum_of_price = 0;
	RETURN @sum_of_price;
END;
GO

DECLARE @result MONEY;
SElECT @result =  Production.GetSumOfPriceByModelID(1);
PRINT @result;
GO

SELECT p.ListPrice FROM Production.Product p WHERE p.ProductModelID = 1;
GO







IF OBJECT_ID (N'Sales.GetLastTwoOrdersBYCustomerID') IS NOT NULL  
    DROP FUNCTION Sales.GetLastTwoOrdersBYCustomerID;  
GO

CREATE FUNCTION Sales.GetLastTwoOrdersBYCustomerID(@id_customer INT)
RETURNS TABLE AS RETURN (SELECT TOP(2) * FROM Sales.SalesOrderHeader s WHERE s.CustomerID = @id_customer);
GO

SELECT * FROM Sales.GetLastTwoOrdersBYCustomerID(30084);
GO

SELECT * FROM Sales.SalesOrderHeader s WHERE s.CustomerID = 30084;
GO
SELECT TOP(2) * FROM Sales.SalesOrderHeader s WHERE s.CustomerID = 30084;
GO



SELECT x.* FROM Sales.Customer c CROSS APPLY (SELECT * FROM Sales.GetLastTwoOrdersBYCustomerID(c.CustomerID)) x;
GO

SELECT x.* FROM Sales.Customer c OUTER APPLY (SELECT * FROM Sales.GetLastTwoOrdersBYCustomerID(c.CustomerID)) x;
GO







IF OBJECT_ID (N'Sales.GetLastTwoOrdersBYCustomerID') IS NOT NULL  
    DROP FUNCTION Sales.GetLastTwoOrdersBYCustomerID;  
GO 
CREATE FUNCTION Sales.GetLastTwoOrdersBYCustomerID(@CustomerID INT)
RETURNS @ret TABLE([SalesOrderID] [int] NOT NULL,
	[RevisionNumber] [tinyint] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[DueDate] [datetime] NOT NULL,
	[ShipDate] [datetime] NULL,
	[Status] [tinyint] NOT NULL,
	[OnlineOrderFlag] [dbo].[Flag] NOT NULL,
	[SalesOrderNumber] [nvarchar](23),
	[PurchaseOrderNumber] [dbo].[OrderNumber] NULL,
	[AccountNumber] [dbo].[AccountNumber] NULL,
	[CustomerID] [int] NOT NULL,
	[SalesPersonID] [int] NULL,
	[TerritoryID] [int] NULL,
	[BillToAddressID] [int] NOT NULL,
	[ShipToAddressID] [int] NOT NULL,
	[ShipMethodID] [int] NOT NULL,
	[CreditCardID] [int] NULL,
	[CreditCardApprovalCode] [varchar](15) NULL,
	[CurrencyRateID] [int] NULL,
	[SubTotal] [money] NOT NULL ,
	[TaxAmt] [money] NOT NULL,
	[Freight] [money] NOT NULL,
	[TotalDue] INT NOT NULL,
	[Comment] [nvarchar](128) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL ) AS BEGIN
	INSERT INTO @ret
	SELECT TOP(2) *
	FROM Sales.SalesOrderHeader AS s
	WHERE s.CustomerID = @CustomerID
	ORDER BY s.OrderDate DESC
	RETURN;
END;
GO