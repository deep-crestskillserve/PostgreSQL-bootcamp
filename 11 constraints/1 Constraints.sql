-- NOT NULL CONSTRAINT
CREATE TABLE TABLE_NN (ID SERIAL PRIMARY KEY, TAG TEXT NOT NULL);

SELECT
	*
FROM
	TABLE_NN;

INSERT INTO
	TABLE_NN (TAG)
VALUES
	('ADAM');

INSERT INTO
	TABLE_NN (TAG)
VALUES
	(NULL);

INSERT INTO
	TABLE_NN (TAG)
VALUES
	('');

CREATE TABLE TABLE_NN2 (ID SERIAL PRIMARY KEY, TAG2 TEXT);

SELECT
	*
FROM
	TABLE_NN2;

ALTER TABLE TABLE_NN2
ALTER COLUMN TAG2
SET NOT NULL;

INSERT INTO
	TABLE_NN2 (TAG2)
VALUES
	('DEEP');

INSERT INTO
	TABLE_NN2 (TAG2)
VALUES
	(NULL);

----------------------------------------------------------------------------------------------------
-- UNIQUE CONSTRAINT
CREATE TABLE EMAILS (ID SERIAL PRIMARY KEY, EMAIL TEXT UNIQUE);

SELECT
	*
FROM
	EMAILS;

INSERT INTO
	EMAILS (EMAIL)
VALUES
	('A@B.COM'),
	('B@C.COM');

INSERT INTO
	EMAILS (EMAIL)
VALUES
	('A@B.COM');

INSERT INTO
	EMAILS (EMAIL)
VALUES
	('C@D.COM');

CREATE TABLE TABLE_PRODUCTS (
	ID SERIAL PRIMARY KEY,
	PRODUCT_CODE VARCHAR(10),
	PRODUCT_NAME TEXT
);

SELECT
	*
FROM
	TABLE_PRODUCTS;

ALTER TABLE TABLE_PRODUCTS
ADD CONSTRAINT UNIQUE_PRODUCT_CODE UNIQUE (PRODUCT_CODE, PRODUCT_NAME);

SELECT
	*
FROM
	TABLE_PRODUCTS;

INSERT INTO
	TABLE_PRODUCTS (PRODUCT_CODE, PRODUCT_NAME)
VALUES
	('A', 'APPLE');

----------------------------------------------------------------------------------------------------
-- DEFAULT CONSTRAINT
CREATE TABLE EMPLOYEES (
	EMPLOYEE_ID SERIAL PRIMARY KEY,
	FIRST_NAME VARCHAR(50),
	LAST_NAME VARCHAR(50),
	IS_ENABLE VARCHAR(2) DEFAULT 'Y'
);

-- UPON USING DEFAULT KEYWORD, IF NO VALUE IS ASSIGNED THEN IT IS ASIGNED TO NULL BY DEFAULT
SELECT
	*
FROM
	EMPLOYEES;

INSERT INTO
	EMPLOYEES (FIRST_NAME, LAST_NAME)
VALUES
	('DEEP1', 'DABHI');

ALTER TABLE EMPLOYEES
ALTER COLUMN IS_ENABLE
SET DEFAULT 'N';

----------------------------------------------------------------------------------------------------
-- PRIMARY KEY CONSTRAINTS
CREATE TABLE TABLE_ITEMS (
	ITEM_ID INTEGER PRIMARY KEY,
	ITEM_NAME VARCHAR(100) NOT NULL
);

SELECT
	*
FROM
	TABLE_ITEMS;

INSERT INTO
	TABLE_ITEMS (ITEM_ID, ITEM_NAME)
VALUES
	(2, 'PEN1');

ALTER TABLE TABLE_ITEMS
ALTER COLUMN ITEM_NAME
DROP NOT NULL;

-- PRIMARY KEY CONSTRAINTS ON MULTIPLE COLUMNS - COMPOSITE KEY
-- ADD TO COLUMN
CREATE TABLE GRADES (
	COURSE_ID VARCHAR(100) NOT NULL,
	STUDENT_ID VARCHAR(100) NOT NULL,
	GRADE INT NOT NULL,
	PRIMARY KEY (COURSE_ID, STUDENT_ID)
	-- SO HERE, THE PRIMARY KEYS ARE CONSIDERED AS THE COMBINATION OF WTOW KWYS
	-- SO IT IS A COMPOSITE KEY
	-- A REPITITIVE ENTRY OF COURSE_ID AND STUDENT_ID COMBINATION WILL CAUSE AN ERROR
);

