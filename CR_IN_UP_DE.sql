-- Creating a table named NameAge
CREATE TABLE NameAge
( SNo int,
  Fname varchar(50),
  Lname varchar(50),
  Age int
)

--Inserting  values in to the table 
INSERT INTO NameAge VALUES
(1,'Ashutosh','Goyal',32),
(2, 'Jim', 'Halpert', 30),
(3, 'Pam', 'Beasley', 31),
(4, 'Dwight', 'Schrute', 29),
(5, 'Angela', 'Martin', 31),
(6, 'Toby', 'Flenderson', 32),
(7, 'Michael', 'Scott', 35)

-- Updating SNo , Age having First Name  Toby
UPDATE NameAge
SET SNo = 8,Age = 38
WHERE Fname = 'toby' 

-- Deleting the row having Last Name Martin
DELETE FROM NameAge
WHERE Lname = 'martin'

-- Deleting all rows in the table,without deleting table
DELETE FROM NameAge

-- Deleting Table from the Database
DROP TABLE NameAge