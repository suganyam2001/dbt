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
    Q.Qol_Affordability,
    Q.Qol_Economy,
    Q.Qol_Education_And_Health,
    Q.Qol_Safety
  FROM rent_by_state R
  JOIN {{ ref('refined_median_income') }} M
    ON TRIM(UPPER(R.STATE)) = TRIM(UPPER(M.STATE))
  JOIN {{ ref('refined_qol_data') }} Q
    ON TRIM(UPPER(M.AREANAME)) = TRIM(UPPER(Q.STATE))
),

correlations AS (
  SELECT
    CORR(MEDIAN_HOUSEHOLD_INCOME, MEDIAN_RENT) AS correlation_income_rent,
    CORR(Qol_Affordability, MEDIAN_RENT) AS correlation_affordability_rent,
    CORR(Qol_Economy, MEDIAN_RENT) AS correlation_economy_rent,
    CORR(Qol_Education_And_Health, MEDIAN_RENT) AS correlation_education_health_rent,
    CORR(Qol_Safety, MEDIAN_RENT) AS correlation_safety_rent
  FROM income_rent_qol
)

SELECT 'Income-Rent' AS metric, ROUND(correlation_income_rent, 2) AS correlation FROM correlations
UNION ALL
SELECT 'Affordability-Rent', ROUND(correlation_affordability_rent, 2) FROM correlations
UNION ALL
SELECT 'Economy-Rent', ROUND(correlation_economy_rent, 2) FROM correlations
UNION ALL
SELECT 'EducationHealth-Rent', ROUND(correlation_education_health_rent, 2) FROM correlations
UNION ALL
SELECT 'Safety-Rent', ROUND(correlation_safety_rent, 2) FROM correlations