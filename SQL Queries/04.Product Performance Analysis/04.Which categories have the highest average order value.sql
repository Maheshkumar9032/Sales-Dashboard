--Which categories have the highest average order value?
with cat_ord_value as(
select
    order_items.product_id as pd_id,
    products.product_category_name as name,
    sum(price) as order_revenue
from order_items
join products ON
order_items.product_id = products.product_id
GROUP BY
    pd_id,
    name
)

SELECT
    name,
    avg(order_revenue) as avg_cat_ord_val
from cat_ord_value
GROUP BY
    name 
ORDER BY
    avg_cat_ord_val DESC
limit 10           
