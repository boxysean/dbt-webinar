{{ config(schema='rdv',
materialized='incremental') }}

{%- set yaml_metadata -%}
tracked_hashkey: HK_CUSTOMER_H
source_models:
  stg_customer:
    rsrc_static: 'Customer'

{%- endset -%}    

{%- set metadata_dict = fromyaml(yaml_metadata) -%}

{{ datavault4dbt.rec_track_sat(tracked_hashkey=metadata_dict.get('tracked_hashkey'),
                                source_models=metadata_dict.get('source_models')) }}