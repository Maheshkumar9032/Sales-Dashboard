--02.Which products are frequently purchased together?

with order_freq as
(SELECT
    oi1.product_id AS product_1,
    oi2.product_id AS product_2,
    COUNT(*) AS frequecncy
FROM order_items oi1
JOIN order_items oi2
    ON oi1.order_id = oi2.order_id
    AND oi1.product_id < oi2.product_id
GROUP BY
    oi1.product_id,
    oi2.product_id   
)

SELECT
    p1.product_category_name AS product_1_category,
    p2.product_category_name AS product_2_category,
    COUNT(*) AS frequency
From order_freq 
join products p1 ON
p1.product_id = order_freq.product_1

join products p2 ON
p2.product_id = order_freq.product_2

WHERE
    p1.product_category_name <> p2.product_category_name
group BY
    p1.product_category_name,
    p2.product_category_name 
ORDER BY
    frequency
     DESC
limit 10    