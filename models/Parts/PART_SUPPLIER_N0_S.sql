{{ config(schema='rdv',
           materialized='incremental',
           unique_key=['HK_PART_SUPPLIER_L', 'ldts']) }} 

{%- set yaml_metadata -%}
source_model: "stg_partsupp" 
parent_hashkey: "HK_PART_SUPPLIER_L"
src_hashdiff: 'hd_PART_SUPPLIER_N_S'
src_payload: 
  - ps_availqty
  - ps_comment
  - ps_supplycost

{%- endset -%}    

{%- set metadata_dict = fromyaml(yaml_metadata) -%}

{{ datavault4dbt.sat_v0(parent_hashkey=metadata_dict.get('parent_hashkey'),
                        src_hashdiff=metadata_dict.get('src_hashdiff'),
                        source_model=metadata_dict.get('source_model'),
                        src_payload=metadata_dict.get('src_payload')) }}