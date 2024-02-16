-- models/clickstream_analysis.sql

{{ config(materialized='view') }}

WITH user_activity AS (
  SELECT *
  FROM
    SNOWFLAKE_SAMPLE_DATA.tpcds_sf100tcl.call_center
)

SELECT *
FROM
  user_activity
