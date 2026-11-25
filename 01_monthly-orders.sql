

SELECT substring (order_purchase_timestamp, 1, 7) as order_month, COUNT(DISTINCT order_id) as total_orders  FROM orders
where order_status = 'delivered' and order_purchase_timestamp >= '2017-01'
GROUP BY  order_month
order by order_month