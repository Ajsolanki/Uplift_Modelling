-- select sum(grand_total) as revenue from (select *, Year(trans_date) as Y, month(trans_date) as M from marketing_transaction) A
-- where Y=2020 and M=5 and payment_method='COD'

select sum(grand_total) from 
(select trans.*, Year(trans_date) as Y, month(trans_date) as M, ord.[status], ord.order_purchase_date, ord.order_estimated_delivery_date, ord.order_customer_delivery_date
from marketing_transaction trans
inner join marketing_orders ord on trans.order_id = ord.order_id
where trans.payment_method='COD' and ord.[status] IN('received','complete') ) A
where Y=2020 and M=5 