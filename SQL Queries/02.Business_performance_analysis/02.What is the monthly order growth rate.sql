--Question 02 
--What is the monthly order growth rate?

WITH monthly_orders AS(
SELECT
    extract (year from orders.order_purchase_timestamp )as year,
    extract (month from orders.order_purchase_timestamp )as month,
    count(order_id) as total_orders
    
    from orders
    group by year, month)


select
    month,
    year, 
    total_orders,
    lag(total_orders)  over (order by year,month) as previous_month,

    round(
        ((total_orders -  lag(total_orders)  over (order by year,month))::numeric/
     lag(total_orders)  over (order by year,month))  * 100, 2) as growth_rate
from 
    monthly_orders