USE sakila;
-- 1) List all actors
SELECT first_name, last_name FROM actor;
-- 2) Find the surname of the actor with the forename John
SELECT last_name FROM actor WHERE first_name = 'John';
-- 3) Find all actors with the surname Neeson
SELECT first_name, last_name FROM actor WHERE last_name = 'Neeson';
-- 4) Find all actors with ID numbers divisible by 10
SELECT first_name, last_name FROM actor WHERE actor_id % 10 = 0;
-- 5) What is the description of the movie with an ID of 100?
SELECT description FROM film WHERE film_id = 100;
-- 6) Find every R-rated movie
SELECT title FROM film WHERE rating = 'R';
-- 7) Find every non-R-rated movie
SELECT title FROM film WHERE rating != 'R';
-- 8) Find the 10 shortest movies
SELECT title FROM film ORDER BY length ASC LIMIT 10;
-- 9) Find the movies with the longest runtime without using LIMIT
SELECT title FROM film WHERE length = (SELECT MAX(length) FROM film);
-- 10) Find all movies that have deleted scenes
SELECT title FROM film WHERE special_features LIKE '%Deleted Scenes%';
-- 11) Using HAVING, reverse-alphabetically list the last names that are not repeated
SELECT last_name FROM actor GROUP BY last_name HAVING COUNT(last_name) = 1 ORDER BY last_name DESC;
-- 12) Using HAVING, list the last names that appear more than once, from highest to lowest frequency
SELECT last_name FROM actor GROUP BY last_name HAVING COUNT(last_name) != 1 ORDER BY COUNT(last_name) DESC;
-- 13) Which actor has appeared in the most films?
SELECT first_name, last_name 
FROM actor a 
JOIN film_actor f 
USING (`actor_id`)
GROUP BY f.actor_id 
ORDER BY COUNT(film_id) DESC 
LIMIT 1;
-- 14) When is 'Academy Dinosaur' due?
SELECT f.title, r.rental_date, f.rental_duration, 
DATE_ADD(r.rental_date, INTERVAL f.rental_duration DAY) AS due_date 
FROM (
    rental r 
    JOIN inventory i 
    USING (`inventory_id`)
    ) 
JOIN film f 
USING (`film_id`)
WHERE f.title = 'ACADEMY DINOSAUR' 
AND r.return_date IS NULL;
-- 15) What is the average runtime of all films?
SELECT AVG(length) FROM film;
-- 16) List the average runtime for every film category
SELECT AVG(length), name AS cat_name 
FROM (
	SELECT f.title, f.length, fc.name 
	FROM film f 
	JOIN (
		SELECT f.film_id, c.name 
		FROM film_category f 
		JOIN category c 
		USING (`category_id`)
    ) fc 
	USING (`film_id`)
) fcn
GROUP BY cat_name;
-- 17) List all movies featuring a robot
SELECT title FROM film WHERE description LIKE '%robot%';
-- 18) How many movies were released in 2010?
SELECT COUNT(film_id) FROM film WHERE release_year = 2010;
-- 19) Find the titles of all the horror movies
SELECT title 
FROM (
	SELECT f.title, f.length, fc.name 
	FROM film f 
	JOIN (
		SELECT f.film_id, c.name 
		FROM film_category f 
		JOIN category c 
		USING (`category_id`)
    ) fc 
	USING (`film_id`)
) fcn 
WHERE name = 'Horror';
-- 20) List the full name of the staff member with the ID 2
SELECT first_name, last_name FROM staff WHERE staff_id = 2;
-- 21) List all the movies that Fred Costner has appeared in
SELECT title 
FROM film 
WHERE film_id IN (
	SELECT film_id 
	FROM film_actor
    WHERE actor_id = (
		SELECT actor_id
		FROM actor
		WHERE first_name = 'Fred' 
		AND last_name = 'Costner'
    )
);
-- 22) How many distinct countries are there?
SELECT COUNT(DISTINCT country) FROM country;
-- 23) List the name of every language in reverse-alphabetical order
SELECT name FROM language ORDER BY name DESC;
-- 24) List the full names of every actor whose surname ends with '-son' in alphabetical order by their forename
SELECT first_name, last_name FROM actor WHERE last_name LIKE '%son' ORDER BY first_name ASC;
-- 25) Which category contains the most films?
SELECT category, COUNT(title) FROM film_list GROUP BY category ORDER BY COUNT(title) DESC LIMIT 1;
