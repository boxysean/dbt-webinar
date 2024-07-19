{{ config(schema='rdv',
    materialized='incremental') }}

{%- set yaml_metadata -%}
source_models: 
  - name: stg_orders
    bk_columns: 'O_ORDERKEY'
    hk_column: HK_ORDER_H
    rsrc_static: 'HK_ORDER_H'
hashkey: HK_ORDER_H
business_keys: 
  - 'O_ORDERKEY'
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ datavault4dbt.hub(hashkey=metadata_dict.get("hashkey"),
        business_keys=metadata_dict.get("business_keys"),
        source_models=metadata_dict.get("source_models")) }}
