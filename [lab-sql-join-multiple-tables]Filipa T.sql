-- 1. Write a query to display for each store its store ID, city, and country.

select s.store_id, c.city, cou.country 
from sakila.store s
left join sakila.address a
on s.address_id = a.address_id
left join sakila.city c
on a.city_id = c.city_id
left join sakila.country cou
on c.country_id = cou.country_id
group by s.store_id
;

-- 2. Write a query to display how much business, in dollars, each store brought in.

select s.store_id, sum(p.amount) as amount_per_store
from sakila.payment p
left join sakila.staff s
on p.staff_id = s.staff_id
group by s.store_id
;

-- 3. What is the average running time of films by category?

select c.name, round(avg(f.length)) avg_length
from sakila.film f
left join sakila.film_category fc
on f.film_id = fc.film_id
left join sakila.category c
on fc.category_id = c.category_id
group by c.name
;

-- 4. Which film categories are longest?

select c.name, round(avg(f.length)) avg_length
from sakila.film f
left join sakila.film_category fa
on f.film_id = fa.film_id
left join sakila.category c
on fa.category_id = c.category_id
group by c.name
order by avg(f.length) desc
;

-- 5. Display the most frequently rented movies in descending order.

select f.title, count(rental_id) as rentals
from sakila.rental r
left join sakila.inventory i
on r.inventory_id = i.inventory_id
left join sakila.film f
on i.film_id = f.film_id
group by f.title
order by count(rental_id) desc
;

-- 6. List the top five genres in gross revenue in descending order.

select c.name, sum(p.amount) as amount_by_category
from sakila.payment p
left join sakila.rental r
on p.customer_id = r.customer_id
left join sakila.inventory i
on r.inventory_id = i.inventory_id
left join sakila.film_category fc
on i.film_id = fc.film_id
left join sakila.category c
on fc.category_id = c.category_id
group by c.name
order by sum(p.amount) desc
limit 5
;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?

select * 
from sakila.inventory i
left join sakila.film f 
on i.film_id = f.film_id
where f.title = 'Academy Dinosaur' and i.store_id = '1'
;

-- Yes