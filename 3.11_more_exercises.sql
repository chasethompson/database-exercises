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
	title
FROM film
WHERE title LIKE "k%"
OR title LIKE "q%"
AND language_id IN (
	SELECT
	language_id
	FROM LANGUAGE
	WHERE NAME = "English");

-- 14. Use subqueries to display all actors who appear in the film Alone Trip.

SELECT
	CONCAT(first_name, " ", last_name) AS full_name
FROM actor
WHERE actor_id IN (
	SELECT actor_id
	FROM film_actor
	WHERE film_id IN (
		SELECT film_id
		FROM film
		WHERE title = "Alone Trip"
	)
);

-- 15. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers.

SELECT
	first_name,
	last_name,
	email
FROM customer
JOIN address USING(address_id)
JOIN city USING(city_id)
JOIN country USING(country_id)
WHERE country="Canada";

-- 16. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.

SELECT
	f.title,
	c.name
FROM film f
JOIN film_category USING(film_id)
JOIN category c USING (category_id)
WHERE c.name = "Family";

-- 17. Write a query to display how much business, in dollars, each store brought in.

SELECT
	store_id,
	SUM(amount)
FROM payment
JOIN staff USING(staff_id)
JOIN store USING(store_id)
GROUP BY store_id
;

-- 18. Write a query to display for each store its store ID, city, and country.

SELECT
	s.store_id,
	city.city,
	c.country
FROM country c
JOIN city city USING(country_id)
JOIN address USING(city_id)
JOIN store s USING (address_id);

-- 19. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)

SELECT
	cat.name AS genre,
	sum(amount) AS gross_revenue
FROM category cat
JOIN film_category USING(category_id)
JOIN film USING(film_id)
JOIN inventory USING(film_id)
JOIN rental USING(inventory_id)
JOIN payment USING(rental_id)
GROUP BY genre
ORDER BY gross_revenue DESC
LIMIT 5;

-- 1. SELECT Statements

# Select all columns from the actor table.

SELECT
	*
FROM actor;

# Select only the last_name column from the actor table.

SELECT
	last_name
FROM actor;

# Select only the following columns from the film table.

SELECT
	*
FROM film;

-- 2. DISTINCT Operator

# Select all distinct (different) last names from the actor table.

SELECT
	DISTINCT last_name
FROM actor;

# Select all distinct (different) postal codes from the address table.

SELECT
	DISTINCT
	postal_code
FROM address;

# Select all distinct (different) ratings from the film table.

SELECT
	DISTINCT
	rating
FROM film;

-- 3. WHERE clause

# Select the title, description, rating, movie length columns from the films table that last 3 hours or longer.

SELECT
	title,
	description,
	rating,
	length
FROM film
WHERE length > 180;

# Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.

SELECT
	payment_id,
	amount,
	payment_date
FROM payment
WHERE payment_date > 2005/05/26;

# Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005.


SELECT
	payment_id,
	amount,
	payment_date
FROM payment
WHERE payment_date > 2005/05/26; 


# SELECT ALL COLUMNS FROM the customer TABLE FOR ROWS that have a LAST NAMES beginning WITH S AND a FIRST NAMES ending WITH N.

SELECT
	*
FROM customer
WHERE last_name LIKE "s%" AND first_name LIKE "%n";

# SELECT ALL COLUMNS FROM the customer TABLE FOR ROWS WHERE the customer IS inactive OR has a LAST NAME beginning WITH "M".

SELECT *
	FROM customer
	WHERE last_name LIKE 'm%' OR active = 0;


# SELECT ALL COLUMNS FROM the category TABLE FOR ROWS WHERE the PRIMARY KEY IS greater THAN 4 AND the NAME field begins WITH either C, S OR T.

SELECT
	*
FROM category
WHERE category_id  > 4 AND NAME LIKE "C%" OR NAME LIKE "S%" OR NAME LIKE "T%";

# Regexp solution

SELECT
	*
FROM category
WHERE category_id > 4
AND NAME REGEXP '^[cst]';

# SELECT ALL COLUMNS minus the PASSWORD COLUMN FROM the staff TABLE FOR ROWS that contain a password.

SELECT
	staff_id,
	first_name,
	last_name,
	address_id,
	picture,
	email,
	store_id,
	active,
	username,
	last_update
FROM staff
WHERE PASSWORD IS NOT NULL; # Also think creating a temp table here, then dropping the column not wante whould work too

# SELECT ALL COLUMNS minus the PASSWORD COLUMN FROM the staff TABLE FOR ROWS that DO NOT contain a password.

SELECT
	staff_id,
	first_name,
	last_name,
	address_id,
	picture,
	email,
	store_id,
	active,
	username,
	last_update
