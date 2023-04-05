use sakila;

-- 1

SELECT 
    s.store_id,
    ci.city,
    co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

-- 2

SELECT 
    s.store_id,
    CONCAT(ci.city, ', ', co.country) AS location,
    SUM(p.amount) AS total_sales
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
JOIN customer c ON s.store_id = c.store_id
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY s.store_id;

-- 3

SELECT 
    c.name AS category_name,
    AVG(f.length) AS avg_running_time
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

-- 4

SELECT 
    c.name AS category_name,
    AVG(f.length) AS avg_running_time
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_running_time DESC;

-- 5

SELECT 
    f.title AS film_title,
    COUNT(*) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id
ORDER BY rental_count DESC;

-- 6

SELECT 
    c.name AS category_name,
    SUM(p.amount) AS total_revenue
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN inventory i ON fc.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY total_revenue DESC
LIMIT 5;

-- 7

SELECT 
    COUNT(*) AS available_copies
FROM inventory i
JOIN store s ON i.store_id = s.store_id
JOIN film f ON i.film_id = f.film_id
WHERE s.store_id = 1
AND f.title = 'Academy Dinosaur'
AND i.inventory_id NOT IN (SELECT inventory_id FROM rental);

