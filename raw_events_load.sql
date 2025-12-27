
create schema if not exists rawds;

create table if not exists rawds.raw_events(event_id INT64, user_id INT64, event_name string, event_timestamp string, event_date string, source string, channel string);

LOAD DATA OVERWRITE `rawds.raw_events` FROM FILES (format = 'CSV', uris = ['gs://analytics-bucket/data/events.csv'], field_delimiter=',');

select * from `rawds.raw_events` limit 5;

select current_timestamp,"Raw Load completed Successfully";