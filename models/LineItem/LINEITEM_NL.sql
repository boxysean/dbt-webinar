{{ config(schema='rdv',
          materialized='incremental') }}

{%- set yaml_metadata -%}
source_models: 
  stg_lineitem:
    fk_columns: 
      - 'HK_PART_H'
      - 'HK_ORDER_H'
      - 'HK_SUPPLIER_H'
      - 'L_LINENUMBER'
    payload:
      - L_QUANTITY
      - L_EXTENDEDPRICE
      - L_DISCOUNT
      - L_TAX
      - L_RETURNFLAG
      - L_LINESTATUS
      - L_SHIPDATE
      - L_COMMITDATE
      - L_RECEIPTDATE
      - L_SHIPINSTRUCT
      - L_SHIPMODE
      - L_COMMENT

    rsrc_static: 'LineItem'
link_hashkey: HK_LINEITEM_NL 
foreign_hashkeys: 
  - 'HK_PART_H'
  - 'HK_ORDER_H'
  - 'HK_SUPPLIER_H'
  - 'L_LINENUMBER'

payload:
    - L_QUANTITY
    - L_EXTENDEDPRICE
    - L_DISCOUNT
    - L_TAX
    - L_RETURNFLAG
    - L_LINESTATUS
    - L_SHIPDATE
    - L_COMMITDATE
    - L_RECEIPTDATE
    - L_SHIPINSTRUCT
    - L_SHIPMODE
    - L_COMMENT

{%- endset -%}


{% set metadata_dict = fromyaml(yaml_metadata) %}

{%- set link_hashkey = metadata_dict['link_hashkey'] -%}
{%- set foreign_hashkeys = metadata_dict['foreign_hashkeys'] -%}
{%- set payload = metadata_dict['payload'] -%}
{%- set source_models = metadata_dict['source_models'] -%}

{{ datavault4dbt.nh_link(link_hashkey=metadata_dict.get("link_hashkey"),
                        foreign_hashkeys=metadata_dict.get("foreign_hashkeys"),
                        payload=metadata_dict.get("payload"),
                        source_models=metadata_dict.get("source_models")) }}