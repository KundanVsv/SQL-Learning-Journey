---------------------PIVOT------------------

--SQL Server PIVOT operator to convert rows to columns.
--SQL Server PIVOT operator rotates a table-valued expression. It turns the unique values in one column into multiple columns in the output and performs aggregations on any remaining column values.

--You need to follow these steps to make a query a pivot table:

--First, select a base dataset for pivoting.
--Second, create a temporary result by using a derived table or common table expression (CTE)
--Third, apply the PIVOT operator.

--Create and insert below tables for Pivot examples.
CREATE TABLE Customers
(
       CustomerName VARCHAR(50),
    ProductName VARCHAR(50),
    Amount INT
)
GO
INSERT INTO Customers VALUES('James', 'Laptop', 30000)
INSERT INTO Customers VALUES('James', 'Desktop', 25000)
INSERT INTO Customers VALUES('David', 'Laptop', 25000)
INSERT INTO Customers VALUES('Smith', 'Desktop', 30000)
INSERT INTO Customers VALUES('Pam', 'Laptop', 45000)
INSERT INTO Customers VALUES('Pam', 'Laptop', 30000)
INSERT INTO Customers VALUES('John', 'Desktop', 30000)
INSERT INTO Customers VALUES('John', 'Desktop', 30000)
INSERT INTO Customers VALUES('John', 'Laptop', 30000)

select * from Customers


/*

Section1:
Section 1 contains a select statement and this select statement has the column name that we want to display. 
In the output, we want CustomerName, Laptop, and Desktop and hence the select statement contains these three columns.
The first column (Customername) is the non-pivot column and the rest are pivot columns (Laptop and Desktop).

Section2:
This section actually gets the actual data that is needed for the pivot report.
In our example, the actual data is nothing but the Customers table data. 
Hence, you can see, here we use a select statement to get the data from the Customers table.

Section3:
This is the section where your Pivot function lies. 
Within the function first, we need to use an aggregate method like SUM, Count, etc. 
Here, we are using the SUM aggregate method and to this method, we pass the Amount filed as we are performing sum on the Amount column.
In the For clause, we need to pass the column name which contains values that are going to be column header.
In our case, it is the ProductName column. 
In the IN clause, we need to specify the Pivoted column names. In our example, it is a Laptop and Desktop.

*/

SELECT CustomerName, 
 Laptop, 
 Desktop
FROM
-- Section2: Get the Actual Data
(
   SELECT  *
   FROM Customers
) AS PivotData
-- Section3: Pivot function
PIVOT
(
 Sum(Amount) FOR ProductName 
 IN (Laptop, Desktop)
) AS PivotTable


---------------------UNPIVOT------------------

--The UNPIVOT operator performs exactly the opposite operation to PIVOT. That is, the UNPIVOT operator turns COLUMNS into ROWS. Let us understand this with an example. We are going to use the following ProductSales table to understand this concept.

--Create and insert below tables for UnPivot examples.
Create Table ProductSales
(
       AgentName VARCHAR(50),
       India int,
       US int,
       UK int
)
Go
INSERT INTO ProductSales VALUES ('Smith', 9160, 5220, 3360)
INSERT INTO ProductSales VALUES ('David', 9770, 5440, 8800)
INSERT INTO ProductSales VALUES ('James', 9870, 5480, 8900)
Go


SELECT * FROM ProductSales

/*Let us visualize the above Product Sales data from a different perspective. For example, we want to tell the sales amount, per count, per agent as shown below. Here, actually, we have to change the perspective of column-wise data into row-wise.
Here, we need to convert the column-wise data into row-wise. Now, the question is how we can do this in SQL Server? The SQL Server provides another built-in function called UNPIVOT which we can use to change the column-wise data into row-wise.*/
SELECT AgentName, Country, SalesAmount
FROM
--Section2
( 
   SELECT *
 FROM ProductSales) AS ActualData
--Section 3
UNPIVOT
(
       SalesAmount
       FOR Country IN (India, US, UK)
) AS UnpivotData

/*

Section1:
Section 1 contains a select statement and this select statement has the column name that we want to display in the pivot report. In the output, we want AgentName, Country, and SalesAmount and hence the select statement contains these three columns. The first column (AgentName) is the normal column and the rest are unpivot columns (Country and SalesAmount).

Section2:
This section gets the actual data from the actual table which is needed for the unpivot report. In our example, the actual data is nothing but the ProductSales table data. Hence, you can see, here we use a select statement to get the data from the ProductSales table.


Section3:
This is the section where our UNPIVOT function works. As we want sales amount by country, so we use SalesAmount For Country option here. As we want the column values India, US, UK as the column header, so here we pass these column values to the IN clause.

*/

---------------------STUFF--------------------
/*The STUFF() function deletes a part of a string and then inserts a substring into the string, beginning at a specified position.

The following shows the syntax of the STUFF() function:

STUFF ( input_string , start_position , length , replace_with_substring )
Code language: SQL (Structured Query Language) (sql)
The STUFF() function accepts four arguments:

input_string is the character string to be processed.
start_position is an integer that identifies the position to start deletion and insertion. If start_position is negative, zero, or longer than the length of the string, the function will return NULL.
length specifies the number of characters to delete. If the length is negative, the function returns NULL. If  length is longer than the length of the input_string, the function will delete the whole string. In case length is zero, the function will insert the replace_with_substring at the beginning of the input_string.
replace_with_substring is a substring that replaces length characters of the input_string beginning at start_position.*/

--1)Below example uses the STUFF() function to delete the first three characters of the string 'SQL Tutorial' and then insert the string 'SQL Server' at the beginning of the string:

SELECT 
    STUFF('SQL Tutorial', 1 , 3, 'SQL Server') result;

--2)The below example uses the STUFF() function to insert the colon (:) at the middle of the time in the format HHMM and returns the new time value in the format HH:MM:

