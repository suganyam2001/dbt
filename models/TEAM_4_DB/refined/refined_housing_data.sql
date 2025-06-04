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
  state AS state
FROM {{ ref('prep_housing_data') }}