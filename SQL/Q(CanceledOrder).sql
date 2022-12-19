select count(ord.order_id) as canceled_order from marketing_orders ord
inner join marketing_transaction trans on ord.order_id = trans.order_id 
where trans.grand_total>=50000 and ord.status='canceled'
