-- Instructions

-- 1. Write a query to display for each store its store ID, city, and country.

select 
	s.store_id,
    c.city,
    co.country
from sakila.store s
join sakila.address a on s.address_id = a.address_id 
join sakila.city c on c.city_id = a.city_id
join sakila.country co on co.country_id = c.country_id;

-- Write a query to display how much business, in dollars, each store brought in.

select
	s.store_id,
	sum(p.amount) as dollars
from sakila.payment p
join sakila.staff s on p.staff_id = s.staff_id
group by 1;

-- What is the average running time of films by category?

Select
	c.name,
	avg(f.length) as average_running_time
from sakila.category c
join sakila.film_category fc on c.category_id = fc.category_id
join sakila.film f on f.film_id = fc.film_id
group by 1;

-- Which film categories are longest?

Select
	c.name,
	avg(f.length) as average_running_time
from sakila.category c
join sakila.film_category fc on c.category_id = fc.category_id
join sakila.film f on f.film_id = fc.film_id
group by 1
order by 2 desc
limit 1;

-- Display the most frequently rented movies in descending order.

select
	f.title,
    count(f.title) as number_of_rents
from sakila.rental r
join sakila.inventory i on r.inventory_id = i.inventory_id
join sakila.film f on f.film_id = i.film_id
group by 1
order by 2 desc;

-- List the top five genres in gross revenue in descending order.

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

-- Is "Academy Dinosaur" available for rent from Store 1?

select
	f.title,
    count(f.title) as film_stock
from sakila.inventory i
join sakila.film f using (film_id)
join sakila.store s using (store_id)
where f.title ='Academy Dinosaur' and store_id = '1'
