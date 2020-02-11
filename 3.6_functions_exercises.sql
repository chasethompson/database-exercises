USE employees;

SELECT
	CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
WHERE last_name LIKE 'e%e'
ORDER BY emp_no DESC;

SELECT
	UPPER(CONCAT(first_name, ' ', last_name)) AS full_name
FROM employees
WHERE last_name LIKE 'e%e'
ORDER BY emp_no DESC;

SELECT
	*,
	DATEDIFF(NOW(), hire_date) AS days_since_hired
FROM `employees`
WHERE birth_date LIKE '%12-25' AND hire_date BETWEEN '1990-01-01' AND '1999-12-31'
ORDER BY birth_date ASC, hire_date DESC;

SELECT
	MIN(salary),
	MAX(salary)
FROM salaries;

SELECT
	LOWER(
		CONCAT(
			LEFT(first_name, 1),
			LEFT(last_name, 4),
			"_",
			SUBSTR(birth_date, 6, 2),
			RIGHT(YEAR(birth_date), 2)
		)
	) AS username,
	first_name,
	last_name,
	birth_date
FROM employees
LIMIT 10;

SELECT
	LOWER(
		CONCAT(
			LEFT(first_name, 1),
			LEFT(last_name, 4),
			"_",
			RIGHT(LEFT(birth_date, 7), 2),
			RIGHT(LEFT(birth_date, 4), 2)
		)
	) AS username,
	first_name,
	last_name,
	birth_date
FROM employees
LIMIT 10;

SELECT
	LOWER(
		CONCAT(
			LEFT(first_name, 1),
			LEFT(last_name, 4),
			"_",
			LPAD(MONTH(birth_date), 2, '0'),
			RIGHT(YEAR(birth_date), 2)
		)
	) AS username,
	first_name,
	last_name,
	birth_date
FROM employees
LIMIT 10;

