-- 1 Write a query to display for each store its store ID, city, and country.
-- 2 Write a query to display how much business, in dollars, each store brought in.
-- 3 What is the average running time of films by category?
-- 4 Which film categories are longest?
-- 5 Display the most frequently rented movies in descending order.
-- 6 List the top five genres in gross revenue in descending order.
-- 7 Is "Academy Dinosaur" available for rent from Store 1?

use sakila;
-- 1
SELECT
  s.store_id, a.address, ci.city, co.country 
FROM sakila.store AS s
JOIN sakila.address a ON s.address_id = a.address_id
JOIN sakila.city ci ON a.city_id = ci.city_id
JOIN sakila.country co ON ci.country_id = co.country_id;

-- 2
SELECT
  s.store_id,
  SUM(p.amount) AS total_sales
FROM
  sakila.store s
JOIN sakila.staff sta ON s.manager_staff_id = sta.staff_id
JOIN sakila.payment p ON sta.staff_id = p.staff_id
GROUP BY
  s.store_id;

-- 3
 SELECT
  c.name AS category,
  AVG(f.length) AS average_running_time
FROM
  sakila.film AS f
JOIN sakila.film_category AS fc ON f.film_id = fc.film_id
JOIN sakila.category AS c ON fc.category_id = c.category_id
GROUP BY
  c.name;

-- 4
SELECT c.name AS 'Category', AVG(f.length) AS 'Average Length'
FROM sakila.category AS c
JOIN sakila.film_category AS fc ON c.category_id = fc.category_id
JOIN sakila.film AS f ON fc.film_id = f.film_id
GROUP BY c.name;

-- 5
SELECT f.title AS 'MOVIE', COUNT(r.rental_id) AS 'RENTAL_COUNT'
FROM sakila.film AS f
JOIN sakila.inventory AS i ON f.film_id = i.film_id
JOIN sakila.rental AS r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY RENTAL_COUNT DESC
LIMIT 0, 1000;


-- 6
SELECT
    c.name AS 'CATEGORY',
    SUM(p.amount) AS 'GROSS_REVENUE'
FROM
    sakila.category AS c
JOIN
    sakila.film_category AS fc ON c.category_id = fc.category_id
JOIN
    sakila.film AS f ON fc.film_id = f.film_id
JOIN
    sakila.inventory AS i ON f.film_id = i.film_id
JOIN
    sakila.rental AS r ON i.inventory_id = r.inventory_id
JOIN
    sakila.payment AS p ON r.rental_id = p.rental_id
GROUP BY
    c.name
ORDER BY
    GROSS_REVENUE DESC
LIMIT 5;


-- 7 
SELECT
    f.title AS 'MOVIE_TITLE',
    s.store_id AS 'STORE_ID',
    CASE
        WHEN COUNT(r.rental_id) > 0 THEN 'Available'
        ELSE 'Not Available'
    END AS 'AVAILABILITY'
FROM
    sakila.film AS f
JOIN
    sakila.inventory AS i ON f.film_id = i.film_id
JOIN
    sakila.store AS s ON i.store_id = s.store_id
LEFT JOIN
    sakila.rental AS r ON i.inventory_id = r.inventory_id
WHERE
    f.title = 'Academy Dinosaur'
    AND s.store_id = 1
GROUP BY
    f.title, s.store_id;
