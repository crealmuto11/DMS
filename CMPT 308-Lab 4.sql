--lab four:Subqueries
--1.Get the cities of agents booking an order for a customer whose cid is 'coo6':
select distinct city
from agents
where aid in (select aid
		from orders
		where cid = 'c006');
--2. distinct pids of products ordered through any agent who takes at least one order from a customer in Kyoto;
--sorted by pid highest to lowest:

select distinct pid
from orders
where aid in ( select aid
		from orders
		where cid in ( select cid
				from customers
				where city = 'Kyoto'
				)
		)
order by pid DESC;
--3. Get the ids and names of customers who did not place an order through agent a01:
select cid, name
from customers
where cid not in (select distinct cid
		from orders
		where aid = 'a01');
--4. Get the ids of customers who ordered both product p01 and p07:
select distinct cid
from customers
where cid in ( select cid
		from orders
		where pid = 'p01')
and  cid in (select cid
		from orders
		where pid = 'p07');
--5.Get the ids of products not ordered by any customers who placed any order
--through agent a08 in pid order from highest to lowest.
select distinct pid
from orders
where cid not in (select cid
		  from orders
	          where aid = 'a08')
order by pid DESC;
--6.Get the name, discount, and city for all customers who place orders through agents
--in Tokyo or New York:
select name, discount, city
from customers
where cid in ( select cid
		from orders 
		where aid in (select aid
				from agents
				where city in ('Tokyo', 'New York')
				)
		);
--7.Get all customers who have the same discount as that of any customers in Duluth or london:
select *
from customers
where discount in (select discount
			from customers
			where city = 'Duluth' or city = 'London');
--8. Check constraints....
-- are limitations to values that can be inputted in a database. They are useful for enforcing domain integrity.
-- Advantages to constraints are: the check cannot be bypassed, they provide consistency, and they can refer
-- to single or multiple columns. An example of a good use of a check constraint is to ensure the user
--inputs a positive value for price to make sure it's not negative. A bad example of implementing one is for an interest
--rate. These values can be negative AND positive, so the user should have the liberty to type in the number that is being
--documented.

