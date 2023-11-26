-- 1. Write a query to display for each store its store ID, city, and country.
select s.store_id, cy.city, ca.country
from sakila.store s
left join sakila.address a
on s.address_id = a.address_id
left join sakila.city cy
on a.city_id = cy.city_id
left join sakila.country ca
on cy.country_id = ca.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.
select st.store_id, sum(amount) as tot_amount_p_store 
from sakila.payment p
left join sakila.staff sa
on p.staff_id = sa.staff_id
left join sakila.store st
on sa.store_id = st.store_id
group by 1;

-- 3. What is the average running time of films by category?
select c.name , avg(length) as avg_running_time 
from sakila.film f
left join sakila.film_category fc
on f.film_id = fc.film_id
left join sakila.category c
on fc.category_id = c.category_id
group by 1
order by 2 desc;

-- 4. Which film categories are longest? SPORTS

-- 5. Display the most frequently rented movies in descending order. BUCKET BROTHERHOOD
select f.title, count(title) 
from sakila.rental r
left join sakila.inventory i
on r.inventory_id = i.inventory_id
left join sakila.film f
on i.film_id = f.film_id
group by 1
order by 2 desc
limit 1;

-- 6. List the top five genres in gross revenue in descending order.
select name, sum(amount) as tot_amount
from sakila.payment py
left join sakila.rental rt
on py.rental_id = rt.rental_id
left join sakila.inventory inv
on rt.inventory_id = inv.inventory_id
left join sakila.film_category fcat
on inv.film_id = fcat.film_id
left join sakila.category cat
on fcat.category_id = cat.category_id
group by 1
order by 2 desc
limit 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1? yes


select store_id, title, return_date
from sakila.rental ren
left join sakila.inventory inv
on ren.inventory_id = inv.inventory_id
left join sakila.film fil
on inv.film_id = fil.film_id
where return_date is not null 
and rental_date is null
and fil.title = "Academy Dinosaur"
order by 1; -- all available in store 1

select store_id, title, count(fil.film_id)
from sakila.rental ren
left join sakila.inventory inv
on ren.inventory_id = inv.inventory_id
left join sakila.film fil
on inv.film_id = fil.film_id
group by 1,2
having fil.title = "Academy Dinosaur" and store_id =1; -- 12 film available 