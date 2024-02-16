default:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: BDUHNM.SD34895
      warehouse: COMPUTE_WH
      database: SNOWFLAKE_SAMPLE_DATA
      schema: INFORMATION_SCHEMA
      role: ACCOUNTADMIN
      threads: 4
      region: west-us-2
