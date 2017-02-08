--Carolena Realmuto | Lab 3

--1.List the order number and total dollars of	all orders.
select ordNumber, totalUSD
from Orders;

--2.List the name and city of agents named Smith.
select name, city
from Agents
where name = 'Smith';

--3. List the id,	name, and price of products with quantity more than 200,100.
select pid, name, priceUSD, quantity
from Products
where quantity > 200100;

--4. names and cities of customers in Duluth
select name, city
from Customers
where city = 'Duluth';

--5. names of agents not in NY and not in Duluth
select name
from Agents
where city not in ('New York', 'Duluth');

--6.List all data for products	in neither Dallas nor Duluth that cost	US$1 or more.
select *
from Products
where city not in ('Dallas', 'Duluth') and priceUSD >= 1;

--7.List all data for orders in February or May.
select *
from Orders
where month = 'Feb' or month = 'May';

--8.List all data for orders in February of	US$600	or more.
select *
from Orders
where month = 'Feb' and totalUSD >= 600;

--9.List all orders from the customer whose cid is C005.
select *
from Orders
where cid = 'c005';