-- monthly revenue with average price per order value
SELECT substring (order_purchase_timestamp, 1, 7) as order_month, COUNT(DISTINCT orders.order_id) as total_orders ,round(sum (price),2 ) as revenue,
round(sum (price) /COUNT(DISTINCT orders.order_id) ,2 )as avg_order_value
FROM orders
join order_items on orders.order_id =  order_items.order_id
where order_status = 'delivered' and order_purchase_timestamp >= '2017-01'
GROUP BY  order_month
order by order_month

