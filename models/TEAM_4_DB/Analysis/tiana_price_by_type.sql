{{ config(schema='Analysis') }} 

WITH refined_data AS (
  SELECT *
  FROM {{ ref('refined_housing_data') }}
)

SELECT
  type,
  beds,
  baths,
  AVG(price) AS avg_price,
  COUNT(*) AS listing_count
FROM refined_data
GROUP BY type, beds, baths
ORDER BY avg_price DESC