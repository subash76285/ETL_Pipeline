# DAG to load events data from GCS bucket to BigQuery Table

from airflow import DAG
from airflow.providers.google.cloud.operators.bigquery import BigQueryInsertJobOperator
from airflow.operators.email_operator import EmailOperator
from airflow.utils.dates import days_ago, timedelta,datetime
import datetime

default_args = {"start_date": datetime.datetime(2025, 12, 27),
                "email": "testgmail@gmail.com",
                "email_on_failure": True,
                "email_on_retry": True,
                "retries": 2,
                "schedule_interval": "@daily"
                }
 
with DAG("DAG to Process Event Data",
         default_args=default_args,
         description="Run the End to end data pipeline using BQ",
         max_active_runs=1,
         concurrency=1, 
         catchup=False 
        ) as dag:


raw_load = BigQueryInsertJobOperator(
            task_id="Raw_Load",
            configuration={"query": {"query": "{% include 'raw_events_load.sql' %}", "useLegacySql": False}},
            )

curation_Load = BigQueryInsertJobOperator(
            task_id="Curation_Load",
            configuration={"query": {"query": "{% include 'curated_events_load.sql' %}", "useLegacySql": False}},
	    )

discovery_load = BigQueryInsertJobOperator(
            task_id="Discovery_Load",
            configuration={"query": {"query": "{% include 'discovery_events_load.sql' %}", "useLegacySql": False}},
            )

raw_load >> curation_load >> discovery_load