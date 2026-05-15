--Who are the top 10 customers by revenue? 

SELECT
    customer_unique_id,
    sum(order_items.price) as revenue
from customers
INNER JOIN orders
on orders.customer_id = customers.customer_id
INNER JOIN order_items
on order_items.order_id = orders.order_id
GROUP BY
    customer_unique_id
ORDER BY
    revenue DESC
limit 10      

 