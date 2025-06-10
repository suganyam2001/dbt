{{ config(
    materialized='view',
    schema='prep'
) }}

SELECT
  STATE,
  AREANAME,
  B19013_001 AS MEDIAN_HOUSEHOLD_INCOME,
  B19127_001 AS AGGREGATE_FAMILY_INCOME,
FROM {{ source('raw', 'MARKETPLACE_INCOME_RAW') }}