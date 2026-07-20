/*
Problem Statement:
Compare salary and theoretical commute savings for US-based "Data" jobs. 
You will group the analysis by Job Title and Work-From-Home (WFH) status to see how these factors impact the average annual salary and a calculated "adjusted" salary.
*/

SELECT 
    jpf.job_title, 
    jpf.work_from_home 
FROM job_postings_fact AS jpf








SELECT catalog_name 
FROM information_schema.schemata;

SELECT table_name 
FROM information_schema.tables 
WHERE table_catalog = 'data_jobs'
    AND table_schema = 'main';

SELECT 
    column_name, 
    data_type
FROM information_schema.columns
WHERE table_name = 'job_postings_fact';

SELECT 
    jpf.job_title_short,
    jpf.job_work_from_home,
    AVG(jpf.salary_year_avg)::INT AS annual_salary_avg,
    AVG(jpf.job_work_from_home::INT * ((jpf.salary_year_avg / 2080)* 260))::INT AS annual_commute_cost_savings,
    (AVG(jpf.salary_year_avg) + AVG(jpf.job_work_from_home::INT * ((jpf.salary_year_avg / 2080)* 260)))::INT AS adjusted_annual_salary_avg
FROM 
    job_postings_fact AS jpf
    
WHERE 
    jpf.job_country = 'United States'
    AND jpf.job_title_short LIKE '%Data%'
    

GROUP BY 
    jpf.job_title_short, 
    jpf.job_work_from_home

ORDER BY 
    jpf.job_title_short DESC,
    jpf.job_work_from_home ASC
;

/*
┌───────────────────────┬────────────────────┬───────────────────┬─────────────────────────────┬────────────────────────────┐
│    job_title_short    │ job_work_from_home │ annual_salary_avg │ annual_commute_cost_savings │ adjusted_annual_salary_avg │
│        varchar        │      boolean       │       int32       │            int32            │           int32            │
├───────────────────────┼────────────────────┼───────────────────┼─────────────────────────────┼────────────────────────────┤
│ Senior Data Scientist │ false              │            160931 │                           0 │                     160931 │
│ Senior Data Scientist │ true               │            164309 │                       20539 │                     184847 │
│ Senior Data Engineer  │ false              │            155568 │                           0 │                     155568 │
│ Senior Data Engineer  │ true               │            148718 │                       18590 │                     167307 │
│ Senior Data Analyst   │ false              │            119612 │                           0 │                     119612 │
│ Senior Data Analyst   │ true               │            115418 │                       14427 │                     129846 │
│ Data Scientist        │ false              │            137281 │                           0 │                     137281 │
│ Data Scientist        │ true               │            142370 │                       17796 │                     160166 │
│ Data Engineer         │ false              │            137701 │                           0 │                     137701 │
│ Data Engineer         │ true               │            141094 │                       17637 │                     158731 │
│ Data Analyst          │ false              │             94340 │                           0 │                      94340 │
│ Data Analyst          │ true               │             98195 │                       12274 │                     110469 │
└───────────────────────┴────────────────────┴───────────────────┴─────────────────────────────┴────────────────────────────┘
  12 rows  

  