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

# Zach's version

SELECT
	DISTINCT title
FROM titles
WHERE emp_no IN (
	SELECT emp_no
	FROM employees
	WHERE first_name = 'Aamod'
);

# How many people in the employees table are no longer working for the company?

SELECT 
	COUNT(*)
FROM employees AS e
WHERE e.emp_no IN (
	SELECT emp_no
	FROM dept_emp AS d
	GROUP BY d.emp_no
	HAVING MAX(to_date) < NOW()
);

# Zach's Version

SELECT
	(SELECT
	COUNT(*)
	FROM employees
)-(
	SELECT
	COUNT(*)
	FROM salaries
	WHERE to_date > now()); 
	
	
# Find all the current department managers that are female

SELECT
	first_name,
	last_name
FROM employees AS e
WHERE e.emp_no IN (
	SELECT emp_no
	FROM dept_manager AS dm
	WHERE dm.to_date > NOW()
	)
AND e.gender = "F";

# Find all the employees that currently have a higher than average salary

SELECT e.first_name, e.last_name, s.salary
FROM employees AS e
JOIN salaries AS s ON s.emp_no = e.emp_no
WHERE s.salary > (
	SELECT 
		AVG(s.salary)
	FROM salaries AS s)
AND s.to_date > NOW();

# Ryan's solution

SELECT
	first_name,
	last_name,
	salary
FROM employees
JOIN salaries USING (emp_no)
WHERE to_date > NOW()
AND salary > (
	SELECT AVG(salary)
	FROM salaries
);

SELECT  first_name, last_name,
    (SELECT max(salary)
     FROM salaries
     WHERE salaries.emp_no = employees.emp_no) employee_salary
FROM employees
WHERE emp_no IN
    (SELECT emp_no FROM salaries
    WHERE salary >
        (SELECT  AVG(salary)
        FROM salaries)
    AND now() BETWEEN from_date AND to_date);

# How many current salaries are within 1 standard deviation of the highest salary?
# What percentage of all salaries is this?

SELECT
	COUNT(*) AS total,
	(COUNT(*) / (SELECT
					COUNT(*)
					FROM salaries) *100) AS percent_of_total
FROM salaries
WHERE salary > (
	SELECT
	MAX(salary) - STD(s.salary)
	FROM salaries AS s
	)
AND to_date > NOW();

# Find all the department names that currently have female managers

SELECT
	d.dept_name
FROM dept_manager AS dm
JOIN departments AS d ON dm.dept_no = d.dept_no
JOIN employees AS e ON dm.emp_no = e.emp_no
WHERE e.emp_no IN (
	SELECT e.emp_no
	FROM employees AS e
	WHERE e.gender = "F")
AND dm.to_date > NOW()
ORDER BY d.dept_name;

#Find the FIRST AND LAST NAME of the employee WITH the highest salary

SELECT
	e.first_name,
	e.last_name
FROM employees AS e
JOIN salaries AS s ON e.emp_no = s.emp_no
WHERE s.salary IN (
	SELECT
		MAX(salary)
	FROM salaries
	)
AND s.to_date > NOW();

# Find the department name that the employee with the highest salary works in

SELECT
	d.dept_name
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
JOIN salaries AS s ON e.emp_no = s.emp_no
WHERE s.salary IN (
	SELECT MAX(salary)
	FROM salaries)
AND s.to_date > NOW();
