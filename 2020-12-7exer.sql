#Case
#1. Run my_employees

USE myemployees;
CREATE TABLE my_employees(
	Id INT(10),
	First_name VARCHAR(10),
	Last_name VARCHAR (10),
	Userid VARCHAR(10),
	Salary DOUBLE (10,2)
);
CREATE TABLE users(
	id INT,
	userid VARCHAR(10),
	department_id INT
);

#2. Display my_employees
DESC my_employees;

#3. Insert data into my_employees

INSERT INTO my_employees
VALUES
(1, 'patel', 'Ralph', 'Rpatel', 895),
(2, 'Dancs', 'Betty', 'Bdancs', 860),
(3,'Biri','Ben','Bbiri',1100),
(4,'Newman','Chad','Cnewman',750),
(5,'Ropeburn','Audrey','Aropebur',1550);

#or

INSERT INTO my_employees
SELECT 1, 'patel', 'Ralph', 'Rpatel', 895 UNION
SELECT 2, 'Dancs', 'Betty', 'Bdancs', 860 UNION
SELECT 3,'Biri','Ben','Bbiri',1100 UNION
SELECT 4,'Newman','Chad','Cnewman',750 UNION
SELECT 5,'Ropeburn','Audrey','Aropebur',1550;

#4. Insert data into users

INSERT INTO users
VALUES
(1,'Rpatel',10),
(2,'Bdancs',10),
(3,'Bbiri',20),
(4,'Cnewman',30),
(5,'Aropebur',40);

#5. change the last name to 'drelxer' whose id is 3

UPDATE my_employees
SET last_name ='drelxer'
WHERE Id = 3;

#6. Write a SQL statement to change the salary column of my_employees table with 1000 for those employees whose salary is under 900

UPDATE my_employees
SET salary = 1000
WHERE salary<900;

#7. Write a SQL statement to delete a person both table user and table my_employees whose userid is Bbiri

DELETE u,e
FROM users u
INNER JOIN my_employees e
ON e.Userid = u.`userid`
WHERE u.`userid`='Bbiri';

#8. delete both tables
DELETE FROM my_employees;
DELETE FROM users;

#9.
SELECT * FROM my_employees;
SELECT * FROM users;

#10. 
TRUNCATE TABLE my_employees;


