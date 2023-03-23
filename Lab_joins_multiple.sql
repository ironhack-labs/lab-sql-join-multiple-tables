#Lab | SQL Joins on multiple tables

#1 - Write a query to display for each store its store ID, city, and country.

select s.store_id,c.city,o.country
from sakila.store s
join address a on s.address_id = a.address_id
join city c on c.city_id = a.city_id
join country o on o.country_id = c.country_id
;

# 2 - Write a query to display how much business, in dollars, each store brought in.
select s.store_id,sum(p.amount) as Amount
from sakila.store s
join customer c on s.store_id = c.store_id
join payment p on p.customer_id = c.customer_id
group by 1
;

# 3 - What is the average running time of films by category?
select name,avg(length) as avg_running_time
from sakila.film f
join film_category c on f.film_id = c.film_id
join category ca on ca.category_id = c.category_id
group by 1
;

# 4 - Which film categories are longest?
select ca.name,avg(f.length) as longest
from sakila.film f
left join film_category c on f.film_id = c.film_id
left join category ca on ca.category_id = c.category_id
group by 1
order by 2 desc
limit 3
;

# 5 - Display the most frequently rented movies in descending order.
select f.title, count(r.rental_id) as rentals
from sakila.film f
join inventory a on f.film_id = a.film_id
join rental r on r.inventory_id = a.inventory_id 
group by 1
order by rentals desc
;

#6 - List the top five genres in gross revenue in descending order.

select c.name,count(p.amount) as Gross_revenue 
from sakila.inventory i
join rental r on i.inventory_id = r.inventory_id
join payment p on p.customer_id = r.customer_id
join film_category ca on ca.film_id = i.film_id
join category c on c.category_id = ca.category_id
group by c.name
order by Gross_revenue desc
limit 5
;

# 7 - Is "Academy Dinosaur" available for rent from Store 1?
select f.film_id,f.title,s.address_id,r.rental_date,r.return_date,
case when r.rental_date <= r.return_date 
	then 'Available' 
    else 'Not available' 
    end as Rent_Status
from sakila.inventory i
join rental r on i.inventory_id = r.inventory_id
join store s on s.store_id = i.store_id
join film f on f.film_id = i.film_id
where f.title = 'Academy Dinosaur' and s.address_id = 1
group by f.film_id
order by r.return_date desc
;
