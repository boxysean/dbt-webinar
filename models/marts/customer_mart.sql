-- Try to answer the question: "Which customer is most valuable?"

select
  customer_hub.HK_CUSTOMER_H,
  customer_sat_p.C_NAME,
  customer_sat_n.C_MKTSEGMENT,
  min(O_ORDERDATE) as first_order_date,
  max(O_ORDERDATE) as latest_order_date,
  count(order_hub.hk_order_h) as number_of_orders,
  sum(O_TOTALPRICE) as customer_lifetime_value
from {{ ref('CUSTOMER_H') }} as customer_hub
left join {{ ref('CUSTOMER_N_S') }} as customer_sat_n on customer_hub.hk_customer_h = customer_sat_n.hk_customer_h
left join {{ ref('CUSTOMER_P_S') }} as customer_sat_p on customer_hub.hk_customer_h = customer_sat_p.hk_customer_h
left join {{ ref('ORDERS_CUSTOMERS_L') }} as orders_customers_link on customer_hub.hk_customer_h = orders_customers_link.hk_customer_h
left join {{ ref('ORDERS_H') }} as order_hub on order_hub.hk_order_h = orders_customers_link.hk_order_h
left join {{ ref('ORDERS_N_S' )}} as order_sat on order_hub.hk_order_h = order_sat.hk_order_h
group by 1, 2, 3
