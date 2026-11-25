select CASE WHEN (order_delivered_customer_date>order_estimated_delivery_date) then 'Late'  ELSE 'On Time' end as  delivery_status ,
count(distinct o.order_id) as total_orders , round(avg(r.review_score),2) as avg_review_score
from orders o
join order_reviews r on o.order_id = r.order_id
where o.order_status = 'delivered'
and o.order_purchase_timestamp >='2017-01'
and o.order_delivered_customer_date is not null 
group by delivery_status

