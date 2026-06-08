----------Aggregate Functions----------

--AVG() Function

--SQL Server AVG() function is an aggregate function that returns the average value of a group.



--Example1--
--The following example returns the average list price of all products:
--In this example, the AVG() function returned a single value for the whole table.
SELECT
    AVG(list_price) AS average_of_listprice
FROM
    production.products;

    select * from production.products


--Example1--
--The following example returns the average list price for each product category:
--In this example:

/*First, the GROUP BY clause divides the products by brands into groups.
Second, the AVG() function calculates average list price for each group.
Third, the HAVING clause removes the brand whose average list price is less than 500.*/
select * from  production.products
select * from production.categories
	SELECT
    category_name,
    CAST(ROUND(AVG(list_price),2) AS DEC(10,2)) avg_product_price
FROM
    production.products p
    INNER JOIN production.categories c 
        ON c.category_id = p.category_id
GROUP BY
    category_name
    HAVING
    AVG(list_price) < 500
ORDER BY
    category_name;

	
--COUNT () Function

--SQL Server COUNT() is an aggregate function that returns the number of items found in a set.


--Exmaple1
--The following statement returns the number of products in the products table:
SELECT 
    COUNT(*) AS product_count
FROM
    production.products
    select * from production.products
--Exmaple2	
--The following example uses the COUNT(*) function to find the number of products whose model year is 2016 and the list price is higher than 999.99:

SELECT 
   COUNT(*)
FROM 
    production.products
WHERE 
    model_year = 2016
    AND list_price > 999.99;

--Eaxmple3 
--SQL Server COUNT() with GROUP BY clause example
--The following statement uses the COUNT(*) function to find the number of products in each product category:

--In this example, first, the GROUP BY clause divided the products into groups using category name then the COUNT() function is applied to each group.

SELECT 
    category_name,
    COUNT(*) product_count
FROM
    production.products p
    INNER JOIN production.categories c 
    ON c.category_id = p.category_id
GROUP BY 
    category_name
ORDER BY
    product_count DESC;

--Example4

--SQL Server COUNT() with HAVING clause example:-
--The following statement returns the brand and the number of products for each. In addition, it returns only the brands that have the number of products greater than 20: 

SELECT 
    brand_name,
    COUNT(*) product_count
FROM
    production.products p
    INNER JOIN production.brands c 
    ON c.brand_id = p.brand_id
GROUP BY 
    brand_name
HAVING
    COUNT(*) > 20
ORDER BY
    product_count DESC;


------MAX() FUNCTION-----

--SQL Server MAX() function is an aggregate function that returns the maximum value in a set.

--Example 1--

--To find the product with the highest list price, you use the following statement wwith max function:-

--In this example:
--First, the subquery used the MAX() function to return the highest list price of all products.
--Then, the outer query selected the product whose list price is equal to the highest list price returned from the subquery.

SELECT 
    product_id,
    product_name,
    list_price
FROM 
    production.products
WHERE 
    list_price = (
        SELECT 
            MAX(list_price )
        FROM
            production.products);

-----Example 2-----
--SQL Server MAX() with GROUP BY clause example
--The following statement gets the brand name and the highest list price of products in each brand:
SELECT
    brand_name,
    MAX(list_price) max_list_price
FROM
    production.products p
    INNER JOIN production.brands b
        ON b.brand_id = p.brand_id 
GROUP BY
    brand_name
ORDER BY
    brand_name DESC;

-- Homework to be done by student--
	
-- Write a query which finds the brand names and the highest list price for each. In addition it uses HAVING clause to find all brands whose max  listprice is greater that 500 and order by max list price descending. 

select 
    brand_name,
    MAX(list_price) Brands_highest_list_price
from 
    production.products p
    INNER JOIN production.brands b
        ON b.brand_id = p.brand_id 
group by 
    brand_name
having 
    MAX(list_price) > 500
order By
    MAX(list_price) DESC;


---------MIN() Function----------

--SQL Server MIN() function is an aggregate function that allows you to find the minimum value in a set. The following illustrates the syntax of the MIN() function:

--Example1

--The following example finds the lowest list price of all products:

SELECT
    MIN(list_price) min_list_price
FROM
    production.products;

-- Example2 

-- find the product with the lowest price, you use the following query:
SELECT 
    product_id,
    product_name,
    list_price
FROM 
    production.products
WHERE 
    list_price = (
        SELECT 
            MIN(list_price )
        FROM
            production.products);

SELECT 
    product_id,
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price = (
        SELECT
            MIN(list_price)
        FROM
            production.products);
            

--Example 3
--The following statement finds the lowest list price for each product category:

SELECT
    category_name,
    MIN(list_price) min_list_price
FROM
    production.products p
    INNER JOIN production.categories c 
        ON c.category_id = p.category_id 
GROUP BY
    category_name
ORDER BY
    category_name;

--Homework to be done by students--
--Write a query which uses the MIN() function in the HAVING clause to get the product category with the minimum list price greater than 500.


-----------SUM() Function---------

--The SQL Server SUM() function is an aggregate function that calculates the sum of all or distinct values in an expression.

--Example1
--The following statement returns the total stocks of all products in all stores:

SELECT 
    SUM(quantity) total_stocks
FROM 
    production.stocks;


--Example 2---
--The following statement finds total stocks by store id:
SELECT
    store_id,
    SUM(quantity) store_stocks
FROM
    production.stocks
GROUP BY
    store_id;

--If you want to display the store name instead of store id, you can use the following statement:

	SELECT
    store_name,
    SUM(quantity) store_stocks
FROM
    production.stocks w
    INNER JOIN sales.stores s
        ON s.store_id = w.store_id
GROUP BY
    store_name;


---The following statement finds stocks for each product and returns only products whose stocks are greater than 100:

SELECT
    product_name,
    SUM(quantity) total_stocks
FROM
    production.stocks s
    INNER JOIN production.products p
        ON p.product_id = s.product_id
GROUP BY
    product_name
HAVING
    SUM(quantity) > 100
ORDER BY
    total_stocks DESC;


------------VAR() AND VARP() STDEV() AND STDEVP() Function-------------

--Variance is a measure of the spread of a data distribution. It measures the distance of the data points from the mean of the dataset. The smaller the variance of a dataset, then the closer is the numbers in the dataset to each other.

CREATE TABLE WindowTable (
WindowID INT IDENTITY,
House Varchar(32),
FullName Varchar(64),
PhysicalSkill Decimal(4, 2),
MentalSkill Decimal (4, 2)
)
GO
INSERT WindowTable
(House, FullName, PhysicalSkill, MentalSkill)
VALUES
('Stark', 'Robb Stark', 6, 6),
('Stark', 'Ned Stark', 8, 7),
('Stark', 'Bran Stark', 2, 9),
('Stark', 'Arya Stark', 4, 6),
('Lannister', 'Jamie Lannister', 7, 5),
('Lannister', 'Tyrion Lannister', 3, 10),
('Lannister', 'Tywin Lannister', 3, 8)
GO
GO
select * from WindowTable 

/*In SQL Server, VAR and VARP calculate the variance of a dataset. 
VAR is a common mathematical function that measures the variance of a sample data set.

VARP measures the variance against a population.
This function is used when you're working with the entire data set,
rather than just a sample set. The internal calculation is slightly
different.

STDEV calculates the standard deviation. T
he standard deviation and variance are tightly connected – STDEV is just the square root of the variance.

Like VARP, STDEVP calculates the standard deviation against a entire population. 

Since we know the entire population in our example, VARP and STDEVP can be used. 
With OVER, it's easy to see the average and standard deviation for each individual.
We can also verify that the standard deviation is the square root of the variance using another SQL function, SQRT. */

SELECT House, FullName, PhysicalSkill,
AVG (ALL  PhysicalSkill ) OVER (PARTITION BY house) AS APartitionByVGPhysicalSkillByHouse,
VARP ( ALL PhysicalSkill) OVER (PARTITION BY house) AS VarPPhysicalSkillByHouse,
STDEVP( ALL PhysicalSkill) OVER (PARTITION BY house) AS StDevPPhysicalSkillByHouse ,
SQRT (VARP ( ALL PhysicalSkill) OVER (PARTITION BY house) ) AS SquareRootOfVariance
FROM WindowTable

