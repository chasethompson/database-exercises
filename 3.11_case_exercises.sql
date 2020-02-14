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

SELECT
	sum(CASE 
		WHEN birth_date > "1964" THEN 0
		WHEN gender = "F" THEN 1
		ELSE 0
	END) AS boomer_females
FROM employees;

SELECT
	*
FROM employees;

/* WRITE a QUERY that RETURNS ALL employees (emp_no), their department number, their START DATE,
their END DATE, AND a NEW COLUMN 'is_current_employee'
that IS a 1 IF the employee IS still WITH the company AND 0 IF not.*/


SELECT
	e.emp_no,
	dept_no,
	hire_date,
	de.to_date,
	CASE
		WHEN de.to_date < NOW() THEN 0
		ELSE 1
	END AS 'Gonzo'
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no;


/* Write a query that returns all employee names, and a new column 'alpha_group' that returns
'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name. */

SELECT
	first_name,
	last_name,
	CASE
		WHEN last_name BETWEEN "Aa" AND "Hzzzzz" THEN "A-H"
		WHEN last_name BETWEEN "Ia" AND "Qzzzzz" THEN "I-Q"
		WHEN last_name BETWEEN "Ra" AND "Zzzzzzz" THEN "R-Z"
		ELSE 'other'
	END AS alpha_group
FROM employees;

/* How many employees were born in each decade? */

SELECT
	COUNT(*)
FROM employees;

SELECT
	sum(
	CASE
		WHEN birth_date BETWEEN '1950-01-01' AND '1959-12-31' THEN 1
		ELSE 0
		END) AS "1950s",
	sum(
	CASE
		WHEN birth_date BETWEEN '1960-01-01' AND '1969-12-31' THEN 1
		ELSE 0
		END) AS "1960s"	
FROM employees;

/* What IS the average salary FOR EACH of the following department
groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?*/

SELECT
	DISTINCT(CASE
		WHEN dept_name IN ('research', 'development') THEN 'R&D'
		WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing'
		WHEN dept_name IN ('production', 'quality management') THEN 'Prod & Q'
		WHEN dept_name IN ('finance', 'human resources') THEN 'Finance & HR'
		ELSE dept_name
	END)AS dept_group,
	AVG(s.salary)
FROM departments AS d
JOIN dept_emp AS de ON d.dept_no = de.dept_no
JOIN salaries AS s ON de.emp_no = s.emp_no
WHERE de.to_date > NOW() AND s.to_date > NOW()
GROUP BY dept_group; 

USE curie_943;

CREATE TEMPORARY TABLE salary_avgs AS
SELECT
	d.dept_name AS `dept_name`,
	AVG(s.salary) AS `average_salary`
FROM employees.departments AS d
JOIN employees.dept_emp AS de ON de.dept_no = d.dept_no
JOIN employees.salaries AS s ON s.emp_no = de.emp_no
WHERE de.to_date > NOW() AND s.to_date > NOW()
GROUP BY d.dept_name
ORDER BY `average_salary` DESC;

SELECT
	*
FROM salary_avgs;

USE employees;

SELECT
	*
FROM curie_943.salary_avgs;