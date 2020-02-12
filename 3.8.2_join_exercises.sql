USE join_example_db;

SELECT
	*
FROM roles
JOIN users ON roles.id = users.id;

SELECT
	*
FROM roles
LEFT JOIN users ON roles.id = users.id;

SELECT
	*
FROM roles
RIGHT JOIN users ON roles.id = users.id;

SELECT
	roles.name,
	COUNT(*)
FROM users
LEFT JOIN roles ON users.id = roles.id
GROUP BY roles.name;

SELECT
	roles.name,
	COUNT(*)
FROM roles
LEFT JOIN users ON users.role_id = roles.id
GROUP BY roles.name;

USE employees;

SELECT
	d.dept_name,
	CONCAT(e.first_name, " ", e.last_name) AS full_name
FROM employees AS e
JOIN dept_manager AS dm
  ON dm.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = dm.dept_no
WHERE dm.to_date = "9999-01-01"
ORDER BY d.dept_name; 

SELECT
	d.dept_name,
	CONCAT(e.first_name, " ", e.last_name) AS full_name
FROM employees AS e
JOIN dept_manager AS dm
  ON dm.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = dm.dept_no
WHERE dm.to_date = "9999-01-01" AND e.gender = "F"
ORDER BY d.dept_name;

SELECT
	t.title AS "Title",
	COUNT(*) AS count
FROM employees AS e
JOIN dept_emp AS de
	ON de.emp_no = e.emp_no
JOIN departments AS d
	ON d.dept_no = de.dept_no
JOIN titles AS t
	ON t.emp_no = e.emp_no
WHERE t.to_date = "9999-01-01" AND de.dept_no = "d009"
GROUP BY t.title
ORDER BY title;

SELECT
	d.dept_name,
	CONCAT(e.first_name, " ", e.last_name) AS full_name,
	s.salary
FROM employees AS e
JOIN dept_manager AS dm
  ON dm.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = dm.dept_no
JOIN salaries AS s
  ON s.emp_no = e.emp_no
WHERE dm.to_date = "9999-01-01" AND s.to_date = '9999-01-01'
ORDER BY d.dept_name; 

SELECT
	d.dept_no,
	d.dept_name,
	COUNT(de.emp_no)
FROM dept_emp AS de
JOIN departments AS d
  ON d.dept_no = de.dept_no
WHERE de.to_date = "9999-01-01"
GROUP BY d.dept_no, d.dept_name 
ORDER BY d.dept_no;

SELECT
	d.dept_name,
	AVG(s.salary)
FROM departments AS d
JOIN dept_emp AS de
  ON de.dept_no = d.dept_no
JOIN salaries AS s
  ON s.emp_no = de.emp_no
WHERE de.to_date = "9999-01-01" AND s.to_date = '9999-01-01'
GROUP BY d.dept_name
ORDER BY AVG(s.salary) DESC
LIMIT 1;

SELECT
	first_name,
	last_name
FROM employees AS e
JOIN salaries AS s ON s.emp_no = e.emp_no
JOIN dept_emp AS de ON de.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
WHERE d.dept_name = "Marketing" AND s.to_date = "9999-01-01"
ORDER BY s.salary DESC
LIMIT 1;

SELECT
	e.first_name,
	e.last_name,
	s.salary,
	d.dept_name
FROM employees AS e
JOIN salaries AS s ON s.emp_no = e.emp_no
JOIN dept_manager AS dm ON dm.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = dm.dept_no
WHERE dm.to_date = "9999-01-01"
ORDER BY s.salary DESC
LIMIT 1;

SELECT
	CONCAT(e.first_name, " ", e.last_name) AS "Employee Name",
	d.dept_name AS "Department Name",
	mn.manager_name AS "Manager Name"
FROM employees AS e
JOIN dept_emp AS de ON de.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
LEFT JOIN
	(SELECT
		CONCAT(e.first_name, " ", e.last_name) AS manager_name, dm.dept_no
		FROM dept_manager AS dm
		JOIN employees AS e ON e.emp_no = dm.emp_no
		WHERE dm.to_date = "9999-01-01") AS mn ON mn.dept_no = de.dept_no
WHERE de.to_date = "9999-01-01";
 
 
SELECT 
 	CONCAT(e.first_name,' ',e.last_name) AS "Employee Name", 
 	d.dept_name AS "Department Name",
 	ms.max_salary_by_department AS "Salary"
 FROM employees e
 	JOIN dept_emp de ON de.emp_no = e.emp_no
 	JOIN departments d ON de.dept_no = d.dept_no 
 	JOIN salaries s ON e.emp_no = s.emp_no
 	JOIN (
 		SELECT
 		MAX(s.salary) AS "max_salary_by_department",
 		d.dept_name 
		FROM salaries AS s
		JOIN employees AS e ON e.emp_no = s.emp_no
		JOIN dept_emp AS de ON de.emp_no = e.emp_no
		JOIN departments AS d ON d.dept_no = de.dept_no
		GROUP BY d.dept_name
		) AS ms ON ms.dept_name = d.dept_name AND ms.max_salary_by_department = s.salary
 WHERE de.to_date = '9999-01-01' AND s.to_date = '9999-01-01';
 