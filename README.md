# ETL Pipeline (First & Last Click of page event)

## 1. Overview
This project demonstrates a pipeline that computes First-Click and Last-Click attribution using GA4-style event data.

The solution uses:
- BigQuery for transformations and data quality
- BigQuery analytical warehouse
- Airflow to automate & schedule

---

## 2. Architecture

Events Data (Sample CSV)
        ↓
     GCS Bucket
        ↓
     BigQuery
(raw → curated → discovery)
        ↓
      Looker

<img width="1240" height="697" alt="image" src="https://github.com/user-attachments/assets/4e590265-00d6-462d-9492-9a5986c0c725" />


Tools:
- BigQuery
- Cloud Storage
- Airflow

---

## 3. Dataset

Source:
A flattened sample dataset is used to simulate BigQuery export.

File:
data/events.csv

Key Fields:
- user_id – user identifier
- event_name – page_view
- event_timestamp – event time
- source, channel – attribution

---

## 4. Model Layers
- raw: Raw sample events data
- curated: Events preparation/transformation/cleansing
- discovery: Business-ready attribution outputs

---

## 5. Data Quality & Tests

- event_id: not null, unique
- user_id: not null
- channel: not null

---

## 6. How to Run

Airflow:
- Dag code uploaded in Airflow UI
- Respective sql files uploaded in GCS Bucket

---

## 7. Failure Handling & Monitoring

- Duplicate events handled via event_id deduplication
- sql catch nulls and duplicates
- Partitioning/clustering in BigQuery

---

## 8. Cost Considerations (BigQuery)

- Partition by event_date
- Cluster by user_id

---