SELECT 
    STUFF('1230', 3, 0, ':') AS formatted_time;

--3)The below example calls the STUFF() function twice to format a date from MMDDYYY to MM/DD/YYY:

SELECT 
    STUFF(STUFF('03102019', 3, 0, '/'), 6, 0, '/') formatted_date;
--4) Usecase:-This below  uses the STUFF() function to mask a credit card number. It reveals only the last four characters of the credit card no:

DECLARE 
    @ccn VARCHAR(20) = '4882584254460197';

SELECT 
    STUFF(@ccn, 1, LEN(@ccn) - 4, REPLICATE('X', LEN(@ccn) - 4))
    credit_card_no;


---------------------INDEXES--------------------



	--The following statement creates a new table named production.parts that consists of two columns part_id and part_name:

CREATE TABLE production.parts(
    part_id   INT NOT NULL, 
    part_name VARCHAR(100)
);

--And this statement inserts some rows into the production.parts table:

INSERT INTO 
    production.parts(part_id, part_name)
VALUES
    (1,'Frame'),
    (2,'Head Tube'),
    (3,'Handlebar Grip'),
    (4,'Shock Absorber'),
    (5,'Fork');

--The production.parts table does not have a primary key. Therefore SQL Server stores its rows in an unordered structure called a heap.

--When you query data from the production.parts table, the query optimizer needs to scan the whole table to search.

--For example, the following SELECT statement finds the part with id 5:

SELECT 
    part_id, 
    part_name
FROM 
    production.parts
WHERE 
    part_id = 5;
--If you display the estimated execution plan in SQL Server Management Studio, you’ll see how SQL Server come up with the following query plan:
--Because the production.parts table has only five rows, the query executes very fast. However, if the table contains a large number of rows, it’ll take a lot of time and resources to search for data.

--To resolve this issue, SQL Server provides a dedicated structure to speed up the retrieval of rows from a table called index.

--SQL Server has two types of indexes: clustered index and non-clustered index. We will focus on the clustered index in this tutorial.

--A clustered index stores data rows in a sorted structure based on its key values. Each table has only one clustered index because data rows can be only sorted in one order. A table that has a clustered index is called a clustered table.


--When you create a table with a primary key, SQL Server automatically creates a corresponding clustered index that includes primary key columns.

--This statement creates a new table named production.part_prices with a primary key that includes two columns: part_id and valid_from.

CREATE TABLE production.part_prices(
    part_id int,
    valid_from date,
    price decimal(18,4) not null,
    PRIMARY KEY(part_id, valid_from) 
);


--If you add a primary key constraint to an existing table that already has a clustered index, SQL Server will enforce the primary key using a non-clustered index:

ALTER TABLE production.parts
ADD PRIMARY KEY(part_id);


--When a table does not have a primary key, which is very rare, you can use the CREATE CLUSTERED INDEX statement to add a clustered index to it.

--The following statement creates a clustered index for the production.parts table:

CREATE CLUSTERED INDEX ix_parts_id
ON production.parts (part_id);  


-------------------------------NON CLUSTERED INDEXES-------------------------------------

--A nonclustered index is a data structure that improves the speed of data retrieval from tables. Unlike a clustered index, a nonclustered index sorts and stores data separately from the data rows in the table. It is a copy of selected columns of data from a table with the links to the associated table.

--Similar to a clustered index, a nonclustered index uses the B-tree structure to organize its data.

--A table may have one or more nonclustered indexes and each non-clustered index may include one or more columns of the table.

---Below is a query without indexes--

--If you display the estimated execution plan, you will see that the query optimizer scans the clustered index to find the row. This is because the sales.customers table does not have an index for the city column.


SELECT 
    customer_id, 
    city
FROM 
    sales.customers
WHERE 
    city = 'Atwater';


--To improve the speed of this query, you can create a new index named ix_customers_city for the city column:

CREATE INDEX ix_customers_city
ON sales.customers(city);


------------COMPOSITE INDEX---------------


--Using SQL Server CREATE INDEX statement to create a nonclustered index for multiple columns example

-- The below query finds the customer whose last name is Berg and first name is Monika:

SELECT 
    customer_id, 
    first_name, 
    last_name
FROM 
    sales.customers
WHERE 
    last_name = 'Berg' AND 
    first_name = 'Monika';
	
	
	--The query optimizer scans the clustered index to locate the customer.
	--To speed up the retrieval of data, you can create a nonclustered index that includes both last_name and first_name columns:

	CREATE INDEX ix_customers_name 
ON sales.customers(last_name, first_name);


---------------------IIF CONDITION--------------

--The IIF() function accepts three arguments. It evaluates the first argument and returns the second argument if the first argument is true; otherwise, it returns the third argument.

--The following shows the syntax of the IIF() function:

--IIF(boolean_expression, true_value, false_value)
--Below  example uses the IIF() function to check if 10 < 20 and returns the True string:
SELECT 
    IIF(10 < 20, 'True', 'False') Result ;

--The below  example nests IIF()function inside IIF() functions and returns the corresponding order status based on the status number:

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


-------------CORELATED SUBQUERY------------

--A correlated subquery is a subquery that uses the values of the outer query. In other words, the correlated subquery depends on the outer query for its values.

--Because of this dependency, a correlated subquery cannot be executed independently as a simple subquery.

--Moreover, a correlated subquery is executed repeatedly, once for each row evaluated by the outer query. The correlated subquery is also known as a repeating subquery.

--The following example finds the products whose list price is equal to the highest list price of the products within the same category:


SELECT
    product_name,
    list_price,
    category_id
FROM
    production.products p1
WHERE
    list_price IN (
        SELECT
            MAX (p2.list_price)
        FROM
            production.products p2
        WHERE
            p2.category_id = p1.category_id
        GROUP BY
            p2.category_id
    )
ORDER BY
    category_id,
    product_name;

