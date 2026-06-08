--Lets create a new schema named hr
--In a SQL database, a schema is a list of logical structures of data. A database user owns the schema, which has the same name as the database manager. As of SQL Server 2005, a  schema is an individual entity (container of objects) distinct from the user who constructs the object. In other words, schemas are similar to separate namespaces or containers used to handle database files. Schemas may be assigned security permissions, making them an effective method for distinguishing and defending database objects based on user access privileges. It increases the database's stability for security-related management.

CREATE SCHEMA hr;
GO

--Create two new tables named candidates and employees in the hr schema and insert the below values into it:

CREATE TABLE hr.candidates(
    id INT PRIMARY KEY IDENTITY,
    fullname VARCHAR(100) NOT NULL
);

CREATE TABLE hr.employees(
    id INT PRIMARY KEY IDENTITY,
    fullname VARCHAR(100) NOT NULL
);

INSERT INTO 
    hr.candidates(fullname)
VALUES
    ('John Doe'),
    ('Lily Bush'),
    ('Peter Drucker'),
    ('Jane Doe');


INSERT INTO 
    hr.employees(fullname)
VALUES
    ('John Doe'),
    ('Jane Doe'),
    ('Michael Scott'),
    ('Jack Sparrow');
	
select * from hr.candidates
select * from hr.employees
	
	---INNER JOIN--
--Inner join produces a data set that includes matching rows from left table and the right table.

--The following example uses the inner join clause to get the rows from the candidates table that has the corresponding rows with the same values in the fullname column of the employees table:

SELECT  
    c.id candidate_id,
    c.fullname candidate_name,
    e.id employee_id,
    e.fullname employee_name
FROM 
    hr.candidates c
    INNER JOIN hr.employees e 
        ON e.fullname = c.fullname;
		
		
-------Left Join-------


--Left join selects data starting from the left table and matching rows in the right table. The left join returns all rows from the left table and the matching rows from the right table. If a row in the left table does not have a matching row in the right table, the columns of the right table will have nulls.

--The left join is also known as the left outer join. The outer keyword is optional.

--The below statement joins the candidates table with the employees table using left join:		

SELECT  
	c.id candidate_id,
	c.fullname candidate_name,
	e.id employee_id,
	e.fullname employee_name
FROM 
	hr.candidates c
	LEFT JOIN hr.employees e 
		ON e.fullname = c.fullname;
		
		
-------Right Join-------		
		
--The right join or right outer join selects data starting from the right table. It is a reversed version of the left join.

--The right join returns a result set that contains all rows from the right table and the matching rows in the left table. If a row in the right table does not have a matching row in the left table, all columns in the left table will contain nulls.		

--The following example uses the right join to query rows from candidates and employees tables:
		
	
SELECT  
    c.id candidate_id,
    c.fullname candidate_name,
    e.id employee_id,
    e.fullname employee_name
FROM 
    hr.candidates c
    RIGHT JOIN hr.employees e 
        ON e.fullname = c.fullname;	
		
	-------- Full join -------------
--The full outer join or full join returns a result set that contains all rows from both left and right tables, with the matching rows from both sides where available. In case there is no match, the missing side will have NULL values.

-- The below example shows how to perform a full join between the candidates and employees tables:

SELECT  
    c.id candidate_id,
    c.fullname candidate_name,
    e.id employee_id,
    e.fullname employee_name
FROM 
    hr.candidates c
    FULL JOIN hr.employees e 
        ON e.fullname = c.fullname;

-----------Joins Using GroupBy and Having Clause-------

SELECT
    brand_name,
    AVG (list_price) avg_price
FROM
    production.products p
INNER JOIN production.brands b ON b.brand_id = p.brand_id
WHERE
    model_year = 2018
GROUP BY
    brand_name
HAVING avg(list_price) > 1000;

-----------Joins Using GroupBy and Order Clause-------




SELECT
    brand_name,
    AVG (list_price) avg_price
FROM
    production.products p
INNER JOIN production.brands b ON b.brand_id = p.brand_id
WHERE
    model_year = 2018
GROUP BY
    brand_name
ORDER BY 
    brand_name;



-------------Cross Join-------------

/*
The following illustrates the syntax of SQL Server CROSS JOIN of two tables:

SELECT
	select_list
FROM
	T1
CROSS JOIN T2;

The CROSS JOIN joined every row from the first table (T1) with every row from the second table (T2). In other words, the cross join returns a Cartesian product of rows from both tables.

Unlike the INNER JOIN or LEFT JOIN, the cross join does not establish a relationship between the joined tables.

Suppose the T1 table contains three rows 1, 2, and 3 and the T2 table contains three rows A, B, and C.

The CROSS JOIN gets a row from the first table (T1) and then creates a new row for every row in the second table (T2). It then does the same for the next row for in the first table (T1) and so on.
*/
--The following statement returns the combinations of all products and stores. The result set can be used for stocktaking procedure during the month-end and year-end closings:


SELECT
    product_id,
    product_name,
    store_id,
    0 AS quantity
FROM
    production.products
CROSS JOIN sales.stores
ORDER BY
    product_name,
    store_id;


	select * from production.products;
	select * from sales.stores;
	
	

		


		
		
		
		