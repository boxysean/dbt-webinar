SELECT
  orders_hub.O_ORDERKEY,
  COUNT(nl.L_QUANTITY) as part_count,
  SUM(nl.L_DISCOUNT) as total_discount,
  SUM(nl.L_TAX) as total_tax,
  sum(nl.L_EXTENDEDPRICE) as price
FROM {{ ref('LINEITEM_NL') }} as nl
LEFT JOIN {{ ref('ORDERS_H') }} as orders_hub
  ON nl.hk_order_h = orders_hub.hk_order_h
LEFT JOIN {{ ref('ORDERS_N_S') }} as orders_sat
  ON orders_hub.HK_ORDER_H = orders_sat.HK_ORDER_H
group by 1
