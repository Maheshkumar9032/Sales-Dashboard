--- What is the average number of items per order?

WITH items_count AS (
    SELECT
        order_id,
        COUNT(product_id) AS item_count,
        SUM(price) AS order_value
    FROM order_items
    GROUP BY order_id
)

SELECT
    AVG(item_count) AS avg_items_per_order,
    AVG(order_value) AS avg_order_value
FROM items_count;

----or

with items_count as (
SELECT
    order_id,
    price,
    count(product_id) as items
from order_items
GROUP BY
    order_id
)

SELECT
    sum(items) * 1.0/
    count(order_id) as avg_items_per_order_count,
    price
from items_count

--or 

SELECT
    count(*) * 1.0 / count(distinct order_id) as avg_items_per_order_count
from
    order_items    

        