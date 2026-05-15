-- 01 Understanding Tables

SELECT *
FROM customers
Limit 10;


SELECT *
FROM orders
LIMIT 10;


SELECT *
FROM order_items
LIMIT 10;


SELECT *
FROM products
LIMIT 10;

------------------------------------------------------------------------------------------------
-- 02 Checking Data Size


SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM order_items;
SELECT COUNT(*) FROM products;


-------------------------------------------------------------------------------------------

-- 03 Check Relationships

Select 
    customers.customer_id,
    orders.order_id
from customers
inner join orders on 
orders.customer_id = customers.customer_id 
limit 10; 

SELECT *
FROM orders o
LEFT JOIN customers c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT *
FROM order_items oi
LEFT JOIN orders o
ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;


SELECT *
FROM order_items oi
LEFT JOIN products p
ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

---- 04 Check Data Quality

select *
from customers where customer_state is null

select *
from order_items where order_item_id is null

 select *
 from orders where order_purchase_timestamp is NULL

 select *
 from products where product_category_name is null

--- Checking Duplicates

 select 
    customer_id,
    count(*)
from customers
GROUP BY
    customer_id
having count(*)>1    


select
    order_id,
    count(*)
from orders
group BY
    order_id 
having count(*)>1

----------------------------------------------------------------------------------------
--- 05 Basic Metrics

select
    count(*) as Total_customers
from customers
 
select
    count(*) as total_orders
from orders

select
    count(*) as total_order_items
from order_items    

select
    count(*) as total_products
from products
