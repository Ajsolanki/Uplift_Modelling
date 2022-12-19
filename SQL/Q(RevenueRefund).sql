select sum(grand_total) as total_refund from (select ord.order_id, datediff(dd,order_estimated_delivery_date, order_customer_delivery_date) as diff, YEAR(order_purchase_date)as Y, trans.grand_total from marketing_orders ord 
inner join marketing_transaction trans on ord.order_id = trans.order_id 
where trans.payment_method='COD') A
where A.diff>0 and A.Y=2017

