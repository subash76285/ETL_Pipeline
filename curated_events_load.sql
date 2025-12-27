create schema if not exists curatedds;

create or replace table if not exists curatedds.curated_events(event_id INT64, user_id INT64, event_name string, event_timestamp timestamp, event_date date, source string, channel string);

insert into curatedds.curated_events select user_id, event_id, event_name, event_ts, source, channel, row_number() over (partition by user_id order by event_ts) as page_order from (SELECT event_id, user_id, event_name, cast(event_timestamp as timestamp) as event_ts, cast(event_date as date) as event_date, source, channel from rawds.raw_events where user_id is not NULL and event_id is not NULL and channel is not NULL);

select * from `curatedds.curated_events` limit 5;

select current_timestamp,"Curated Load completed Successfully";