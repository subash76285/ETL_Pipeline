## Entry 1 – Requirement understanding
- Reviewed assessment requirements and evaluation criteria.
- Identified core focus areas: dbt modeling, attribution logic.

---

## Entry 2 – Architecture planning
- Designed a high-level architecture for events attribution.
- Prepared data flow diagram.

---

## Entry 3 – Dataset preparation
- Created a flattened sample dataset (CSV).
- Ensured multiple users, multiple touchpoints, and purchase events.
- Manually validated expected First-Click and Last-Click outcomes.

---

## Entry 4 – Raw Zone
- Implemented raw_events dataset to clean and standardize raw data.

---

## Entry 5 – Curated Zone
- Converted timestamps and selected required fields.
- Verified staging output matches input data correctly.
  
---

## Entry 6 – Discovery Zone
- Implemented First-Click attribution using window functions.
- Implemented Last-Click attribution using window functions.

---

- Prioritized correctness, simplicity, and explainability over complexity.
- All SQL written to be BigQuery-compatible.