---------CHECKSUM_AGG() Function----------

--In SQL Server, CHECKSUM_AGG returns the checksum of all values in a group, ignoring NULLs. This is a simplified way to determine if the data in a row or group of rows has changed:

select * from WindowTable
SELECT House, FullName, PhysicalSkill,
CHECKSUM_AGG ( ALL (CAST (PhysicalSkill AS INT)) ) OVER (PARTITION BY house) AS CheckSumAGG
FROM WindowTable
 ----Now lets update physucal skill for one person and then the checksum_agg output.
UPDATE WindowTable SET PhysicalSkill = 7 WHERE FullName = 'Arya Stark'
GO
 
SELECT House, FullName, PhysicalSkill,
CHECKSUM_AGG ( ALL (CAST (PhysicalSkill AS INT)) ) OVER (PARTITION BY house) AS CheckSumAGG
FROM WindowTable

--As you can see clearly from the output, the result of the CHECKSUM_AGG() changed. It means that the data in the Physical column has been changed since the last checksum calculation.


--------------------Mathematical Function-------------------------------
--SQUARE(): Returns the square of a value.
--Syntax: SQUARE (number)

Select Square(34) as S_Temp 


--ABS(): A mathematical function that returns he absolute (positive) value of the specified numeric expression. 
--Syntax: ABS ( numeric_expression )

SELECT ABS(-11.0), ABS(0.0), ABS(11.0)

 
--CEILING(): This function returns the smallest integer greater than, or equal to, the specified numeric expression.
--Syntax: CEILING ( numeric_expression )

SELECT list_price,CEILING(list_price)as CelingValue
from production.products

--FLOOR(): Returns the largest integer less than or equal to the specified numeric expression.
--Syntax: FLOOR ( numeric_expression ) 

SELECT list_price,FLOOR(list_price) AS FloorValue
from production.products

--ROUND(): Returns a numeric value, rounded to the specified length or precision.
--Syntax: ROUND (number,decimal,operation )

SELECT list_price, Round(list_price,1) AS RoundValue from production.products


--POWER(): Returns the value of the specified expression to the specified power.
--Syntax: POWER ( float_expression , y )

SELECT POWER(5, 3)as PowerofThree


--------------------Date Fuctions----------------------

--The CURRENT_TIMESTAMP() function is used to see the system's current date and time without considering the timezone in the output:
select current_timestamp AS date;
--GETDATE() function is used to see the system's current date and time on which the SQL Server is running:
select getdate() AS date;
--GETUTCDATE() function is used  to see the system's current date and time based on the UTC timestamp as an integer
select GETUTCDATE() AS date; --UK DATE AND TIME
-- SYSDATETIME() function is used to see the system's current date and time with more fractional precision in milliseconds
select SYSDATETIME() AS date;
--SYSUTCDATETIME() function is used to see the system's current date and time based on the UTC timestamp as an integer
select SYSUTCDATETIME () AS date;
-- --This example uses the SYSDATETIMEOFFSET() function is used to see the system's current date and time with the timezone offset:
select SYSDATETIMEOFFSET ()AS date;

------------------------------------------------------------------------------------------------------------------------------
-------****DATEFROMPARTS() function-----

/*The following shows the syntax of the DATEFROMPARTS() function:
--Return a DATE value from the year, month, and day.
DATEFROMPARTS(year, month, day)

The DATEFROMPARTS() function accepts three arguments:

year is an integer expression that resolves to a year
month is an integer expression that evaluates to a month that ranges from 1 to 12.
day is an integer expression that specifies a day, ranging from 1 to 31

The DATEFROMPARTS() function returns a DATE value. If any argument is NULL, the function will return NULL.*/


--This example uses the  to construct a date from the day, month, and year values.
--DATEFROMPARTS(year, month, day)

SELECT DATEFROMPARTS(2019, 12, 31) AS Result1,  
DATEFROMPARTS(2019, NULL, 31) AS Result2;  

--Executing the statement will show the below output. Here we see the result1 return the date, but result2 returns NULL as the month argument is NULL.


----------------------------------------------------------------------------------------------------------------------


------****DATETIME2FROMPARTS() function-------
--	Returns a DATETIME2 value from the date and time arguments

--DATETIME2FROMPARTS ( year, month, day, hour, minute, seconds, fractions, precision )

/*The DATETIME2FROMPARTS() function returns a date value constructed from the year, month, day, hour, minute, seconds, fractions, and precision value.
The DATETIME2FROMPARTS() function accepts eight arguments:

year is an integer expression that resolves to a year.
month is an integer expression that evaluates to a month that ranges from 1 to 12.
day is an integer expression that identifies a day, ranging from 1 to 31
hour is an integer expression that identifies the hours.
minute is an integer expression that identifies the minutes.
seconds is an integer expression that identifies the seconds.
fractions is an integer expression that identifies a fractional seconds value.
precision is an integer expression that identifies the precision of the DATETIME2 value.

The DATETIME2FROMPARTS() function returns a value of the DATETIME2 type. If any argument is NULL, the function will return NULL.

If one argument has an invalid value, the DATETIME2FROMPARTS() function will raise an error. */


--This example uses the DATETIME2FROMPARTS() function to construct a datetime2 value from the day, month, year, hour, minute, seconds, fractions, and precision values.

SELECT DATETIME2FROMPARTS ( 2029, 10, 31, 11, 59, 59, 0, 0 ) AS Result1,  
DATETIME2FROMPARTS(2019, NULL, 31, 11, 59, 59, 0, 0) AS Result2;    

--Executing the statement will show the below output. Here we see the result1 return the datetime value, but result2 returns NULL as the month argument is NULL.



-----*****DATETIMEOFFSETFROMPARTS()-------
/*The DATETIMEOFFSETFROMPARTS() constructs a DATETIMEOFFSET value from the specified date and time arguments.
Returns a DATETIMEOFFSET value from the date and time arguments

The following shows the syntax of DATETIMEOFFSETFROMPARTS() function:
DATETIMEOFFSETFROMPARTS ( year, month, day, hour, minute, seconds, fractions, hour_offset, minute_offset, precision )  

The DATETIMEOFFSETFROMPARTS() function accepts the following arguments:

year is an integer expression that resolves to a year.
month is an integer expression that evaluates to a month that ranges from 1 to 12.
day is an integer expression that identifies a day, ranging from 1 to 31
hour is an integer expression that identifies the hours.
minute is an integer expression that identifies the minutes.
seconds is an integer expression that identifies the seconds.
fractions is an integer expression that identifies a fractional seconds value.
hour_offsetis an integer expression that specifies the hour portion of the time zone offset.
minute_offsetis an integer expression that specifies the minute portion of the time zone offset.
precision is an integer expression that identifies the precision of the DATETIMEOFFSET value.

--This example uses the DATETIMEOFFSETFROMPARTS() function to construct a datetimeoffset value from the date and time values.*/

SELECT DATETIMEOFFSETFROMPARTS(2021, 10, 11, 20, 35, 30, 4000, 10, 30, 4) AS Result1,  
DATETIMEOFFSETFROMPARTS(NULL, 10, 11, 20, 35, 30, 4000, 10, 30, 4) AS Result2;   
--Executing the statement will show the below output. Here we see the result1 return the datetimeoffset value, but result2 returns NULL as the year argument is NULL.

---****TIMEFROMPARTS() function-----
--Returns a TIME value from the time parts with the precisions
/*The TIMEFROMPARTS() function returns a fully initialized time value. It requires five arguments as shown in the following syntax:

TIMEFROMPARTS ( hour, minute, seconds, fractions, precision )  

In this syntax:

hour – specifies hours.
minute – specifies minutes.
seconds – specifies seconds.
fractions – specifies fractions.
precision – specifies the precision of the time value. The precision cannot be null. If it is null, the function will raise an error.
The TIMEFROMPARTS() function returns a value of type time(precision) */

