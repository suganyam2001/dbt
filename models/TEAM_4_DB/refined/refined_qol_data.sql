{{ config(
    materialized='view',
    schema='refined'
) }}

SELECT
  state AS state,
  Qol_TotalScore,
  Qol_Life,
  Qol_Affordability,
  Qol_Economy,
  Qol_Education_And_Health,
  Qol_Safety
FROM {{ ref('prep_qol_data') }}