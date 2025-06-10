{{ config(
    materialized='view',
    schema='prep'
) }}

SELECT
  JSON_DATA:"state"::STRING AS state,
  JSON_DATA:"QualityOfLifeTotalScore"::NUMBER AS Qol_TotalScore,
  JSON_DATA:"QualityOfLifeQualityOfLife"::NUMBER AS Qol_Life,
  JSON_DATA:"QualityOfLifeAffordability"::NUMBER AS Qol_Affordability,
  JSON_DATA:"QualityOfLifeEconomy"::NUMBER AS Qol_Economy,
  JSON_DATA:"QualityOfLifeEducationAndHealth"::NUMBER AS Qol_Education_And_Health,
  JSON_DATA:"QualityOfLifeSafety"::NUMBER AS Qol_Safety
FROM {{ source('raw', 'QOL_JSON_RAW') }}