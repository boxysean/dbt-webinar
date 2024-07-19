{{ config(schema='rdv',
          materialized='incremental') }}

{%- set yaml_metadata -%}
source_models: 
  - name: stg_partsupp
    fk_columns: 
      - 'HK_PART_H'
      - 'HK_SUPPLIER_H'
    rsrc_static: 'PartSupp'
link_hashkey: HK_PART_SUPPLIER_L 
foreign_hashkeys: 
  - 'HK_PART_H'
  - 'HK_SUPPLIER_H'
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ datavault4dbt.link(link_hashkey=metadata_dict.get("link_hashkey"),
        foreign_hashkeys=metadata_dict.get("foreign_hashkeys"),
        source_models=metadata_dict.get("source_models")) }}