--	In this example, for each product evaluated by the outer query, the subquery finds the highest price of all products in its category.

--If the price of the current product is equal to the highest price of all products in its category, the product is included in the result set. This process continues for the next product and so on.

--As you can see, the correlated subquery is executed once for each product evaluated by the outer query.

------------EXISTS WITH CORRELATED SUBQUERY--------------

select * from customers;
select * from sales; -- error there is no table with that particular name 

SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers c
WHERE
    EXISTS (
        SELECT
            COUNT (*)
        FROM
            sales.orders o
        WHERE
            customer_id = c.customer_id
        GROUP BY
            customer_id
        HAVING
            COUNT (*) > 2
    )
ORDER BY
    first_name,
    last_name;

--	In this example, we had a correlated subquery that returns customers who place more than two orders.

--If the number of orders placed by the customer is less than or equal to two, the subquery returns an empty result set that causes the EXISTS operator to evaluate to FALSE.

--Based on the result of the EXISTS operator, the customer will be included in the result set.


---------------------VIEW-------------------------------
--The following statement creates a view named daily_sales based on the orders, order_items, and products tables:

CREATE VIEW sales.daily_sales
AS
SELECT
    year(order_date) AS y,
    month(order_date) AS m,
    day(order_date) AS d,
    p.product_id,
    product_name,
    quantity * i.list_price AS sales
FROM
    sales.orders AS o
INNER JOIN sales.order_items AS i
    ON o.order_id = i.order_id
INNER JOIN production.products AS p
    ON p.product_id = i.product_id;

DROP VIEW sales.daily_sales
--Once the daily_sales view is created, you can query data against the underlying tables using a simple SELECT statement:
SELECT 
    * 
FROM 
    sales.daily_sales
ORDER BY
    y, m, d, product_name;
--To add the customer name column to the sales.daily_sales view, you use the CREATE VIEW OR ALTER as follows:

---------------------STORED PROCEDURE---------------------
--SELECT 
--	product_name, 
--	list_price
--FROM 
--	production.products
--ORDER BY 
--	product_name;

----In this syntax:

--The uspProductList is the name of the stored procedure.
--The AS keyword separates the heading and the body of the stored procedure.
--If the stored procedure has one statement, the BEGIN and END keywords surrounding the statement are optional. However, it is a good practice to include them to make the code clear.
--Note that in addition to the CREATE PROCEDURE keywords, you can use the CREATE PROC keywords to make the statement shorter.
--If everything is correct, then you will see the following message:

--Commands completed successfully.

--It means that the stored procedure has been successfully compiled and saved into the database catalog.


CREATE PROCEDURE uspProductList
AS
BEGIN
    SELECT 
        product_name, 
        list_price
    FROM 
        production.products
    ORDER BY 
        product_name;
END;


EXEC uspProductList;
--DROP PROCEDURE uspProductList;


--Creating a stored procedure with one parameter
/*
SELECT
    product_name,
    list_price
FROM 
    production.products
ORDER BY
    list_price;
	*/
--We can create a stored procedure that wraps this query using the CREATE PROCEDURE statement:
	CREATE PROCEDURE uspFindProducts
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    ORDER BY
        list_price;
END;

--However, this time we can add a parameter to the stored procedure to find the products whose list prices are greater than an input price:
--In this example:

--First, we added a parameter named @min_list_price to the uspFindProducts stored procedure. Every parameter must start with the @ sign. The AS DECIMAL keywords specify the data type of the @min_list_price parameter. The parameter must be surrounded by the opening and closing brackets.
--Second, we used @min_list_price parameter in the WHERE clause of the SELECT statement to filter only the products whose list prices are greater than or equal to the @min_list_price.

ALTER PROCEDURE uspFindProducts(@min_list_price AS DECIMAL)
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    WHERE
        list_price >= @min_list_price
    ORDER BY
        list_price;
END;

EXEC uspFindProducts 100;

--Creating a stored procedure with multiple parameters
--Stored procedures can take one or more parameters. The parameters are separated by commas.

--The following statement modifies the uspFindProducts stored procedure by adding one more parameter named @max_list_price to it:

ALTER PROCEDURE uspFindProducts(
    @min_list_price AS DECIMAL
    ,@max_list_price AS DECIMAL
)
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    WHERE
        list_price >= @min_list_price AND
        list_price <= @max_list_price
    ORDER BY
        list_price;
END;

--Once the stored procedure is modified successfully, you can execute it by passing two arguments, one for @min_list_price and the other for @max_list_price:

EXECUTE uspFindProducts 900, 1000;


--Using named parameters
--In case stored procedures have multiple parameters, it is better and more clear to execute the stored procedures using named parameters.

--For example, the following statement executes the uspFindProducts stored procedure using the named parameters @min_list_priceand @max_list_price:

EXECUTE uspFindProducts 
    @min_list_price = 900, 
    @max_list_price = 1000;
--Creating text parameters
--The following statement adds the @name parameter as a character string parameter to the stored procedure.

ALTER PROCEDURE uspFindProducts(
    @min_list_price AS DECIMAL
    ,@max_list_price AS DECIMAL
    ,@name AS VARCHAR(max)
)
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    WHERE
        list_price >= @min_list_price AND
        list_price <= @max_list_price AND
        product_name LIKE '%' + @name + '%'
    ORDER BY
        list_price;
END;

--In the WHERE clause of the SELECT statement, we added the following condition:

----product_name LIKE '%' + @name + '%'

--By doing this, the stored procedure returns the products whose list prices are in the range of min and max list prices and the product names also contain a piece of text that you pass in.

--Once the stored procedure is altered successfully, you can execute it as follows:

EXECUTE uspFindProducts 
    @min_list_price = 900, 
    @max_list_price = 1000,
    @name = 'Trek';

