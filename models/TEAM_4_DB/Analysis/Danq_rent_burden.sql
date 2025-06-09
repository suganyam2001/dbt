{{ config(
  materialized='view',
  schema='delivery'
) }}

WITH refined_housing AS (
  SELECT *
  FROM {{ ref('refined_housing_data') }}
),

refined_income AS (
  SELECT *
  FROM {{ ref('refined_median_income') }}
)

SELECT i.areaname,
       ROUND(MEDIAN(h.price)* 12) AS median_rent_price,
       i.median_household_income,
       ROUND((MEDIAN(h.price) * 12) / i.median_household_income,3) AS rent_burden
FROM refined_housing h
INNER JOIN refined_income i
    ON h.state = i.state
GROUP BY i.areaname, i.median_household_income
ORDER BY rent_burden DESC
