USE AdventureWorks2012;

ALTER TABLE dbo.Employee
ADD EmpNum int;

DECLARE @EmpTablVar TABLE (BusinessEntityID INT NOT NULL, NationalIDNumber NVARCHAR(15) NOT NULL, LoginID NVARCHAR(256) NOT NULL,
JobTitle  NVARCHAR(50) NOT NULL, BirthDate  DATE NOT NULL, MaritalStatus NCHAR(1) NOT NULL, Gender NCHAR(1) NOT NULL,
HireDate DATE NOT NULL, VacationHours SMALLINT NOT NULL, SickLeaveHours SMALLINT NOT NULL, ModifiedDate DATE, EmpNum INT)

INSERT INTO @EmpTablVar 
(BusinessEntityID, NationalIDNumber, LoginID, JobTitle, BirthDate, MaritalStatus, Gender, 
HireDate, VacationHours, SickLeaveHours, ModifiedDate, EmpNum)
SELECT 
e.BusinessEntityID, e.NationalIDNumber, e.LoginID, e.JobTitle, e.BirthDate, e.MaritalStatus, e.Gender, 
e.HireDate, hre.VacationHours, e.SickLeaveHours, e.ModifiedDate, ROW_NUMBER() OVER(ORDER BY e.BusinessEntityID)
FROM dbo.Employee e
JOIN HumanResources.Employee hre ON hre.BusinessEntityID = e.BusinessEntityID;

UPDATE dbo.Employee 
SET 
	VacationHours = CASE WHEN etv.VacationHours > 0 
	THEN etv.VacationHours END,
	EmpNum = etv.EmpNum 
FROM dbo.Employee e 
JOIN @EmpTablVar etv ON etv.BusinessEntityID = e.BusinessEntityID;

select e.* from dbo.Employee e
JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID 
WHERE p.EmailPromotion = 0;

DELETE dbo.Employee FROM dbo.Employee e
JOIN Person.Person p on p.BusinessEntityID = e.BusinessEntityID
 WHERE p.EmailPromotion = 0;

SELECT *
FROM AdventureWorks2012.INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE
WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'Employee';

SELECT default_constraints.*
FROM sys.all_columns
INNER JOIN sys.tables ON all_columns.object_id = tables.object_id
INNER JOIN sys.schemas ON tables.schema_id = schemas.schema_id
INNER JOIN sys.default_constraints ON all_columns.default_object_id = default_constraints.object_id
WHERE  schemas.name = 'dbo' AND tables.name = 'Employee';

ALTER TABLE dbo.Employee DROP COLUMN EmpNum;
ALTER TABLE dbo.Employee DROP CONSTRAINT UC_NationalIDNumber, chk_vacation_hours_mb_positive, DF_VacationHours;








DROP TABLE dbo.Employee;

