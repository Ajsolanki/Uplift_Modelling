select customer_id,  product_name, count(product_name) as ords from marketing_orders
group by customer_id, product_name
order by ords desc