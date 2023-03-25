-- 1.Write a query to display for each store its store ID, city, and country.
SELECT
s.store_id,
c.city,
co.country
FROM sakila.store s
JOIN sakila.address a using(address_id)
JOIN sakila.city c using(city_id)
JOIN sakila.country co using(country_id);

-- 2.Write a query to display how much business, in dollars, each store brought in.

SELECT 
sto.store_id,
sum(p.amount) as Total_in_dollars
FROM sakila.store sto
JOIN sakila.staff sta using(store_id)
JOIN sakila.payment p using(staff_id)
GROUP BY 1;
-- 3.What is the average running time of films by category?
SELECT
c.name,
avg(f.length) as avg_running_time
FROM sakila.category c
JOIN sakila.film_category fc using(category_id)
JOIN sakila.film f using(film_id)
GROUP BY 1;


-- 4.Which film categories are longest?
SELECT
c.name,
avg(f.length) as avg_running_time
FROM sakila.category c
JOIN sakila.film_category fc using(category_id)
JOIN sakila.film f using(film_id)
GROUP BY 1
ORDER BY 2 desc LIMIT 1;
-- 5.Display the most frequently rented movies in descending order.
SELECT
f.title,
count(r.rental_id) as freq_rent
FROM sakila.rental r
JOIN sakila.inventory i using(inventory_id)
JOIN sakila.film f using(film_id)
GROUP BY 1
ORDER BY 2 desc;
-- 6.List the top five genres in gross revenue in descending order.
SELECT
c.name,
sum(p.amount) as gross_revenue
FROM sakila.category c
JOIN sakila.film_category fc using(category_id)
JOIN sakila.film f using(film_id)
JOIN sakila.inventory i using(film_id)
JOIN sakila.rental r using(inventory_id)
JOIN sakila.payment p using(rental_id)
GROUP BY 1
ORDER BY 2 desc LIMIT 5;


-- 7.Is "Academy Dinosaur" available for rent from Store 1?

SELECT
	f.title,
    count(f.title) as film_stock
FROM sakila.inventory i
JOIN sakila.film f using (film_id)
JOIN sakila.store s using (store_id)
WHERE f.title ='Academy Dinosaur' and store_id = '1'