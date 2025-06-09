{{ config(
    materialized='view',
    schema='delivery'
) }}

SELECT areaname,
       ROUND(MEDIAN(price)* 12) AS median_rent_price,
       median_household_income,
       ROUND((MEDIAN(price) * 12) / median_household_income,3) AS rent_burden
FROM {{ ref('Join_housing') }}
GROUP BY areaname, median_household_income
ORDER BY rent_burden DESC