FROM staff
WHERE PASSWORD IS NULL;

-- 4. IN operator

# SELECT the phone AND district COLUMNS FROM the address TABLE FOR addresses IN California, England, Taipei, OR West Java.

SELECT
	phone,
	district
FROM address
WHERE district IN ('California', 'England', 'Taipei', 'West Java');

# SELECT the payment id, amount, AND payment DATE COLUMNS FROM the payment TABLE FOR payments made ON 05/25/2005, 05/27/2005, AND 05/29/2005. (USE the IN operator AND the DATE FUNCTION, instead of the AND operator AS IN previous exercises.)

SELECT
	payment_id,
	amount,
	payment_date
FROM payment
WHERE DATE(payment_date)
IN (DATE("2005-05-25"),DATE("2005-05-27"),DATE("2005-05-29"));

# SELECT ALL COLUMNS FROM the film TABLE FOR films rated G, PG-13 OR NC-17.

SELECT
	*
FROM film
WHERE rating IN ('G', 'PG-13', 'NC-17');

-- 5. BETWEEN operator

# SELECT ALL COLUMNS FROM the payment TABLE FOR payments made BETWEEN midnight 05/25/2005 AND 1 SECOND BEFORE midnight 05/26/2005.
# SELECT the following COLUMNS FROM the film TABLE FOR films WHERE the length of the description IS BETWEEN 100 AND 120. Hint: total_rental_cost = rental_duration * rental_rate

-- 6. LIKE operator

# SELECT the following COLUMNS FROM the film TABLE FOR ROWS WHERE the description begins WITH "A Thoughtful".
# SELECT the following COLUMNS FROM the film TABLE FOR ROWS WHERE the description ENDS WITH the word "Boat".
# SELECT the following COLUMNS FROM the film TABLE WHERE the description CONTAINS the word "DATABASE" AND the length of the film IS greater THAN 3 hours.
-- 7. LIMIT Operator

#SELECT ALL COLUMNS FROM the payment TABLE AND only include the FIRST 20 rows.
#SELECT the payment DATE AND amount COLUMNS FROM the payment TABLE FOR ROWS WHERE the payment amount IS greater THAN 5, AND only SELECT ROWS whose zero-based INDEX IN the result SET IS BETWEEN 1000-2000.
#SELECT ALL COLUMNS FROM the customer TABLE, limiting results TO those WHERE the zero-based INDEX IS BETWEEN 101-200.
-- 8. ORDER BY statement

# SELECT ALL COLUMNS FROM the film TABLE AND order ROWS BY the length field IN ascending order.
# SELECT ALL DISTINCT ratings FROM the film TABLE ordered BY rating IN descending order.
# SELECT the payment DATE AND amount COLUMNS FROM the payment TABLE FOR the FIRST 20 payments ordered BY payment amount IN descending order.
# SELECT the title, description, special features, length, AND rental duration COLUMNS FROM the film TABLE FOR the FIRST 10 films WITH behind the scenes footage under 2 hours IN length AND a rental duration BETWEEN 5 AND 7 days, ordered BY length IN descending order.
-- 9. JOINs

# SELECT customer first_name/last_name AND actor first_name/last_name COLUMNS FROM performing a LEFT JOIN BETWEEN the customer AND actor COLUMN ON the last_name COLUMN IN EACH table. (i.e. customer.last_name = actor.last_name)
# Label customer first_name/last_name COLUMNS AS customer_first_name/customer_last_name
# Label actor first_name/last_name COLUMNS IN a similar fashion.
# RETURNS correct number of records: 599
# SELECT the customer first_name/last_name AND actor first_name/last_name COLUMNS FROM performing a /RIGHT JOIN BETWEEN the customer AND actor COLUMN ON the last_name COLUMN IN EACH table. (i.e. customer.last_name = actor.last_name)
# RETURNS correct number of records: 200
# SELECT the customer first_name/last_name AND actor first_name/last_name COLUMNS FROM performing an INNER JOIN BETWEEN the customer AND actor COLUMN ON the last_name COLUMN IN EACH table. (i.e. customer.last_name = actor.last_name)
# RETURNS correct number of records: 43
# SELECT the city NAME AND country NAME COLUMNS FROM the city TABLE, performing a LEFT JOIN WITH the country TABLE TO get the country NAME column.
# RETURNS correct records: 600
# SELECT the title, description, RELEASE YEAR, AND LANGUAGE NAME COLUMNS FROM the film TABLE, performing a LEFT JOIN WITH the LANGUAGE TABLE TO get the "language" column.
# Label the language.name COLUMN AS "language"
# RETURNS 1000 ROWS
# SELECT the first_name, last_name, address, address2, city NAME, district, AND postal CODE COLUMNS FROM the staff TABLE, performing 2 LEFT joins WITH the address TABLE THEN the city TABLE TO get the address AND city related columns.
# RETURNS correct number of ROWS: 2

