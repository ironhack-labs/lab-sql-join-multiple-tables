-- 1) Writing a query to display for each store its store ID, city, and country
select _store_.store_id, _city_.city, _country_.country
from sakila.store _store_
inner join sakila.address _address_ on _store_.address_id = _address_.address_id
inner join sakila.city _city_ on _address_.city_id = _city_.city_id
inner join sakila.country _country_ on _city_.country_id = _country_.country_id;

-- 2) Writing a query to display how much business, in dollars, each store brought in
select _store_.store_id, sum(_payment_.amount) as business_amount
from sakila.payment _payment_
left join sakila.staff _staff_ on _payment_.staff_id = _staff_.staff_id
left join sakila.store _store_ on _staff_.store_id = _store_.store_id
group by _store_.store_id;

-- 3) What is the average running time of films by category?
select _category_.name as category, round(avg(_film_.length), 2) as average_length
from sakila.film _film_
left join sakila.film_category _film_category_ on _film_.film_id = _film_category_.film_id
left join sakila.category _category_ on _film_category_.category_id = _category_.category_id
group by _category_.name;

-- 4) Which film categories are longest? Showing top 3
select _category_.name as category, round(avg(_film_.length), 2) as average_length
from sakila.film _film_
left join sakila.film_category _film_category_ on _film_.film_id = _film_category_.film_id
left join sakila.category _category_ on _film_category_.category_id = _category_.category_id
group by _category_.name
order by avg(_film_.length) desc
limit 3;

-- 5) Displaying the most frequently rented movies in descending order
select _film_.title, count(*) as number_of_rentals
from sakila.rental _rental_
left join sakila.inventory _inventory_ on _rental_.inventory_id = _inventory_.inventory_id
left join sakila.film _film_ on _inventory_.film_id = _film_.film_id
group by _film_.title
order by count(*) desc;

-- 6) Listing the top five genres in gross revenue in descending order
select _category_.name, sum(_payment_.amount) as gross_revenue
from sakila.payment _payment_
left join sakila.rental _rental_ on _payment_.rental_id = _rental_.rental_id
left join sakila.inventory _inventory_ on _rental_.inventory_id = _inventory_.inventory_id
left join sakila.film_category _film_category_ on _inventory_.film_id = _film_category_.film_id
left join sakila.category _category_ on _film_category_.category_id = _category_.category_id
group by _category_.name
order by sum(_payment_.amount) desc;

-- 7) Is "Academy Dinosaur" available for rent from Store 1?
select *
from sakila.inventory _inventory_
left join sakila.film _film_ on _inventory_.film_id = _film_.film_id
where (_film_.title = "ACADEMY DINOSAUR") and (_inventory_.store_id = 1);
-- Answer: Yes!