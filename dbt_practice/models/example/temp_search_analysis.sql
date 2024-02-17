{{ config(materialized='table') }}

with weather_ as(
SELECT *
FROM WEATHER_SOURCE_LLC_FROSTBYTE.onpoint_id.history_day
WHERE date_valid_std = TO_DATE('2022-06-11', 'YYYY-MM-DD') 
and city_name = 'Denver'
and country = 'US'
and avg_temperature_air_2m_f > 80
order by max_temperature_air_2m_f desc),

search_ as (
select count(*) search_count, clean_landingpage, to_date(date, 'YY-MM-DD') date_
from GOOGLE_KEYWORDS_SEARCH_DATASET__DISCOVER_ALL_SEARCHES_ON_GOOGLE.datafeeds.google_keywords
where year = 22
and month = 6
and day = 11
group by clean_landingpage, date
order by 1 desc
)
select max(a.max_temperature_air_2m_f) avg_temp, b.clean_landingpage website
from weather_ a,
     search_ b
where a.date_valid_std = b.date_
group by 2