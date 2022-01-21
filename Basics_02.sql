
Insert into EmployeeDemographics VALUES
(1011, 'Ryan', 'Howard', 26, 'Male'),
(NULL, 'Holly','Flax', NULL, 'Male'),
(1013, 'Darryl', 'Philbin', NULL, 'Male')

Insert into EmployeeSalary VALUES
(1010, NULL, 47000),
(NULL, 'Salesman', 43000)



/* Aliasing - renaming the column /table by adding AS After it  */

SELECT FirstName + ' ' + LastName As FullName
FROM EmployeeDemographics

-- Aliasing on aggregate fuctions
SELECT AVG(Age) As AvgAge
FROM EmployeeDemographics



 /*Joins (INNER,FULL,LEFT,RIGHT) */ 

SELECT * 
FROM EmployeeDemographics de 
FULL JOIN EmployeeSalary sa
	ON de.EmployeeID = sa.EmployeeID

SELECT * 
FROM EmployeeDemographics de
INNER JOIN EmployeeSalary sa
	ON de.EmployeeID = sa.EmployeeID

-- Highest Paid Employees Exept Reginal Manager (Michael)
SELECT de.EmployeeID,FirstName,LastName,Salary
FROM EmployeeDemographics de
INNER JOIN EmployeeSalary sa
	ON de.EmployeeID = sa.EmployeeID
WHERE FirstName <> 'Michael'
ORDER BY SALARY DESC

-- Average Salary of a salesman
SELECT Jobtitle,AVG(Salary) as Avg_sal
FROM EmployeeDemographics de
INNER JOIN EmployeeSalary sa
	ON de.EmployeeID = sa.EmployeeID
WHERE Jobtitle = 'Salesman'
Group by Jobtitle



/*
Creating a new tabel WareHouseEmployeeDemographics & adding values to it 

Create Table WareHouseEmployeeDemographics 
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
)

Insert into WareHouseEmployeeDemographics VALUES
(1013, 'Darryl', 'Philbin', NULL, 'Male'),
(1050, 'Roy', 'Anderson', 31, 'Male'),
(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
(1052, 'Val', 'Johnson', 31, 'Female')
*/

/*Union,Union All (UNION removes Duplicate values While UNION ALL includes everthing )*/

SELECT *
FROM EmployeeDemographics
UNION 
SELECT *
FROM WareHouseEmployeeDemographics

SELECT *
FROM EmployeeDemographics
UNION ALL
SELECT *
FROM WareHouseEmployeeDemographics

-- Adding UNION clause when Columns are not the same (But Data Type is same)
SELECT EmployeeID,FirstName,Age
FROM EmployeeDemographics
UNION 
SELECT EmployeeID,Jobtitle,Salary
FROM EmployeeSalary



/* USe Cases */

SELECT FirstName,LastName,Age,
CASE
     WHEN AGE > 30 THEN 'OLD'
	 WHEN AGE BETWEEN 27 AND 30 THEN 'YOUNG'
	 ELSE 'BABY'
END
From EmployeeDemographics
WHERE AGE IS NOT NULL
ORDER BY AGE

-- Incrementing salary according to JobRoles
SELECT FirstName,LastName,Jobtitle,Salary,
CASE
	WHEN Jobtitle = 'Salesman' THEN Salary + (Salary * .10)
	WHEN Jobtitle = 'HR' THEN Salary + (Salary * .08)
	WHEN Jobtitle = 'Accountant' THEN Salary + (Salary * .05)
	ELSE Salary + (Salary*.03)
END as Incremented_Salary
FROM EmployeeDemographics de
JOIN EmployeeSalary sa
	ON de.EmployeeID = sa.EmployeeID



/* Having Clause */

-- Lookinga at No. of Job title occuring moew than one time    
SELECT Jobtitle,COUNT(Jobtitle)
FROM EmployeeDemographics de
JOIN EmployeeSalary sa
	ON de.EmployeeID = sa.EmployeeID
GROUP BY Jobtitle
HAVING COUNT(Jobtitle) >1             --WHERE DOES NOT WORK ON AGGREGATE FUNCTIONS   


-- Lookinga at Jobtitle having AVG Salary more than 45000  
SELECT Jobtitle,AVG(Salary)
FROM EmployeeDemographics de
JOIN EmployeeSalary sa
	ON de.EmployeeID = sa.EmployeeID
GROUP BY Jobtitle
HAVING AVG(Salary) >45000             --WHERE DOES NOT WORK ON AGGREGATE FUNCTIONS   
ORDER BY AVG(Salary)



/* Parting By */

-- Looking at the information of employee with the No. of people of same gender work with them 
SELECT FirstName, LastName,Gender,Salary,
COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender
FROM EmployeeDemographics de
JOIN EmployeeSalary sa
	ON de.EmployeeID = sa.EmployeeID




