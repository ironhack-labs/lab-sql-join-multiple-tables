select s.store_id, c.city, co.country
from  sakila.store s
join sakila.address a using(address_id)
join sakila.city c using(city_id)
join sakila.country co using(country_id);

select s.store_id, sum(p.amount)
from sakila.store s
join sakila.customer c using(store_id)
join sakila.payment p using(customer_id) 
group by store_id;

select name, avg(length) as 'avg_running_time'
from sakila.category c
join sakila.film_category fc on c.category_id = fc.category_id
join sakila.film f on fc.film_id = f.film_id
group by name;

select title, max(length) as 'max_length'
from sakila.film f
join sakila.film_category fc on f.film_id = fc.film_id
join sakila.category c on fc.category_id = c.category_id
group by title
order by max_length desc;

select f.title, count(r.rental_id) as 'rentals'
from sakila.film f
join sakila.inventory i using(film_id)
join sakila.rental r using(inventory_id)
group by f.title 
order by rentals desc;

select c.name, sum(amount) as 'gross_revenue'
from sakila.rental r
join sakila.inventory i using(inventory_id)
join sakila.film_category fc using(film_id)
join sakila.category c using(category_id)
join sakila.payment p using(rental_id)
group by c.name
order by gross_revenue desc
limit 5;

select title, 
	case
	when count(*) > 0 then 'Yes' 
         else 'No' 
       end as  'available'
from sakila.film 
join sakila.inventory i using(film_id) 
join sakila.rental using(inventory_id) 
where title = 'Academy Dinosaur' and store_id = '1' and return_date is not null
group by title;