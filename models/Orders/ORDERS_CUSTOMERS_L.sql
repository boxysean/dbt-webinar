{{ config(schema='rdv',
          materialized='incremental') }}

{%- set yaml_metadata -%}
source_models: 
  - name: stg_orders
    fk_columns: 
      - 'HK_ORDER_H'
      - 'HK_CUSTOMER_H'
    rsrc_static: 'Orders'
link_hashkey: HK_ORDERS_CUSTOMERS_L 
foreign_hashkeys: 
  - 'HK_ORDER_H'
  - 'HK_CUSTOMER_H'
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ datavault4dbt.link(link_hashkey=metadata_dict.get("link_hashkey"),
        foreign_hashkeys=metadata_dict.get("foreign_hashkeys"),
        source_models=metadata_dict.get("source_models")) }}