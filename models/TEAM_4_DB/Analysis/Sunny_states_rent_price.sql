{{ config(
    materialized='view',
    schema='delivery'
) }}

( SELECT areaname,
         ROUND(MEDIAN(price)) AS median_rent_price,
         'Top 5' AS Rent_Group
  FROM {{ ref('Join_housing') }}
  GROUP BY areaname
  ORDER BY median_rent_price DESC
  LIMIT 5
)
UNION ALL
( SELECT areaname, 
         ROUND(MEDIAN(price)) AS median_rent_price,
         'Bottom 5' AS Rent_Group
  FROM {{ ref('Join_housing') }}
  GROUP BY areaname
  ORDER BY median_rent_price  ASC
  LIMIT 5
)
ORDER BY median_rent_price DESC