{{ config(materialized='view') }}
{{ config(schema='stg') }}

{%- set yaml_metadata -%}
source_model: 
  'TPCH': 'Part'
hashed_columns:
  HK_PART_H:
    - P_PARTKEY
  hd_PART_N_S:
    is_hashdiff: true
    columns:
      - P_BRAND
      - P_COMMENT
      - P_CONTAINER
      - P_MFGR
      - P_NAME
      - P_RETAILPRICE
      - P_SIZE



rsrc: '!Part' 
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