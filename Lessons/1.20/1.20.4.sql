/*
Problem Statement:
Create a unique identifier for each job posting by combining multiple columns into a single "compound key." 
You will need to convert different data types (Dates and Integers) into a common format (String/Text) to successfully join them together.
*/


SELECT * FROM information_schema.schemata;

SELECT catalog_name 
FROM information_schema.schemata;

USE data_jobs.main;


SELECT table_name 
FROM information_schema.tables 
WHERE table_catalog = 'data_jobs'
    AND table_schema = 'main';


DESCRIBE job_postings_fact;

SELECT 
    jpf.job_posted_date,
    jpf.company_id,
    jpf.job_title_short,
    jpf.job_posted_date::DATE as dt,
    jpf.company_id::STRING || '-' || jpf.job_posted_date::DATE::STRING AS compound_key    
FROM job_postings_fact AS jpf
LIMIT 10;
/*
┌─────────────────────┬────────────┬─────────────────────┬────────────┬─────────────────┐
│   job_posted_date   │ company_id │   job_title_short   │     dt     │  compound_key   │
│      timestamp      │   int32    │       varchar       │    date    │     varchar     │
├─────────────────────┼────────────┼─────────────────────┼────────────┼─────────────────┤
│ 2023-01-01 00:00:04 │       4593 │ Data Analyst        │ 2023-01-01 │ 4593-2023-01-01 │
│ 2023-01-01 00:00:22 │       4594 │ Data Analyst        │ 2023-01-01 │ 4594-2023-01-01 │
│ 2023-01-01 00:00:24 │       4595 │ Data Analyst        │ 2023-01-01 │ 4595-2023-01-01 │
│ 2023-01-01 00:00:27 │       4596 │ Senior Data Analyst │ 2023-01-01 │ 4596-2023-01-01 │
│ 2023-01-01 00:00:38 │       4597 │ Data Analyst        │ 2023-01-01 │ 4597-2023-01-01 │
│ 2023-01-01 00:00:38 │       4598 │ Data Analyst        │ 2023-01-01 │ 4598-2023-01-01 │
│ 2023-01-01 00:00:43 │       4599 │ Data Analyst        │ 2023-01-01 │ 4599-2023-01-01 │
│ 2023-01-01 00:00:51 │       4600 │ Data Analyst        │ 2023-01-01 │ 4600-2023-01-01 │
│ 2023-01-01 00:00:57 │       4601 │ Senior Data Analyst │ 2023-01-01 │ 4601-2023-01-01 │
│ 2023-01-01 00:00:57 │       4602 │ Business Analyst    │ 2023-01-01 │ 4602-2023-01-01 │
└─────────────────────┴────────────┴─────────────────────┴────────────┴─────────────────┘
  10 rows                                                                     5 columns

  LEARNINGS:
  - simple syntax for converting data types is ::
    jpf.job_posted_date::DATE as dt,
    jpf.company_id::STRING || '-' || jpf.job_posted_date::DATE::STRING AS compound_key   
