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

-- 5. Using IN, display the country_id and country columns for the following countries: Afghanistan, Bangladesh, and China:

SELECT
	country_id,
	country
FROM country
WHERE country IN ("Afghanistan", "Bangladesh", "China");

-- 6. List the last names of all the actors, as well as how many actors have that last name.

SELECT
	last_name,
	COUNT(*)
FROM actor
GROUP BY last_name;

-- 7. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors

SELECT
	last_name,
	COUNT(*)
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) > 1;

-- 8. You cannot locate the schema of the address table. Which query would you use to re-create it?

SHOW CREATE TABLE address;

DESCRIBE address;

-- 9. Use JOIN to display the first and last names, as well as the address, of each staff member.

SELECT
	first_name,
	last_name,
	address
FROM staff
JOIN address USING(address_id);

-- 10. Use JOIN to display the total amount rung up by each staff member in August of 2005.

SELECT
	first_name,
	last_name,
	SUM(amount)
FROM staff
JOIN payment p USING(staff_id)
WHERE payment_date BETWEEN "2005-08-01" AND "2005-08-31"
GROUP BY staff_id;

-- 11. List each film and the number of actors who are listed for that film.

SELECT
	title,
	COUNT(actor_id)
FROM film
JOIN film_actor fa USING(film_id)
GROUP BY title;

-- 12. How many copies of the film Hunchback Impossible exist in the inventory system?

SELECT
	title,
	COUNT(*)
FROM film
JOIN inventory i USING (film_id)
WHERE title = "Hunchback Impossible";

-- 13. The music of Queen and Kris Kristofferson have seen an unlikely resurgence.
-- AS an unintended consequence, films starting WITH the letters K AND Q have also soared IN popularity.
-- USE subqueries TO display the titles of movies starting WITH the letters K AND Q whose LANGUAGE IS English.

SELECT
	*
FROM film
WHERE title LIKE "K%"
OR title LIKE "Q%;"
AND language_id IN (
	SELECT
	language_id
	FROM LANGUAGE
	WHERE NAME = "engligh");
	
SELECT
	title
FROM film 
WHERE title LIKE 'k%'
OR title LIKE 'q%'
AND language_id IN (
	SELECT language_id
	FROM LANGUAGE
	WHERE NAME = "English");
	
	SELECT title FROM film
JOIN LANGUAGE USING(language_id)
WHERE language.name="English"
AND title LIKE "K%"
OR title LIKE "Q%";


/*





The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
Use subqueries to display all actors who appear in the film Alone Trip.
You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers.
Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.
Write a query to display how much business, in dollars, each store brought in.
Write a query to display for each store its store ID, city, and country.
List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.) */