--In this statement, we used the uspFindProducts stored procedure to find the product whose list prices are in the range of 900 and 1,000 and their names contain the word Trek.

--------------TRANSACTION-----------------

--A transaction is a single unit of work that typically contains multiple T-SQL statements.

--If a transaction is successful, the changes are committed to the database. However, if a transaction has an error, the changes have to be rolled back.

--When executing a single statement such as INSERT, UPDATE, and DELETE, SQL Server uses the autocommit transaction. In this case, each statement is a transaction.

--To start a transaction explicitly, you use the BEGIN TRANSACTION or BEGIN TRAN statement first:

BEGIN TRANSACTION;

--Then, execute one or more statements including INSERT, UPDATE, and DELETE.

--Finally, commit the transaction using the COMMIT statement:

COMMIT;

--Or roll back the transaction using the ROLLBACK statement:

ROLLBACK;

--Here’s the sequence of statements for starting a transaction explicitly and committing it:

-- start a transaction
BEGIN TRANSACTION;

-- other statements

-- commit the transaction
COMMIT;



-- We’ll create two tables: invoices and invoice_items for the demonstration:

CREATE TABLE invoices (
  id int IDENTITY PRIMARY KEY,
  customer_id int NOT NULL,
  total decimal(10, 2) NOT NULL DEFAULT 0 CHECK (total >= 0)
);

