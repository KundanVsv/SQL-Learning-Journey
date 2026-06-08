--------AND OPERATOR-----------
--The AND is a logical operator that allows you to combine two Boolean expressions. It returns TRUE only when both expressions evaluate to TRUE.

--Example 1:
--The following example finds the products where the category identification number is one and the list price is greater than 400:
SELECT
    *
FROM
    production.products
WHERE
    category_id = 1
AND list_price > 400
ORDER BY
    list_price DESC;
	
	
--Example 2:
	
-- The following statement finds the products that meet all the following conditions: category id is 1, the list price is greater than 400, and the brand id is 1:

SELECT
    *
FROM
    production.products
WHERE
    category_id = 1
AND list_price > 400
AND brand_id = 1
ORDER BY
    list_price DESC;

--Example 3:

--In this example, we used both OR and AND operators in the condition. As always, SQL Server evaluated the AND operator first. Therefore, the query retrieved the products whose brand id is two and list price is greater than 1,000 or those whose brand id is one.

--To get the product whose brand id is one or two and list price is larger than 1,000, you use parentheses as follows:

SELECT
    *
FROM
    production.products
WHERE
    (brand_id = 1 OR brand_id = 2)
AND list_price > 1000
ORDER BY
    brand_id;


-----------OR Operator---------


----The SQL Server OR is a logical operator that allows you to combine two Boolean expressions. It returns TRUE when either of the conditions evaluates to TRUE.

--Example 1:

--The following example finds the products whose list price is less than 200 or greater than 6,000:

SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price < 200
OR list_price > 6000
ORDER BY
    list_price;

--Example 2:

--The following statement finds the products whose brand id is 1, 2, or 4:
	SELECT
    product_name,
    brand_id
FROM
    production.products
WHERE
    brand_id = 1
OR brand_id = 2
OR brand_id = 4
ORDER BY
    brand_id DESC;
	
	-----------NOT Operator---------
	
SELECT
    product_name,
    brand_id
FROM
    production.products
WHERE
NOT    brand_id = 1


--------UNION & UNION ALL OPERATOR--------------

-- SQL Server UNION is one of the set operations that allow you to combine results of two SELECT statements into a single result set which includes all the rows that belong to the SELECT statements in the union.

-- By default, the UNION operator removes all duplicate rows from the result sets. However, if you want to retain the duplicate rows, you need to specify the ALL keyword is explicitly as shown below:


SELECT
    first_name,
    last_name
FROM
    sales.staffs
UNION
SELECT
    first_name,
    last_name
FROM
    sales.customers;
	
--The staffs table has 10 rows and the customers table has 1,445 rows as shown in the following queries:

SELECT
    COUNT (*)
FROM
    sales.staffs;
-- 10       

SELECT
    COUNT (*)
FROM
    sales.customers;
-- 1454


-- Because the result set of the union returns only 1,454 rows, it means that one duplicate row was removed.

-- To include the duplicate row, you use the UNION ALL as shown in the following query:-- 

SELECT
    first_name,
    last_name
FROM
    sales.staffs
UNION ALL
SELECT
    first_name,
    last_name
FROM
    sales.customers;
	
	
	
	------------INTERSECT------------
	
	--The SQL Server INTERSECT combines result sets of two or more queries and returns distinct rows that are output by both queries.
	--The first query finds all cities of the customers and the second query finds the cities of the stores. The whole query, which uses INTERSECT, returns the common cities of customers and stores, which are the cities output by both input queries
	
	
SELECT
    city
FROM
    sales.customers
INTERSECT
SELECT
    city
FROM
    sales.stores
ORDER BY
    city;
	
	
	------------EXCEPT------------
	
	--The SQL Server EXCEPT compares the result sets of two queries and returns the distinct rows from the first query that are not output by the\second query. In other words, the EXCEPT subtracts the result set of a query from another.


--The following example uses the EXCEPT operator to find the products that have no sales:

SELECT
    product_id
FROM
    production.products
EXCEPT
SELECT
    product_id
FROM
    sales.order_items;


	------------LIKE------------
	
	/*The SQL Server LIKE is a logical operator that determines if a character string matches a specified pattern. A pattern may include regular characters and wildcard characters. The LIKE operator is used in the WHERE clause of the SELECT, UPDATE, and DELETE statements to filter rows based on pattern matching.
	
	Pattern
The pattern is a sequence of characters to search for in the column or expression. It can include the following valid wildcard characters:

The percent wildcard (%): any string of zero or more characters.
The underscore (_) wildcard: any single character.
The [list of characters] wildcard: any single character within the specified set.
The [^]: any single character not within a list or a range.
The wildcard characters makes the LIKE operator more flexible than the equal (=) and not equal (!=) string comparison operators.*/


--Example 1
--the following example finds the customers whose last name starts with the letter z:

SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE 'z%'
ORDER BY
    first_name;
	
--Example 2
--The following example returns the customers whose last name ends with the string er:
	
SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE '%er'
ORDER BY
    first_name;
	
	
-- Example 3
-- The following statement retrieves the customers whose last name starts with the letter t and ends with the letter s:

SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE 't%s'
ORDER BY
    first_name;
	
	--Example 4
	--The underscore represents a single character. For example, the following statement returns the customers where the second character is the letter u:
	
/*	The pattern _u%

The first underscore character ( _) matches any single character.
The second letter u matches the letter u exactly
The third character % matches any sequence of characters */

SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE '_u%'
ORDER BY
    first_name; 

