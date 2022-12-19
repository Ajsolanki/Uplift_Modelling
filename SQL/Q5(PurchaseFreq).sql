--with T as (select ord.*, year(ord.order_purchase_date) as Y, month(ord.order_purchase_date) as M, day(ord.order_purchase_date) as D from marketing_orders ord
--where ord.customer_id IN(select customer_id from marketing_customer where name LIKE '%R. Kusuma Laksmiwati%'))

--select Y, count(order_id) as ord, count(order_id)/count(distinct M) from T
--group by Y
--order by Y, ord desc

select sum(A.diff)/count(A.diff) as avrg from 
		(select ord.*, isnull(datediff(DD, lag(order_purchase_date) over (order by order_purchase_date), order_purchase_date),0) as diff from marketing_orders ord	
				where ord.customer_id IN(select customer_id from marketing_customer where name LIKE '%R. Kusuma Laksmiwati%')) A

