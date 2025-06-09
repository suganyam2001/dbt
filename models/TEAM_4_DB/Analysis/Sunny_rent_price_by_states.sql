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

(SELECT i.areaname,
       ROUND(MEDIAN(price)) AS median_rent_price,
       'Top 5' AS Rent_Group
FROM refined_housing h
INNER JOIN refined_income i
  ON h.state = i.state
GROUP BY i.areaname
ORDER BY median_rent_price DESC
LIMIT 5)

UNION ALL

(SELECT i.areaname,
       ROUND(MEDIAN(price)) AS median_rent_price,
       'Bottom 5' AS Rent_Group
FROM refined_housing h
INNER JOIN refined_income i
  ON h.state = i.state
GROUP BY i.areaname
ORDER BY median_rent_price ASC
LIMIT 5)

ORDER BY median_rent_price DESC
