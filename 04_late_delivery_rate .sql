select  order_id, order_delivered_customer_date, order_estimated_delivery_date, 
julianday(order_delivered_customer_date) - julianday(order_estimated_delivery_date) as days_late,
CASE WHEN (order_delivered_customer_date>order_estimated_delivery_date) then 'Late'  ELSE 'On Time' end as  delivery_status 
from orders
where order_status = 'delivered'
limit 10 


SELECT
  SUM(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date
           THEN 1 ELSE 0 END) AS late_orders,
  COUNT(order_id) AS total_orders,
  ROUND(SUM(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date
                 THEN 1 ELSE 0 END) * 100.0 / COUNT(order_id), 2) AS pct_late
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_purchase_timestamp >= '2017-01';