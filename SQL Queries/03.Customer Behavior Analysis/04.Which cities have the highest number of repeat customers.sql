--04. Which cities have the highest number of repeat customers?

with customer_orders as
(SELECT
    customer_unique_id,
    customer_city
from customers    
join orders ON
orders.customer_id = customers.customer_id
group By
    customer_unique_id,
    customer_city
having count(orders.order_id) > 1   
    )

select
    customer_city,
    count(*) as repeat_cx_count
from
    customer_orders
group by
    customer_city
order by 
    repeat_cx_count DESC
limit 10    

----------------------------------------------------------------------------------------

