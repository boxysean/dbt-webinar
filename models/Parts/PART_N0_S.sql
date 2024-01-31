{{ config(schema='rdv',
           materialized='incremental',
           unique_key=['HK_PART_H', 'ldts']) }} 

{%- set yaml_metadata -%}
source_model: "stg_part" 
parent_hashkey: "HK_PART_H"
src_hashdiff: 'hd_PART_N_S'
src_payload: 
  - p_brand
  - p_comment
  - p_container
  - p_mfgr
  - p_name
  - p_retailprice
  - p_size

{%- endset -%}    

{%- set metadata_dict = fromyaml(yaml_metadata) -%}

{{ datavault4dbt.sat_v0(parent_hashkey=metadata_dict.get('parent_hashkey'),
                        src_hashdiff=metadata_dict.get('src_hashdiff'),
                        source_model=metadata_dict.get('source_model'),
                        src_payload=metadata_dict.get('src_payload')) }}