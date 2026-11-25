select c.customer_state, count(o.order_id) as total_orders, ROUND(SUM(CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
                 THEN 1 ELSE 0 END) * 100.0 / COUNT(o.order_id), 2) AS pct_late 
				from orders o
				join customers c on c.customer_id = o.customer_id
				where o.order_status = 'delivered'
and o.order_purchase_timestamp >='2017-01'
and o.order_delivered_customer_date is not null 
group by c.customer_state
order by pct_late desc 

