-- Server-level logins
CREATE LOGIN hr_login WITH PASSWORD = 'Hr@12345';
CREATE LOGIN sales_login WITH PASSWORD = 'Sales@12345';

-- Database-level users
USE CompanyDB;
GO
CREATE USER hr_user FOR LOGIN hr_login;
CREATE USER sales_user FOR LOGIN sales_login;

CREATE SCHEMA HR AUTHORIZATION hr_user;
CREATE SCHEMA Sales AUTHORIZATION sales_user;
------------------------------
-- HR Schema
CREATE TABLE HR.Employees (
    EmpID INT PRIMARY KEY,
    FullName NVARCHAR(100),
    Position NVARCHAR(50)
);

-- Sales Schema
CREATE TABLE Sales.Customers (
    CustID INT PRIMARY KEY,
    CustName NVARCHAR(100),
    Region NVARCHAR(50)
);
-----set permission --------
-- HR user: access only HR schema
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::HR TO hr_user;
DENY CONTROL ON SCHEMA::Sales TO hr_user;

-- Sales user: access only Sales schema
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Sales TO sales_user;
DENY CONTROL ON SCHEMA::HR TO sales_user;
------test connection -------
-- ? Should work
SELECT * FROM HR.Employees;

-- ? Should fail
SELECT * FROM Sales.Customers;
-------------------------------------------
-- ? Should work
SELECT * FROM Sales.Customers;

-- ? Should fail
SELECT * FROM HR.Employees;


