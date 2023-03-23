use sakila;
-- Write a query to display for each store its store ID, city, and country.
select s.store_id, c.city, z.country
from sakila.store s
join address a on s.address_id = a.address_id
join city c on c.city_id = a.city_id
join country z on z.country_id = c.country_id;

-- Write a query to display how much business, in dollars, each store brought in.
SELECT 
    s.store_id, sum(p.amount)
FROM sakila.store s
JOIN sakila.customer c USING(store_id)
JOIN sakila.payment p USING(customer_id) 
GROUP BY store_id;

-- What is the average running time of films by category?
SELECT c.name AS category, AVG(f.length) AS avg_running_time
FROM sakila.film f
JOIN sakila.film_category fc ON f.film_id = fc.film_id
JOIN sakila.category c ON fc.category_id = c.category_id
GROUP BY c.name;

-- Which film categories are longest?
SELECT c.name AS category, AVG(f.length) AS avg_running_time
FROM sakila.film f
JOIN sakila.film_category fc ON f.film_id = fc.film_id
JOIN sakila.category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_running_time DESC;

-- Display the most frequently rented movies in descending order.
select f.title as movie, count(r.rental_id) as rentals from film f
join sakila.inventory i using(film_id)
join sakila.rental r using(inventory_id)
group by movie 
order by rentals desc;

-- List the top five genres in gross revenue in descending order.
select ca.name as genres, sum(p.amount) as gross_revenue 
from sakila.category ca
join sakila.film_category c using(category_id)
join sakila.inventory i using(film_id) 
join sakila.rental r using(inventory_id)
join sakila.payment p using(rental_id)
group by ca.name 
order by gross_revenue desc limit 5;

-- Is "Academy Dinosaur" available for rent from Store 1?
SELECT title, 
	CASE 
	WHEN COUNT(*) > 0 THEN 'Yes' 
	ELSE 'No' 
	END AS available
FROM sakila.film 
JOIN sakila.inventory USING(film_id) 
JOIN sakila.rental USING(inventory_id) 
WHERE title = 'Academy Dinosaur' AND store_id = '1' AND return_date IS NOT NULL
GROUP BY title;