INSERT INTO
	GRADES (COURSE_ID, STUDENT_ID, GRADE)
VALUES
	('MATH', 'S1', 50),
	('CHEMISTRY', 'S1', 70),
	('ENGLISH', 'S2', 70),
	('PHYSICS', 'S1', 80),
	('MATH', 'S2', 70);

INSERT INTO
	GRADES (COURSE_ID, STUDENT_ID, GRADE)
VALUES
	('MATH', 'S1', 70);

SELECT
	*
FROM
	GRADES;

ALTER TABLE GRADES
DROP CONSTRAINT GRADES_PKEY;

SELECT
	*
FROM
	GRADES;

ALTER TABLE GRADES
ADD CONSTRAINT GRADES_COURSE_ID_STUDENT_ID_PKEY PRIMARY KEY (COURSE_ID, STUDENT_ID);

----------------------------------------------------------------------------------------------------
-- FOREIGN KEY
-- TABLE WITHOUT FOREIGN KEY CONSTRAINTS
CREATE TABLE T_SUPPLIERS (
	SUPPLIER_ID INT PRIMARY KEY,
	SUPPLIER_NAME VARCHAR(50) NOT NULL
);

CREATE TABLE T_PRODUCTS (
	PRODUCT_ID INT PRIMARY KEY,
	PRODUCT_NAME VARCHAR(50) NOT NULL,
	SUPPLIER_ID INT NOT NULL
);

INSERT INTO
	T_SUPPLIERS (SUPPLIER_ID, SUPPLIER_NAME)
VALUES
	(1, 'SUP1'),
	(2, 'SUP2');

SELECT
	*
FROM
	T_SUPPLIERS;

INSERT INTO
	T_PRODUCTS (PRODUCT_ID, PRODUCT_NAME, SUPPLIER_ID)
VALUES
	(1, 'PEN', 1),
	(2, 'PENCIL', 2);

SELECT
	*
FROM
	T_PRODUCTS;

INSERT INTO
	T_PRODUCTS (PRODUCT_ID, PRODUCT_NAME, SUPPLIER_ID)
VALUES
	(3, 'ERASER', 10),
	(4, 'BAG', 100);

-- THERE IS NO RELATION BETWEEN THE TWO TABLES, SO WE ARE ABLE TO ADD DATA IN PRODUCTS TABLE. EVEN AFTER, NOT HAVING THE SUPPLIER 10 AND 100 IN SUPPLIER RELATION
-- SO BECAUSE OF NO INVOLVEMENT OF SUCH SUPPLIERS, ENTERED DATA IS INVALID
----------------------------------------------------------------------------------------------------
-- CREATING FOREIGN KEY CONSTRAINTS
DROP TABLE T_PRODUCTS;

DROP TABLE T_SUPPLIERS;

CREATE TABLE T_SUPPLIERS ( -- THIS IS THE CHILD TABLE OF T_PRODUCTS
	-- SO THIS IS THE FOREIGN TABLE
	SUPPLIER_ID INT PRIMARY KEY,
	SUPPLIER_NAME VARCHAR(100) NOT NULL
);

CREATE TABLE T_PRODUCTS ( -- THIS IS THE PARENT TABLE OF T_SUPPLIERS
	-- SO THIS IS THE PRIMARY TABLE
	PRODUCT_ID INT PRIMARY KEY,
	PRODUCT_NAME VARCHAR(100) NOT NULL,
	SUPPLIER_ID INT NOT NULL,
	FOREIGN KEY (SUPPLIER_ID) REFERENCES T_SUPPLIERS (SUPPLIER_ID)
);

-- POSTGRESQL FOREIGN KEY IS BASED ON THE FIRST TABLE COMBINATION OF 
-- COLUMN WITH PRIMARY KEY VALUES FROM THE SECOND TABLE
-- A FOREIGN KEY SOMETHING THAT KINDA LINK THESE TWO TABLES 
----------------------------------------------------------------------------------------------------
-- FOREIGN KEYS MAINTAINS REFERENTIAL DATA INTEGRITY
-- MAKE SURE DATA IS TO BE REFERENCED IS AVAILABLE INSIDE OF THE FOREIGN TABLE BEFORE USING THE SAME INSIDE THE PRIMARY TABLE
INSERT INTO
	T_SUPPLIERS (SUPPLIER_ID, SUPPLIER_NAME)
