--01.Which product categories generate the most revenue?
SELECT
    product_category_name,
    sum(order_items.price) as price
from products
join order_items ON
order_items.product_id = products.product_id
group BY
    product_category_name
ORDER BY
    price DESC
limit 10    

