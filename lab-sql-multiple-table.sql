
SELECT
	 s.store_id,
     c.city,
     co.country
FROM sakila.store s
JOIN sakila.address a USING(address_id)
JOIN sakila.city c USING(city_id)
JOIN sakila.country co USING(country_id)
;

SELECT
      s.store_id,
      sum(p.amount) as gross
FROM sakila.store s
JOIN staff st USING(store_id)
JOIN payment p USING(staff_id)
GROUP BY 1;

SELECT
      c.name,
	  AVG(f.length) AS avg_running_time
from sakila.film f
JOIN sakila.film_category fc USING(film_id)
JOIN sakila.category c USING(category_id)
GROUP BY c.category_id
ORDER BY avg_running_time DESC;

SELECT
      c.name,
	  AVG(f.length) AS avg_running_time
FROM sakila.film f
JOIN sakila.film_category fc USING(film_id)
JOIN sakila.category c USING(category_id)
GROUP BY c.category_id
ORDER BY avg_running_time DESC
LIMIT 5;

SELECT 
      f.film_id,
      f.title, 
      COUNT(*) AS rental_count
FROM sakila.film f
JOIN sakila.inventory i USING(film_id)
JOIN sakila.rental r USING(inventory_id)
GROUP BY f.film_id
ORDER BY rental_count DESC;

SELECT
      c.name,
      sum(p.amount) as gross_revenue
FROM sakila.film f
JOIN sakila.film_category fc USING(film_id)
JOIN sakila.category c USING(category_id)
JOIN sakila.inventory i USING(film_id)
JOIN sakila.rental r USING(inventory_id)
JOIN sakila.payment p USING(rental_id)
GROUP BY c.category_id
ORDER BY gross_revenue DESC
LIMIT 5;

SELECT 
      f.title, 
      i.store_id, 
      r.inventory_id,
  CASE
    WHEN COUNT(r.return_date) > 0 THEN 'Yes' 
    ELSE 'No' 
    END AS available 
FROM sakila.film f
JOIN inventory i USING(film_id) 
LEFT JOIN rental r USING(inventory_id)
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1 
GROUP BY 1,2,3;