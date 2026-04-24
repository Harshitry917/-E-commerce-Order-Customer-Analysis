-- E - Commerce order & customers analysis  (SQL) 

CREATE DATABASE project ;
USE project;
			-- CUSTOMERS TABLE
CREATE TABLE customers (
customers_id  INT , 
customers_name VARCHAR (100),
city VARCHAR (100) 
);
INSERT INTO customers VALUES
(1, 'Rahul', 'Delhi'),
(2, 'Amit', 'Mumbai'),
(3, 'Neha', 'Pune'),
(4, 'Priya', 'Bangalore'),
(5, 'Rohit', 'Hyderabad'),
(6, 'Sneha', 'Chennai'),
(7, 'Arjun', 'Kolkata'),
(8, 'Kavya', 'Jaipur'),
(9, 'Vikas', 'Ahmedabad'),
(10, 'Anjali', 'Lucknow');

-- ORDERS TABLE
CREATE TABLE orders ( 
order_id INT  PRIMARY KEY, 
customer_id INT , 
product_name VARCHAR (100) ,
category VARCHAR (100) ,
quantity INT , 
price INT , 
order_date DATE
); 
INSERT INTO orders VALUES
(101,1,'Laptop','Electronics',1,50000,'2024-01-10'),
(102,2,'Mobile','Electronics',2,20000,'2024-01-12'),
(103,3,'Shoes','Fashion',3,2000,'2024-01-15'),
(104,4,'Watch','Accessories',1,3000,'2024-01-18'),
(105,5,'Tablet','Electronics',1,25000,'2024-01-20'),
(106,6,'Headphones','Electronics',2,1500,'2024-02-01'),
(107,7,'T-shirt','Fashion',4,800,'2024-02-05'),
(108,8,'Bag','Accessories',2,1200,'2024-02-08'),
(109,9,'Shoes','Fashion',1,2500,'2024-02-10'),
(110,10,'Mobile','Electronics',1,18000,'2024-02-12'),
(111,1,'Laptop','Electronics',1,52000,'2024-02-15'),
(112,2,'Watch','Accessories',2,3500,'2024-02-18'),
(113,3,'Bag','Accessories',1,1000,'2024-02-20'),
(114,4,'Shoes','Fashion',2,2200,'2024-02-25'),
(115,5,'Mobile','Electronics',1,21000,'2024-02-28'),
(116,6,'Laptop','Electronics',1,48000,'2024-03-02'),
(117,7,'Shoes','Fashion',2,2300,'2024-03-05'),
(118,8,'Watch','Accessories',1,4000,'2024-03-08'),
(119,9,'Tablet','Electronics',1,27000,'2024-03-10'),
(120,10,'T-shirt','Fashion',3,900,'2024-03-12'),
(121,1,'Mobile','Electronics',2,19000,'2024-03-15'),
(122,2,'Shoes','Fashion',1,2400,'2024-03-18'),
(123,3,'Laptop','Electronics',1,53000,'2024-03-20'),
(124,4,'Bag','Accessories',2,1100,'2024-03-22'),
(125,5,'Watch','Accessories',1,3200,'2024-03-25'),
(126,6,'Tablet','Electronics',1,26000,'2024-04-01'),
(127,7,'Mobile','Electronics',1,17000,'2024-04-03'),
(128,8,'Shoes','Fashion',2,2100,'2024-04-05'),
(129,9,'Bag','Accessories',3,1300,'2024-04-08'),
(130,10,'Laptop','Electronics',1,55000,'2024-04-10'),
(131,1,'Watch','Accessories',1,3000,'2024-04-12'),
(132,2,'T-shirt','Fashion',2,700,'2024-04-15'),
(133,3,'Mobile','Electronics',1,20000,'2024-04-18'),
(134,4,'Laptop','Electronics',1,54000,'2024-04-20'),
(135,5,'Shoes','Fashion',2,2200,'2024-04-22'),
(136,6,'Bag','Accessories',2,1200,'2024-05-01'),
(137,7,'Watch','Accessories',1,3500,'2024-05-03'),
(138,8,'Tablet','Electronics',1,28000,'2024-05-05'),
(139,9,'Mobile','Electronics',2,19500,'2024-05-08'),
(140,10,'Shoes','Fashion',1,2300,'2024-05-10'),
(141,1,'Laptop','Electronics',1,56000,'2024-05-12'),
(142,2,'Bag','Accessories',1,1400,'2024-05-15'),
(143,3,'Shoes','Fashion',2,2400,'2024-05-18'),
(144,4,'Mobile','Electronics',1,22000,'2024-05-20'),
(145,5,'Watch','Accessories',2,3300,'2024-05-22'),
(146,6,'T-shirt','Fashion',3,850,'2024-06-01'),
(147,7,'Laptop','Electronics',1,57000,'2024-06-03'),
(148,8,'Mobile','Electronics',1,21000,'2024-06-05'),
(149,9,'Shoes','Fashion',2,2600,'2024-06-08'),
(150,10,'Tablet','Electronics',1,30000,'2024-06-10');

