USE sakila;

# 1. Write a query to display for each store its store ID, city, and country.
SELECT
	s.store_id,
    c.city,
    co.country
FROM store s
JOIN address a using (address_id)
JOIN city c using (city_id)
JOIN country co using (country_id);

# 2. Write a query to display how much business, in dollars, each store brought in.
SELECT
	s.store_id,
    sum(amount) as total_business
FROM store s
LEFT JOIN customer c using (store_id)
LEFT JOIN payment p using (customer_id)
GROUP BY 1;

# 3. What is the average running time of films by category?
SELECT
    c.name,
    avg(f.length) avg_run_time
FROM category c
LEFT JOIN film_category fc using(category_id)
LEFT JOIN film f using(film_id)
GROUP BY 1;

# 4. Which film categories are longest?
SELECT
    c.name,
    avg(f.length) avg_run_time
FROM category c
LEFT JOIN film_category fc using(category_id)
LEFT JOIN film f using(film_id)
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

# 5. Display the most frequently rented movies in descending order.
SELECT
	f.title,
    count(*) as num_rentals
FROM film f
LEFT JOIN inventory i using (film_id)
LEFT JOIN rental r using (inventory_id)
GROUP BY 1
ORDER BY 2 DESC;

# 6. List the top five genres in gross revenue in descending order
SELECT
	c.name,
    sum(amount) as gross_revenue
FROM category c
LEFT JOIN film_category fa using (category_id)
LEFT JOIN film f using (film_id)
LEFT JOIN inventory i using (film_id)
LEFT JOIN rental r using (inventory_id)
LEFT JOIN payment p using (rental_id)
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

# 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT
	f.title,
    s.store_id,
    case
		when return_date = null then 'out of stock'
        else 'in stock'
        end as stock
FROM category c    
LEFT JOIN film_category fa using (category_id)
LEFT JOIN film f using (film_id)
LEFT JOIN inventory i using (film_id)
LEFT JOIN rental r using (inventory_id)
LEFT JOIN store s using (store_id)
WHERE f.title ='Academy Dinosaur' AND store_id=1 AND return_date is not null
GROUP BY 3
;
