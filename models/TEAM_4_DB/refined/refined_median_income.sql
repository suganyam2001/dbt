{{ config(
    materialized='view',
    schema='refined'
) }}

SELECT
  STATE,
  AREANAME,
  MEDIAN_HOUSEHOLD_INCOME,
  AGGREGATE_FAMILY_INCOME
FROM {{ ref('prep_median_income') }}