CREATE TABLE invoice_items (
  id int,
  invoice_id int NOT NULL,
  item_name varchar(100) NOT NULL,
  amount decimal(10, 2) NOT NULL CHECK (amount >= 0),
  tax decimal(4, 2) NOT NULL CHECK (tax >= 0),
  PRIMARY KEY (id, invoice_id),
  FOREIGN KEY (invoice_id) REFERENCES invoices (id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);


--The invoices table stores the header of the invoice while the invoice_items table stores the line items. The total field in the invoices table is calculated from the line items.

--The following example uses the BEGIN TRANSACTION and COMMIT statements to create a transaction:

BEGIN TRANSACTION;

INSERT INTO invoices (customer_id, total)
VALUES (100, 0);

INSERT INTO invoice_items (id, invoice_id, item_name, amount, tax)
VALUES (10, 1, 'Keyboard', 70, 0.08),
       (20, 1, 'Mouse', 50, 0.08);

UPDATE invoices
SET total = (SELECT
  SUM(amount * (1 + tax))
FROM invoice_items
WHERE invoice_id = 1);

COMMIT;

---------------------SAVEPOINT------------------------

--A Savepoint is like a marker. It saves a particular portion of a transaction without rolling the entire transaction.

BEGIN TRAN;

INSERT INTO invoices (customer_id, total)
VALUES (100, 0);

SAVE TRAN ST1; 

INSERT INTO invoices (customer_id, total)
VALUES (100, 0),
(200, 0),
(300, 0),
(400, 0),
(500, 0);


ROLLBACK TRAN ST1;

select * from invoices


---------------------EXCEPTION HANDLING------------------
--An error condition during a program executionis called an exception.
--The mechanism for resolving such an exception is exception handlin
---------------------TRY/CATCH------------------------------

--The TRY CATCH construct allows you to gracefully handle exceptions in SQL Server. To use the TRY CATCH construct, you first place a group of Transact-SQL statements that could cause an exception in a BEGIN TRY...END TRY block as follows:

BEGIN TRY  
--   -- statements that may cause exceptions
END TRY  
--
--Then you use a BEGIN CATCH...END CATCH block immediately after the TRY block:

BEGIN CATCH  
--   -- statements that handle exception
END CATCH  

--The following illustrates a complete TRY CATCH construct:
--If the statements between the TRY block complete without an error, the statements between the CATCH block will not execute. However, if any statement inside the TRY block causes an exception, the control transfers to the statements in the CATCH block.

BEGIN TRY  
   -- statements that may cause exceptions
END TRY 
BEGIN CATCH  
   -- statements that handle exception
END CATCH 

--The CATCH block functions
--Inside the CATCH block, you can use the following functions to get the detailed information on the error that occurred:

--ERROR_LINE() returns the line number on which the exception occurred.
--ERROR_MESSAGE() returns the complete text of the generated error message.
--ERROR_PROCEDURE() returns the name of the stored procedure or trigger where the error occurred.
--ERROR_NUMBER() returns the number of the error that occurred.
--ERROR_SEVERITY() returns the severity level of the error that occurred.
--ERROR_STATE() returns the state number of the error that occurred.
--Note that you only use these functions in the CATCH block. If you use them outside of the CATCH block, all of these functions will return NULL.

--Nested TRY CATCH constructs
--You can nest TRY CATCH construct inside another TRY CATCH construct. However, either a TRY block or a CATCH block can contain a nested TRY CATCH, for example:

BEGIN TRY
    --- statements that may cause exceptions
END TRY
BEGIN CATCH
    -- statements to handle exception
    BEGIN TRY
        --- nested TRY block
    END TRY
    BEGIN CATCH
        --- nested CATCH block
    END CATCH
END CATCH



--SQL Server TRY CATCH examples

--First, create a stored procedure named usp_divide that divides two numbers:
--In this stored procedure, we placed the formula inside the TRY block and called the CATCH block functions ERROR_* inside the CATCH block.

CREATE PROC usp_divide(
    @a decimal,
    @b decimal,
    @c decimal output
) AS
BEGIN
    BEGIN TRY
        SET @c = @a / @b;
    END TRY
    BEGIN CATCH
        SELECT  
            ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;  
    END CATCH
END;
GO

--Now, call the usp_divide stored procedure to divide 10 by 2:

--Because no exception occurred in the TRY block, the stored procedure completed at the TRY block.

DECLARE @r decimal;
EXEC usp_divide 10, 2, @r output;
PRINT @r;


--Now lets attempt to divide 20 by zero by calling the usp_divide stored procedure:
-- Because of division by zero error which was caused by the formula, the control was passed to the statement inside the CATCH block which returned the error’s detailed information.
DECLARE @r2 decimal;
EXEC usp_divide 10, 0, @r2 output;
PRINT @r2;



--SQL Serer TRY CATCH with transactions
--Inside a CATCH block, you can test the state of transactions by using the XACT_STATE() function.

--If the XACT_STATE() function returns -1, it means that an uncommittable transaction is pending, you should issue a ROLLBACK TRANSACTION statement.
--In case the XACT_STATE() function returns 1, it means that a committable transaction is pending. You can issue a COMMIT TRANSACTION statement in this case.
--If the XACT_STATE() function return 0, it means no transaction is pending, therefore, you don’t need to take any action.
--It is a good practice to test your transaction state before issuing a COMMIT TRANSACTION or ROLLBACK TRANSACTION statement in a CATCH block to ensure consistency.

--Using TRY CATCH with transactions example
--First, set up two new tables sales.persons and sales.deals for demonstration:

CREATE TABLE sales.persons
(
    person_id  INT
    PRIMARY KEY IDENTITY, 
    first_name NVARCHAR(100) NOT NULL, 
    last_name  NVARCHAR(100) NOT NULL
);

CREATE TABLE sales.deals
(
    deal_id   INT
    PRIMARY KEY IDENTITY, 
    person_id INT NOT NULL, 
    deal_note NVARCHAR(100), 
    FOREIGN KEY(person_id) REFERENCES sales.persons(
    person_id)
);

insert into 
    sales.persons(first_name, last_name)
values
    ('John','Doe'),
    ('Jane','Doe');

insert into 
    sales.deals(person_id, deal_note)
values
    (1,'Deal for John Doe'),
    (2,'Deal for Jane Doe');

--Next, create a new stored procedure named usp_report_error that will be used in a CATCH block to report the detailed information of an error:

CREATE PROC usp_report_error
AS
    SELECT   
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_LINE () AS ErrorLine  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_MESSAGE() AS ErrorMessage;  
GO

--Then, lets develop a new stored procedure that deletes a row from the sales.persons table:

--In this stored procedure, we used the XACT_STATE() function to check the state of the transaction before performing COMMIT TRANSACTION or ROLLBACK TRANSACTION inside the CATCH block.

CREATE PROC usp_delete_person(
    @person_id INT
) AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        -- delete the person
        DELETE FROM sales.persons 
        WHERE person_id = @person_id;
        -- if DELETE succeeds, commit the transaction
        COMMIT TRANSACTION;  
    END TRY
    BEGIN CATCH
        -- report exception
        EXEC usp_report_error;
        
        -- Test if the transaction is uncommittable.  
        IF (XACT_STATE()) = -1  
        BEGIN  
            PRINT  N'The transaction is in an uncommittable state.' +  
                    'Rolling back transaction.'  
            ROLLBACK TRANSACTION;  
        END;  
        
        -- Test if the transaction is committable.  
        IF (XACT_STATE()) = 1  
        BEGIN  
            PRINT N'The transaction is committable.' +  
                'Committing transaction.'  
            COMMIT TRANSACTION;     
        END;  
    END CATCH
END;
GO

select * from sales.persons;
--After that, call the usp_delete_person stored procedure to delete the person id 2:

EXEC usp_delete_person 2;

--There was no exception occurred.
--Finally, lets call the stored procedure usp_delete_person to delete person id 1:

EXEC usp_delete_person 1;


---------------------ROLLUP-----------------------------
--The SQL Server ROLLUP is a subclause of the GROUP BY clause which provides a shorthand for defining multiple grouping sets. Unlike the CUBE subclause, ROLLUP does not create all possible grouping sets based on the dimension columns; the CUBE makes a subset of those.

--When generating the grouping sets, ROLLUP assumes a hierarchy among the dimension columns and only generates grouping sets based on this hierarchy.

--The ROLLUP is often used to generate subtotals and totals for reporting purposes.

--Let’s consider an example. The following CUBE (d1,d2,d3) defines eight possible grouping sets:

(d1, d2, d3)
(d1, d2)
(d2, d3)
(d1, d3)
(d1)
(d2)
(d3)
()

--And the ROLLUP(d1,d2,d3) creates only four grouping sets, assuming the hierarchy d1 > d2 > d3, as follows:

(d1, d2, d3)
(d1, d2)
(d1)
()

--The ROLLUP is commonly used to calculate the aggregates of hierarchical data such as sales by year > quarter > month.

/*SQL Server ROLLUP syntax
The general syntax of the SQL Server ROLLUP is as follows:

SELECT
    d1,
    d2,
    d3,
    aggregate_function(c4)
FROM
    table_name
GROUP BY
    ROLLUP (d1, d2, d3);*/

--In this syntax, d1, d2, and d3 are the dimension columns. The statement will calculate the aggregation of values in the column c4 based on the hierarchy d1 > d2 > d3.

---Example


--We will reuse the sales.sales_summary table created in the GROUPING SETS exmaple . If you have not created the sales.sales_summary table, you can use the following statement to create it.

SELECT
    b.brand_name AS brand,
    c.category_name AS category,
    p.model_year,
    round(
        SUM (
            quantity * i.list_price * (1 - discount)
        ),
        0
    ) sales INTO sales.sales_summary
FROM
    sales.order_items i
INNER JOIN production.products p ON p.product_id = i.product_id
INNER JOIN production.brands b ON b.brand_id = p.brand_id
INNER JOIN production.categories c ON c.category_id = p.category_id
GROUP BY
    b.brand_name,
    c.category_name,
    p.model_year
ORDER BY
    b.brand_name,
	c.category_name,
    p.model_year;


--The following query uses the ROLLUP to calculate the sales amount by brand (subtotal) and both brand and category (total).

SELECT
    brand,
    category,
    SUM (sales) sales
FROM
    sales.sales_summary
GROUP BY
    cube (category, brand);

 --In this example, the query assumes that there is a hierarchy between brand and category, which is the brand > category.   
 --Note that if you change the order of brand and category, the result will be different as shown in the following query:

 SELECT
    category,
    brand,
    SUM (sales) sales
FROM
    sales.sales_summary
GROUP BY
    ROLLUP (category, brand);

	--In this example, the hierarchy is the brand > segment

	--The following statement shows how to perform a partial roll-up:

	SELECT
    brand,
    category,
    SUM (sales) sales
FROM
    sales.sales_summary
GROUP BY
    brand,
    ROLLUP (category);

--------------------TRIGGERS------------------------------

--SQL Server triggers are special stored procedures that are executed automatically in response to the database object, database, and server events. SQL Server provides three type of triggers:

--Data manipulation language (DML) triggers which are invoked automatically in response to INSERT, UPDATE, and DELETE events against tables.
--Data definition language (DDL) triggers which fire in response to CREATE, ALTER, and DROP statements. DDL triggers also fire in response to some system stored procedures that perform DDL-like operations.

--The CREATE TRIGGER statement allows you to create a new trigger that is fired automatically whenever an event such as INSERT, DELETE, or UPDATE occurs against a table.


--Virtual tables for triggers: INSERTED and DELETED
--SQL Server provides two virtual tables that are available specifically for triggers called INSERTED and DELETED tables. SQL Server uses these tables to capture the data of the modified row before and after the event occurs.

--The following table shows the content of the INSERTED and DELETED tables before and after each event:
/*
DML event -	      INSERTED table holds            -   DELETED table holds
INSERT	  -       rows to be inserted	          -   empty
UPDATE	  -       new rows modified by the update -	  existing rows modified by the update
DELETE	  -       empty	                          -   rows to be deleted
*/
--The following illustrates the syntax of the CREATE TRIGGER statement:

CREATE TRIGGER [schema_name.]trigger_name
ON table_name
AFTER  {[INSERT],[UPDATE],[DELETE]}
[NOT FOR REPLICATION]
AS
{sql_statements}

--In this syntax:

--The schema_name is the name of the schema to which the new trigger belongs. The schema name is optional.
--The trigger_name is the user-defined name for the new trigger.
--The table_name is the table to which the trigger applies.
--The event is listed in the AFTER clause. The event could be INSERT, UPDATE, or DELETE. A single trigger can fire in response to one or more actions against the table.
--The NOT FOR REPLICATION option instructs SQL Server not to fire the trigger when data modification is made as part of a replication process.
--The sql_statements is one or more Transact-SQL used to carry out actions once an event occurs.



--1)The following statement creates a table named production.product_audits to record information when an INSERT or DELETE event occurs against the production.products table:
--The production.product_audits table has all the columns from the production.products table. In addition, it has a few more columns to record the changes e.g., updated_at, operation, and the change_id.

