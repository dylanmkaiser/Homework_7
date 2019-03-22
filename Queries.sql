-- 1a
SELECT first_name, last_name 
FROM sakila.actor;

-- 1b
SELECT concat(first_name, ' ', last_name) 
FROM sakila.actor;

-- 2a
SELECT actor_id, first_name, last_name 
FROM sakila.actor
WHERE first_name = 'JOE';

-- 2b
SELECT first_name, last_name
FROM sakila.actor
WHERE last_name LIKE '%GEN%';

-- 2c
SELECT first_name, last_name
FROM sakila.actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;

-- 2d
SELECT country_id, country
FROM sakila.country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- 3a
ALTER TABLE sakila.actor
ADD description BLOB;

-- 3b
ALTER TABLE sakila.actor
DROP description;

-- 4a
SELECT last_name, COUNT(last_name)
FROM sakila.actor
GROUP BY last_name;

-- 4b
SELECT last_name, COUNT(last_name) as countlastname
FROM sakila.actor
GROUP BY last_name
HAVING countlastname > 1;

-- 4c
UPDATE sakila.actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

-- 4d
UPDATE sakila.actor
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO';

-- 5a
SHOW CREATE TABLE address;

-- 6a
SELECT staff.first_name, staff.last_name, address.address
FROM staff
INNER JOIN address ON staff.address_id=address.address_id;

-- 6b
SELECT s.staff_id, s.first_name, s.last_name, SUM(p.amount)
FROM staff s
INNER JOIN payment p ON s.staff_id=p.staff_id
WHERE payment_date LIKE '2005-08%' 
GROUP BY s.staff_id;

-- 6c
SELECT f.film_id, f.title, COUNT(fa.actor_id) as number_of_actors
FROM film f
INNER JOIN film_actor fa ON f.film_id=fa.film_id
GROUP BY f.film_id;

-- 6d
SELECT f.film_id, f.title, COUNT(i.film_id) as number_of_copies
FROM film f
INNER JOIN inventory i ON f.film_id=i.film_id
WHERE title = 'Hunchback Impossible'
GROUP BY f.film_id;

-- 6e
SELECT c.first_name, c.last_name, SUM(p.amount) as 'Total Amount Paid'
FROM customer c
INNER JOIN payment p ON c.customer_id=p.customer_id
GROUP BY c.customer_id
ORDER BY last_name;

-- 7a
SELECT title
FROM film
WHERE (language_id IN
(
  SELECT language_id
  FROM language
  WHERE language_id = 1
) AND title LIKE 'K%' OR title LIKE 'Q%');

-- 7b
SELECT first_name, last_name
FROM actor
WHERE actor_id IN
(
  SELECT actor_id
  FROM film_actor
  WHERE film_id IN
  (
    SELECT film_id
    FROM film
    WHERE title IN ('ALONE TRIP')
  ) 
);

-- 7c
SELECT first_name, last_name, email
FROM customer c
INNER JOIN address a ON c.address_id=a.address_id
INNER JOIN city ci ON a.city_id=ci.city_id
INNER JOIN country co ON ci.country_id = co.country_id
WHERE co.country IN ('Canada');


-- 7d
SELECT title
FROM film
WHERE film_id IN
(
  SELECT film_id
  FROM film_category
  WHERE category_id IN
  (
    SELECT category_id
    FROM category
    WHERE name IN ('Family')
  ) 
);

-- 7e
SELECT f.title, COUNT(f.film_id) as '# of Times Rented'
FROM film f 
INNER JOIN inventory i ON i.film_id=f.film_id
INNER JOIN rental r ON r.inventory_id=i.inventory_id
GROUP BY f.film_id
ORDER BY COUNT(f.film_id) DESC
LIMIT 10;

-- 7f
SELECT s.store_id AS 'Store ID', SUM(p.amount) as 'Total Amount Paid'
FROM store s
INNER JOIN staff sta ON s.store_id=sta.store_id
INNER JOIN payment p ON sta.staff_id=p.staff_id
GROUP BY s.store_id;

-- 7g
SELECT s.store_id, ci.city, co.country
FROM store s
INNER JOIN address a ON s.address_id=a.address_id
INNER JOIN city ci ON a.city_id=ci.city_id
INNER JOIN country co ON ci.country_id=co.country_id;

-- 7h
SELECT c.name as 'Genre', SUM(p.amount) as 'Gross Revenue'
FROM category c 
INNER JOIN film_category fc ON c.category_id=fc.category_id
INNER JOIN inventory i ON fc.film_id=i.film_id
INNER JOIN rental r ON i.inventory_id=r.inventory_id
INNER JOIN payment p ON r.customer_id=p.customer_id
GROUP BY c.name
ORDER BY SUM(p.amount) DESC
LIMIT 5;

-- 8a
CREATE VIEW top_five_genres AS
SELECT c.name as 'Genre', SUM(p.amount) as 'Gross Revenue'
FROM category c 
INNER JOIN film_category fc ON c.category_id=fc.category_id
INNER JOIN inventory i ON fc.film_id=i.film_id
INNER JOIN rental r ON i.inventory_id=r.inventory_id
INNER JOIN payment p ON r.customer_id=p.customer_id
GROUP BY c.name
ORDER BY SUM(p.amount) DESC
LIMIT 5;

-- 8b
SELECT * FROM top_five_genres;

-- 8c
DROP VIEW top_five_genres;



