---Question 4
---What percentage of revenue comes from the top 10% of orders?  

WITH orders_revenues AS (
    SELECT
        order_id,
        SUM(order_items.price) AS rev
    FROM order_items
    GROUP BY order_id
),

ranked_orders AS (
    SELECT
        order_id,
        rev, 
        ntile(10) OVER (ORDER BY rev DESC) AS revenue_rank
    FROM orders_revenues
)

SELECT 
    CASE 
        WHEN revenue_rank = 1 THEN 'Top 10% Orders'
        ELSE 'Remaining 90% Orders'
    END AS order_segment,
    ROUND(SUM(rev) / SUM(SUM(rev)) OVER () * 100, 2) AS revenue_share
FROM ranked_orders
GROUP BY order_segment
ORDER BY revenue_share DESC