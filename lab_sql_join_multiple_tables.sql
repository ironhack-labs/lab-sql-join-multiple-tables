-- Write a query to display for each store its store ID, city, and country.

select * from sakila.store ;

select * from sakila.address;

select * from sakila.city;

select * from sakila.country;

-- step 1
-- joining the table store and address to see output
select * 
from sakila.store s
left join sakila.address a
on s.address_id = a.address_id;

-- step 2
-- adding the second table City to have the city code, and country to have the coutry

select * 
from sakila.store s
left join sakila.address a
on s.address_id = a.address_id
left join sakila.city c
on c.city_id = a.city_id
left join sakila.country cou
on c.country_id = cou.country_id
;

-- selecting only the relevant column to display store ID, city, and country.

select a.address, a.district, s.store_id, c.city,cou.country 
from sakila.store s
left join sakila.address a
on s.address_id = a.address_id
left join sakila.city c
on c.city_id = a.city_id
left join sakila.country cou
on c.country_id = cou.country_id
;

-- RESULT
-- 47 MySakila Drive	Alberta	1	Lethbridge	Canada
-- 28 MySQL Boulevard	QLD	2	Woodridge	Australia


-- Write a query to display how much business, in dollars, each store brought in.

select * from sakila.payment ;


select * from sakila.customer;

-- Used join, sum on amount , and then group by store id

select c.store_id, sum(p.amount)
from sakila.payment p
left join sakila.customer c
on p.customer_id = c.customer_id
group by c.store_id
;

-- What is the average running time of films by category?

select * from sakila.film ;
select * from sakila.category;
select * from sakila.film_category;

select c.category_id, c.name, avg(fi.length) as Average_length
from sakila.film fi
left join sakila.film_category f
on fi.film_id = f.film_id
inner join sakila.category c 
on c.category_id =f.category_id
group by c.category_id
;

-- result 
/*
1	Action	111.6094
2	Animation	111.0152
3	Children	109.8000
4	Classics	111.6667
5	Comedy	115.8276
6	Documentary	108.7500
7	Drama	120.8387
8	Family	114.7826
9	Foreign	121.6986
10	Games	127.8361
11	Horror	112.4821
12	Music	113.6471
*/
-- Which film categories are longest?
-- same function adding order by to get the max average length forall category 


select c.category_id, c.name, avg(fi.length) as Average_length
from sakila.film fi
left join sakila.film_category f
on fi.film_id = f.film_id
inner join sakila.category c 
on c.category_id =f.category_id
group by c.category_id 
order by Average_length desc
;
-- Result 
-- 15	Sports	128.2027


-- Display the most frequently rented movies in descending order.

select * from sakila.rental;
select * from sakila.film;
select * from sakila.inventory;

select i.film_id, count(i.film_id) as rental_count
from sakila.rental r
left join sakila.inventory i
on r.inventory_id = i.inventory_id
left join sakila.film f
on i.film_id = f.film_id
group by film_id
order by rental_count desc
;

-- Result 
/*
103	34
738	33
767	32
331	32
489	32
382	32
730	32
*/

-- List the top five genres in gross revenue in descending order.

select * from sakila.payment;
select * from sakila.category;
select * from sakila.rental;
select * from sakila.film_category;
select * from inventory;

select * 
from sakila.film_category fc
left join sakila.category c
on c.category_id = fc.category_id;

-- Final steps

select c.category_id,c.name, sum(p.amount) as total_amount
from sakila.film_category fc
left join sakila.category c
on c.category_id = fc.category_id
left join sakila.inventory i
on i.film_id = fc.film_id
left join sakila.rental r
on i.inventory_id = r.inventory_id
left join sakila.payment p
on r.rental_id = p.rental_id
group by c.category_id
order by total_amount desc
;

-- Result 
-- 1	Action	4375.85
-- 13	New	4351.62
-- 10	Games	4281.33
-- 9	Foreign	4270.67
-- 8	Family	4226.07

-- Is "Academy Dinosaur" available for rent from Store 1?
-- Yes it is 
-- result 
/*
- 1	ACADEMY DINOSAUR	1
1	ACADEMY DINOSAUR	2
2	ACE GOLDFINGER	2
3	ADAPTATION HOLES	2
4	AFFAIR PREJUDICE	1
4	AFFAIR PREJUDICE	2
*/

select * from inventory;
select * from film;

select f.film_id, f.title,i.store_id
from sakila.film f
left join sakila.inventory i
on f.film_id = i.film_id
group by f.film_id, i.store_id
;








