{{ config(materialized='view') }}
{{ config(schema='stg') }}

{%- set yaml_metadata -%}
source_model: 
  'TPCH': 'LineItem'
hashed_columns:
  HK_LINEITEM_NL:
    - L_PARTKEY
    - L_ORDERKEY
    - L_SUPPKEY
    - L_LINENUMBER
  HK_ORDER_H:
    - L_ORDERKEY
  HK_PART_H:
    - L_PARTKEY
  HK_SUPPLIER_H:
    - L_SUPPKEY



rsrc: '!LineItem' 
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