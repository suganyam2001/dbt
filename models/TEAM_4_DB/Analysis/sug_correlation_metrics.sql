{{ config(
    materialized='view',
    schema='analysis'
) }}

WITH rent_by_state AS (
  SELECT
    HOUSING_STATE,
    MEDIAN(PRICE) AS MEDIAN_RENT
  FROM {{ref ('Join_housing')}}
  GROUP BY HOUSING_STATE
),
income_rent_qol AS (
  SELECT
    J.AREANAME AS STATE,
    J.MEDIAN_HOUSEHOLD_INCOME,
    R.MEDIAN_RENT,
    -J.QOL_AFFORDABILITY AS Qol_Affordability_Reversed,
    -J.QOL_ECONOMY AS Qol_Economy_Reversed,
    -J.QOL_EDUCATION_AND_HEALTH AS Qol_Education_And_Health_Reversed,
    -J.QOL_SAFETY AS Qol_Safety_Reversed
  FROM rent_by_state R
  INNER JOIN {{ref ('Join_housing')}} J
    ON R.HOUSING_STATE = J.HOUSING_STATE
),
correlations AS (
  SELECT
    CORR(MEDIAN_HOUSEHOLD_INCOME, MEDIAN_RENT) AS correlation_income_rent,
    CORR(Qol_Affordability_Reversed, MEDIAN_RENT) AS correlation_affordability_rent,
    CORR(Qol_Economy_Reversed, MEDIAN_RENT) AS correlation_economy_rent,
    CORR(Qol_Education_And_Health_Reversed, MEDIAN_RENT) AS correlation_education_health_rent,
    CORR(Qol_Safety_Reversed, MEDIAN_RENT) AS correlation_safety_rent
  FROM income_rent_qol
)
SELECT 'Income-Rent' AS metric, ROUND(correlation_income_rent, 2) AS correlation FROM correlations
UNION ALL
SELECT 'Affordability-Rent', ROUND(correlation_affordability_rent, 2) FROM correlations
UNION ALL
SELECT 'Economy-Rent', ROUND(correlation_economy_rent, 2) FROM correlations
UNION ALL
SELECT 'Education-Health-Rent', ROUND(correlation_education_health_rent, 2) FROM correlations
UNION ALL
SELECT 'Safety-Rent', ROUND(correlation_safety_rent, 2) FROM correlations