--This example uses the  to construct a time value for the specified time and precision values.
SELECT TIMEFROMPARTS(20, 55, 59, 0, 0) AS Result1,  
TIMEFROMPARTS(10, 30, 19, 5, 2) AS Result2;  
--Executing the statement will show the below output. Here we see the result1 return the time value without fraction, but result2 returns the time with fractions. The fraction value is calculated as 5/100 or 0.05 of a second as the given precision is 2.


-- 
select DAY('2023/01/07')
select MONTH('2023/01/07')
select YEAR('2023/01/07')

--DATENAME() function is used  to extract the part of the date such as day, month, or year.
SELECT DATENAME(day, '2021/09/10') AS Result1,  
DATENAME(month, '2021/09/10') AS Result2,  
DATENAME(year, '2021/09/10') AS Result3;  

/*DATEPART() function is used to extract the part of the date as an integer value,
which makes it different from the DATENAME() function.*/
SELECT DATEPART(day, '2021/09/10') AS Result1,  
DATEPART(month, '2021/09/10') AS Result2,  
DATEPART(year, '2021/09/10') AS Result3;  



--This example uses the DATEDIFF() function and displays the differences between the starting and ending date expressions.
select DATEDIFF(MONTH,'2022/01/07','2023/01/07');

SELECT DATEDIFF(dd,'2019/2/3', '2020/3/5') AS TotalDays,  
 DATEDIFF(MM,'2019/2/3', '2020/3/5') AS TotalMonths,    
 DATEDIFF(WK,'2019/2/3', '2020/3/5') AS TotalWeeks;  


 -- This example uses the DATEADD() function and returns a new date value after adding an integer value to the date portion.
select DATEADD (YY,6,'2023/01/07')
select DATEADD (MM,6,'2023/01/07')
select DATEADD (DD,6,'2023/01/07')

SELECT DATEADD(second, 1, '2020-12-31 23:59:59') AS Result1,  
DATEADD(day, 1, '2020-12-31 20:59:59') AS Result2;  

-------------------------------------------------------------------------------------

---------------STRING FUNCTIONS()-----------------
--Let's create below Faculty_Info tables and insert values into it.
CREATE TABLE Faculty_Info  
(  
Faculty_ID INT NOT NULL PRIMARY KEY,    
Faculty_First_Name VARCHAR (100),    
Faculty_Last_Name VARCHAR (100),    
Faculty_Dept_Id INT NOT NULL,  
Faculty_Address Varchar(120),  
Faculty_City Varchar (80),  
Faculty_Salary INT   
);  
--truncate table Faculty_Info
INSERT INTO Faculty_Info (Faculty_ID, Faculty_First_Name, Faculty_Last_Name,Faculty_Dept_Id, Faculty_Address, Faculty_City, Faculty_Salary) VALUES (1001, 'Arushi', '      Yadav', 4001, 'Aman Vihar', 'Delhi', 20000);  
INSERT INTO Faculty_Info (Faculty_ID, Faculty_First_Name, Faculty_Last_Name,Faculty_Dept_Id, Faculty_Address, Faculty_City, Faculty_Salary) VALUES (1002, 'Bulbul', '      Sharma', 4002, 'Nirman Vihar', 'Delhi', 38000 );  
INSERT INTO Faculty_Info (Faculty_ID, Faculty_First_Name, Faculty_Last_Name,Faculty_Dept_Id, Faculty_Address, Faculty_City, Faculty_Salary) VALUES (1004, 'Virat', '     Kohli', 4001, 'Sector 128', 'Mumbai', 45000);  
INSERT INTO Faculty_Info (Faculty_ID, Faculty_First_Name, Faculty_Last_Name,Faculty_Dept_Id, Faculty_Address, Faculty_City, Faculty_Salary) VALUES (1005, 'Rohit', '     Sharma', 4001, 'Vivek Vihar', 'Kolkata', 42000);  
INSERT INTO Faculty_Info (Faculty_ID, Faculty_First_Name, Faculty_Last_Name,Faculty_Dept_Id, Faculty_Address, Faculty_City, Faculty_Salary) VALUES (1006, 'Ritesh', '    Gujaran', 4002, 'Sarvodya Calony', 'Bangalore', 28000);  
INSERT INTO Faculty_Info (Faculty_ID, Faculty_First_Name, Faculty_Last_Name,Faculty_Dept_Id, Faculty_Address, Faculty_City, Faculty_Salary)VALUES (1007, 'Shivam', '    Biswas', 4003, 'Krishna Nagar', 'Lucknow', 35000);  

--LTRIM String Function
--This string function cuts the given character or string from the left of the given original string. It also removes the space from the left of the specified string.


--The following SELECT query trims the space from the specified string:

SELECT LTRIM( '              INTELLIPAAT           ');  
SELECT RTRIM( '              INTELLIPAAT           ');  

--Example : The following SELECT query uses LTRIM() with the Faculty_Last_Name column of above Faculty_Info table:
select * from Faculty_Info;
SELECT Faculty_Last_Name, RTRIM(Faculty_Last_Name) AS LTRIM_LastName FROM Faculty_Info;  
select lower(Faculty_First_Name) from Faculty_Info;

--LOWER()
--SELECT LOWER(Column_Name) AS Alias_Name FROM Table_Name;  

--SELECT LOWER(String);  
--Example 1: The following SELECT query converts the upper case letters of the given string into the lower case letters.

SELECT LOWER( 'NEW DELHI IS THE CAPITAL OF INDIA');  
select lower(Faculty_First_Name) from Faculty_Info;
--UPPER 
--Below example returns uppercase
SELECT UPPER( 'ritesh is a good teacher');  

--REVERSE
--Returns Reverse
select REVERSE('ritesh')

--LEN
--Returns length of characters
select LEN('ritesh')

--REPLACE
--
SELECT REPLACE('TheHomeDepot','HomeDepot','DEPARTMENT') 
AS REPLACED_DATA; 


--Substring

--The SUBSTRING string function in Structured Query Language shows the characters or sub-string from the specific index value of the original string. 

--This exmaple will show th 1 to 25 characters including spaces from the passed string.
SELECT SUBSTRING('Intellipaat is a learning place for professionals', 1, 20) AS substring_1_20;  
--This exmaple will show th 7th position in the string
SELECT SUBSTRING( 'Intellipaat', 7, 1) AS substring_7_1;  


--------------------------------------------------------------------------------------

----------------------SYSTEM FUNCTIONS----------------------------

-------Lets create a table named employee----------
CREATE TABLE [dbo].[employee](
	[name] [varchar](45) NOT NULL,
	[occupation] [varchar](35) NOT NULL,
	[working_date] [date] NULL,
	[working_hours] [varchar](10) NULL,
	[salary] [int] NULL,
	[weight] [decimal](8, 2) NULL,
	[empstatus] [int] NULL
) ON [PRIMARY]
GO
INSERT [dbo].[employee] ([name], [occupation], [working_date], [working_hours], [salary], [weight], [empstatus]) VALUES (N'Jake Evans', N'HR', CAST(N'2020-10-04' AS Date), N'9', 25000, CAST(80.35 AS Decimal(8, 2)), 1)
INSERT [dbo].[employee] ([name], [occupation], [working_date], [working_hours], [salary], [weight], [empstatus]) VALUES (N'Brad Simmons', N'Engineer', CAST(N'2020-10-04' AS Date), N'12', 65000, CAST(90.15 AS Decimal(8, 2)), 1)
INSERT [dbo].[employee] ([name], [occupation], [working_date], [working_hours], [salary], [weight], [empstatus]) VALUES (N'Lily Huges', N'Writer', CAST(N'2020-10-04' AS Date), N'13', 35000, CAST(70.45 AS Decimal(8, 2)), 2)
INSERT [dbo].[employee] ([name], [occupation], [working_date], [working_hours], [salary], [weight], [empstatus]) VALUES (N'Laura Paul', N'Manager', CAST(N'2020-10-04' AS Date), N'10', 45000, CAST(40.75 AS Decimal(8, 2)), 1)
INSERT [dbo].[employee] ([name], [occupation], [working_date], [working_hours], [salary], [weight], [empstatus]) VALUES (N'Diego Simmons', N'Teacher', CAST(N'2020-10-04' AS Date), N'12', 30000, CAST(52.55 AS Decimal(8, 2)), 2)
INSERT [dbo].[employee] ([name], [occupation], [working_date], [working_hours], [salary], [weight], [empstatus]) VALUES (N'Antonio Bennet', N'Writer', CAST(N'2020-10-04' AS Date), N'13', 35000, CAST(67.85 AS Decimal(8, 2)), 2)
GO


