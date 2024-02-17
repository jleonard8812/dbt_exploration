{{ config(materialized='view') }}

with weather_ as(
SELECT avg(AVG_TEMPERATURE_AIR_2M_F) avg_temp, date_valid_std date_
FROM WEATHER_SOURCE_LLC_FROSTBYTE.onpoint_id.history_day
WHERE date_valid_std between TO_DATE('2020-01-01', 'YYYY-MM-DD') and TO_DATE('2021-01-01', 'YYYY-MM-DD') 
and country = 'US'
group by date_valid_std
order by 1 desc
),
covid_ as (
    SELECT m.COUNTRY_REGION, m.DATE, m.CASES, m.DEATHS, m.DEATHS / m.CASES as CFR
FROM (SELECT COUNTRY_REGION, DATE, AVG(CASES) AS CASES, AVG(DEATHS) AS DEATHS
      FROM COVID19_EPIDEMIOLOGICAL_DATA.public.ECDC_GLOBAL
      GROUP BY COUNTRY_REGION, DATE) m
WHERE m.CASES > 0
and m.COUNTRY_REGION = 'United States'
),
final_ as (
select b.date, a.avg_temp, b.CFR
from weather_ a,
     covid_ b 
where a.date_ = b.date
)
select *
from final_