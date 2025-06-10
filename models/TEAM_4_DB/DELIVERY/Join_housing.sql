{{ config(
    materialized='view',
    schema='delivery'
) }}

SELECT
  -- Housing table columns
  C.ID,
  C.PRICE,
  C.TYPE,
  C.SQFEET,
  C.BEDS,
  C.BATHS,
  C.CATS_ALLOWED,
  C.DOGS_ALLOWED,
  C.SMOKING_ALLOWED,
  C.WHEELCHAIR_ACCESS,
  C.ELECTRIC_VEHICLE_CHARGE,
  C.COMES_FURNISHED,
  C.PARKING_OPTIONS,
  C.STATE AS HOUSING_STATE,
  
  -- Income table columns
  M.AREANAME,
  M.MEDIAN_HOUSEHOLD_INCOME,
  M.AGGREGATE_FAMILY_INCOME,
  
  -- QOL table columns
  Q.QOL_TOTALSCORE,
  Q.QOL_LIFE,
  Q.QOL_AFFORDABILITY,
  Q.QOL_ECONOMY,
  Q.QOL_EDUCATION_AND_HEALTH,
  Q.QOL_SAFETY
FROM {{ ref('refined_housing_data') }} C
INNER JOIN {{ ref('refined_median_income') }} M
  ON C.STATE = M.STATE
INNER JOIN {{ ref('refined_qol_data') }} Q
  ON M.AREANAME = Q.STATE
