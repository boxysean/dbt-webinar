-- Why PITs? Fast: PITs have the whole history pre-populated, so queries are faster

select 
  c_custkey as customer_key,
  c_name as name,
  c_address as address,
  c_phone as phone,
  c_acctbal as account_balance,
  c_mktsegment as market_segment
from {{ ref('customer_bp') }} as pit
left join {{ ref('CUSTOMER_H') }} as hub on pit.hk_customer_h = hub.hk_customer_h
left join {{ ref('CUSTOMER_N_S') }} as n_sat on pit.hk_customer_n_s = n_sat.hk_customer_h and pit.ldts_customer_n_s = n_sat.ldts
left join {{ ref('CUSTOMER_P_S') }} as p_sat on pit.hk_customer_p_s = p_sat.hk_customer_h and pit.ldts_customer_p_s = p_sat.ldts

where pit.sdts = (select max(sdts) from {{ ref('customer_bp') }})
