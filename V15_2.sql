USE AdventureWorks2012;

ALTER TABLE dbo.Employee
ADD SumTotal MONEY,
	SumTaxAmt MONEY,
	WithoutTax AS (SumTaxAmt - SumTotal);

SELECT e.BusinessEntityID, e.NationalIDNumber, e.LoginID,
e.JobTitle, e.BirthDate, e.MaritalStatus, e.Gender, e.HireDate,
e.VacationHours, e.SickLeaveHours, e.ModifiedDate, e.SumTotal, e.SumTaxAmt
INTO #Employee   
FROM dbo.Employee e
WHERE 1 = 0 

INSERT INTO #Employee 
	(BusinessEntityID, NationalIDNumber, LoginID, JobTitle, BirthDate, MaritalStatus, 
	Gender, HireDate, VacationHours, SickLeaveHours, ModifiedDate, SumTotal, SumTaxAmt)
SELECT e.BusinessEntityID, e.NationalIDNumber, e.LoginID, e.JobTitle, e.BirthDate, e.MaritalStatus, 
	e.Gender, e.HireDate, e.VacationHours, e.SickLeaveHours, e.ModifiedDate, e.SumTotal, e.SumTaxAmt 
FROM dbo.Employee e


UPDATE #Employee
SET #Employee.SumTotal = f.sum1, #Employee.SumTaxAmt = f.sum2
FROM #Employee
INNER JOIN
(
  SELECT EmployeeID, SUM(TotalDue) sum1, SUM(TaxAmt) sum2
  FROM Purchasing.PurchaseOrderHeader
  GROUP BY EmployeeID 
) f ON #Employee.BusinessEntityID = f.EmployeeID
SELECT SumTaxAmt, SumTotal FROM #Employee;

SELECT * FROM dbo.Employee WHERE MaritalStatus = 'S';
DELETE FROM dbo.Employee WHERE MaritalStatus = 'S';
SELECT * FROM dbo.Employee WHERE MaritalStatus = 'S';
