USE employees;

SELECT DISTINCT title
FROM titles;

SELECT
	last_name
FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY last_name;

SELECT
	first_name,
	last_name
FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY first_name, last_name;

SELECT
	CONCAT(first_name, " ", last_name) AS full_name
FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY full_name;


SELECT
	last_name
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name;

SELECT
	last_name,
	COUNT(*)
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name
ORDER BY COUNT(*);

SELECT
	gender,
	COUNT(*)
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY gender;

SELECT
	LOWER(CONCAT(LEFT(first_name, 1),LEFT(last_name, 4),"_",RIGHT(LEFT(birth_date, 7), 2),RIGHT(LEFT(birth_date, 4), 2))) AS username,
	COUNT(*)
FROM employees
GROUP BY username;

SELECT
	LOWER(CONCAT(LEFT(first_name, 1),LEFT(last_name, 4),"_",RIGHT(LEFT(birth_date, 7), 2),RIGHT(LEFT(birth_date, 4), 2))) AS username,
	COUNT(*)
FROM employees
GROUP BY username
HAVING COUNT(username) > 1;

SELECT SUM(end_users)
FROM
	(SELECT LOWER(CONCAT(LEFT(first_name,1),LEFT(last_name,4),"_",SUBSTR(birth_date,6,2),RIGHT(YEAR(birth_date),2))) AS username,
	count(*) AS end_users
	FROM employees
	GROUP BY username
	HAVING count(username) > 1
	ORDER BY count(*)
	)  AS total_count;
