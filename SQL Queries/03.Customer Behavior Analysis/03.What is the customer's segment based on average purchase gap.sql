
--03.What is the customer's segment based on average purchase gap?

with cx_orders as 
(SELECT
    customer_unique_id,
    orders.order_purchase_timestamp as current_order_time,
    lag(orders.order_purchase_timestamp) 
    over(partition by customers.customer_unique_id order by orders.order_purchase_timestamp)
    as previous_order_time
from
    customers
join orders ON
orders.customer_id = customers.customer_id
),

customer_avg as
(SELECT
    customer_unique_id,
    round(avg(extract(epoch from(current_order_time - previous_order_time))/86400),2)
     as avg_time_btw_orders
from  cx_orders
WHERE
    previous_order_time is not null 
GROUP BY
        customer_unique_id
),

cx_segment_tabel as 
(select *,
    case
        when avg_time_btw_orders <=7 then 'Frequent (7)'
        when avg_time_btw_orders <=30 then 'Regular (30)'
        when avg_time_btw_orders <=90 then 'Occalisonal (90)'
        else 'at risk'
    end as customer_segment
from customer_avg
)

select
    customer_segment,
    count(*) as segment_count
from cx_segment_tabel
group by
    customer_segment