-- 1.	TOTAL REVENUE 
SELECT SUM(quantity * price )AS 
total_revenue 
FROM orders; 

-- 2.	 TOTAL ORDERS COUNT 
SELECT COUNT(*)AS total_orders 
FROM orders ; 

-- 3.	 PRODUCT WISE REVENUE 
select
orders.product_name, sum(orders.quantity * orders.price)as total_revenue 
from orders
group by product_name 
order by total_revenue desc;

-- 4. 	 CATEGORY WISE REVENUE 
select category from orders ;
select orders.category , 
sum(orders.quantity * orders.price) as total_revenue 
from orders 
group by category
order by total_revenue;

-- 5. 	CUSTOMERS WISE REVENUE JOIN
SELECT c.customers_name, 
SUM(o.quantity * o.price) AS revenue 
FROM orders o
JOIN customers c 
ON o.customer_id = c.customer_id 
GROUP BY c.customers_name
ORDER  BY revenue DESC ;

-- 6 	 CUSTOMERS WISE PRODUCT AND QUANTITY 
select 
customers.customers_name, 
orders.product_name ,
sum(orders.quantity) as total_orders 
from customers 
inner join orders on customers.customer_id = orders.customer_id 
group by  customers.customers_name , orders.product_name; 

-- 7 	 MONTH WISE REVENUE 
select order_date from orders ;
select 
month(order_date) as month,
sum(price*quantity) as revenue  
from orders
group by month 
order by month ;

-- 8.	 month wise orders count 

select 
month (order_date) as month ,
count(order_id) as total_orders 
from orders 
group by month ;

-- 9 	month wise quantity sold 
select 
month (order_date) as month, 
sum(quantity) as total_sold 
from orders 
group by month ;

-- 10 . 	best month highest sales 
select  month ( order_date ) as month , 
sum(quantity * price) as totaL_revenue 
from orders 
group by month 
order by totaL_revenue  desc 
limit 1 ; 

-- 11 . 	month wise category revenue 
select category,  month ( order_date) as month , 
sum(quantity * price)as revenue 
from orders 
group by month, category 
order by month ;

-- 12 . TOP 5 PRODUCT 
select product_name ,
sum(quantity * price) as revenue 
from orders 
group by product_name 
order by revenue desc 
limit 5 ;
 
-- TOP 5 CUSTOMERS 
select   customer_id , 
sum(quantity * price ) as revenu 
from orders 
group by customer_id 
order by revenu desc 
limit 5 ; 

-- TOP 5 CUSTOMERS USING JOINS 
select 
customers.customers_name,
sum(orders.quantity * orders.price)as revenue
from customers 
join orders on customers.customer_id = orders.customer_id 
group by customers.customers_name 
order by revenue desc 
limit 5;
