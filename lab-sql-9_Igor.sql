-- Lab | SQL Joins on multiple tables

-- Write a query to display for each store its store ID, city, and country.

SELECT 
	s.store_id, 
    c.city, 
    co.country
FROM sakila.store s
JOIN sakila.address a USING(address_id)
JOIN sakila.city c USING(city_id)
JOIN sakila.country co USING(country_id);

-- Write a query to display how much business, in dollars, each store brought in.

SELECT 
	s.store_id, 
    sum(p.amount)
FROM sakila.store s
JOIN sakila.customer c USING(store_id)
JOIN sakila.payment p USING(customer_id) 
GROUP BY store_id;

-- What is the average running time of films by category?

SELECT 
	name, 
	avg(length) as avg_running_time
FROM sakila.category c
JOIN sakila.film_category fc ON c.category_id = fc.category_id
JOIN sakila.film f ON fc.film_id = f.film_id
GROUP BY name;

-- Which film categories are longest?

SELECT 
	title, 
    MAX(length) AS max_length
FROM sakila.film f
JOIN sakila.film_category fc ON f.film_id = fc.film_id
JOIN sakila.category c ON fc.category_id = c.category_id
GROUP BY title
ORDER BY max_length DESC;


-- Display the most frequently rented movies in descending order.

SELECT 
	f.title, 
	count(r.rental_id) as rentals 
FROM sakila.film f
JOIN sakila.inventory i USING(film_id)
JOIN sakila.rental r USING(inventory_id)
GROUP BY f.title 
ORDER BY rentals DESC;

-- List the top five genres in gross revenue in descending order.

SELECT 
	c.name, 
	sum(amount) AS gross_revenue
FROM sakila.rental r
JOIN sakila.inventory i USING(inventory_id)
JOIN sakila.film_category fc USING(film_id)
JOIN sakila.category c USING(category_id)
JOIN sakila.payment p USING(rental_id)
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;

-- Is "Academy Dinosaur" available for rent from Store 1?

SELECT 
	title, 
       CASE 
         WHEN COUNT(*) > 0 THEN 'Yes' 
         ELSE 'No' 
       END AS available
FROM sakila.film 
JOIN sakila.inventory USING(film_id) 
JOIN sakila.rental USING(inventory_id) 
WHERE title = 'Academy Dinosaur' AND store_id = '1' AND return_date IS NOT NULL
GROUP BY title;