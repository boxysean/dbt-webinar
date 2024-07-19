{{ config(schema='rdv',
           materialized='incremental',
           unique_key=['HK_ORDER_H', 'ldts']) }} 

{%- set yaml_metadata -%}
source_model: "stg_orders" 
parent_hashkey: "HK_ORDER_H"
src_hashdiff: 'hd_ORDERS_N_S'
src_payload: 
  - o_clerk
  - o_comment
  - o_orderdate
  - o_orderpriority
  - o_orderstatus
  - o_shippriority
  - o_totalprice

{%- endset -%}    

{%- set metadata_dict = fromyaml(yaml_metadata) -%}

{{ datavault4dbt.sat_v0(parent_hashkey=metadata_dict.get('parent_hashkey'),
                        src_hashdiff=metadata_dict.get('src_hashdiff'),
                        source_model=metadata_dict.get('source_model'),
                        src_payload=metadata_dict.get('src_payload')) }}