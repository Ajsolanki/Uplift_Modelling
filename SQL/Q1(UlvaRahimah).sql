-- select cus.customer_id, cus.name, ord.order_id, trans. from marketing_customer cus
-- inner join marketing_orders ord on cus.customer_id = ord.customer_id
-- left join marketing_transaction trans on ord.order_id = ord.order_id
-- where name like 'Ulva Rahimah'
select cus.customer_id, trans.price from marketing_customer cus
left join marketing_transaction trans on cus.customer_id = trans.customer_id
where cus.name like 'Ulva Rahimah' and trans.price>5000

