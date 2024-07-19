{{ config(materialized='view') }}
{{ config(schema='stg') }}

{%- set yaml_metadata -%}
source_model: 
  'TPCH': 'PartSupp'
hashed_columns:
  HK_PART_SUPPLIER_L:
    - PS_PARTKEY
    - PS_SUPPKEY
  HK_PART_H:
    - PS_PARTKEY
  HK_SUPPLIER_H:
    - PS_SUPPKEY
  hd_PART_SUPPLIER_N_S:
    is_hashdiff: true
    columns:
      - PS_AVAILQTY
      - PS_COMMENT
      - PS_SUPPLYCOST



rsrc: '!PartSupp' 
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