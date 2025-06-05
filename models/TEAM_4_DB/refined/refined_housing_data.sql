WITH source_data AS (
  SELECT *
  FROM {{ ref('prep_housing_data') }}
)

SELECT
  id,
  price,
  type,
  sqfeet,
  beds,
  baths,
  cats_allowed,
  dogs_allowed,
  smoking_allowed,
  wheelchair_access,
  electric_vehicle_charge,
  comes_furnished,
  parking_options,
  UPPER(state) AS state
FROM source_data
WHERE LENGTH(CAST(price AS STRING)) BETWEEN 2 AND 5