--CAST

--The SQL CAST function is mainly used to convert the expression from one data type to another data type. 
--If the SQL Server CAST function is unable to convert a declaration to the desired data type, this function returns an error.
--We use the CAST function to convert numeric data into character or string data.
--CAST (expression AS [data type])  

--truncate table employee
select * from employee

Select weight , Convert(int ,weight) as Int_weight from employee

-- This example convert the decimal to integer value
SELECT name,weight, CAST (weight AS Integer) AS weightininteger FROM employee
-- This example convert the decimal to character value
SELECT name,weight,CAST (weight AS char(5)) weightwithchardatatype FROM employee


--CONVERT

--CONVERT ( data_type (length) , expr, style)  
/*In the syntax, we have used the following parameters:

-data_type: It represents the target data type in which we want to convert the expression. 
            It can include the following data types as an input: bigint, int, smallint, tinyint, bit, 
                decimal, numeric, money, float, datetime, char, nchar, varchar, nvarchar, text, ntext, binary, image, etc.
                We make sure that the input data type should not be an alias type.
-length: It is an optional parameter for specifying the length of the target data type. By default, its value is 30.
-expr: It specifies a valid expression that we are going to convert into another type.
-style: It is an optional value that indicates the output style of the converted value.
        We will get the NULL value when it is NULL. It is useful for the DATE data type format.*/

/*This example converts the data type of float value to an integer.
        Here we have first declared a float variable and then assign them float value.
        Next, we will convert the float value to an integer with the help of the CONVERT function and print the result.*/

--Declare float variable  
DECLARE @floatvalue AS Float  
--Assign value into a float variable  
SET @floatvalue = 345.1346   
--Use Convert function for conversion  
SELECT @floatvalue AS Actual_Value ,CONVERT(INT, @floatvalue) AS Result  


--This example will convert the decimal number into another decimal number with zero scales with the help of the CONVERT function. The rounding and truncation behavior of this function works similarly to the CAST function in SQL Server.

DECLARE @decimalVal AS DECIMAL  
SET @decimalVal = 9.956  
SELECT CONVERT(DECIMAL(2, 0), @decimalVal) AS Result  



--CHOOSE
SELECT   CHOOSE(2, 'First', 'Second', 'Third') Result;

-- Below example  CHOOSE() function will return the curent status based on the value in empstatus column of the employee table.

select * from employee

select name,occupation,working_hours,working_date,salary,empstatus,CHOOSE(empstatus,'Active','Inactive') as currentstatus from employee

--ALTER TABLE employee add empstatus int
/*
UPDATE employee SET empstatus=1 where name ='Jake Evans'
UPDATE employee SET empstatus=1 where name ='Brad Simmons'
UPDATE employee SET empstatus=2 where name ='Lily Huges'
UPDATE employee SET empstatus=1 where name ='Laura Paul'
UPDATE employee SET empstatus=2 where name ='Diego Simmons'
UPDATE employee SET empstatus=2 where name ='Antonio Bennet' */


---------ISNULL----------
/*
The ISNULL() function returns the replacement if the expression evaluates to NULL. Before returning a value, it implicitly converts the type of replacement to the type of the expression if the types of the two arguments are different.

In case the expression is not NULL, the ISNULL() function returns the value of the expression.*/

SELECT 
    ISNULL(NULL,20) result;

------Lets create table names divisions to understand ISNULL Function------
	CREATE TABLE divisions
(
    id      INT
    PRIMARY KEY IDENTITY, 
    min_age INT DEFAULT 0, 
    max_age INT
);

INSERT INTO divisions(min_age, max_age)
VALUES(5,null),
        (20,null),
        (null,30);

SELECT  id,min_age,max_age 
FROM     divisions;


SELECT 
    id, 
    ISNULL(min_age,0) min_age, 
    ISNULL(max_age,99) max_age
FROM
    divisions;
/*
If a division does not require minimum age, the min_age column will have NULL. Similarly, if a division does not require maximum age the max_age column will also have NULL.

Last, use the ISNULL() function to convert NULL in the min_age column to 0 and NULL in the max_age column to 99:*/

SELECT 
    id, 
    ISNULL(min_age,0) min_age, 
    ISNULL(max_age,99) max_age
FROM
    divisions;

/* The ISNUMERIC() accepts an expression and returns 1 if the expression is a valid numeric type; otherwise, it returns 0.

The following shows the syntax of the ISNUMERIC() function:

ISNUMERIC ( expression )  
In this syntax, the expression is any valid expression to be evaluated.

Note that a valid numeric type is one of the following:

Exact numbers: BIGINT, INT, SMALLINT, TINYINT, and BIT
Fixed precision: DECIMAL, NUMERIC
Approximate: FLOAT, REAL
Monetary values: MONEY, SMALLMONEY
The ISNUMERIC() actually checks if a value can be converted to a numeric data type and returns the right answer. However, it doesn’t tell you which datatype and properly handle the overflow.

This was why the TRY_CAST(), TRY_PARSE(), and TRY_CONVERT() function was introduced since SQL Server 2012.*/



--This example uses the ISNUMERIC() function to check if the string '$10' can be converted to a number or not:

SELECT ISNUMERIC('$10') result;
SELECT ISNUMERIC('-2.23E-308') result;
SELECT ISNUMERIC('+ABC') result;

------IIF----------------
/*
The IIF() function accepts three arguments. It evaluates the first argument and returns the second argument if the first argument is true; otherwise, it returns the third argument.

The following shows the syntax of the IIF() function:

IIF(boolean_expression, true_value, false_value)
 
In this syntax:

boolean_expression is an expression to be evaluated. It must be a valid Boolean expression, or the function will raise an error.
true_value is the value to be returned if the boolean_expression evaluates to true.
false_value is the value to be returned if the boolean_expression evaluates to false.*/

--This example uses the IIF() function to check if 10 < 20 and returns the True string:
SELECT     IIF(10 > 20, 'True', 'False') Result ;
--This example nests IIF()function inside IIF() functions and returns the corresponding order status based on the status number:
select * from sales.orders
SELECT    
    IIF(order_status = 1,'Pending', 
        IIF(order_status=2, 'Processing',
            IIF(order_status=3, 'Rejected',
                IIF(order_status=4,'Completed','N/A')
            )
        )
    ) order_status,
    COUNT(order_id) order_count
FROM    
    sales.orders
WHERE 
    YEAR(order_date) = 2018
GROUP BY 
    order_status;


---This example uses the IIF() function with the SUM() function to get the number of orders by order status in 2018.

SELECT    
    SUM(IIF(order_status = 1, 1, 0)) AS 'Pending', 
    SUM(IIF(order_status = 2, 1, 0)) AS 'Processing', 
    SUM(IIF(order_status = 3, 1, 0)) AS 'Rejected', 
    SUM(IIF(order_status = 4, 1, 0)) AS 'Completed', 
    COUNT(*) AS Total
FROM    
    sales.orders
WHERE 
    YEAR(order_date) = 2018;

	----TRY_CAST()------

