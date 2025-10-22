-- *************************************************************
-- Safe updates (same header as class scripts)
-- *************************************************************
set SQL_SAFE_UPDATES=0;
set FOREIGN_KEY_CHECKS=0;

use `Assignment#3`;

-- Rename the tables. 
rename table `merchants (1)` to merchants;
rename table `products (1)` to products;
rename table `sell (1)` to sell;
rename table `orders (1)` to orders;
rename table `contain (2)` to contain;
rename table `place (1)` to place;
rename table `customers (1)` to customers;

-- ==========================
-- primary key constraints
-- ==========================

alter table merchants 
add primary key (mid);

alter table products
add primary key (pid);

alter table customers
add primary key (cid);

alter table orders
add primary key (oid);

alter table sell
add primary key (mid, pid);

alter table contain
add primary key (oid, pid);

alter table place
add primary key (cid, oid);

-- ==========================
-- foreign key constraints
-- ==========================

alter table sell
add foreign key (mid) references merchants(mid),
add foreign key (pid) references products(pid);

alter table contain
add foreign key (oid) references orders(oid),
add foreign key (pid) references products(pid);

alter table place
add foreign key (cid) references customers(cid),
add foreign key (oid) references orders(oid);

-- ***************************************************************
-- Query #1:
-- Product names and merchant names for items with zero inventory
select products.name, merchants.name
from sell
join products on sell.pid = products.pid
join merchants on sell.mid = merchants.mid
where sell.quantity_available = 0;

-- notes:
-- • sell.quantity_available = 0 means merchant has no stock left
-- • join sell -> products to get product name, join sell -> merchants to get seller

-- Check to make sure there are definitley no items out of stock.
select distinct quantity_available
from sell
order by quantity_available;
-- Lowest number is 1 by quantity available so there is no items that arent available. 

-- *********************************************************
-- Query #2:
-- Products which do not appear in the sell table
select products.name, products.description
from products
left join sell on products.pid = sell.pid
where sell.pid is null;

-- notes:
-- • left join + where sell.pid is null returns products with no matching sell row
-- • these are products that are not sold by any merchant in the sell table


-- ********************************************************************
-- Q3: Count customers who bought SATA drives but not routers.
-- Note: Find all customers who bought SATA drives, then exclude any who also bought a router. Count the remaining customers.

select count(distinct customers.cid)
from customers
join place on customers.cid = place.cid
join contain on place.oid = contain.oid
join products on contain.pid = products.pid
where products.name = 'Hard Drive'
and customers.cid not in (
    select distinct customers.cid
    from customers
    join place on customers.cid = place.cid
    join contain on place.oid = contain.oid
    join products on contain.pid = products.pid
    where products.name = 'Router'
);

-- Check the products to make sure 
select pid, name, category, description
from products;

-- *************************************************************
-- Q4: Apply 20% sale to all HP networking products
-- This query updates the price in the sell table by multiplying
-- the current price by 0.8 (20% discount), but only for rows
-- where the merchant is HP and the product category is Networking.
-- *************************************************************

update sell
join merchants on sell.mid = merchants.mid
join products on sell.pid = products.pid
set sell.price = sell.price * 0.8
where merchants.name = 'HP'
  and products.category = 'Networking';
  
-- note: 0 rows affected in this dataset because hp currently does not sell any products in the 'networking' category.

-- Q 5: products ordered by uriel whitney from acer
select products.name, sell.price
from customers
join place on customers.cid = place.cid
join orders on place.oid = orders.oid
join contain on orders.oid = contain.oid
join sell on contain.pid = sell.pid
join merchants on sell.mid = merchants.mid
join products on sell.pid = products.pid
where customers.fullname = 'Uriel Whitney'
  and merchants.name = 'Acer';

-- Start from customers to identify Uriel Whitney.
-- Join place → orders → contain → sell → merchants → products to get product info and prices.
-- Filter where the customer is 'Uriel Whitney' and merchant is 'Acer'.
-- Returns product names and their selling prices.

select sell.mid, year(place.order_date), sum(sell.price)
from sell, contain, orders, place
where sell.pid = contain.pid
  and contain.oid = orders.oid
  and orders.oid = place.oid
group by sell.mid, year(place.order_date)
order by sell.mid, year(place.order_date);

-- This query calculates total sales for each company per year. 
-- It adds up the price of all products sold by joining sell to contain to orders to place, then groups by company and year.

select sell.mid, year(place.order_date), sum(sell.price) as total_sales
from sell, contain, orders, place
where sell.pid = contain.pid
  and contain.oid = orders.oid
  and orders.oid = place.oid
group by sell.mid, year(place.order_date)
order by total_sales desc
limit 1;

-- This query calculates the total sales for each merchant per year. 
-- It joins the sell, contain, orders, and place tables to link products to their orders and order dates.
-- Then, it sums the sell.price for each merchant and year to get the total revenue. 
-- Finally, it orders the results by total sales and shows the merchant with the highest revenue using limit 1.

-- *******************************************************
-- Query #8
-- This query calculates the average cost of all shipping methods by using the avg() function on the shipping_cost column of the orders table. 
-- It gives an idea of which shipping methods are generally cheapest on average.
select avg(orders.shipping_cost) as avg_shipping_cost
from orders;

-- The ultimate average shiping cost is around $25.17. 


-- *******************************************************
-- Query #9:
-- This query shows the best sold ($) catgeory for each of the companies. 
select merchants.name, products.category, sum(sell.price * sell.quantity_available) as total_sales
from merchants
join sell on merchants.mid = sell.mid
join products on sell.pid = products.pid
group by merchants.name, products.category
order by merchants.name, total_sales desc;

-- For each company the best sold category ultimatley seems to be Peripheral products compared to Networking or Computer products. 

-- ***************************************
-- Query #10: 
-- This query find the customers who spent the most and least at each company. 
-- total spent per customer per merchant

select merchants.name as company,
       customers.fullname,
       sum(sell.price) as total_spent
from customers
join place on customers.cid = place.cid
join orders on place.oid = orders.oid
join contain on orders.oid = contain.oid
join sell on contain.pid = sell.pid
join merchants on sell.mid = merchants.mid
group by merchants.name, customers.fullname
order by merchants.name, total_spent desc;