CREATE TABLE production.product_audits(
    change_id INT IDENTITY PRIMARY KEY,
    product_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    model_year SMALLINT NOT NULL,
    list_price DEC(10,2) NOT NULL,
    updated_at DATETIME NOT NULL,
    operation CHAR(3) NOT NULL,
    CHECK(operation = 'INS' or operation='DEL')
);


--2)Now we will create the after trigger

CREATE TRIGGER production.trg_product_audit
ON production.products
AFTER INSERT, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO production.product_audits(
        product_id, 
        product_name,
        brand_id,
        category_id,
        model_year,
        list_price, 
        updated_at, 
        operation
    )
    SELECT
        i.product_id,
        product_name,
        brand_id,
        category_id,
        model_year,
        i.list_price,
        GETDATE(),
        'INS'
    FROM
        inserted i
    UNION ALL
    SELECT
        d.product_id,
        product_name,
        brand_id,
        category_id,
        model_year,
        d.list_price,
        GETDATE(),
        'DEL'
    FROM
        deleted d;
END


--3) Testing the trigger
--The following statement inserts a new row into the production.products table:

INSERT INTO production.products(
    product_name, 
    brand_id, 
    category_id, 
    model_year, 
    list_price
)
VALUES (
    'Test product',
    1,
    1,
    2018,
    599
);

select * from production.products;
--select * from production,
---Because of the INSERT event, the production.trg_product_audit trigger of production.products table was fired.

--Let’s examine the contents of the production.product_audits table:

SELECT 
    * 
FROM 
    production.product_audits;

--The following statement deletes a row from the production.products table:

DELETE FROM 
    production.products
WHERE 
    product_id = 322;
--As expected, the trigger was fired and inserted the deleted row into the production.product_audits table:

SELECT 
    * 
FROM 
    production.product_audits;
---------------------COALESCE () Function-------------------

--The SQL Server COALESCE expression accepts a number of arguments, evaluates them in sequence, and returns the first non-null argument.
--The following example uses the COALESCE expression to return the string 'Hi' because it is the first non-null argument:

SELECT 
    COALESCE(NULL, 'Hi', 'Hello', NULL) result;

	-- The following query returns first name, last name, phone, and email of all customers:

SELECT 
    first_name, 
    last_name, 
    phone, 
    email
FROM 
    sales.customers
ORDER BY 
    first_name, 
    last_name;

--Here is the partial output:
--SQL Server COALESCE expression sample result set
--The phone column will have NULL if the customer does not have the phone number recorded in the sales.customers table.

--To make the output more business friendly, you can use the COALESCE expression to substitute NULL by the string N/A (not available) as shown in the following query:

SELECT 
    first_name, 
    last_name, 
    COALESCE(phone,'N/A') phone, 
    email
FROM 
    sales.customers
ORDER BY 
    first_name, 
    last_name;

---------------------CTE------------------------------------

