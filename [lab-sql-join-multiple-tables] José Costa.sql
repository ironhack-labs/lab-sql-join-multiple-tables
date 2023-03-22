# 1. Write a query to display for each store its store ID, city, and country.
use sakila;

select s.store_id as store, c.city as city, co.country as country from store s
join address a using(address_id)
join city c using(city_id)
join country co using(country_id);

# 2. Write a query to display how much business, in dollars, each store brought in.
select s.store_id as store, sum(p.amount) as money from store s
join customer c using(store_id)
join payment p using(customer_id) group by store_id;

# 3. What is the average running time of films by category?
select ca.name as categ, avg(f.length) as avg_length from film f
join film_category c using(film_id)
join category ca using (category_id) group by ca.name order by ca.name;

#4. Which film categories are longest?
select ca.name as categ, avg(f.length) as avg_length from film f
join film_category c using(film_id)
join category ca using (category_id) group by ca.name order by avg_length desc limit 5;

#5. Display the most frequently rented movies in descending order.
select title, rental_rate from film order by rental_rate desc;

select f.title as movie, count(r.rental_id) as rentals from film f
join inventory i using(film_id)
join rental r using(inventory_id)
group by movie order by rentals desc;

#6. List the top five genres in gross revenue in descending order.
select ca.name as categ, sum(p.amount) as revenue from category ca
join film_category c using(category_id)
join inventory i using(film_id) 
join rental r using(inventory_id)
join payment p using(rental_id)
group by ca.name order by revenue desc;

#7. Is "Academy Dinosaur" available for rent from Store 1?
select f.title as movie, i.store_id as store, r.inventory_id as inventory_id, 
       case 
         when r.return_date is null then 'No' 
         else 'Yes' 
       end as available 
       from film f
join inventory i using(film_id) 
join rental r using (inventory_id)
where (f.title="Academy Dinosaur") and (i.store_id=1)
group by inventory_id;

