--What are the peak hours or days for orders? 


SELECT
    to_char(orders.order_purchase_timestamp, 'Day') as day,
    extract(hour from orders.order_purchase_timestamp) as hour,
    count(orders.order_id) as order_count
from orders
GROUP BY
    day,
    hour 
ORDER BY
    order_count Desc        