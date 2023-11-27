-- Write a query to display for each store its store ID, city, and country.

select sa.store_id, ci.city, co.country
from sakila.store sa
inner join sakila.address ad
on sa.address_id = ad.address_id
inner join sakila.city ci
on ad.city_id = ci.city_id
inner join sakila.country co
on ci.country_id = co.country_id;

-- Write a query to display how much business, in dollars, each store brought in.

select so.store_id, sum(pa.amount) as total_amount, ad.address
from sakila.payment pa 
inner join sakila.staff st
on pa.staff_id = st.staff_id
inner join sakila.store so
on st.store_id = so.store_id
inner join sakila.address ad
on so.address_id = ad.address_id
group by so.store_id;

-- What is the average running time of films by category?

select c.name as Category, avg(fi.length) as Average_Time
from sakila.film_category ca
inner join sakila.film fi
on ca.film_id = fi.film_id
inner join sakila.category c
on ca.category_id = c.category_id
group by Category;

-- Which film categories are longest?

select c.name as Category, avg(fi.length) as Average_Time
from sakila.film_category ca
inner join sakila.film fi
on ca.film_id = fi.film_id
inner join sakila.category c
on ca.category_id = c.category_id
group by Category
order by Average_Time desc;

-- Display the most frequently rented movies in descending order.

select f.title as title, count(f.title) AS film_rentals
from sakila.rental re
inner join sakila.inventory i
on re.inventory_id = i.inventory_id
inner join sakila.film f
on i.film_id = f.film_id
group by f.title
order by film_rentals desc;

-- List the top five genres in gross revenue in descending order.

select sum(p.amount), ca.name
from sakila.payment p
inner join sakila.rental r 
on p.rental_id = r.rental_id
inner join sakila.inventory i
on r.inventory_id = i.inventory_id
inner join sakila.film_category c 
on i.film_id = c.film_id
inner join sakila.category ca
on c.category_id = ca.category_id
group by ca.name
order by sum(p.amount) desc
limit 5;

-- Is "Academy Dinosaur" available for rent from Store 1?
-- Yes, it is

select f.title, i.store_id
from sakila.film f
inner join sakila.inventory i
on f.film_id = i.film_id
where f.title = 'Academy Dinosaur' AND i.store_id = 1;