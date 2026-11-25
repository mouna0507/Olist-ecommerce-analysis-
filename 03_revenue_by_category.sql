select  pn.product_category_name_english, count(DISTINCT o.order_id) as total_orders ,round(sum(oi.price),2) as total_revenue,
 round(sum (oi.price) /COUNT(DISTINCT o.order_id) ,2 )as avg_order_value
from orders o
join order_items oi on o.order_id = oi.order_id
join products p on p.product_id = oi.product_id
join product_name pn on pn.product_category_name = p.product_category_name
where o.order_status = 'delivered' and o.order_purchase_timestamp >= '2017-01'
group by pn.product_category_name_english
order by total_revenue desc 
limit  10