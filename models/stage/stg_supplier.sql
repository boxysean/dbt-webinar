{{ config(materialized='view') }}
{{ config(schema='stg') }}

{%- set yaml_metadata -%}
source_model: 
  'TPCH': 'Supplier'
hashed_columns:
  HK_SUPPLIER_H:
    - S_SUPPKEY
  hd_SUPPLIER_N_S:
    is_hashdiff: true
    columns:
      - S_ACCTBAL
  hd_SUPPLIER_P_S:
    is_hashdiff: true
    columns:
      - S_ADDRESS
      - S_NAME



rsrc: '!Supplier' 
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