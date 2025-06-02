SELECT *
FROM {{ ref('refined_housing_data') }}
WHERE price < 0