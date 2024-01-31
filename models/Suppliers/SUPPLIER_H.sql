{{ config(schema='rdv',
    materialized='incremental') }}

{%- set yaml_metadata -%}
source_models: 
  - name: stg_supplier
    bk_columns: 'S_SUPPKEY'
    hk_column: HK_SUPPLIER_H
    rsrc_static: 'HK_SUPPLIER_H'
hashkey: HK_SUPPLIER_H
business_keys: 
  - 'S_SUPPKEY'
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ datavault4dbt.hub(hashkey=metadata_dict.get("hashkey"),
        business_keys=metadata_dict.get("business_keys"),
        source_models=metadata_dict.get("source_models")) }}
