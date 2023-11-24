-- 1. Write a query to display for each store its store ID, city, and country.
select s.store_id, cy.city, nation.country
from sakila.store as s
left join sakila.address as ad
on s.address_id = ad.address_id
left join sakila.city as cy
on ad.city_id = cy.city_id
left join sakila.country as nation
on cy.country_id = nation.country_id 
;

-- 2. Write a query to display how much business, in dollars, each store brought in.
select s.store_id, sum(pay.amount) as amount_generated
from sakila.store as s
left join sakila.customer as c
on s.store_id = c.store_id
left join sakila.payment as pay
on c.customer_id = pay.customer_id
group by 1
;

-- 3. What is the average running time of films by category?
select cat.name, avg(fm.length) as avg_length
from sakila.film as fm
left join sakila.film_category as fm_cat
on fm.film_id = fm_cat.film_id
left join sakila.category as cat
on fm_cat.category_id = cat.category_id
group by 1
;

-- 4. Which film categories are longest?
select cat.name, avg(fm.length) as avg_length
from sakila.film as fm
left join sakila.film_category as fm_cat
on fm.film_id = fm_cat.film_id
left join sakila.category as cat
on fm_cat.category_id = cat.category_id
group by 1
order by avg(fm.length) desc
;

-- 5. Display the most frequently rented movies in descending order.
select fm.film_id, fm.title, count(r.rental_id) as rent_freq
from sakila.rental as r
left join sakila.inventory as inv
on r.inventory_id = inv.inventory_id
left join sakila.film as fm
on inv.film_id = fm.film_id
group by 1
order by 3 desc
;

-- 6. List the top five genres in gross revenue in descending order.
select cat.name, sum(pay.amount) as gross_revenue
from sakila.category as cat
left join sakila.film_category as fm_cat
on cat.category_id = fm_cat.category_id
left join sakila.film as fm
on fm_cat.film_id = fm.film_id
left join sakila.inventory as inv
on fm.film_id = inv.film_id
left join sakila.rental as r
on inv.inventory_id = r.inventory_id
left join sakila.payment as pay
on r.rental_id = pay.rental_id
group by cat.name
order by sum(pay.amount) desc
limit 5
;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
select inv.inventory_id, fm.title, inv.store_id, max(r.rental_date) as last_rental
from sakila.film as fm
left join sakila.inventory as inv
on fm.film_id = inv.film_id
left join sakila.rental as r
on inv.inventory_id = r.inventory_id
where fm.title = 'Academy Dinosaur'
group by inv.inventory_id
;
-- Answer: No, currently the movie is only in store 2 available.