VALUES
	(10, 'SUP10'),
	(1, 'SUP1'),
	(2, 'SUP2');

SELECT
	*
FROM
	T_SUPPLIERS;

INSERT INTO
	T_PRODUCTS (PRODUCT_ID, PRODUCT_NAME, SUPPLIER_ID)
VALUES
	(1, 'PEN', 1),
	(2, 'PENCIL', 2);

SELECT
	*
FROM
	T_PRODUCTS;

INSERT INTO
	T_PRODUCTS (PRODUCT_ID, PRODUCT_NAME, SUPPLIER_ID)
VALUES
	(3, 'BOTTLE', 10);

-- DELETE
DELETE FROM T_PRODUCTS
WHERE
	PRODUCT_ID = 3;

DELETE FROM T_SUPPLIERS
WHERE
	SUPPLIER_ID = 10;

UPDATE T_PRODUCTS
SET
	SUPPLIER_ID = 2
WHERE
	PRODUCT_ID = 1;

----------------------------------------------------------------------------------------------------
-- DROP A CONSTRAINT
ALTER TABLE T_PRODUCTS
DROP CONSTRAINT T_PRODUCTS_SUPPLIER_ID_FKEY;

----------------------------------------------------------------------------------------------------
-- Add or update foreign key constraint on existing table
-- 1. FIRST DROP THE CONSTRAINT
-- 2. ASSIGN NEW CONSTRAINT
ALTER TABLE TABLENAME
DROP CONSTRAINT CNAME;

ALTER TABLE T_PRODUCTS
ADD CONSTRAINT T_PRODUCTS_SUPPLIER_ID_FKEY FOREIGN KEY (SUPPLIER_ID) REFERENCES T_SUPPLIERS (SUPPLIER_ID);

----------------------------------------------------------------------------------------------------
-- CHECK constraint - Add to new table
CREATE TABLE STAFF (
	STAFF_ID SERIAL PRIMARY KEY,
	FIRST_NAME VARCHAR(50),
	LAST_NAME VARCHAR(50),
	BIRTH_DATE DATE CHECK (BIRTH_DATE > '1991-01-01'),
	JOINED_DATE DATE CHECK (JOINED_DATE > BIRTH_DATE),
	SALARY NUMERIC CHECK (SALARY > 0)
)
SELECT
	*
FROM
	STAFF;

INSERT INTO
	STAFF (
		FIRST_NAME,
		LAST_NAME,
		BIRTH_DATE,
		JOINED_DATE,
		SALARY
	)
VALUES
	(
		'DEEP',
		'DABHI',
		'14-05-2004',
		'06-01-2025',
		15000
	);

SELECT
	*
FROM
	STAFF;

INSERT INTO
	STAFF (
		FIRST_NAME,
		LAST_NAME,
		BIRTH_DATE,
		JOINED_DATE,
		SALARY
	)
VALUES
	(
		'DEEP',
		'DABHI',
		'14-05-2004',
		'06-05-2024',
		-15000
	);

-- CHECK IS NAMED AS {TABLE}_{COLUMN}_CHECK
----------------------------------------------------------------------------------------------------
-- CHECK constraint - Add, Rename, Drop on existing table
CREATE TABLE PRICES (
	PRICE_ID SERIAL PRIMARY KEY,
	PRODUCT_ID INT NOT NULL,
	PRICE NUMERIC NOT NULL,
	DISCOUNT NUMERIC NOT NULL,
	VALID_FROM_DATE DATE NOT NULL
);

ALTER TABLE PRICES
ADD CONSTRAINT PRICE_DISCOUNT_CHECK CHECK (
	PRICE > 0
	AND DISCOUNT >= 10
	AND PRICE > DISCOUNT
);

INSERT INTO
	PRICES (PRODUCT_ID, PRICE, DISCOUNT, VALID_FROM_DATE)
VALUES
	(1, 100, 30, '01-01-2025');

SELECT
	*
FROM
	PRICES;

ALTER TABLE PRICES
RENAME CONSTRAINT PRICE_CHECK TO PRICE_DISCOUNT_CHECK;

ALTER TABLE PRICES
DROP CONSTRAINT PRICE_DISCOUNT_CHECK;