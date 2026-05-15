-- Question 5
-- What percentage of customers are repeat customers?


with cx_orders as (
    SELECT
        c.customer_unique_id,
        count(o.order_id) as order_count
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)

SELECT
    round(
        count(case when order_count > 1 then 1 end) 
        / count(*)::numeric * 100, 
    2) || '%' as repeat_cx_percentage
FROM cx_orders

