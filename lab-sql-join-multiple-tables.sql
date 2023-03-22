use sakila;

-- 1.Write a query to display for each store its store ID, city, and country.alter
SELECT s.store_id, c.city, co.country
FROM store s
JOIN address a USING(address_id)
JOIN city c USING(city_id)
JOIN country co USING(country_id)
;

-- 2.Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id, SUM(p.amount) AS revenue
FROM store s
JOIN staff st USING(store_id)
JOIN payment p USING(staff_id)
GROUP BY s.store_id
ORDER BY revenue DESC
;

-- 3.What is the average running time of films by category?
SELECT c.name AS category, AVG(f.length) AS avg_running_time
FROM film_category fc
JOIN category c USING(category_id)
JOIN film f USING(film_id)
GROUP BY c.name
;

-- 4.Which film categories are longest?
SELECT c.name AS category, AVG(f.length) AS avg_running_time
FROM film_category fc
JOIN category c USING(category_id)
JOIN film f USING(film_id)
GROUP BY c.name
ORDER BY avg_running_time DESC
;

-- 5.Display the most frequently rented movies in descending order.
SELECT f.title, COUNT(*) AS rental_count
FROM rental r
JOIN inventory i USING(inventory_id)
JOIN film f USING(film_id)
GROUP BY f.title
ORDER BY rental_count DESC
;

-- 6.List the top five genres in gross revenue in descending order.
SELECT c.name AS category, SUM(p.amount) AS gross_revenue
FROM rental r
JOIN inventory i USING(inventory_id)
JOIN film_category fc USING(film_id)
JOIN category c USING(category_id)
JOIN payment p USING(rental_id)
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5
;

-- 7.Is "Academy Dinosaur" available for rent from Store 1?
SELECT 
  f.title AS movie, 
  i.store_id AS store, 
  r.inventory_id AS inventory_id,
  CASE
    WHEN COUNT(r.return_date) > 0 THEN 'Yes' 
    ELSE 'No' 
  END AS available 
FROM 
  film f
  JOIN inventory i USING(film_id) 
  LEFT JOIN rental r USING (inventory_id)
WHERE 
  f.title = 'Academy Dinosaur' 
  AND i.store_id = 1 
GROUP BY 
  1,2,3;