/* The TRY_CAST() function casts a value of one type to another. It returns NULL if the conversion fails.

The following shows the syntax of the TRY_CAST() function:

TRY_CAST ( expression AS data_type [ ( length ) ] )  
The TRY_CAST() accepts two arguments:

data_type is any valid data type into which the function will cast the expression.
expression is the value to cast.
The TRY_CAST() function takes the input value and tries to cast it to a value of the specified data type. It returns the value in the specified data if the cast succeeds; Otherwise, it returns NULL. But, if you request a conversion that is explicitly not allowed, the TRY_CAST() function will fail with an error.

TRY_CAST() vs. CAST()
If the cast fails, the TRY_CAST() function returns NULL while the CAST() function raises an error.

You use the NULL handling functions or expressions such as ISNULL(), COALESCE, or CASE to handle the result of the TRY_CAST() function in case the cast fails. On the other hand, you use the TRY...CATCH statement to handle the result of the CAST() function if the cast fails.

Examples:-*/

--The following example shows how the TRY_CAST() function returns NULL when the cast fails:

SELECT 
    CASE
        WHEN TRY_CAST('test' AS INT) IS NULL
        THEN 'Cast failed'
        ELSE 'Cast succeeded'
    END AS Result;
	
--This example returns an error because a number cannot be cast into an XML data type:

SELECT 
    TRY_CAST(30.5 AS XML);

-- The following example uses the TRY_CAST() function to convert a string to a decimal:

SELECT     TRY_CAST('12.34' AS DECIMAL(4, 2)) Result
select GETDATE()
--The following example uses the TRY_CAST() function to convert the current system date and time to a date value:
	SELECT 	TRY_CAST(GETDATE() AS DATE) Result;
-- The followiung example uses TRY_CAST() funtion to convert the current system date and time to a time value:
SELECT 	TRY_CAST(GETDATE() AS TIME) Result;


--------------TRY_CONVERT()----------

/*The TRY_CONVERT() function converts a value of one type to another. It returns NULL if the conversion fails.

The following illustrates the syntax of the TRY_CONVERT() function:

TRY_CONVERT (
    data_type[(length)], 
    expression 
    [,style]
)
 
The TRY_CONVERT() accepts three arguments:

data_type is a valid data type into which the function will cast the expression.
expression is the value to cast.
style is a provided integer that specifies how the function will translate the expression.
The TRY_CONVERT() function tries to convert the value passed to it to a specified data type. It returns the value as the specified data if the cast succeeds; Otherwise, it returns. However, if you request a conversion that is explicitly not permitted, the TRY_CONVERT() function will fail with an error. */

--TRY_CONVERT() returns NULL example
--This example shows how the TRY_CONVERT() function returns NULL when the cast fails:

SELECT 
    CASE
        WHEN TRY_CONVERT( INT, 'test') IS NULL
        THEN 'Cast  failed'
        ELSE 'Cast  succeeded'
    END AS Result;


--This example uses the TRY_CONVERT() function to convert a string to an integer:

SELECT 
    TRY_CONVERT( INT, '100') Result;


--This example uses the TRY_CONVERT() function to convert the current system date and time to a date value:

SELECT 	TRY_CONVERT( DATE, GETDATE()) Result;
SELECT 	TRY_CONVERT( TIME, GETDATE()) Result;



---TRY_PARSE()

/*The TRY_PARSE() function is used to translate the result of an expression to the requested data type. It returns NULL if the cast fails.

Below is the syntax of the TRY_PARSE() function:

TRY_PARSE ( expression AS data_type [ USING culture ] )  

In this syntax:

expression evaluates to a string value of NVARCHAR(4000).
data_type represents the data type requested for the result.
culture is an optional string that specifies the culture in which expression is formatted. It defaults to the language of the current session. Note that the culture is not limited to the ones supported by SQL; It can accept any culture supported by .NET Framework. */



--This example uses the TRY_PARSE() function to convert the string '14 April 2019' to a date:

SELECT 
    TRY_PARSE('14 April 2019' AS date) result;

--The following example uses the TRY_PARSE() function to convert the string '-1250' to an integer:

SELECT 
    TRY_PARSE('-1250' AS INT) result;

--	Using SQL Server TRY_PARSE() function with CASE expression example
--This example uses the TRY_PARSE() function with the CASE to test expression and return the corresponding message if the cast is failed -- or succeeded.

SELECT 
    CASE
        WHEN TRY_PARSE('Last year' AS DATE) IS NULL
        THEN 'Cast failed'
        ELSE 'Cast succeeded'
    END AS result;


-----convert datetime to string-------

/*
To convert a datetime to a string, you use the CONVERT() function as follows:

CONVERT(VARCHAR, datetime [,style])
 
In this syntax:

VARCHAR is the first argument that represents the string type.
datetime is an expression that evaluates to date or datetime value that you want to convert to a string
sytle specifies the format of the date. The value of style is a number predefined by SQL Server. The style parameter is optional.*/

/*NOTE:BElow link has all ways to convert datetime to differeant formats. Kindly go through table mentioned in below link.
https://learn.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-ver16 */

--a) Convert datetime to string in mon dd yyyy hh:miAM (or PM) format example
DECLARE @dt DATETIME = '2022-12-31 14:43:35.863';

SELECT 
    CONVERT(VARCHAR(20),@dt,0) s1,
    CONVERT(VARCHAR(20),@dt,100) s2;

--b) Convert datetime to string in mm/dd/yy and mm/dd/yyyy formats example
DECLARE @dtp DATETIME = '2022-12-31 14:43:35.863';
SELECT 
    CONVERT(VARCHAR(10),@dtp,1) s1,
    CONVERT(VARCHAR(10),@dtp,101) s2;

--c)Convert datetime to string in dd.mm.yy and dd.mm.yyyy formats example
DECLARE @dts DATETIME = '2022-12-31 14:43:35.863';

SELECT 
    CONVERT(VARCHAR(10),@dt,4) s1,
    CONVERT(VARCHAR(10),@dt,104) s2;

--d)Convert datetime to string in dd-mm-yy dd-mm-yyyy formats example
DECLARE @dts DATETIME = '2019-12-31 14:43:35.863';

SELECT 
    CONVERT(VARCHAR(10),@dts,5) s1,
    CONVERT(VARCHAR(10),@dts,105) s2;


	------convert string to datetime-------------



/*SQL Server provides the CONVERT() function that converts a value of one type to another:

CONVERT(target_type, expression [, style])
 
Besides the CONVERT() function, you can also use the TRY_CONVERT() function:

TRY_CONVERT(target_type, expression [, style])
 
The main difference between CONVERT() and TRY_CONVERT() is that in case of conversion fails, the CONVERT() function raises an error while the TRY_CONVERT() function returns NULL.*/

--This example uses the CONVERT() function to convert a string in ANSI date format to a datetime:

  SELECT  CONVERT(DATETIME, '2019-08-15', 102) result;



--If the conversion fails, the CONVERT() function will raise an error:

SELECT CONVERT(DATETIME, '2019-18-15', 102) result;

--Note that the CONVERT() function can also convert an ISO date string without delimiters to a date value as shown in the following eeg
SELECT 
    CONVERT(DATETIME, '20190731') result;

--This example shows how to use the CONVERT() function to convert strings in ISO date format to datetime values:
SELECT CONVERT(DATETIME, '2019-09-25');
SELECT CONVERT(DATETIME, '2019/09/25');
SELECT CONVERT(DATETIME, '2019.09.25');
SELECT CONVERT(DATETIME, '2019-09-25 12:11');
SELECT CONVERT(DATETIME, '2019-09-25 12:11:09');
SELECT CONVERT(DATETIME, '2019-09-25 12:11:09.555');
SELECT CONVERT(DATETIME, '2019/09/25 12:11:09.555');
SELECT CONVERT(DATETIME, '2019.09.25 12:11:09.555');


--------Convert Datetime to Date-----------

--This statement uses the CONVERT() function to convert a datetime to a date:

--CONVERT(DATE, datetime_expression)

--This example uses the TRY_CONVERT() function to convert the current datetime to a date:
SELECT 
    CONVERT(DATE, GETDATE()) date;
	
--This example uses the CAST() function to convert the current datetime to a date value:
select GETDATE ()
SELECT 
    CAST(GETDATE() AS DATE) date;

----------------------------------------------------------------------------------------

-------------Windows Function---------------------


------- CUME_DIST() function---------------

