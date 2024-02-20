{{
    config(
        materialized='table'
    )
}}

select
  orders_hub.O_ORDERKEY as order_key,
  count(nl.L_QUANTITY) as part_count,
  sum(nl.L_DISCOUNT) as total_discount,
  sum(nl.L_TAX) as total_tax,
  sum(nl.L_EXTENDEDPRICE) as price
from {{ ref('LINEITEM_NL') }} as nl
left join {{ ref('ORDERS_H') }} as orders_hub on nl.HK_ORDER_H = orders_hub.hk_order_h
left join {{ ref('ORDERS_N_S') }} as orders_sat on orders_hub.HK_ORDER_H = orders_sat.HK_ORDER_H
group by 1
