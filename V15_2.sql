SELECT Name, GroupName FROM HumanResources.Department WHERE GroupName = 'Research and Development'

SELECT MIN(SickLeaveHours) AS MinSickLeaveHours FROM HumanResources.Employee

SELECT DISTINCT top 10 JobTitle, 
CASE WHEN PATINDEX('% %', JobTitle) != ' ' THEN 
    SUBSTRING(JobTitle, 1, PATINDEX('% %', JobTitle))
ELSE 
	JobTitle
END
	AS FirstWord FROM HumanResources.Employee ORDER BY JobTitle