/*Sometimes, you want to make a report that contains the top or bottom x% values from a data set e.g., top 5% sales staffs by net sales. One way to achieve this with SQL Server is to use the CUME_DIST() function.

The CUME_DIST() function calculates the cumulative distribution of a value within a group of values. Simply put, it calculates the relative position of a value in a group of values.

The following shows the syntax of the CUME_DIST() function:

 CUME_DIST() OVER (
    [PARTITION BY partition_expression, ... ]
    ORDER BY sort_expression [ASC | DESC], ...
) */

/*Let’s examine this syntax in detail.

PARTITION BY clause
The PARTITION BY clause distributes rows into multiple partitions to which the CUME_DIST() function is applied.

The PARTITION BY clause is optional. The CUME_DIST() function will treat the whole result set as a single partition if you omit the PARTITION BY clause.

ORDER BY clause
The ORDER BY clause specifies the logical order of rows in each partition to which the CUME_DIST() function is applied. The ORDER BY clause considers NULL values as the lowest possible values.

Return value
The result of CUME_DIST() is greater than 0 and less than or equal to 1.

0 < CUME_DIST() <= 1
The function returns the same cumulative distribution values for the same tie values */

--The following statement creates a view named department_headcounts based on the employees and departments tables for the demonstration:
select * from employees
select * from departments
CREATE VIEW department_headcounts
AS
SELECT 
	department_name,
	COUNT(employee_id) headcount
FROM 
	employees e
	INNER JOIN departments d
		ON d.department_id = e.department_id
GROUP BY 
	d.department_name;

--	The following statement finds the cumulative distribution values by headcount of each department:

SELECT
	department_name,
	headcount,
	ROUND(
		CUME_DIST() OVER (
			ORDER BY headcount
		)
	,2) cume_dist_val
FROM
	department_headcounts;


/*In this example, departments were sorted by their number of headcounts in ascending order. The total of rows in the result set is 11.

The Administration department has one headcount. The Human Resources and Public Relations also have the same headcount as Administration. As the result, there are three departments that have one headcount. The CUME_DIST() function will use the following formula to calculate the cumulative distribution values of the first row:

3 / 11 = 0.27
The same logic is applied to the second and third rows.

The Marketing department has two headcounts. The function will find other departments which have the number of headcounts less than or equal to 2. The result is 5. Therefore, the CUME_DIST() of the Marketing department is 5 / 11 = 0.45

The same logic is applied to the remaining rows*/




--  The DENSE_RANK()        --

/*The DENSE_RANK()is a window function that assigns ranks to rows in partitions with no gaps in the ranking values.

If two or more rows in each partition have the same values, they receive the same rank. The next row has the rank increased by one.

Different from the RANK() function, the DENSE_RANK() function always generates consecutive rank values.

The syntax of the DENSE_RANK() function is as follows:

DENSE_RANK() OVER (
	PARTITION BY expr1[{,expr2...}]
	ORDER BY expr1 [ASC|DESC], [{,expr2...}]
)

In this syntax:

First, the PARTITION BY clause divides the result set produced by the FROM clause into partitions.
Then, The ORDER BY specifies the order of rows in each partition.
Finally, the DENSE_RANK() function is applied to the rows in the specified order of each partition. It resets the rank when the partition boundary is crossed.*/
CREATE TABLE t (
	col CHAR
);
	truncate table t
INSERT INTO t(col)
VALUES('A'),('B'),('B'),('C'),('D'),('D'),('E');
	
	
SELECT 	* FROM	t;


/*a) The following statement uses both DENSE_RANK() and RANK() functions to assign ranks to each row of the result set*/

SELECT
	col,
	DENSE_RANK() OVER (
		ORDER BY col
	) my_dense_rank,
	RANK() OVER (
		ORDER BY col
	) my_rank
FROM
	t;
--The following statement uses the DENSE_RANK() function to rank employees by their salaries:
/* b) In this example:

First, the PARTITION BY clause divided the employees by department names into partitions.
Then, the ORDER BY clause sorted the employees in each department (partition) by their salaries.
Finally, the DENSE_RANK() function was applied to each partition to assign the rank to rows based on the salary order.*/
	SELECT 
	employee_id,
	first_name, 
	last_name, 
	salary, 
	DENSE_RANK() OVER (
		ORDER BY salary DESC
	) salary_rank
FROM 
	employees;

/* c) If you want to find only employees who have the highest salary in their departments, you just to use a subquery in the FROM clause as follows:*/

SELECT 
	* 
FROM (
	SELECT 
		first_name, 
		last_name, 
		department_name,
		salary, 
		DENSE_RANK() OVER (
			PARTITION BY department_name
			ORDER BY salary DESC) salary_rank
	FROM 
		employees e
		INNER JOIN departments d 
			ON d.department_id = e.department_id
	) t
WHERE 
	salary_rank = 1;

--FIRST_VALUE() ----

	/*The FIRST_VALUE() is a window function that returns the first value in an ordered set of values.

The following illustrates the syntax of the FIRST_VALUE() function:

FIRST_VALUE(expression) OVER (
    partition_clause
    order_clause
    frame_clause
)
 
In this syntax:

 expression
The return value of the expression from the first row in a partition or result set.

The OVER clause consists of three clauses: partition_clause, order_clause, and frame_clause.

partition_clause
The partition_clause clause has the following syntax:

PARTITION BY expr1, expr2, ...
 
The PARTITION BY clause divides the rows of the result sets into partitions to which the FIRST_VALUE() function applies. If you skip the PARTITION BY clause, the function treats the whole result set as a single partition.

order_clause
The order_clause clause sorts the rows in partitions to which the FIRST_VALUE() function applies. The ORDER BY clause has the following syntax:

ORDER BY expr1 [ASC | DESC], expr2, ...
 
frame_clause
The frame_clause defines the subset (or frame) of the current partition. Check it out the window function tutorial for the detailed information of the frame clause.*/

/*The following statement finds the employee who has the lowest salary in the company:
In this example, the ORDER BY clause sorted the employees by salary and the FIRST_VALUE() selected the first name of the employee who has the lowest salary.*/

SELECT
    first_name,
    last_name,
    salary,
    FIRST_VALUE (first_name) OVER (
        ORDER BY salary
    ) lowest_salary
FROM
    employees e;



	----LAG()------


/*SQL LAG() is a window function that provides access to a row at a specified physical offset which comes before the current row.

In other words, by using the LAG() function, from the current row, you can access data of the previous row, or from the second row before the current row, or from the third row before current row, and so on.

The LAG() function can be very useful for calculating the difference between the current row and the previous row.

The following illustrates the syntax of the LAG() function:

LAG(return_value [,offset[, default_value ]]) OVER (
    PARTITION BY expr1, expr2,...
	ORDER BY expr1 [ASC | DESC], expr2,...
)

Let’s examine each element of the LAG() function in more detail.

return_value
The return value based on the specified offset. It can be a column of the row at a given offset from the current row.

offset
The number of rows back from the current row from which to access data. The offset must be a non-negative integer. It defaults to one if skipped.

default_value
If the preceding row is not specified, default_value is returned. For example, when the offset is 2, the return value from the first row is default_value. If default_value is not given and no preceding row found, NULL is returned by default.

PARTITION BY clause
The PARTITION BY clause organizes rows into one or more partitions to which the LAG() function is applied. The whole result is treated as a single partition if you omit the PARTITION BY clause.

ORDER BY clause
The ORDER BY clause specifies the order of rows in each partition to which the LAG() function is applied.*/

/*SQL LAG() function example
We will create a new table named basic_pays that stores the salary history of employees:*/

CREATE TABLE basic_pays (
	employee_id int,
	fiscal_year INT,
	salary DECIMAL(10 , 2 ),
	PRIMARY KEY (employee_id, fiscal_year)
);

INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(100,2017,24000);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(101,2017,17000);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(102,2017,17000);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(103,2017,9000);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(104,2017,6000);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(105,2017,4800);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(106,2017,4800);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(107,2017,4200);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(108,2017,12000);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(109,2017,9000);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(110,2017,8200);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(111,2017,7700);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(112,2017,7800);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(113,2017,6900);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(114,2017,11000);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(115,2017,3100);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(116,2017,2900);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(117,2017,2800);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(118,2017,2600);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(119,2017,2500);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(120,2017,8000);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(121,2017,8200);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(122,2017,7900);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(123,2017,6500);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(126,2017,2700);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(145,2017,14000);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(146,2017,13500);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(176,2017,8600);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(177,2017,8400);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(178,2017,7000);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(179,2017,6200);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(192,2017,4000);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(193,2017,3900);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(200,2017,4400);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(201,2017,13000);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(202,2017,6000);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(203,2017,6500);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(204,2017,10000);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(205,2017,12000);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(206,2017,8300);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(100,2018,25920);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(101,2018,18190);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(102,2018,18360);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(103,2018,9720);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(104,2018,6060);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(105,2018,4992);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(106,2018,5040);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(107,2018,4284);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(108,2018,12360);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(109,2018,9540);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(110,2018,8692);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(111,2018,7931);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(112,2018,8580);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(113,2018,7107);
INSERT INTO basic_pays(employee_id, fiscal_year,salary) VALUES(114,2018,11440);

--The following statement returns both the current and previous year’s salary of all employees:

SELECT 
	employee_id, 
	fiscal_year, 
	salary,
	LAG(salary) OVER (
		PARTITION BY employee_id 
		ORDER BY fiscal_year) previous_salary
FROM
	basic_pays;

/*In this example:

First, the PARTITION BY clause divided the result set into groups by employee ID.
Second, for each group, the ORDER BY clause sorted the rows by fiscal year in ascending order.
Third, LAG() function applied to the row of each group independently. The first row in each group was NULL because there was no previous year’s salary. The second and third row gots the salary from the first and second row and populated them into the previous_salary column.*/

/*The LAST_VALUE() is a window function that returns the last value in an ordered set of values.

The following illustrates the syntax of the LAST_VALUE() function:

LAST_VALUE(expression) OVER (
    partition_clause
    order_clause
    frame_clause
)
 
In this syntax:
expression
The returned value of the function which can be a column or an expression that results in a single value.

The OVER clause consists of three clauses: partition_clause, order_clause, and frame_clause.

partition_clause
The syntax of the partition_clause clause is as follows:

PARTITION BY expr1, expr2, ...

The PARTITION BY clause divides the rows of the result sets into partitions to which the LAST_VALUE() function applies. Because the PARTITION BY clause is optional, if you omit it, the function treats the whole result set as a single partition.

order_clause
The order_clause clause specified the order of rows in partitions to which the LAST_VALUE() function applies. The syntax of the ORDER BY clause is as follows:

ORDER BY expr1 [ASC | DESC], expr2, ...

frame_clause
The frame_clause defines the subset (or frame) of the partition being evaluated.
*/
--The following statement finds employees who have the highest salary in the company:
--In this example, the ORDER BY clause sorted employees by salary and the LAST_VALUE() selected the first name of the employee who has the lowest salary.

SELECT
    first_name,
    last_name,
    salary,
    LAST_VALUE (first_name) OVER (
        ORDER BY salary
        RANGE BETWEEN UNBOUNDED PRECEDING AND 
        UNBOUNDED FOLLOWING
    ) highest_salary
FROM
    employees;


	-- LEAD() --


/*SQL LEAD() is a window function that provides access to a row at a specified physical offset which follows the current row.

For example, by using the LEAD() function, from the current row, you can access data of the next row, or the second row that follows the current row, or the third row that follows the current row, and so on.

The LEAD() function can be very useful for calculating the difference between the value of the current row and the value of the following row. 

The syntax of the LEAD() function is as follows:

LEAD(return_value [,offset[, default ]]) OVER (
    PARTITION BY expr1, expr2,...
	ORDER BY expr1 [ASC | DESC], expr2,...
)
 
 return_value
The return value of the following row offsetting from the current row.

 offset
The number of rows forwards from the current row from which to access data. The offset must be a non-negative integer. If you don’t specify offset, it defaults to 1.

 default
The function returns default if the offset goes beyond the scope of the partition. If you do not specify default, NULL is returned.

 PARTITION BY clause
The PARTITION BY clause divides rows of the result set into partitions to which the LEAD() function applies. If you do not specify the PARTITION BY clause, the whole result set is treated as a single partition.

ORDER BY clause
The ORDER BY clause sorts the rows in each partition to which the LEAD() function applies.*/

--In this example, we omitted the PARTITION BY clause, therefore, the whole result was treated as a single partition. The ORDER BY clause sorted employees by hire dates in ascending order. The LEAD() function applied to each row in the result set.
SELECT 
	first_name,
	last_name, 
	hire_date, 
	LEAD(hire_date, 1) OVER (
		ORDER BY hire_date
	) AS next_hired
FROM 
	employees;


	---NTILE() --


	/*The SQL NTILE() is a window function that allows you to break the result set into a specified number of approximately equal groups, or buckets. It assigns each group a bucket number starting from one. For each row in a group, the NTILE() function assigns a bucket number representing the group to which the row belongs.

The syntax of the NTILE() function is as follows:

NTILE(buckets) OVER ( 
	PARTITION BY expr1, expr2,...
	ORDER BY expr1 [ASC|DESC], expr2 ...
)
 
Let’s examine the syntax in detail:

buckets
The number of buckets, which is a literal positive integer number or an expression that evaluates to a positive integer number.

PARTITION BY
The PARITITION BY clause divides the result set returned from the FROM clause into partitions to which the NTILE() function is applied.

ORDER BY
The ORDER BY clause specifies the order of rows in each partition to which the NTILE() is applied.

Notice that if the number of rows is not divisible by buckets, the NTILE() function results in groups of two sizes with the difference by one. The larger groups always come before the smaller group in the order specified by the ORDER BY clause.*/

CREATE TABLE t1 (
	col INT NOT NULL
);
	
INSERT INTO t1(col) 
VALUES(1),(2),(3),(4),(5),(6),(7),(8),(9),(10);
	
	
SELECT * FROM t1;

-- If you use the NTILE() function to divide ten rows into three groups, you will have the first group with four rows and other two groups with three rows.

SELECT 
	col, 
	NTILE (3) OVER (
		ORDER BY col
	) buckets
FROM 
	t1;

--The following statement uses the NTILE() function to divide the employees into five buckets based on their salaries:

SELECT
	first_name, 
	last_name, 
	salary,
	NTILE(5) OVER (
		ORDER BY salary DESC
	) salary_group
FROM 
	employees;

	--PERCENT_RANK()--

/*	The PERCENT_RANK() is a window function that calculates the percentile ranking of rows in a result set.

The syntax of the PERCENT_RANK() function is as follows:

PERCENT_RANK()  
    OVER ( 
        PARTITION BY expr1, expr2,...
        ORDER BY expr1 [ASC|DESC], expr2 ...
    )
 
The PERCENT_RANK() function returns a percentile ranking number which ranges from zero to one.

For a specific row, PERCENT_RANK() uses the following formula to calculate the percentile rank:

(rank - 1) / (total_rows - 1)
 
In this formula, rank is the rank of the row. total_rows is the number of rows that are being evaluated.

Based on this formula, the PERCENT_RANK() function always returns zero for the first row the result set.

The PARTITION BY clause divides the rows into partitions and the ORDER BY clause specifies the logical order of rows for each partition. The PERCENT_RANK() function is calculated for each ordered partition independently.

The PARTITION BY clause is optional. If you omit the PARTITION BY clause, the function treats the whole result set as a single partition. */



--The following query finds the percentile ranks of employees by their salaries:
--In this example, we omitted the PARTITION BY clause so the function treated the whole employees in the result set as a single partition. Notice that we used the ROUND() function to round the percentile rankings to two decimal places.
SELECT
    first_name,
    last_name,
    salary,
    ROUND(
        PERCENT_RANK() OVER (
            ORDER BY salary
        ) 
    ,2) percentile_rank
FROM
    employees;
 

 

----RANK()-----


