-- CROSS JOINS
SELECT
	*
FROM
	LEFT_PRODUCTS
	CROSS JOIN RIGHT_PRODUCTS;

-- METHOD 1
SELECT
	*
FROM
	LEFT_PRODUCTS,
	RIGHT_PRODUCTS;

-- METHOD 2
SELECT
	*
FROM
	LEFT_PRODUCTS
	INNER JOIN RIGHT_PRODUCTS ON TRUE;

SELECT
	*
FROM
	ACTORS
	CROSS JOIN DIRECTORS;

----------------------------------------------------------------------------------------------------
-- Natural Joins
-- BY DEFAULT NATURAL JOIN IS INNER JOIN
SELECT
	COLUMN_FIRST
FROM
	TABLE1 NATURAL [INNER, LEFT, RIGHT]
	JOIN TABLE2;

SELECT
	*
FROM
	LEFT_PRODUCTS
	NATURAL JOIN RIGHT_PRODUCTS;

SELECT
	*
FROM
	MOVIES
	NATURAL LEFT JOIN DIRECTORS;

SELECT
	*
FROM
	MOVIES
	NATURAL RIGHT JOIN DIRECTORS;

----------------------------------------------------------------------------------------------------
-- Append tables with different columns
CREATE TABLE TABLE1 (ADD_DATE DATE, COL1 INT, COL2 INT, COL3 INT);

CREATE TABLE TABLE2 (
	ADD_DATE DATE,
	COL1 INT,
	COL2 INT,
	COL3 INT,
	COL4 INT,
	COL5 INT
);

INSERT INTO
	TABLE1
VALUES
	('2020-01-01', 1, 2, 3),
	('2020-01-02', 4, 5, 6);

SELECT
	*
FROM
	TABLE1;

INSERT INTO
	TABLE2
VALUES
	('2020-01-01', NULL, 7, 8, 9, 10),
	('2020-01-02', 11, 12, 13, 14, 15),
	('2020-01-03', 16, 17, 18, 19, 20);

SELECT
	*
FROM
	TABLE2;

SELECT
	COALESCE(T1.ADD_DATE, T2.ADD_DATE) AS ADD_DATE,
	COALESCE(T1.COL1, T2.COL1) AS COL1,
	COALESCE(T1.COL2, T2.COL2) AS COL2,
	COALESCE(T1.COL3, T2.COL3) AS COL3,
	T2.COL4,
	T2.COL5
FROM
	TABLE1 AS T1
	FULL OUTER JOIN TABLE2 AS T2 ON T1.ADD_DATE = T2.ADD_DATE; 