--	Introduction to CTE in SQL Server
--CTE stands for common table expression. A CTE allows you to define a temporary named result set that available temporarily in the execution scope of a statement such as SELECT, INSERT, UPDATE, DELETE, or MERGE.

--In this syntax:

--First, specify the expression name (expression_name) to which you can refer later in a query.
--Next, specify a list of comma-separated columns after the expression_name. The number of columns must be the same as the number of columns defined in the CTE_definition.
--Then, use the AS keyword after the expression name or column list if the column list is specified.
--After, define a SELECT statement whose result set populates the common table expression.
--Finally, refer to the common table expression in a query (SQL_statement) such as SELECT, INSERT, UPDATE, DELETE, or MERGE.
--We prefer to use common table expressions rather than to use subqueries because common table expressions are more readable. We also use CTE in the queries that contain analytic functions (or window functions)



--Here are  some examples of using common table expressions.

--A) Simple SQL Server CTE example
--This query uses a CTE to return the sales amounts by sales staffs in 2018:

--In this example:

--First, we defined cte_sales_amounts as the name of the common table expression. the CTE returns a result that that consists of three columns staff, year, and sales derived from the definition query.
--Second, we constructed a query that returns the total sales amount by sales staff and year by querying data from the orders, order_items and staffs tables.
--Third, we referred to the CTE in the outer query and select only the rows whose year are 2018.

WITH cte_sales_amounts (staff, sales, year) AS (
    SELECT    
        first_name + ' ' + last_name, 
        SUM(quantity * list_price * (1 - discount)),
        YEAR(order_date)
    FROM    
        sales.orders o
    INNER JOIN sales.order_items i ON i.order_id = o.order_id
    INNER JOIN sales.staffs s ON s.staff_id = o.staff_id
    GROUP BY 
        first_name + ' ' + last_name,
        year(order_date)
)

SELECT
    staff, 
    sales
FROM 
    cte_sales_amounts
WHERE
    year = 2018;


	--B) Using a common table expression to make report averages based on counts
	--This example uses the CTE to return the average number of sales orders in 2018 for all sales staffs.
	--In this example:

--First, we used cte_sales as the name of the common table expression. We skipped the column list of the CTE so it is derived from the CTE definition statement. In this example, it includes staff_id and order_count columns.

	WITH cte_sales AS (
    SELECT 
        staff_id, 
        COUNT(*) order_count  
    FROM
        sales.orders
    WHERE 
        YEAR(order_date) = 2018
    GROUP BY
        staff_id

)
SELECT
    AVG(order_count) average_orders_by_staff
FROM 
    cte_sales;


--Second, we use the following query to define the result set that populates the common table expression cte_sales. The query returns the number of orders in 2018 by sales staff.
	SELECT    
    staff_id, 
    COUNT(*) order_count
FROM    
    sales.orders
WHERE 
    YEAR(order_date) = 2018
GROUP BY 
    staff_id;

--Third, we refer to the cte_sales in the outer statement and use the AVG() function to get the average sales order by all staffs.
	SELECT
    AVG(order_count) average_orders_by_staff
FROM 
    cte_sales;


--C) Using multiple SQL Server CTE in a single query example
--The following example uses two CTE cte_category_counts and cte_category_sales to return the number of the products and sales for each product category. The outer query joins two CTEs using the category_id column.


WITH cte_category_counts (
    category_id, 
    category_name, 
    product_count
)
AS (
    SELECT 
        c.category_id, 
        c.category_name, 
        COUNT(p.product_id)
    FROM 
        production.products p
        INNER JOIN production.categories c 
            ON c.category_id = p.category_id
    GROUP BY 
        c.category_id, 
        c.category_name
),
cte_category_sales(category_id, sales) AS (
    SELECT    
        p.category_id, 
        SUM(i.quantity * i.list_price * (1 - i.discount))
    FROM    
        sales.order_items i
        INNER JOIN production.products p 
            ON p.product_id = i.product_id
        INNER JOIN sales.orders o 
            ON o.order_id = i.order_id
    WHERE order_status = 4 -- completed
    GROUP BY 
        p.category_id
) 

SELECT 
    c.category_id, 
    c.category_name, 
    c.product_count, 
    s.sales
FROM
    cte_category_counts c
    INNER JOIN cte_category_sales s 
        ON s.category_id = c.category_id
ORDER BY 
    c.category_name;


-------while loop-----------


--The WHILE statement is a control-flow statement that allows you to execute a statement block repeatedly as long as a specified condition is TRUE.

--The following example illustrates how to use the WHILE statement to print out numbers from 1 to 5:



DECLARE @counter INT = 1;

WHILE @counter <= 5
BEGIN
    PRINT @counter;
    SET @counter = @counter + 1;
END

--In this example:

--First, we declared the @counter variable and set its value to one.
--Then, in the condition of the WHILE statement, we checked if the @counteris less than or equal to five. If it was not, we printed out the @counter and increased its value by one. After five iterations, the @counter is 6 which caused the condition of the WHILE clause evaluates to FALSE, the loop stopped.
-- Here , we have learned how to use the SQL Server WHILE statement to repeat the execution of a statement block based on a specified condition.


---------CASE --------------

--SQL Server CASE expression evaluates a list of conditions and returns one of the multiple specified results. The CASE expression has two formats: simple CASE expression and searched CASE expression. Both of CASE expression formats support an optional ELSE statement.

--Because CASE is an expression, you can use it in any clause that accepts an expression such as SELECT, WHERE, GROUP BY, and HAVING.


--This example uses the COUNT() function with the GROUP BY clause to return the number orders for each order’s status:

SELECT    
    order_status, 
    COUNT(order_id) order_count
FROM    
    sales.orders
WHERE 
    YEAR(order_date) = 2018
GROUP BY 
    order_status;

--The values in the order_status column are numbers, which is not meaningful in this case. To make the output more understandable, you can use the simple CASE expression as shown in the following query:

