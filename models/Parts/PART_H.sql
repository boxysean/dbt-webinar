{{ config(schema='rdv',
    materialized='incremental') }}

{%- set yaml_metadata -%}
source_models: 
  - name: stg_part
    bk_columns: 'P_PARTKEY'
    hk_column: HK_PART_H
    rsrc_static: 'HK_PART_H'
hashkey: HK_PART_H
business_keys: 
  - 'P_PARTKEY'
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ datavault4dbt.hub(hashkey=metadata_dict.get("hashkey"),
        business_keys=metadata_dict.get("business_keys"),
        source_models=metadata_dict.get("source_models")) }}
