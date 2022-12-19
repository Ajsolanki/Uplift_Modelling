--select avg(trans.grand_total)   from marketing_orders ord
--inner join marketing_transaction trans on ord.order_id = trans.order_id
--where ord.customer_id IN(select customer_id from marketing_customer where name = 'Puspa Kuswandari')

select avg(trans.grand_total) from marketing_transaction trans 
where trans.customer_id IN(select customer_id from marketing_customer where name LIKE 'Puspa Kuswandari')