SELECT    
    CASE order_status
        WHEN 1 THEN 'Pending'
        WHEN 2 THEN 'Processing'
        WHEN 3 THEN 'Rejected'
        WHEN 4 THEN 'Completed'
    END AS order_status, 
    COUNT(order_id) order_count
FROM    
    sales.orders
WHERE 
    YEAR(order_date) = 2018
GROUP BY 
    order_status;
-----Example 2------
--
	SELECT    
    o.order_id, 
    SUM(quantity * list_price) order_value,
    CASE
        WHEN SUM(quantity * list_price) <= 500 
            THEN 'Very Low'
        WHEN SUM(quantity * list_price) > 500 AND 
            SUM(quantity * list_price) <= 1000 
            THEN 'Low'
        WHEN SUM(quantity * list_price) > 1000 AND 
            SUM(quantity * list_price) <= 5000 
            THEN 'Medium'
        WHEN SUM(quantity * list_price) > 5000 AND 
            SUM(quantity * list_price) <= 10000 
            THEN 'High'
        WHEN SUM(quantity * list_price) > 10000 
            THEN 'Very High'
    END order_priority
FROM    
    sales.orders o
INNER JOIN sales.order_items i ON i.order_id = o.order_id
WHERE 
    YEAR(order_date) = 2018
GROUP BY 
    o.order_id;




  -- SUMMARY
  -- Pivot
  -- Unpivot
  -- Stuff
  -- Indexes
  -- Non-clustered Indexes
        -- COMPOSITE INDEX
        -- IIF condition 
        -- Corelated Subquery
        -- EXISTS WITH CORRELATED SUBQUERY
 -- View 
 -- Stored procedure 
 -- Transaction
 -- Savepoint







-------- Exercises ---------
-- #1) create a view that displays all completed orders along with; 
-- order ID, customer full name, product name, quantity, total price of each iteml, Only include orders where the order status is 4 (Completed).
                                /*
   my code                             create view Completed_orders
                                AS
                                    SELECT 
                                        order_id,
                                        first_name,
                                        last_name,
                                        product_name,
                                        quantity,
                                        sum(list_price) Total_price,
                                    FROM
                                        sales.order_items i
                                        INNER JOIN production.products p 
                                            ON p.product_id = i.product_id
                                        INNER JOIN sales.orders o 
                                            ON o.order_id = i.order_id
                                    WHERE order_status = 4 -- completed
                                    GROUP BY 
                                        p.category_id  */
                                         --production.products p join sales.order_items s ON p.product_id = s.product_id,
                                         --sales.order_items e join sales.customers c ON e.customer_id = c.customer_id,
                                         --sales.orders o join sales.orders a ON o.customer_id = a.customer_id;


/*
1)
Create a view that displays all completed orders along with:
Order ID
Customer full name
Product name
Quantity
Total price of each item
Only include orders where the order status is 4 (Completed). */

------------------
CREATE VIEW v_completed_orders AS
SELECT o.order_id, 
       c.first_name + ' ' + c.last_name AS customer_name,
       p.product_name, 
       oi.quantity,
       (oi.quantity * oi.list_price * (1 - oi.discount)) AS total_price
FROM sales.orders o
JOIN sales.customers c ON o.customer_id = c.customer_id
JOIN sales.order_items oi ON o.order_id = oi.order_id
JOIN production.products p ON oi.product_id = p.product_id
WHERE o.order_status = 4;



/*
2)Create a view to display:
Employee ID
Employee full name
Manager full name
Use a SELF JOIN on the employees table.  */

----------------
CREATE VIEW v_employee_manager AS
SELECT e.employee_id, 
       e.first_name + ' ' + e.last_name AS employee_name,
       m.first_name + ' ' + m.last_name AS manager_name
FROM employees e
LEFT JOIN employees m 
ON e.manager_id = m.employee_id;



/*
3)Create a stored procedure that accepts a Store ID as input and returns the total sales amount for that store. */

CREATE PROCEDURE usp_store_sales 
@StoreID INT
AS
BEGIN
    SELECT s.store_name, 
           SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_sales
    FROM sales.orders o
    JOIN sales.order_items oi ON o.order_id = oi.order_id
    JOIN sales.stores s ON o.store_id = s.store_id
    WHERE o.store_id = @StoreID
    GROUP BY s.store_name;
END;


/*
4)Create a stored procedure that accepts:

Store ID
Start Date
End Date
And returns the total sales for that store within the given date range.   */

-----------------------------------------------------------------------------

CREATE PROCEDURE usp_store_sales_range 
@StoreID INT, 
@StartDate DATE, 
@EndDate DATE
AS
BEGIN
    SELECT s.store_name, 
           SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_sales
    FROM sales.orders o
    JOIN sales.order_items oi ON o.order_id = oi.order_id
    JOIN sales.stores s ON o.store_id = s.store_id
    WHERE o.store_id = @StoreID
      AND o.order_date BETWEEN @StartDate AND @EndDate
    GROUP BY s.store_name;
END;

/*
5)Demonstrate how to:

Insert a new order
Capture the generated Order ID
Insert order items
Create a SAVEPOINT
Roll back only the item section if needed
All inside a transaction using TRY-CATCH. */

-------------------------------------------------------------------
BEGIN TRANSACTION;

BEGIN TRY
    INSERT INTO sales.orders 
    (customer_id, order_status, order_date, required_date, store_id, staff_id)
    VALUES (1, 1, GETDATE(), DATEADD(DAY, 7, GETDATE()), 1, 1);

    DECLARE @OrderID INT = SCOPE_IDENTITY();

    SAVE TRANSACTION ItemInsert;

    INSERT INTO sales.order_items 
    (order_id, item_id, product_id, quantity, list_price, discount)
    VALUES (@OrderID, 1, 1, 5, 100, 0);

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
END CATCH;





