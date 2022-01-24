/* Subqueries ( )*/

Select EmployeeID, JobTitle, Salary
From EmployeeSalary

-- Subquery in Select

Select EmployeeID, Salary, (Select AVG(Salary) From EmployeeSalary) as AllAvgSalary
From EmployeeSalary

-- How to do it with Partition By
Select EmployeeID, Salary, AVG(Salary) over () as AllAvgSalary
From EmployeeSalary

-- Why Group By doesn't work
Select EmployeeID, Salary, AVG(Salary) as AllAvgSalary
From EmployeeSalary
Group By EmployeeID, Salary
order by EmployeeID


-- Subquery in From

Select a.EmployeeID, AllAvgSalary
From 
	(Select EmployeeID, Salary, AVG(Salary) over () as AllAvgSalary
	 From EmployeeSalary) a
Order by a.EmployeeID


-- Subquery in Where


Select EmployeeID, JobTitle, Salary
From EmployeeSalary
where EmployeeID in (
	Select EmployeeID 
	From EmployeeDemographics
	where Age > 30)



/* Common Table Expression - CTEs */

WITH CTE_Employee as 
(SELECT FirstName, LastName, Gender, Salary,
COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender,
AVG(salary) OVER (PARTITION BY Gender) as AVGsalary

FROM EmployeeDemographics de
JOIN EmployeeSalary sa
	ON de.EmployeeID = sa.EmployeeID
WHERE Salary > '45000'
)
SELECT *
FROM CTE_Employee


/* Temp Tables */
CREATE TABLE #temp_table
(EmployeeID int,
JobTittle varchar(100),
Salary int
)
SELECT *
FROM #temp_table

INSERT INTO #temp_table
SELECT *
FROM EmployeeSalary



DROP TABLE IF EXISTS #temp_table2
CREATE TABLE #temp_table2 (
Jobtitle varchar (50),
EmployeePerJob int,
AvgAge int,
AvgSalary int
)

INSERT INTO #temp_table2
SELECT Jobtitle, Count(Jobtitle), Avg(Age), Avg(Salary)
FROM EmployeeDemographics de
JOIN EmployeeSalary sa
	ON de.EmployeeID = sa.EmployeeID
group by Jobtitle

SELECT * 
FROM #temp_table2



/* String Functions - TRIM, LTRIM, RTRIM, REPLACE, SUBSTRING, UPPER,LOWER */

-- Drop Table EmployeeErrors;

CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)

Insert into EmployeeErrors Values 
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')

Select *
From EmployeeErrors

-- Using Trim, LTRIM, RTRIM

Select EmployeeID, TRIM(employeeID) AS IDTRIM
FROM EmployeeErrors 

Select EmployeeID, RTRIM(employeeID) as IDRTRIM
FROM EmployeeErrors 

Select EmployeeID, LTRIM(employeeID) as IDLTRIM
FROM EmployeeErrors 

	
-- Using Replace

Select LastName, REPLACE(LastName, '- Fired', '') as LastNameFixed
FROM EmployeeErrors


-- Using Substring

Select Substring(err.FirstName,1,3), Substring(dem.FirstName,1,3), Substring(err.LastName,1,3), Substring(dem.LastName,1,3)
FROM EmployeeErrors err
JOIN EmployeeDemographics dem
	on Substring(err.FirstName,1,3) = Substring(dem.FirstName,1,3)
	and Substring(err.LastName,1,3) = Substring(dem.LastName,1,3)

-- Using UPPER and lower

Select firstname, LOWER(firstname)
from EmployeeErrors

Select Firstname, UPPER(FirstName)
from EmployeeErrors


/* Stored Procedures */

CREATE PROCEDURE TEST
AS
Select *
FROM EmployeeDemographics 

EXEC TEST


CREATE PROCEDURE Temp_Employee
AS
DROP TABLE IF EXISTS #temp_employee
Create table #temp_employee (
JobTitle varchar(100),
EmployeesPerJob int ,
AvgAge int,
AvgSalary int
)


Insert into #temp_employee
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
FROM SQLTutorial..EmployeeDemographics emp
JOIN SQLTutorial..EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
group by JobTitle

Select * 
From #temp_employee
GO;
