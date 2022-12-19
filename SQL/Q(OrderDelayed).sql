select count(order_id) as total_delayed_prod from (select ord.*, datediff(dd,order_estimated_delivery_date, order_customer_delivery_date) as diff from marketing_orders ord 
inner join marketing_transaction trans on ord.order_id = trans.order_id 
where trans.payment_method='COD') A
where A.diff>0
