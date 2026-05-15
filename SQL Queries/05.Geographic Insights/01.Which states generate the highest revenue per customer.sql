--Which states generate the highest revenue per customer? 

SELECT
    customers.customer_state as state,
    sum(order_items.price) as revenue,
    count(DISTINCT customer_unique_id) as total_cx,
    sum(order_items.price)* 1.0 / count(DISTINCT customer_unique_id) as avg_rev_per_cx
   
from order_items
join orders on
orders.order_id = order_items.order_id
join customers ON
customers.customer_id = orders.customer_id
GROUP BY
    state
HAVING count(DISTINCT customer_unique_id) > 100    
order BY
    avg_rev_per_cx desc,
    revenue desc
limit 10    