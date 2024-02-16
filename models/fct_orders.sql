select 
  hub.hk_order_h,
  link.hk_customer_h,
  o_orderdate as order_date,
  o_totalprice as total_price,
  o_orderstatus as order_status,
  o_orderpriority as order_priority
  
from {{ ref('ORDERS_H') }} as hub
left join {{ ref('ORDERS_N_S') }} as sat on hub.hk_order_h = sat.hk_order_h
left join {{ ref('ORDERS_CUSTOMERS_L')}} as link on link.hk_order_h = hub.hk_order_h

where ledts = (select max(ledts) from {{ ref('ORDERS_N_S') }})
