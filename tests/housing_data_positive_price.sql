WITH raw_data AS (
  SELECT *
  FROM {{ source('raw', 'HOUSING_CSV_RAW') }}
)

SELECT *
FROM raw_data
WHERE price < 0
