{{ config(materialized='view') }}
{{ config(schema='stg') }}

{%- set yaml_metadata -%}
source_model: 
  'TPCH': 'Customer'
hashed_columns:
  HK_CUSTOMER_H:
    - C_CUSTKEY
  hd_CUSTOMER_N_S:
    is_hashdiff: true
    columns:
      - C_ACCTBAL
      - C_MKTSEGMENT
      - C_COMMENT
  hd_CUSTOMER_P_S:
    is_hashdiff: true
    columns:
      - C_NAME
      - C_ADDRESS
      - C_PHONE



rsrc: '!Customer' 
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