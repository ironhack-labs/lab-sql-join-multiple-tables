-- 1. Display for each store its store ID, city, and country.
SELECT
    st.store_id AS store,
    ci.city AS city,
    co.country AS country
FROM
    sakila.store st
LEFT JOIN sakila.address ad ON st.address_id = ad.address_id
LEFT JOIN sakila.city ci ON ad.city_id = ci.city_id
LEFT JOIN sakila.country co ON ci.country_id = co.country_id;

-- 2. Display how much business, in dollars, each store brought in.
SELECT
    st.store_id AS store,
    CONCAT(COUNT(amount), ' USD') AS amount
FROM
    sakila.payment pay
LEFT JOIN sakila.staff st ON pay.staff_id = st.staff_id
LEFT JOIN sakila.store sto ON st.store_id = sto.store_id
GROUP BY
    st.store_id;

-- 3. What is the average running time of films by category?
SELECT
    cat.name AS Category,
    AVG(f.length) AS avg_length
FROM
    sakila.film f
LEFT JOIN sakila.film_category f_c ON f.film_id = f_c.film_id
LEFT JOIN sakila.category cat ON f_c.category_id = cat.category_id
GROUP BY
    cat.name;

-- 4. Which film categories are longest?
SELECT
    cat.name AS Category,
    AVG(f.length) AS avg_length
FROM
    sakila.film f
LEFT JOIN sakila.film_category f_c ON f.film_id = f_c.film_id
LEFT JOIN sakila.category cat ON f_c.category_id = cat.category_id
GROUP BY
    cat.name
ORDER BY
    avg_length DESC;

-- 5. Display the most frequently rented movies in descending order.
SELECT
    f.title AS Name,
    COUNT(r.rental_id) AS n_rented
FROM
    sakila.film f
LEFT JOIN sakila.inventory inv ON f.film_id = inv.film_id
LEFT JOIN sakila.rental r ON inv.inventory_id = r.inventory_id
GROUP BY
    f.title
ORDER BY
    n_rented DESC;

-- 6. List the top five genres in gross revenue in descending order.
SELECT
    c.name AS Category,
    SUM(p.amount) AS GrossRevenue
FROM
    sakila.payment p
LEFT JOIN sakila.rental r ON p.rental_id = r.rental_id
LEFT JOIN sakila.inventory inv ON r.inventory_id = inv.inventory_id
LEFT JOIN sakila.film f ON inv.film_id = f.film_id
LEFT JOIN sakila.film_category fc ON f.film_id = fc.film_id
LEFT JOIN sakila.category c ON fc.category_id = c.category_id
GROUP BY
    c.name
ORDER BY
    GrossRevenue DESC;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT *
FROM
    sakila.inventory inv
LEFT JOIN sakila.film f ON inv.film_id = f.film_id
WHERE
    f.title = 'ACADEMY DINOSAUR' AND inv.store_id = 1;
-- YES, IT'S AVAILABLE!
