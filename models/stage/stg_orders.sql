{{ config(materialized='view') }}
{{ config(schema='stg') }}

{%- set yaml_metadata -%}
source_model: 
  'TPCH': 'Orders'
hashed_columns:
  HK_ORDER_H:
    - O_ORDERKEY
  HK_ORDERS_CUSTOMERS_L:
    - O_ORDERKEY
    - O_CUSTKEY
  HK_CUSTOMER_H:
    - O_CUSTKEY
  HK_ORDER_H:
    - O_ORDERKEY
  hd_ORDERS_N_S:
    is_hashdiff: true
    columns:
      - O_CLERK
      - O_COMMENT
      - O_ORDERDATE
      - O_ORDERPRIORITY
      - O_ORDERSTATUS
      - O_SHIPPRIORITY
      - O_TOTALPRICE



rsrc: '!Orders' 
ldts: 'sysdate()'
include_source_columns: true

{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ datavault4dbt.stage(source_model=metadata_dict.get('source_model'),
                        ldts=metadata_dict.get('ldts'),
                        rsrc=metadata_dict.get('rsrc'),
                        hashed_columns=metadata_dict.get('hashed_columns'),
                        derived_columns=metadata_dict.get('derived_columns'),
                        prejoined_columns=metadata_dict.get('prejoined_columns'),
                        missing_columns=metadata_dict.get('missing_columns')) }}