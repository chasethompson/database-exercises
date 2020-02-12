USE employees;

SELECT
	first_name,
	last_name
FROM `employees`
WHERE last_name IN ("Vidya", "Maya", "Irena");


SELECT column_a, column_b, column_c
FROM table_a
WHERE column_a IN (
    SELECT column_a
    FROM table_b
    WHERE column_b = TRUE
);

SELECT
	*
FROM employees AS e
WHERE emp_no IN(
	SELECT emp_no
	FROM salaries
	WHERE salary < 39000
);


# Find all the employees with the same hire date as employee 101010 using a sub-query

SELECT
	*
FROM employees
WHERE hire_date IN (
	SELECT hire_date
 	FROM employees
 	WHERE emp_no = 101010
 );
 
# Find ALL the titles held BY ALL employees WITH the FIRST NAME Aamod. 314 total titles, 6 UNIQUE titles

SELECT
	title,
	COUNT(*)
FROM titles
WHERE emp_no IN (
	SELECT emp_no
	FROM employees
	WHERE first_name = "Aamod"
)
GROUP BY title;

# How many people in the employees table are no longer working for the company?

