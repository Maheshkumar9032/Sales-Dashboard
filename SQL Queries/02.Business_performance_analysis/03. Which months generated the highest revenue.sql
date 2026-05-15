---Qurestion 03
---Which months generated the highest revenue?

SELECT
    extract(month from order_purchase_timestamp) as month,
    sum(order_items.price) as revenue
from orders
left JOIN order_items ON 
    order_items.order_id = orders.order_id
group BY
    MONTH
ORDER BY
    revenue DESC;        
