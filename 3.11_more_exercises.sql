/* How much DO the current managers of EACH department get paid, relative TO the average salary FOR the department?
IS there ANY department WHERE the department manager gets paid LESS THAN the average salary?*/

USE employees; 

SELECT
	manager.dept_name,
	CONCAT(manager.first_name, " ", manager.last_name) AS full_name,
	manager.manager_salary,
	emp.avg_emp_salary
FROM (
	SELECT
		dept_name,
		salary AS manager_salary,
		first_name,
		last_name
		FROM departments
		JOIN dept_manager AS dm USING(dept_no)
		JOIN employees AS e USING (emp_no)
		JOIN salaries AS s USING(emp_no)
		WHERE s.to_date > NOW() AND dm.to_date > NOW() 
		) AS manager
JOIN (
	SELECT
		dept_name,
		AVG(salary) AS avg_emp_salary
	FROM salaries AS s
	JOIN dept_emp AS de USING(emp_no)
	JOIN departments AS d USING (dept_no)
	WHERE s.to_date > NOW()
	GROUP BY dept_name
	) AS emp
USING(dept_name)
;


