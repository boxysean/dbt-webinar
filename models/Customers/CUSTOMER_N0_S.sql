{{ config(schema='rdv',
           materialized='incremental',
           unique_key=['HK_CUSTOMER_H', 'ldts']) }} 

{%- set yaml_metadata -%}
source_model: "stg_customer" 
parent_hashkey: "HK_CUSTOMER_H"
src_hashdiff: 'hd_CUSTOMER_N_S'
src_payload: 
  - c_acctbal
  - c_mktsegment
  - c_comment

{%- endset -%}    

{%- set metadata_dict = fromyaml(yaml_metadata) -%}

{{ datavault4dbt.sat_v0(parent_hashkey=metadata_dict.get('parent_hashkey'),
                        src_hashdiff=metadata_dict.get('src_hashdiff'),
                        source_model=metadata_dict.get('source_model'),
                        src_payload=metadata_dict.get('src_payload')) }}