/*
he RANK() function is a window function that assigns a rank to each row in the partition of a result set.

The rank of a row is determined by one plus the number of ranks that come before it.

The syntax of the RANK() function is as follows

RANK() OVER (
	PARTITION BY <expr1>[{,<expr2>...}]
	ORDER BY <expr1> [ASC|DESC], [{,<expr2>...}]
)
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, the PARTITION BY clause distributes the rows in the result set into partitions by one or more criteria.
Second, the ORDER BY clause sorts the rows in each a partition.
The RANK() function is operated on the rows of each partition and re-initialized when crossing each partition boundary.
The same column values receive the same ranks. When multiple rows share the same rank, the rank of the next row is not consecutive. This is similar to Olympic medaling in that if two athletes share the gold medal, there is no silver medal.
*/

CREATE TABLE c1 (
	col CHAR
);
	
INSERT INTO c1(col)
VALUES('A'),('B'),('B'),('C'),('D'),('D'),('E');
	
	
SELECT 
	*
FROM
	c1;
--The following statement uses the RANK() function to assign ranks to the rows of the result set:
--As clearly shown in the output, the second and third rows share the same rank because they have the same value. The fourth row gets the rank 4 because the RANK() function skips the rank 3.

--Note that if you want to have consecutive ranks, you can use the DENSE_RANK() function.

SELECT
	col,
	RANK() OVER (
		ORDER BY col
	) myrank
FROM
	c1;

--The following statement ranks employees by their salaries:
/*In this example, we omitted the PARTITION BY clause so the whole result set was treated as a single partition.

The ORDER BY clause sorted the rows in the result by salary. The RANK() function then is applied to each row in the result considering the order of employees by salary in descending order.*/

SELECT 
	first_name, 
	last_name, 
	salary, 
	RANK() OVER (ORDER BY salary) salary_rank
FROM 
	employees;

-----ROW_NUMBER-----
/*he ROW_NUMBER() is a window function that assigns a sequential integer number to each row in the query’s result set.

The following illustrates the syntax of the ROW_NUMBER() function:

ROW_NUMBER() OVER (
    [PARTITION BY expr1, expr2,...]
    ORDER BY expr1 [ASC | DESC], expr2,...
)
Code language: SQL (Structured Query Language) (sql)
In this syntax,

First, the PARTITION BY clause divides the result set returned from the FROM clause into partitions. The PARTITION BY clause is optional. If you omit it, the whole result set is treated as a single partition.
Then, the ORDER BY clause sorts the rows in each partition. Because the ROW_NUMBER() is an order sensitive function, the ORDER BY clause is required.
Finally, each row in each partition is assigned a sequential integer number called a row number. The row number is reset whenever the partition boundary is crossed.*/


-- a) The following statement finds the first name, last name, and salary of all employees. In addition, it uses the ROW_NUMBER() function to add sequential integer number to each row.


SELECT 
    ROW_NUMBER() OVER (
            ORDER BY salary
    ) row_num, 
    first_name, 
    last_name, 
    salary
FROM
    employees;

--b) Using SQL ROW_NUMBER() for finding nth highest value per group
--The following example shows you how to find the employees whose have the highest salary in their departments:
/*In the subquery:

First, the PARTITION BY clause distributes the employees by departments.
Second, the ORDER BY clause sorts the employee in each department by salary in the descending order.
Third, the ROW_NUMBER() assigns each row a sequential integer number. It resets the number when the department changes.*/

--In the outer query, we selected only the employee rows which have the row_num with the value 1.
--If you change the predicate in the WHERE clause from 1 to 2, 3, and so on, you will get the employees who have the second highest salary, third highest salary, and so on.
SELECT 
    department_name,
    first_name,
    last_name,
    salary
FROM 
    (
        SELECT 
            department_name,
            ROW_NUMBER() OVER (
                PARTITION BY department_name
                ORDER BY salary DESC) row_num, 
            first_name, 
            last_name, 
            salary
        FROM 
            employees e
            INNER JOIN departments d 
                ON d.department_id = e.department_id
    ) t
WHERE 
    row_num = 2;


---- USER DEFINED FUNCTIONS-----


--A scalar function returns a single value each time it is invoked, and is generally valid wherever an SQL expression is valid. A table functioncan be used in a FROM clause and returns a table. A row function can be used as a transform function and returns a row.

---- SCALAR VALUED FUNCTION--------


----------------

/*In this simple example, we will show you how to create the Sum Scalar functions without any parameters.

From the below aggregate query, you can observe that we are summing the Yearly Income of the MyEmployee table.

*/
--

CREATE FUNCTION NoParameters ()
  RETURNS INT
  AS
    BEGIN 
       RETURN (SELECT SUM([Salary]) FROM [employees])
    END


	select *,dbo.NoParameters() AS [Total Income] from employees


/*In this example, we will show you, How to create a Scalar function with parameters. From the below query, you can observe that we are concatinating First name and Last Name.
NOTE: We are using the SPACE to provide the space between the First name and last name.*/

-- Scalar with parameters example
CREATE FUNCTION fullName (@firstName VARCHAR(50), @lastName VARCHAR(50))
  RETURNS VARCHAR(200)
  AS
    BEGIN 
       RETURN (SELECT  @firstName + SPACE(2) + @lastName )
    END

SELECT employee_id
       -- Passing Parameters to fullname Function
      ,dbo.fullname(first_name, last_name) AS [Name]
      ,email
      ,phone_number
      ,hire_date
      ,salary
  FROM employees

  select * from employees



  ------TABLE VALUED FUNCTION -------------------



  ----INLINE TABLE VALUED FUNCTION--------


-- this simple example, we will show you, How to create a SQL Inline table valued function without any parameters. 
--From the below query, you can observe that we are selecting the top 10 records from the MyEmployee table.

-- Inline without parameters example


select * from employees

CREATE FUNCTION TopTenCustomers ()
  RETURNS TABLE
  AS
       RETURN (
		   SELECT TOP 10 first_name
		  ,last_name
		  ,email
		  ,phone_number
		  ,hire_date
		  ,salary
		  ,department_id
		  FROM employees
               )
SELECT * FROM [dbo].[TopTenCustomers] ()
GO

--Inline Function with Parameters Example
--This example shows how to create an Inline table valued functions with parameters.

--From the below query, you can see we are selecting the records from both the table using INNER JOIN, whose department is equal to a parameter that we pass.

select * from employees
		select * from departments

CREATE FUNCTION CustomerbyDepartment (@profession VARCHAR(50))
  RETURNS TABLE
  AS
     RETURN (
		SELECT  first_name
                ,last_name
		,email
		,phone_number
		,dept.department_name AS Department
		,salary AS Income
		,hire_date
		FROM employees AS e
		INNER JOIN 
		departments AS dept ON
		  dept.department_id = e.department_id
		WHERE [department_name] = @profession
		)



		SELECT * FROM [dbo].[CustomerbyDepartment] ('IT')
GO






-- exercises --

-- 1) Write a join query to find average list_price per category

SELECT 
    category_name,
    AVG(list_price) as Avg_list_price
FROM 
    production.products p INNER JOIN production.categories c
ON 
    p.category_id = c.category_id
Group by c.category_name;



-- 2) Write a query to show categories where average price < 500

select c.category_name, AVG(p.list_price) as Avg_price
from production.products p JOIN production.categories c
ON p.category_id = c.category_id
GROUP BY c.category_name
HAVING AVG(p.list_price) < 500;


-- 3)

SELECT 
    category_name,
    AVG(list_price) avg_product_price
FROM
    production.products p 
    INNER JOIN production.categories c
        ON c.category_id = p.category_id
GROUP BY 
    category_name
HAVING
    AVG(list_price) < 500
ORDER BY 
    category_name;
    

-- 4)

SELECT 
    category_name,
    AVG(list_price) as AVG_list_price
FROM
    production.products p LEFT JOIN production.categories c
    ON c.category_id = p.category_id
GROUP BY
    category_name
    HAVING 
        AVG(list_price) > 500
ORDER BY 
    category_name DESC;





