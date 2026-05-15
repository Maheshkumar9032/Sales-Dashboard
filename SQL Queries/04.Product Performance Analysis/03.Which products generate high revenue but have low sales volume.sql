--Which products generate high revenue but have low sales volume? 


select
    order_items.product_id as pd_id,
    products.product_category_name as name,
    sum(price) as revenue,
    count(*) as sales_count
from order_items
join products ON
products.product_id = order_items.product_id
GROUP BY
    pd_id,
    name
ORDER BY
    revenue DESC,
    sales_count ASC
limit 10        


