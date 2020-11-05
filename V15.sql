USE AdventureWorks2012;
GO

DECLARE @xml XML;

SET @xml = (SELECT LocationID '@ID', Name '@Name', CostRate '@Cost'
			FROM Production.Location
			FOR XML
				PATH ('Location'),
				ROOT ('Locations')
			);

SELECT @xml;


DROP TABLE dbo.#xml;

CREATE TABLE dbo.#xml
(
    LocationID INT,
	Name nvarchar(50),
	CostRate smallmoney
);

INSERT INTO dbo.#xml
SELECT
   x.Location.value('@ID', 'INT') as LocationID,
   x.Location.value('@Name', 'VARCHAR(50)') as Name,
   x.Location.value('@Cost', 'smallmoney') as CostRate
FROM @xml.nodes('Locations/Location') AS x (Location)

SELECT * FROM dbo.#xml;
