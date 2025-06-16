# End-to-End Data Pipeline using Snowflake & dbt

This project showcases an end-to-end data pipeline built using **Snowflake** and **dbt**.
The pipeline integrates and transforms datasets related to **housing rent**, **income**, and **quality of life metrics** across U.S. states, following analytics engineering best practices.

##  Pipeline Architecture

Structured using a modular schema approach in Snowflake:
RAW → PREP → REFINED → DELIVERY

- **RAW**: Ingests data from CSV (Kaggle), JSON, and Marketplace (Snowflake) sources.
PREP and REFINED Layer data transformation in dbt:
- **PREP**: Performs light cleaning and type handling.
- **REFINED**: Joins and cleans data, applies transformations.
- **DELIVERY**: Final views for dashboard and stakeholder insights.

## Technologies Used

- **Snowflake**: Data warehouse, access control, Data Loading
- **dbt**: Data modeling, SQL transformations, lineage (DAG), documentation
- **GitHub**: Version control, branch management

## Governance

- Implemented **Role-Based Access Control (RBAC)** for secure data access.
- Created read-only viewer roles for delivery layer and dashboards.

## Key Insights Delivered

- Correlation analysis between rent prices and QoL/income factors
- Rent burden rankings by state
- Rent trends by property size and type

## Supporting Materials
### Project Summary Report : https://github.com/suganyam2001/dbt/blob/main/Data_Integration_and_Transformation_Pipeline_Report.docx
### Final Presentation : https://github.com/suganyam2001/dbt/blob/main/Data_Integration_and_Transformation_Pipeline.pdf
---
