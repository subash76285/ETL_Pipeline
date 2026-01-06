create schema if not exists discoveryds;

create or replace table discoveryds.first_event as select distinct user_pseudo_id, first_value(source) over (partition by user_pseudo_id order by event_time) as first_click_source,
  first_value(medium) over (partition by user_pseudo_id order by event_time) as first_click_medium from curatedds.curated_events_final;


create or replace table discoveryds.last_event as select distinct user_pseudo_id,
  last_value(source) over (partition by user_pseudo_id order by event_time rows between unbounded preceding and unbounded following) as last_click_source,
  last_value(medium) over (partition by user_pseudo_id order by event_time rows between unbounded preceding and unbounded following) as last_click_medium from curatedds.curated_events_final;


select * from `discovery.first_event` limit 5;

select * from `discovery.last_event` limit 5;

select current_timestamp, "Discovery Load completed Successfully";


