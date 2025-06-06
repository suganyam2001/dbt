WITH rent_by_state AS (
  SELECT
    C.STATE,
    MEDIAN(C.PRICE) AS MEDIAN_RENT
  FROM {{ ref('refined_housing_data') }} C
  GROUP BY C.STATE
),
income_rent_qol AS (
  SELECT
    M.STATE,
    M.MEDIAN_HOUSEHOLD_INCOME,
    R.MEDIAN_RENT,
    -Q.Qol_Affordability AS Qol_Affordability_Reversed,
    -Q.Qol_Economy AS Qol_Economy_Reversed,
    -Q.Qol_Education_And_Health AS Qol_Education_And_Health_Reversed,
    -Q.Qol_Safety AS Qol_Safety_Reversed
  FROM rent_by_state R
  INNER JOIN {{ ref('refined_median_income') }} M
    ON R.STATE = M.STATE
  INNER JOIN {{ ref('refined_qol_data') }} Q
    ON M.AREANAME = Q.STATE
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