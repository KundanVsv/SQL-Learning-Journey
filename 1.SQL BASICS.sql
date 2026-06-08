create database SQLTRAINING;
GO
use SQLTRAINING;
GO


create table sales_1
(empid int primary key,
f_name char(20) NOT NULL,
l_name char(20) NOT NULL,
mobile_no bigint UNIQUE DEFAULT '444400000',
DOB date NOT NULL CHECK(DOB > '1980-01-01')
);
sp_help sales_1
--drop table orders_1
--drop table sales_1
--truncate table orders_1
--truncate table sales_1
select * from orders_1
select * from sales_1

INSERT INTO sales_1 values
(1,'peter','paul',9987667543,'1988-12-18'),
(2,'nancy', 'idi',085748898,'1991-03-01'),
(3, 'joy', 'dike', 9389499009,'1981-03-04'),
(4, 'ike', 'fueu', 8658796006,'2020-01-03');

select * from sales_1
--CHECK CONSTRAINT VALIDATION
INSERT INTO  sales_1 values
(5, 'roy', 'lewis', 9389677009,'1979-03-04')
--UNIQUE CONSTRAINT VALIDATION
INSERT INTO  sales_1 values
(5, 'roy', 'lewis', 9389499009,'1979-03-04')
--DEFAULT CONSTRAINT VALIDATION
INSERT INTO  sales_1 (empid,f_name,l_name,DOB)values
(5, 'roy', 'lewis','1989-03-04')

--delete from sales_1 where empid=5

select * from sales_1
select * from orders_1

CREATE TABLE orders_1
(empid INT Foreign Key References sales_1(empid),
order_id VARCHAR(20) UNIQUE,
product VARCHAR(20) NOT NULL,
city VARCHAR(20) DEFAULT 'Mumbai'
)

--drop table sales_1
--drop table orders_1

select * from sales_1
select * from orders_1 where order_id=110
truncate table orders_1
truncate table sales_1
insert into orders_1 values
(1, 110, 'banana', 'Surat'),
(2, 112, 'apple', 'Mumbai'),
(3, 113, 'grapes', 'Bengaluru')
select * from orders_1 where city = 'Mumbai'

-- DEFAULT CONSTRAINT VALIDATION
insert into orders_1 (empid,order_id,product)values(4, 115, 'mango')


select * from orders_1 where city like 'S_r_t' 


use SQLTRAINING

--Create
CREATE TABLE [dbo].[tblstudent]
    (
		[id] int NOT NULL,
       [student_code]      [VARCHAR](20) NOT NULL,
       [student_firstname] [VARCHAR](250) NOT NULL,
       [student_lastname]  [VARCHAR](10) NOT NULL,
       [address]           [VARCHAR](max) NULL,
       [city_code]         [VARCHAR](20) NOT NULL,
       [school_code]       [VARCHAR](20) NULL,
       [admissiondate]     [DATETIME] NULL,
       CONSTRAINT [PK_ID] PRIMARY KEY CLUSTERED ( [id] ASC )
    )

-- SELECT 
select id,student_code,student_firstname from tblstudent 
truncate table tblstudent
--INSERT

INSERT INTO tblstudent VALUES
(001,'S001','seema','tyagi','hgsgjhshjkhskjh','MH','DPS-MUM','2022-11-17'),
(002,'S002','geeta','kumar','hjjkhkjhjkhjhks','BN','DPS-BNG','2021-07-21'),
(003,'S003','smaeer','tyagi','hgsgjhshjkhskjh','MH','DPS-MUM','2022-05-11'),
(004,'S004','ritesh','gujaran','hgsgjhshjkhskjh','BN','DPS-BNG','2022-08-12'),
(005,'S005','karan','yadav','hgsgjhshjkhskjh','MH','DPS-MUM','2022-11-12'),
(006,'S006','seema','devadiga','hgsgjhshjkhskjh','MH','DPS-MUM','2022-11-27')

truncate table tblstudent
select  student_lastname from tblstudent
select  * from tblstudent

--alter

ALTER TABLE dbo.tblstudent
ADD GENDER VARCHAR(20)  NULL,mobile_no INT NULL ;


EXEC sp_rename 'dbo.tblstudent.Address', 'TempAddress';

Alter table tblstudent alter column Tempaddress nvarchar(1500);
Alter table tblstudent alter column Tempaddress drop NULL;
Alter table tblstudent drop column Tempaddress 

sp_help tblstudent

--DROP

DROP TABLE tblstudent

--UPDATE

UPDATE tblstudent SET address='SARJAPURA MAIN ROAD' WHERE student_code='S004'

--UPDATE FROM ANOTHER TABLE


UPDATE tblstudent SET address= (select city from orders_1 where order_id=113) WHERE student_code='S004'
---UPDATE WITH TOP

UPDATE TOP(3) tblstudent SET address= (select city from orders_1 where order_id=113) 

--------MERGE----------
USE [SQLTRAINING]
GO

/****** Object:  Table [dbo].[sales]    Script Date: 07-01-2023 16:24:35 ******/
SET ANSI_NULLS ON
GO
DROP TABLE Employee_Source
DROP TABLE Employee_Target
SET QUOTED_IDENTIFIER ON
GO
--Source Table
CREATE TABLE [dbo].[Employee_Source](
	[id] [int]  primary key,
	[name] [varchar](20) NOT NULL)
--Target Table 
CREATE TABLE [dbo].[Employee_Target](
	[id] [int]  primary key,
	[name] [varchar](20) NOT NULL)
	TRUNCATE TABLE Employee_Source
		TRUNCATE TABLE Employee_Target
	
	
	INSERT INTO  Employee_Source VALUES
	(1,'Ritesh'),
	(2,'Aarushi'),
	(3,'Chetan')

	-- update Employee_Target set name='Mike' where id=1
	-- update Employee_Target set name='Tom' where id=2
	
	INSERT INTO  Employee_Target VALUES
	(4,'Saksham')


	select * from Employee_Source;
	select * from Employee_Target;


	--Merge 

MERGE [TARGET] AS T 
USING [SOURCE] AS S
	ON [JOIN CONDITION]
WHEN MATCHED THEN
	[UPDATE STATEMENT]
WHEN NOT MATCHED BY TARGET THEN
	[INSERT STATEMENT]
WHEN NOT MATCHED BY SOURCE THEN
	[DELETE STATEMENT]


-- Merge Example


Merge Employee_Target AS T
Using Employee_Source AS S
ON T.id=S.id
WHEN MATCHED THEN 
UPDATE SET T.name=S.name
WHEN NOT MATCHED BY TARGET THEN
INSERT (id,name) values (S.id,S.name)
WHEN NOT MATCHED BY SOURCE THEN
DELETE;







