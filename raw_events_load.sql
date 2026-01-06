
create schema if not exists rawds;

LOAD DATA OVERWRITE `rawds.raw_events` FROM FILES (format = 'JSON', uris = ['gs://analytics-bucket/data/raw_ga4_events.json']);

select * from `rawds.raw_events` limit 5;

select current_timestamp,"Raw Load completed Successfully";
