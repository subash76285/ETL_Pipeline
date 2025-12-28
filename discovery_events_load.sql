create schema if not exists discoveryds;

create or replace table if not exists discoveryds.first_events(event_id INT64, user_id INT64, event_name string, event_timestamp timestamp, event_date date, source string, channel string) partition by event_date cluster by event_id;

insert into curatedds.curated_events select user_id, first_value(channel) over (partition by user_id order by event_ts) as first_click_channel from curatedds.curated_events qualify event_name = 'purchase';


create or replace table if not exists discoveryds.last_events(event_id INT64, user_id INT64, event_name string, event_timestamp timestamp, event_date date, source string, channel string) partition by event_date cluster by event_id;

insert into curatedds.curated_events select user_id, last_value(channel) over (partition by user_id order by event_ts rows between unbounded preceding and unbounded following) as last_click_channel from curatedds.curated_events qualify event_name = 'purchase';


select * from `discovery.first_events` limit 5;

select * from `discovery.last_events` limit 5;

select current_timestamp, "Discovery Load completed Successfully";

