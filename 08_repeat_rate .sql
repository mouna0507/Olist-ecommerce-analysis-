SELECT
  SUM(CASE WHEN num_orders > 1 THEN 1 ELSE 0 END) AS repeat_customers,
  COUNT(*) AS total_customers,
  ROUND(SUM(CASE WHEN num_orders > 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS repeat_rate_pct
FROM (
  SELECT c.customer_unique_id,
         COUNT(o.order_id) AS num_orders
  FROM customers c
  JOIN orders o ON o.customer_id = c.customer_id
  WHERE o.order_status = 'delivered'
    AND o.order_purchase_timestamp >= '2017-01'
    AND o.order_delivered_customer_date IS NOT NULL
  GROUP BY c.customer_unique_id
) AS per_customer;