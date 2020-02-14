USE curie_943;

# Using the example from the lesson, re-create the employees_with_departments table.

CREATE TEMPORARY TABLE employees_with_departments AS
SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
;

SELECT
	*
FROM employees_with_departments;

# Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns

ALTER TABLE employees_with_departments ADD full_name VARCHAR(256) NOT NULL;

# Update the table so that full name column contains the correct data

UPDATE employees_with_departments
SET full_name = CONCAT(first_name, " ", last_name);


# Remove the first_name and last_name columns from the table.

ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;

# What is another way you could have ended up with this same table? You could've done a CONCAT for first name and last name initially

INSERT INTO employees_with_department SELECT CONCAT(first_name, ' ', last_name) FROM employees.employees;
SELECT * FROM employees_with_department LIMIT 5;

# Create a temporary table based on the payment table from the sakila database

CREATE TEMPORARY TABLE payments AS
SELECT
*	
FROM payment.sakila;

ALTER TABLE payments ADD amount_int INT(4);

UPDATE payments SET amount_int=amount*100;

# Find out how the average pay in each department compares to the overall average pay.
# In order to make the comparison easier, you should use the Z-score for salaries.
# In terms of salary, what IS the best department TO WORK FOR? The worst?

DROP TABLE my_emps;

CREATE TEMPORARY TABLE my_emps AS 
SELECT emp_no, first_name, last_name, dept_no, dept_name, salary
FROM employees.employees e
JOIN employees.dept_emp de USING(emp_no)
JOIN employees.departments d USING(dept_no)
JOIN employees.salaries s USING(emp_no)
WHERE s.to_date > now()
	AND de.to_date > now();


SELECT * FROM my_emps;

CREATE TEMPORARY TABLE ave AS
SELECT AVG(salary) sal_ave
FROM employees.salaries
WHERE to_date > now();

CREATE TEMPORARY TABLE dev AS
SELECT std(salary) sal_dev
FROM employees.salaries
WHERE to_date > now();
	

SELECT 
	dept_name, 
	AVG(salary) AS average, 
	(AVG(salary) - (SELECT sal_ave FROM ave)) / (SELECT sal_dev FROM dev)
		AS salary_z_score
FROM my_emps
GROUP BY dept_name;


#testing purposes
CREATE TABLE ave_dev AS
SELECT 
	AVG(salary) AS sal_ave,
	std(salary) AS sal_dev
FROM employees.salaries
WHERE to_date > now();

SELECT * FROM ave_dev;

SELECT 
	dept_name, 
	AVG(salary) AS average, 
	(SELECT sal_ave FROM ave_dev) AS total_av,
	(SELECT sal_dev FROM ave_dev) AS deviation,
	(AVG(salary) - (SELECT sal_ave FROM ave_dev)) / (SELECT sal_dev FROM ave_dev)
		AS salary_z_score
FROM my_emps
GROUP BY dept_name;	
# Zack's Verision

CREATE TABLE emps AS
SELECT
	e.*,
	s.salary,
	d.dept_name AS department,
	d.dept_no
FROM employees.employees e
JOIN employees.salaries s USING (emp_no)
JOIN employees.dept_emp de USING (emp_no)
JOIN employees.departments d USING (dept_no);

SELECT * FROM emps LIMIT 50;

ALTER TABLE emps ADD mean_salary FLOAT;
ALTER TABLE emps ADD sd_salary FLOAT;
ALTER TABLE emps ADD z_salary FLOAT;

/* ALTER TABLE emps
ADD mean_salary FLOAT,
	sd_salary FLOAT,
	z_salary FLOAT; */

CREATE TEMPORARY TABLE salary_aggregates AS
SELECT
	AVG(salary) AS mean,
	STDDEV(salary) AS sd
FROM emps;

SELECT * FROM salary_aggregates;

UPDATE emps SET mean_salary = (SELECT mean FROM salary_aggregates);
UPDATE emps SET sd_salary = (SELECT sd FROM salary_aggregates);
UPDATE emps SET z_salary = (salary - mean_salary) / sd_salary;

SELECT
	department,
	AVG(z_salary) AS z_salary
FROM emps
GROUP BY department
ORDER BY department;