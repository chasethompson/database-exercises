-- Employees Database

# 1

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

-- If you work in Production or Customer Service as a manager you would make less than the average for your department

-- Sakila Database



-- # 1 Display the first and last names in all lowercase of all the actors.

USE sakila;

SELECT
	LOWER(CONCAT(first_name, " ", last_name)) AS full_name_lower
FROM actor;

-- # 2 You need to find the ID number, first name, and last name of an actor,
-- of whom you know only the FIRST NAME, "Joe." What IS ONE QUERY you could USE TO obtain this information?

SELECT
	actor_id,
	first_name,
	last_name
FROM actor
WHERE first_name = 'Joe';

-- or

SELECT
	*
FROM actor
WHERE first_name = 'Joe';

-- 3. Find all actors whose last name contain the letters "gen"

SELECT
	*
FROM actor
WHERE last_name LIKE "%gen%";

-- 4. Find all actors whose last names contain the letters "li". This time, order the rows by last name and first name, in that order.

SELECT
	*
FROM actor
WHERE last_name LIKE "%li%"
ORDER BY last_name, first_name;


/*



Using IN, display the country_id and country columns for the following countries: Afghanistan, Bangladesh, and China:
List the last names of all the actors, as well as how many actors have that last name.
List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
You cannot locate the schema of the address table. Which query would you use to re-create it?
Use JOIN to display the first and last names, as well as the address, of each staff member.
Use JOIN to display the total amount rung up by each staff member in August of 2005.
List each film and the number of actors who are listed for that film.
How many copies of the film Hunchback Impossible exist in the inventory system?
The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
Use subqueries to display all actors who appear in the film Alone Trip.
You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers.
Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.
Write a query to display how much business, in dollars, each store brought in.
Write a query to display for each store its store ID, city, and country.
List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.) */