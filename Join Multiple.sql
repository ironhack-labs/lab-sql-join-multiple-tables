-- 1. Write a query to display for each store its store ID, city, and country.

SELECT 
    s.store_id, a.city_id, co.country
FROM
    sakila.store s
        JOIN
    sakila.address a ON s.address_id = a.address_id
        JOIN
    sakila.city ci ON a.city_id = ci.city_id
        JOIN
    sakila.country co ON ci.country_id = co.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.

SELECT 
    s.store_id, SUM(p.amount) AS dollars
FROM
    sakila.payment p
        JOIN
    sakila.staff s ON p.staff_id = s.staff_id
GROUP BY 1;

-- 3. What is the average running time of films by category?

SELECT 
    c.name AS category, AVG(f.length) AS average_running_time
FROM
    sakila.film f
        JOIN
    film_category fc ON f.film_id = fc.film_id
        JOIN
    film.category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY average_running_time DESC;

-- 4. Which film categories are longest?

SELECT 
    c.name AS category, AVG(f.length) AS avg_length
FROM
    sakila.film f
        JOIN
    film_category fc ON f.film_id = fc.film_id
        JOIN
    category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_length DESC;

-- 5. Display the most frequently rented movies in descending order.

SELECT 
    f.title, COUNT(f.title) AS number_of_rents
FROM
    sakila.rental r
        JOIN
    sakila.inventory i ON r.inventory_id = i.inventory_id
        JOIN
    sakila.film f ON f.film_id = i.film_id
GROUP BY 1
ORDER BY 2 DESC;

-- 6. List the top five genres in gross revenue in descending order.

SELECT 
    c.name, SUM(p.amount) AS gross_revenue
FROM
    sakila.category c
        JOIN
    sakila.film_category fc USING (category_id)
        JOIN
    sakila.film f USING (film_id)
        JOIN
    sakila.inventory i USING (film_id)
        JOIN
    sakila.rental r USING (inventory_id)
        JOIN
    sakila.payment p USING (rental_id)
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?

SELECT 
    f.title, COUNT(f.title) AS film_stock
FROM
    sakila.inventory i
        JOIN
    sakila.film f USING (film_id)
        JOIN
    sakila.store s USING (store_id)
WHERE
    f.title = 'Academy Dinosaur'
        AND store_id = '1'
