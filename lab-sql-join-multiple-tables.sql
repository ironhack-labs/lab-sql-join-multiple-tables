select store_id, city, country 
from sakila.store sto inner join sakila.address ad on sto.address_id = ad.address_id
inner join sakila.city ci on ad.city_id = ci.city_id
inner join sakila.country cou on ci.country_id = cou.country_id
group by sto.store_id; 

select sto.store_id, sum(amount) as total_store_amount 
from sakila.store sto inner join sakila.staff sta on sto.store_id = sta.store_id
inner join sakila.payment pay on sta.staff_id = pay.staff_id
group by sto.store_id;  

select name, round(avg(length),2) as average_lenght 
from sakila.category cat inner join sakila.film_category fcat on cat.category_id = fcat.category_id
inner join sakila.film f on fcat.film_id = f.film_id
group by cat.name;  

select name, round(avg(length),2) as average_lenght 
from sakila.category cat inner join sakila.film_category fcat on cat.category_id = fcat.category_id
inner join sakila.film f on fcat.film_id = f.film_id
group by cat.name order by 2 desc; 

select title, count(rental_id) as nr_rentals 
from sakila.film f inner join sakila.inventory inv on f.film_id = inv.film_id
inner join sakila.rental rent on inv.inventory_id = rent.inventory_id
group by title order by 2 desc; 

select name, sum(amount) as total_amount 
from sakila.category cat inner join sakila.film_category fcat on cat.category_id = fcat.category_id
inner join sakila.film f on fcat.film_id = f.film_id
inner join sakila.inventory inv on f.film_id = inv.film_id
inner join sakila.rental rent on inv.inventory_id = rent.inventory_id
inner join sakila.payment pay on rent.rental_id = pay.rental_id
group by cat.name order by 2 desc limit 5;

select title, sto.store_id 
from sakila.film f inner join sakila.inventory inv on f.film_id = inv.film_id
inner join sakila.store sto on inv.store_id = sto.store_id
where title = "ACADEMY DINOSAUR"
group by title, sto.store_id; 