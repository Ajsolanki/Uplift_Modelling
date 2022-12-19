-- Number of orders placed by Ulva Rahimah having price of the product greater than 5000/- ? 
select count(cus.customer_id) as total_orders from marketing_customer cus
left join marketing_transaction trans on cus.customer_id = trans.customer_id
where cus.name like '%Ulva Rahimah%' and trans.price>5000


-- Average Order Value of Puspa Kuswandari is ?
select avg(trans.grand_total) from marketing_transaction trans 
where trans.customer_id IN(select customer_id from marketing_customer where name LIKE '%Puspa Kuswandari%')

--Which table among the given dataset has the most ambiguous data when you consider the 6 dimensions of data quality? Reference: https://www.collibra.com/us/en/blog/the-6-dimensions-of-data-quality
select customer_id,  product_name, count(product_name) as ords from marketing_orders
group by customer_id, product_name
order by ords desc

-- Avg purchase frequency of R. Kusuma Laksmiwati?
	-- Alternate solution tried -- 
	--with T as (select ord.*, year(ord.order_purchase_date) as Y, month(ord.order_purchase_date) as M, day(ord.order_purchase_date) as D from marketing_orders ord
	--where ord.customer_id IN(select customer_id from marketing_customer where name LIKE '%R. Kusuma Laksmiwati%'))

	--select Y, count(order_id) as ord, count(order_id)/count(distinct M) from T
	--group by Y
	--order by Y, ord desc

select sum(A.diff)/count(A.diff) as avrg from 
		(select ord.*, isnull(datediff(DD, lag(order_purchase_date) over (order by order_purchase_date), order_purchase_date),0) as diff from marketing_orders ord	
				where ord.customer_id IN(select customer_id from marketing_customer where name LIKE '%R. Kusuma Laksmiwati%')) A

-- How much of the revenue (Grand_Total) came from Cash Delivery in the month of may 2020?
-- select sum(grand_total) as revenue from (select *, Year(trans_date) as Y, month(trans_date) as M from marketing_transaction) A
-- where Y=2020 and M=5 and payment_method='COD'

select sum(grand_total) from 
(select trans.*, Year(trans_date) as Y, month(trans_date) as M, ord.[status], ord.order_purchase_date, ord.order_estimated_delivery_date, ord.order_customer_delivery_date
from marketing_transaction trans
inner join marketing_orders ord on trans.order_id = ord.order_id
where trans.payment_method='COD' and ord.[status] IN('received','complete') ) A
where Y=2020 and M=5 

-- How many number of orders have been delayed having Cash on delivery as transaction type?
select count(order_id) as total_delayed_prod from (select ord.*, datediff(dd,order_estimated_delivery_date, order_customer_delivery_date) as diff from marketing_orders ord 
inner join marketing_transaction trans on ord.order_id = trans.order_id 
where trans.payment_method='COD') A
where A.diff>0
 

-- Assuming that all the revenue generated from delayed orders has to be refunded. How much amount of money has to be refunded back to customers by MyDepot in the year 2017?
select sum(grand_total) as total_refund 
from 
(select ord.order_id, datediff(dd,order_estimated_delivery_date, order_customer_delivery_date) as diff, YEAR(order_purchase_date)as Y, trans.grand_total from marketing_orders ord 
inner join marketing_transaction trans on ord.order_id = trans.order_id 
) A
where A.diff>0 and A.Y=2017


-- The number of products having a price of less than 2000/- have been bought by customers in July, August, and September of 2016? Try to solve this in the most optimal way possible i.e. use as many inbuilt functions as possible
select count(ord.order_id) as total_ord from marketing_orders ord
inner join marketing_transaction trans on ord.order_id = trans.order_id
where trans.price<2000 and  year(ord.order_purchase_date)=2016 and month(ord.order_purchase_date) IN(7,8,9)

-- Number of cancelled orders with transactional value more than 50000?
select count(ord.order_id) as canceled_order from marketing_orders ord
inner join marketing_transaction trans on ord.order_id = trans.order_id 
where trans.grand_total>50000 and ord.status='canceled'
