-- 1.Write a query to display for each store its store ID, city, and country.
select 
	A.store_id, 
    C.city, 
    D.country
from sakila.store A 
join sakila.address B on B.address_id = A.address_id
join sakila.city C using(city_id)
join sakila.country D using(country_id);

-- 2.Write a query to display how much business, in dollars, each store brought in.
select 
	A.store_id, 
    sum(C.amount) as tot 
from sakila.store A 
join sakila.customer B on B.store_id = A.store_id
join sakila.payment C using(customer_id) 
group by a.store_id
;


-- 3.What is the average running time of films by category?
select 
	A.category_id, 
    avg(B.length) as avg_run 
from sakila.film_category A 
join sakila.film B on B.film_id = A.film_id
group by a.category_id
;

-- 4.Which film categories are longest?
select 
	A.category_id, 
    avg(B.length) as avg_run 
from sakila.film_category A 
join sakila.film B on B.film_id = A.film_id
group by a.category_id
order by avg_run desc
;
-- 5.Display the most frequently rented movies in descending order.
select 
	C.title, 
    count(C.film_id) as frequency
from sakila.rental A 
left join sakila.inventory B on B.inventory_id = A.inventory_id
left join sakila.film C using(film_id)
group by c.title
order by frequency desc
;

-- 6.List the top five genres in gross revenue in descending order.
select 
	F.name, 
    sum(B.amount) as tot 
from sakila.rental A 
left join sakila.payment B on B.rental_id = A.rental_id
left join sakila.inventory C using(inventory_id)
left join sakila.film D using(film_id)
left join sakila.film_category E using(film_id)
left join sakila.category F using(category_id)
group by f.name
order by tot desc
limit 5
;

-- 7.Is "Academy Dinosaur" available for rent from Store 1?
select 
B.store_id, 
C.title,
A.rental_date, 
A.return_date
from sakila.rental A 
left join sakila.inventory B using(inventory_id)
left join sakila.film C using(film_id)
where A.rental_date < A.return_date
having B.store_id = 1 and C.title = 'Academy Dinosaur';