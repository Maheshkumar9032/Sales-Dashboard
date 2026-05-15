---Question_01
---What is the monthly revenue trend?
SELECT
    extract (year from orders.order_purchase_timestamp) as year,
    extract (month from orders.order_purchase_timestamp) as month,
    round(sum(order_items.price), 0) as Revenue
    from orders
    left join order_items ON 
    order_items.order_id = orders.order_id 
    group by year, month
    order by year, month


