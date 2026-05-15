--Which cities generate the most orders but low revenue? 

SELECT
    customers.customer_city as city,
    count(order_items.order_id) as order_count,
    sum(order_items.price) as revenue
from customers
join orders ON
orders.customer_id = customers.customer_id
JOIN order_items ON
order_items.order_id = orders.order_id
GROUP BY
    city 
ORDER BY
    order_count Desc,
    revenue ASC  