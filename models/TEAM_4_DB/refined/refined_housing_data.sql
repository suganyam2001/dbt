SELECT
  ID,
  STATE,
  PRICE,
  TYPE,
  BEDS,
  BATHS,
  SQFEET,
  PARKING_OPTIONS
FROM {{ source('raw', 'HOUSING_CSV_RAW') }}