--Exmaple 5
--The following query returns the customers where the first character in the last name is not the letter in the range A through X:

SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE '%[^A-X]__' -- query selects the customers where the third last character in the last_name is y OR z;
ORDER BY
    last_name;
	
	
	
------BETWEEN & NOT BETWEEN--------
--The BETWEEN operator is a logical operator that allows you to specify a range to test.

--Example1
--The following query finds the products whose list prices are between 149.99 and 199.99:

SELECT
    product_id,
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price BETWEEN 149.99 AND 199.99
ORDER BY
    list_price;
	
	--Example2
--To get the products whose list prices are not in the range of 149.99 and 199.99, you use the NOT BETWEEN operator as follows:
	
	SELECT
    product_id,
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price NOT BETWEEN 149.99 AND 199.99
ORDER BY
    list_price;
	
--Example3	

--The following query finds the orders that customers placed between January 15, 2017 and January 17, 2017:

SELECT
    order_id,
    customer_id,
    order_date,
    order_status
FROM
    sales.orders
WHERE
    order_date BETWEEN '20170115' AND '20170117'
ORDER BY
    order_date;
	
	
----------WHERE CLAUSE AND ORDERBY CLUASE-----------
	
--When you use the SELECT statement to query data against a table, you get all the rows of that table, which is unnecessary because the application may only process a set of rows at the time.

--To get the rows from the table that satisfy one or more conditions, you use the WHERE clause

--To sort the rows in ASCENDING OR DESCENDING we use orderby clause 
	

--Example1 

--The following statement retrieves all products with the category id 1:

SELECT top 19
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
    category_id = 1 AND list_price between 100 AND 400
ORDER BY
    list_price DESC;
	
--The following example returns products that meet two conditions: category id is 1, and the model is 2018. It uses the logical operator AND to combine the two conditions.

SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
    category_id = 1 AND model_year = 2018
ORDER BY
    list_price DESC;
	
	
------------GROUPBY--------------

--The GROUP BY clause allows you to arrange the rows of a query in groups. The groups are determined by the columns that you specify in the GROUP BY clause.

--In this query, the GROUP BY clause produced a group for each combination of the values in the columns listed in the GROUP BY clause.

--Consider the following example:

SELECT
    customer_id,
    YEAR (order_date) order_year
FROM
    sales.orders
WHERE
    customer_id IN (1, 2)
ORDER BY
    customer_id;	
	
--- In this example, we retrieved the customer id and the ordered year of the customers with customer id one and two.

-- As you can see clearly from the output, the customer with the id one placed one order in 2016 and two orders in 2018. The customer with id two placed two orders in 2017 and one order in 2018.

-- Let’s add a GROUP BY clause to the query to see the effect:	
--The GROUP BY clause arranged the first three rows into two groups and the next three rows into the other two groups with the unique combinations of the customer id and order year.
SELECT
    customer_id,
    YEAR (order_date) order_year
FROM
    sales.orders
WHERE
    customer_id IN (1, 2)
GROUP BY
    customer_id,
    YEAR (order_date)
ORDER BY
    customer_id;
	
	
	-----Example 2
	
	---The following query returns the number of customers in every city:

SELECT
    city,
    COUNT (customer_id) customer_count
FROM
    sales.customers
GROUP BY
    city
ORDER BY
    city;
	
	
	--------------HAVING CLAUSE-----------
	
	--The HAVING clause is often used with the GROUP BY clause to filter groups based on a specified list of conditions. 
	
	---The following statement uses the HAVING clause to find the customers who placed at least two orders per year:
	
	--In this example First, the GROUP BY clause groups the sales order by customer and order year. The COUNT() function returns the number of orders each customer placed in each year.
--Second, the HAVING clause filtered out all the customers whose number of orders is less than two.

SELECT
    customer_id,
    YEAR (order_date),
    COUNT (order_id) order_count
FROM
    sales.orders
GROUP BY
    customer_id,
    YEAR (order_date)
HAVING
    COUNT (order_id) >= 2
ORDER BY
    customer_id;
	
	
--------------------Temporary tables----------------------	
	
----Temporary tables are tables that exist temporarily on the SQL Server.
--The temporary tables are useful for storing the immediate result sets that are accessed multiple times.	

--To create a temporary table is to use the CREATE TABLE statement:

CREATE TABLE #haro_products (
    product_name VARCHAR(MAX),
    list_price DEC(10,2)
);

CREATE TABLE ##haro_products (
    product_name VARCHAR(MAX),
    list_price DEC(10,2)
);

--This statement has the same syntax as creating a regular table. However, the name of the temporary table starts with a hash symbol (#)

--After creating the temporary table, you can insert data into this table as a regular table:

INSERT INTO #haro_products
SELECT
    product_name,
    list_price
FROM 
    production.products
WHERE
    brand_id = 2;

-- Of course, you can query data against it within the current session:

SELECT
    *
FROM
    #haro_products;
	
	
-- Global Temporary Table
	
---Sometimes, you may want to create a temporary table that is accessible across connections. In this case, you can use global temporary tables.

--Unlike a temporary table, the name of a global temporary table starts with a double hash symbol (##).

--The following statements first create a global temporary table named ##heller_products and then populate data from the production.products table into this table:

CREATE TABLE ##heller_products (
    product_name VARCHAR(MAX),
    list_price DEC(10,2)
);

INSERT INTO ##heller_products
SELECT
    product_name,
    list_price
FROM 
    production.products
WHERE
    brand_id = 3;
	
select * from ##heller_products 