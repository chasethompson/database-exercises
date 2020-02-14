-- IF()

# With EXCEL IF(this, that, IF(this, that)(IF this, that))

-- IF(source_column_name [=,>,<,...] conditional_statement,value_to_assign, other_value_to_assign)

SELECT
	dept_name,
	dept_name = 'research'
FROM departments;

SELECT
	dept_name,
	IF(dept_name = 'research', TRUE, FALSE)
FROM departments;

SELECT
	dept_name,
	IF(dept_name = 'research', 'TRUE', 'FALSE') AS 'True or False'
FROM departments;

# Use for true/false, not beyond a single condition
IF(THIS, THAT, ELSE)

-- Case Statements

CASE source_column_name
WHEN conditional_statement
THEN value_to_assign
ELSE other_value_to_assign
END AS new_column_name

SELECT col1, 
 CASE source_column_name
	WHEN conditional_statement
	THEN value_to_assign
	ELSE other_value_to_assign
 END AS new_column_name
FROM table1;

USE employees;

SELECT DISTINCT dept_name
FROM departments;

SELECT
	dept_name,
	CASE dept_name
		WHEN 'Research' THEN 'Development'
		WHEN 'Marketing' THEN 'Sales'
		ELSE dept_name
	END AS dept_group
FROM departments;

SELECT *
FROM departments;

SELECT
	dept_name,
	CASE
		WHEN dept_name IN ('research', 'development') THEN 'R&D'
		WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing'
		WHEN dept_name IN ('production', 'quality management') THEN 'Prod & Q'
		ELSE dept_name
	END AS dept_group
FROM department;

SELECT
	CASE
		WHEN dept_name IN ('research', 'development') THEN 'R&D'
		WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing'
		WHEN dept_name IN ('production', 'quality management') THEN 'Prod & Q'
		ELSE dept_name
	END AS dept_group
FROM departments;

SELECT
	DISTINCT
	CASE
		WHEN dept_name IN ('research', 'development') THEN 'R&D'
		WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing'
		WHEN dept_name IN ('production', 'quality management') THEN 'Prod & Q'
		ELSE dept_name
	END AS dept_group
FROM departments;

SELECT
	COUNT(DISTINCT(
	CASE
		WHEN dept_name IN ('research', 'development') THEN 'R&D'
		WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing'
		WHEN dept_name IN ('production', 'quality management') THEN 'Prod & Q'
		ELSE dept_name
	END)) AS dept_group
FROM departments;

SELECT
	CASE
		WHEN gender = 'F' THEN 1
		ELSE 0
	END AS is_female
FROM employees;

SELECT
	SUM(CASE
		WHEN gender = 'F' THEN 1
		ELSE 0
	END) AS is_female
FROM employees;

SELECT
	CASE
		WHEN gender = 'F' THEN 'female'
		WHEN gender = 'M' THEN 'male'
		ELSE 'other'
	END
FROM employees
LIMIT 50;
