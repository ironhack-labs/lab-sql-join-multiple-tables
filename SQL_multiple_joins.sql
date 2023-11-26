-- 1.Write a query to display for each store its store ID, city, and country.
select s.store_id, ci.city, cou.country
from sakila.store s 
left join sakila.address a on s.address_id = a.address_id
left join sakila.city ci on a.city_id = ci.city_id
left join sakila.country cou on ci.country_id = cou.country_id
group by s.store_id order by 1;


-- 2.Write a query to display how much business, in dollars, each store brought in.
select st.store_id, sum(amount) as revenue_$
from sakila.staff st
left join sakila.payment pay on st.staff_id = pay.staff_id
group by 1 order by 2;
 
-- 3.What is the average running time of films by category?
select cat.name, round(avg(length), 2) as avg_duration_by_category
from sakila.category cat left join sakila.film_category fcat on cat.category_id = fcat.category_id
left join sakila.film f on fcat.film_id = f.film_id 
group by cat.name;

-- 4.Which film categories are longest?
select cat.name, round(avg(length), 2) as avg_duration_by_category
from sakila.category cat left join sakila.film_category fcat on cat.category_id = fcat.category_id
left join sakila.film f on fcat.film_id = f.film_id 
group by cat.name order by 2 desc
limit 5;


-- 5.Display the most frequently rented movies in descending order.
select f.title, count(rental_id) as count_rentals_by_film
from sakila.film f left join sakila.inventory i on f.film_id = i.film_id
left join sakila.rental ren on i.inventory_id = ren.inventory_id
group by f.title order by 2 desc
limit 5;


-- 6.List the top five genres in gross revenue in descending order.
select cat.name, sum(amount) as category_revenue
from sakila.category cat left join sakila.film_category fcat on cat.category_id = fcat.category_id 
left join sakila.inventory i on fcat.film_id = i.film_id 
left join sakila.rental ren on i.inventory_id = ren.inventory_id
left join sakila.payment pay on ren.rental_id = pay.rental_id
group by cat.name order by 2 desc
limit 5;


-- 7.Is "Academy Dinosaur" available for rent from Store 1?
select f.title
from sakila.inventory i left join sakila.film f on i.film_id=f.film_id 
where (f.title = 'Academy Dinosaur') and (i.store_id = 1)
group by i.store_id
;

end;