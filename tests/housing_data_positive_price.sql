WITH refined_data AS (
  SELECT *
  FROM {{ ref('refined_housing_data') }}
)

SELECT *
FROM refined_data
WHERE price <= 0