-- 1. Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, c.city, co.country
FROM sakila.store s
JOIN sakila.address a
USING (address_id)
JOIN sakila.city c
USING (city_id)
JOIN sakila.country co
USING (country_id)
;

-- 2.Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id, CONCAT('$ ', sum(amount)) as TotalBusiness # MISSING DOLLARS
FROM sakila.staff staff
JOIN sakila.store s
USING (store_id)
JOIN  sakila.payment p
USING (staff_id)
GROUP BY s.store_id;
;


-- 3.What is the average running time of films by category?
SELECT  c.name, avg(f.length) as AverageRunningTime
FROM sakila.film f
JOIN sakila.film_category fc
USING (film_id)
JOIN sakila.category c
USING (category_id)
GROUP BY c.name
;

-- 4.Which film categories are longest?
SELECT  c.name, avg(f.length) as AverageRunningTime
FROM sakila.film f
JOIN sakila.film_category fc
USING (film_id)
JOIN sakila.category c
USING (category_id)
GROUP BY c.name
ORDER BY AverageRunningTime DESC
LIMIT 2;

-- 5.Display the most frequently rented movies in descending order.
SELECT f.title, sum(rental_id)
FROM sakila.rental r
JOIN sakila.inventory i 
USING (inventory_id)
JOIN sakila.film f
USING (film_id)
GROUP BY 1
ORDER BY 1 DESC
;

-- 6. List the top five genres in gross revenue in descending order.
SELECT c.name, CONCAT('$ ', sum(p.amount)) as GrossRevenue
FROM sakila.payment p
JOIN sakila.rental r 
USING (rental_id)
JOIN sakila.inventory i
USING (inventory_id)
JOIN sakila.film_category f
USING (film_id)
JOIN sakila.category c
USING (category_id)
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


-- 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT f.title, i.store_id, return_date
FROM sakila.inventory i
JOIN sakila.film f ON i.film_id  = f.film_id AND f.title = "Academy Dinosaur"
JOIN sakila.rental r ON i.inventory_id = r.inventory_id AND r.return_date > now()
JOIN sakila.store s ON i.store_id = s.store_id
GROUP BY 1;


