{{ config(schema='rdv',
    materialized='incremental') }}

{%- set yaml_metadata -%}
source_models: 
  - name: stg_customer
    bk_columns: 'C_CUSTKEY'
    hk_column: HK_CUSTOMER_H
    rsrc_static: 'HK_CUSTOMER_H'
hashkey: HK_CUSTOMER_H
business_keys: 
  - 'C_CUSTKEY'
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ datavault4dbt.hub(hashkey=metadata_dict.get("hashkey"),
        business_keys=metadata_dict.get("business_keys"),
        source_models=metadata_dict.get("source_models")) }}
