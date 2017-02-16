--Lab 5: SQL Queries: The Joins
--1.Show the cities of agents booking an order for a customer whose id is 'c006':
select Agents.city, Agents.name
from Agents, Customers, Orders
where Agents.aid = Orders.aid 
  and Customers.cid = Orders.cid
  and Orders.cid = 'c006';

--2. Show the ids of products ordered through any agent who makes at least one order
--for a customer in Kyoto, sorted by pid from highest to lowest.
select Products.pid
from Products, Agents, Orders, Customers
where products.pid = orders.pid 
   and agents.aid = orders.aid
   and customers.cid = orders.cid
   and customers.city = 'Kyoto'
order by Products.pid DESC;
--3.Show the names of customers who have never placed an order (Subquery)
select distinct name
from Customers
where cid not in (select cid
		  from Orders);
--4.Show the names of customers who have never placed an order (Outer Join)
select distinct name
from customers full outer join orders on customers.cid = orders.cid
where orders.cid is null;
--5.Show the names of customers who placed at least one order through an agent in their
--own city, along with those agent(s') names
select distinct customers.name as "Customer", agents.name as "Agent"
from customers, agents, orders
where customers.city = agents.city 
   and orders.cid = customers.cid 
   and orders.aid = agents.aid;
--6. Show the names of customers and agents living in the same city, along with the name
--of the shared city, regardless of whether or not the customer has ever placed an order with that agent.
select distinct customers.name, customers.city, agents.city, agents.name
from customers, agents, orders
where customers.city = agents.city;
--7.Show the name and city of customers who live in THE city that makes the FEWEST different kind of products
--(use count and group by on the Products table)
select customers.name, customers.city, products.city
from customers, products
where customers.city = products.city
group by products.city, customers.name, customers.city
order by count(pid) ASC
Limit 2;