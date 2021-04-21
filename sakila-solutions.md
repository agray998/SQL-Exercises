# Sakila SQL Solutions

```sql
SELECT DISTINCT *
FROM actor;
```

```sql
SELECT last_name
FROM actor
WHERE first_name='John';
```

```sql
SELECT *
FROM actor
WHERE last_name='Neeson';
```

```sql
SELECT *
FROM actor
WHERE actor_id%10=0;
```

```sql
SELECT description
FROM film
WHERE film_id=100;
```

```sql
SELECT title
FROM film
WHERE rating='R';
```

```sql
SELECT title
FROM film
WHERE rating!='R';
```

```sql
SELECT title, length
FROM film
ORDER BY length
LIMIT 10;
```

```sql
SELECT title, length
FROM film
WHERE length=(
    SELECT MAX(length)
    FROM film
);
```

```sql
SELECT title
FROM film
WHERE special_features='Deleted Scenes';
```

```sql
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name HAVING COUNT(last_name)=1
ORDER BY last_name DESC;
```

```sql
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name HAVING COUNT(last_name)>1
ORDER BY COUNT(last_name) DESC;
```

```sql
SELECT f.actor_id, a.first_name, a.last_name, COUNT(f.actor_id)
FROM film_actor f
JOIN actor a ON f.actor_id=a.actor_id
GROUP BY f.actor_id
ORDER BY COUNT(f.actor_id) DESC
LIMIT 1;
```

```sql
SELECT f.actor_id, a.first_name, a.last_name, COUNT(f.actor_id)
FROM film_actor f
JOIN actor a ON f.actor_id=a.actor_id
GROUP BY f.actor_id
ORDER BY COUNT(f.actor_id) DESC
LIMIT 1;
```

```sql
SELECT 
    f.title,
    r.rental_date,
    f.rental_duration,
        DATE_ADD(r.rental_date,
        INTERVAL f.rental_duration DAY) AS due_date
FROM
    (rental r
    JOIN inventory i
    ON r.inventory_id = i.inventory_id)
    JOIN film f
     ON f.film_id = i.film_id
WHERE
    f.title = 'ACADEMY DINOSAUR'
        AND r.return_date IS NULL;
```

```sql
SELECT AVG(length)
FROM film;
```

```sql
SELECT category, AVG(length)
FROM film_list
GROUP BY category;
```

```sql
SELECT film_id, title
FROM film
WHERE description LIKE '%robot%';
```

```sql
SELECT COUNT(release_year)
FROM film
WHERE release_year=2010;
```

```sql
SELECT title
FROM film_list
WHERE category='Horror';
```

```sql
SELECT CONCAT(first_name, ' ', last_name) AS name
FROM staff
WHERE staff_id=2;
```

```sql
SELECT title, actors
FROM film_list
WHERE actors LIKE '%Fred Costner%';
```

```sql
SELECT COUNT(DISTINCT country)
FROM country;
```

```sql
SELECT DISTINCT name
FROM language
ORDER BY name DESC;
```

```sql
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE '%son%'
ORDER BY first_name;
```

```sql
SELECT category, COUNT(title)
FROM film_list
GROUP BY category
ORDER BY COUNT(title) DESC
LIMIT 1;
```
