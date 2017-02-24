--Lab 6: Interesting and painful queries:
--1. Display the name and city of customers who live in any city that makes the most different
--kinds of products.
select customers.name, customers.city
from customers
where customers.city in (select products.city
		from products
		group by products.city
		order by count(products.city) DESC
		LIMIT 1
		);
--2.Display the names of products whose priceUSD is strictly above the average priceUSD,
--in reverse-alphabetical order.
select products.name
from products
where products.priceUSD > (select avg(products.priceUSD)
			    from products
			    )
order by products.name ASC;
			 
--3.Display the customer name, pid ordered, and the total for all orders, sorted by total from 
--low to high.
select customers.name, orders.pid, orders.totalUSD
from customers, orders
where customers.cid = orders.cid
order by orders.totalUSD ASC;
--4.Display all customers names (alphabetical order) and their total ordered, and nothing more
--(use coalesce)
select customers.name,
	coalesce(sum(orders.totalUSD),0.0)
from orders RIGHT OUTER JOIN customers ON customers.cid = orders.cid
group by customers.name
order by customers.name ASC;
--5.Display the names of all customers who bought products from agents based in Newark along with
--the names of the products they ordered, and the names of agents
select customers.name as Cust_Name, 
       products.name as Prod_Name, 
       agents.name as Agent_Name
from orders inner join customers on orders.cid = customers.cid
	    inner join products on orders.pid = products.pid
	    inner join agents on orders.aid = agents.aid
where agents.city = 'Newark';
--6.Write a query to check the accuracy of the totalUSD column in the Orders table.
--this means calculating orders.totalUSD from data in other tables and comparing those values
--to the values in orders.totalUSD. diplay all rows in orders where Orders.totalUSD is incorrect
Select *
from ( select orders.*, orders.qty*products.priceUSD*(1-(customers.discount/100)) as ActualDollars
        from orders inner join products on orders.pid = products.pid
                    inner join customers on orders.cid = customers.cid) as CheckTable
where totalUSD != ActualDollars;

--7.what's the different between the LEFT OUTER JOIN and a RIGHT OUTER JOIN. Give example queries
--in SQL to demonstrate.
--The difference between the left outer join and a right outer join is what table is being outputted
--from the query. When you use a left outer join, the left table will be displayed plus any matches
--with the right table AND any unmatched left/right table values that will show up as NULL.
--An example is as follows:
select *
from products LEFT OUTER JOIN orders on orders.pid = products.pid;
--A right outer join is the opposite of a left outer join. All of the right table will be displayed including
--all matches with the left table AND any unmatched values that will show up as null.
--An example of this is:
select *
from products RIGHT OUTER JOIN orders on orders.pid = products.pid;
--One may think that these two tables are similar, (they are) however, what they are displaying is different.
--The left outer join takes all values in the products table and matches it with the orders table. Any values
--that do not have a match (bottom rows) are left null for the orders table.
--For the right outer join, it does the opposite of what I mentioned above. For this result, you see no null
--values because the orders table does not contain any orders that do not have products. This result is similar
--to an inner join for this particular example... (interesting..).