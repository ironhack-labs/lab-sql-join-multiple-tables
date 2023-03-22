-- Instructions
-- 1. Write a query to display for each store its store ID, city, and country.
SELECT A.store_id, C.city, D.country 
FROM sakila.store a
JOIN sakila.address B USING (address_id) 
JOIN sakila.city C USING (city_id)
JOIN sakila.country D USING (country_id);

-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT A.store_id, sum(C.amount) as Total_Amount 
FROM sakila.store a
JOIN sakila.customer B USING (store_id) 
JOIN sakila.payment C USING (customer_id)
GROUP BY 1;

-- 3. What is the average running time of films by category?
SELECT C.name, avg(A.length) as Average_Running_Time
FROM sakila.film A
JOIN sakila.film_category B USING(film_id)
JOIN sakila.category C USING(category_id)
GROUP BY 1;

-- 4. Which film categories are longest?
SELECT C.name, avg(A.length) as Average_Running_Time
FROM sakila.film A
JOIN sakila.film_category B USING(film_id)
JOIN sakila.category C USING(category_id)
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3;

-- 5. Display the most frequently rented movies in descending order.
SELECT A.title, COUNT(C.rental_date) as Rental_Frequency
FROM sakila.film A
JOIN sakila.inventory B USING(film_id)
JOIN sakila.rental C USING(inventory_id)
GROUP BY 1
ORDER BY 2 DESC;

-- 6. List the top five genres in gross revenue in descending order.
SELECT A.name, sum(F.amount) as Gross_Revenue
FROM sakila.category A
JOIN sakila.film_category B USING(category_id)
JOIN sakila.film C USING(film_id)
JOIN sakila.inventory D USING (film_id)
JOIN sakila.rental E USING(inventory_id)
JOIN sakila.payment F USING(rental_id)
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT *
FROM sakila.film A
JOIN sakila.inventory B USING(film_id)
JOIN sakila.store C USING(store_id)
WHERE A.title = "Academy Dinosaur" and C.store_id = 1;