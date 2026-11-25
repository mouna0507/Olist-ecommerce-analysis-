SELECT c.customer_unique_id,
       COUNT(o.order_id) AS num_orders
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
  AND o.order_purchase_timestamp >= '2017-01'
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_unique_id
HAVING COUNT(o.order_id) > 1
ORDER BY num_orders DESC;