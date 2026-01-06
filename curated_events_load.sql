create schema if not exists curatedds;


create or replace table curatedds.curated_events as select user_pseudo_id, event_name, TIMESTAMP(event_timestamp) AS event_time, 
  COALESCE((select value.string_value from unnest(event_params) where key = 'source'), traffic_source.source, 'direct') AS source,
  COALESCE((select value.string_value from unnest(event_params) where key = 'medium'), traffic_source.medium, '(none)') AS medium,
  (select value.int_value from unnest(event_params) where key = 'value') as event_value from rawds.raw_events;

create or replace table curatedds.curated_events_final as select user_pseudo_id, event_name, event_time, source, medium, event_value, ROW_NUMBER() OVER (PARTITION by user_pseudo_id order by event_time) AS event_order from stg_ga4_events;

select * from `curatedds.curated_events_final` limit 5;

select current_timestamp,"Curated Load completed Successfully";
