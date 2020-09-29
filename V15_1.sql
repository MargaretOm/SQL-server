USE AdventureWorks2012;
GO

SELECT DISTINCT HumanResources.Employee.BusinessEntityID, HumanResources.Employee.JobTitle, HumanResources.Shift.Name, HumanResources.Shift.StartTime, HumanResources.Shift.EndTime FROM HumanResources.Employee
INNER JOIN HumanResources.EmployeeDepartmentHistory ON HumanResources.EmployeeDepartmentHistory.BusinessEntityID = HumanResources.Employee.BusinessEntityID
INNER JOIN HumanResources.Shift ON HumanResources.Shift.ShiftID = HumanResources.EmployeeDepartmentHistory.ShiftID;
GO

SELECT EmpGroup.GroupName, COUNT(*) as EmpCount 
FROM (
	SELECT DISTINCT HumanResources.Employee.BusinessEntityID, HumanResources.Department.GroupName
	FROM HumanResources.Department
	INNER JOIN HumanResources.EmployeeDepartmentHistory ON HumanResources.EmployeeDepartmentHistory.DepartmentID = HumanResources.Department.DepartmentID
	INNER JOIN HumanResources.Employee ON HumanResources.Employee.BusinessEntityID = HumanResources.EmployeeDepartmentHistory.BusinessEntityID
	WHERE HumanResources.EmployeeDepartmentHistory.EndDate IS NULL
	) as EmpGroup
GROUP BY EmpGroup.GroupName
GO


WITH EmpGroup AS (
	SELECT DISTINCT HumanResources.Employee.BusinessEntityID, HumanResources.Department.GroupName
	FROM HumanResources.Department
	INNER JOIN HumanResources.EmployeeDepartmentHistory ON HumanResources.EmployeeDepartmentHistory.DepartmentID = HumanResources.Department.DepartmentID
	INNER JOIN HumanResources.Employee ON HumanResources.Employee.BusinessEntityID = HumanResources.EmployeeDepartmentHistory.BusinessEntityID
	WHERE HumanResources.EmployeeDepartmentHistory.EndDate IS NULL
	)
SELECT EmpGroup.GroupName, COUNT(*) as EmpCount
FROM EmpGroup
GROUP BY EmpGroup.GroupName
GO

WITH 
EmpInfo AS (
	SELECT DISTINCT HumanResources.Department.Name as departmentName, HumanResources.Employee.BusinessEntityID, HumanResources.EmployeePayHistory.Rate
	FROM HumanResources.Employee
	INNER JOIN HumanResources.EmployeeDepartmentHistory ON HumanResources.EmployeeDepartmentHistory.BusinessEntityID = HumanResources.Employee.BusinessEntityID
	INNER JOIN HumanResources.Department ON HumanResources.Department.DepartmentID = HumanResources.EmployeeDepartmentHistory.DepartmentID
	INNER JOIN HumanResources.EmployeePayHistory ON HumanResources.EmployeePayHistory.BusinessEntityID = HumanResources.Employee.BusinessEntityID
	),
RateGroups AS (
	SELECT EmpInfo.departmentName, MAX(EmpInfo.Rate) as maxRate
	FROM EmpInfo
	GROUP BY EmpInfo.departmentName
)
SELECT EmpInfo.departmentName, EmpInfo.BusinessEntityID, EmpInfo.Rate, maxRate
FROM EmpInfo
INNER JOIN RateGroups ON RateGroups.departmentName = EmpInfo.departmentName
ORDER BY RateGroups.departmentName