/* What IS the average replacement cost of a film? Does this CHANGE depending ON the rating of the film?


+-----------------------+
| AVG(replacement_cost) |
+-----------------------+
|             19.984000 |
+-----------------------+
1 ROW IN SET (2.39 sec)

+--------+-----------------------+
| rating | AVG(replacement_cost) |
+--------+-----------------------+
| G      |             20.124831 |
| PG     |             18.959072 |
| PG-13  |             20.402556 |
| R      |             20.231026 |
| NC-17  |             20.137619 |
+--------+-----------------------+
5 ROWS IN SET (0.09 sec)
How many different films of EACH genre are IN the DATABASE?


+-------------+-------+
| NAME        | count |
+-------------+-------+
| ACTION      |    64 |
| Animation   |    66 |
| Children    |    60 |
| Classics    |    57 |
| Comedy      |    58 |
| Documentary |    68 |
| Drama       |    62 |
| Family      |    69 |
| FOREIGN     |    73 |
| Games       |    61 |
| Horror      |    56 |
| Music       |    51 |
| NEW         |    63 |
| Sci-Fi      |    61 |
| Sports      |    74 |
| Travel      |    57 |
+-------------+-------+
16 ROWS IN SET (0.06 sec)
What are the 5 frequently rented films?


+---------------------+-------+
| title               | total |
+---------------------+-------+
| BUCKET BROTHERHOOD  |    34 |
| ROCKETEER MOTHER    |    33 |
| GRIT CLOCKWORK      |    32 |
| RIDGEMONT SUBMARINE |    32 |
| JUGGLER HARDLY      |    32 |
+---------------------+-------+
5 ROWS IN SET (0.11 sec)
What are the most most profitable films (IN terms of gross revenue)?


+-------------------+--------+
| title             | total  |
+-------------------+--------+
| TELEGRAPH VOYAGE  | 231.73 |
| WIFE TURN         | 223.69 |
| ZORRO ARK         | 214.69 |
| GOODFELLAS SALUTE | 209.69 |
| SATURDAY LAMBS    | 204.72 |
+-------------------+--------+
5 ROWS IN SET (0.17 sec)
Who IS the best customer?


+------------+--------+
| NAME       | total  |
+------------+--------+
| SEAL, KARL | 221.55 |
+------------+--------+
1 ROW IN SET (0.12 sec)
Who are the most popular actors (that have appeared IN the most films)?


+-----------------+-------+
| actor_name      | total |
+-----------------+-------+
| DEGENERES, GINA |    42 |
| TORN, WALTER    |    41 |
| KEITEL, MARY    |    40 |
| CARREY, MATTHEW |    39 |
| KILMER, SANDRA  |    37 |
+-----------------+-------+
5 ROWS IN SET (0.07 sec)
What are the sales FOR EACH store FOR EACH MONTH IN 2005?

SELECT
	concat(YEAR(payment_date), "-", MONTH(payment_date)) AS months,
	store_id,
	sum(amount) AS sales
FROM payment
JOIN rental USING(rental_id)
JOIN inventory USING(inventory_id)
WHERE payment_date LIKE "2005%"
GROUP BY months, store_id;


+---------+----------+----------+
| MONTH   | store_id | sales    |
+---------+----------+----------+
| 2005-05 |        1 |  2459.25 |
| 2005-05 |        2 |  2364.19 |
| 2005-06 |        1 |  4734.79 |
| 2005-06 |        2 |  4895.10 |
| 2005-07 |        1 | 14308.66 |
| 2005-07 |        2 | 14060.25 |
| 2005-08 |        1 | 11933.99 |
| 2005-08 |        2 | 12136.15 |
+---------+----------+----------+
8 ROWS IN SET (0.14 sec)
Bonus: Find the film title, customer NAME, customer phone number, AND customer address FOR ALL the outstanding DVDs.


+------------------------+------------------+--------------+
| title                  | customer_name    | phone        |
+------------------------+------------------+--------------+
| HYDE DOCTOR            | KNIGHT, GAIL     | 904253967161 |
| HUNGER ROOF            | MAULDIN, GREGORY | 80303246192  |
| FRISCO FORREST         | JENKINS, LOUISE  | 800716535041 |
| TITANS JERK            | HOWELL, WILLIE   | 991802825778 |
| CONNECTION MICROCOSMOS | DIAZ, EMILY      | 333339908719 |
+------------------------+------------------+--------------+
5 ROWS IN SET (0.06 sec)
183 ROWS total, above IS just the FIRST 5



 */