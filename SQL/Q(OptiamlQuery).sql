select count(ord.order_id) as total_ord from marketing_orders ord
inner join marketing_transaction trans on ord.order_id = trans.order_id
where trans.price<2000 and  year(ord.order_purchase_date)=2016 and month(ord.order_purchase_date) IN(7,8,9)