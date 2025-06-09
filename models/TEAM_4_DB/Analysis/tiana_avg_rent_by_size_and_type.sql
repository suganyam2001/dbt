WITH cleaned_data AS (
  SELECT
    type,
    state,
    CASE 
      WHEN sqfeet < 500 THEN 'Small (<500 sqft)'
      WHEN sqfeet BETWEEN 500 AND 1000 THEN 'Medium (500–1000 sqft)'
      WHEN sqfeet > 1000 THEN 'Large (>1000 sqft)'
    END AS size_group,
    price,
    sqfeet
  FROM {{ ref('refined_housing_data') }}
  WHERE price BETWEEN 100 AND 10000
    AND sqfeet BETWEEN 100 AND 5000
    AND price IS NOT NULL
    AND sqfeet IS NOT NULL
),

avg_rent_by_size_type AS (
  SELECT
    type,
    size_group,
    ROUND(AVG(price), 2) AS avg_price,
    ROUND(AVG(sqfeet), 0) AS avg_sqfeet,
    COUNT(*) AS listing_count
  FROM cleaned_data
  GROUP BY type, size_group
)

SELECT *
FROM avg_rent_by_size_type
ORDER BY size_group, type