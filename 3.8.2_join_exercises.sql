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
	r.name AS role_name,
	count(u.id)
FROM roles AS r
LEFT JOIN users AS u ON  u.role_id = r.id
GROUP BY role_name;


SELECT
	roles.name,
	COUNT(*)
FROM roles
LEFT JOIN users ON users.role_id = roles.id
GROUP BY roles.name;

USE employees;

# Query that shows each department along with the name of the current manager for that department

SELECT
	d.dept_name,
	CONCAT(e.first_name, " ", e.last_name) AS full_name
FROM employees AS e
JOIN dept_manager AS dm
  ON dm.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = dm.dept_no
WHERE dm.to_date > NOW()
ORDER BY d.dept_name; 

# Find the name of all departments currently managed by women.

SELECT
	d.dept_name,
	CONCAT(e.first_name, " ", e.last_name) AS full_name
FROM employees AS e
JOIN dept_manager AS dm
  ON dm.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = dm.dept_no
WHERE dm.to_date > NOW() AND e.gender = "F"
ORDER BY d.dept_name;

# Find the current titles of employees currently working in the Customer Service department

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
WHERE t.to_date > NOW() AND de.to_date > CURDATE() AND de.dept_no = "d009"
GROUP BY t.title
ORDER BY title;

# Took out an unnecessary call FROM employees

SELECT
	title AS "Title",
	COUNT(*) AS Count
FROM departments AS d
JOIN dept_emp AS de ON de.dept_no = d.dept_no
JOIN titles AS t ON t.emp_no = de.emp_no
WHERE t.to_date > CURDATE() AND de.to_date > CURDATE() AND dept_name = "Customer Service"
GROUP BY title;

# Find the current salary of all current managers

SELECT
	d.dept_name AS `Department Name`,
	CONCAT(e.first_name, " ", e.last_name) AS `Manager Name`,
	s.salary AS `Salary`
FROM employees AS e
JOIN dept_manager AS dm
  ON dm.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = dm.dept_no
JOIN salaries AS s
  ON s.emp_no = e.emp_no
WHERE dm.to_date > NOW() AND s.to_date > NOW()
ORDER BY d.dept_name; 

# Find the number of employees in each department

SELECT
	d.dept_no,
	d.dept_name,
	COUNT(de.emp_no) AS `num_employees`
FROM dept_emp AS de
JOIN departments AS d
  ON d.dept_no = de.dept_no
WHERE de.to_date > NOW()
GROUP BY d.dept_no 
ORDER BY d.dept_no;

# Which department has the highest average salary?

SELECT
	d.dept_name AS `dept_name`,
	AVG(s.salary) AS `average_salary`
FROM departments AS d
JOIN dept_emp AS de
  ON de.dept_no = d.dept_no
JOIN salaries AS s
  ON s.emp_no = de.emp_no
WHERE de.to_date > NOW() AND s.to_date > NOW()
GROUP BY d.dept_name
ORDER BY `average_salary` DESC
LIMIT 1;

# Who is the highest paid employee in the Marketing department?

SELECT
	first_name,
	last_name
FROM employees AS e
JOIN salaries AS s ON s.emp_no = e.emp_no
JOIN dept_emp AS de ON de.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
WHERE d.dept_name = "Marketing" AND s.to_date > NOW() AND de.to_date > NOW()
ORDER BY s.salary DESC
LIMIT 1;

# Which current department manager has the highest salary?

SELECT
	e.first_name,
	e.last_name,
	s.salary,
	d.dept_name
FROM employees AS e
JOIN salaries AS s ON s.emp_no = e.emp_no
JOIN dept_manager AS dm ON dm.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = dm.dept_no
WHERE dm.to_date > NOW() AND s.to_date > NOW()
ORDER BY s.salary DESC
LIMIT 1;

# Find the names of all current employees, their department name, and their current manager's name

SELECT
	CONCAT(e.first_name, " ", e.last_name) AS "Employee NAME",
	d.dept_name AS "Department NAME",
	mn.manager_name AS "Manager NAME"
FROM employees AS e
JOIN dept_emp AS de ON de.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
LEFT JOIN
	(SELECT
		CONCAT(e.first_name, " ", e.last_name) AS manager_name, dm.dept_no
		FROM dept_manager AS dm
		JOIN employees AS e ON e.emp_no = dm.emp_no
		WHERE dm.to_date > NOW()) AS mn ON mn.dept_no = de.dept_no
WHERE de.to_date > NOW();
 
# Find the highest paid employee in each department
 
SELECT 
 	CONCAT(e.first_name,' ',e.last_name) AS "Employee NAME", 
 	d.dept_name AS "Department NAME",
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
 WHERE de.to_date > NOW() AND s.to_date > NOW();
 