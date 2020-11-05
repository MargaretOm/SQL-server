USE AdventureWorks2012;
GO

DROP PROCEDURE dbo.OrderCountByShipping;
GO

CREATE PROCEDURE dbo.OrderCountByShipping(@ShipMethodNames NVARCHAR(300)) AS
	DECLARE @Query AS NVARCHAR(900);
	SET @Query = '
SELECT EmployeeID, ' + @ShipMethodNames + '
FROM (
	SELECT EmployeeID, PurchaseOrderID, Name FROM Purchasing.PurchaseOrderHeader POH
	JOIN Purchasing.ShipMethod SH 
	ON POH.ShipMethodID = SH.ShipMethodID
) AS pol
PIVOT (COUNT(PurchaseOrderID) FOR pol.Name IN(' + @ShipMethodNames + ')) AS pvt'
    EXECUTE sp_executesql @Query
GO
	
EXECUTE dbo.OrderCountByShipping '[CARGO TRANSPORT 5],[OVERNIGHT J-FAST],[OVERSEAS - DELUXE]'
GO
