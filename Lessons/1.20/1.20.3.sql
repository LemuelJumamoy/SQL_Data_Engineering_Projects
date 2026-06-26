/*
Problem Statement
Identify average annualized salaries for US jobs, grouped by job_title_short, and format them in two ways: precise currency and rounded whole numbers.
*/

SHOW DATABASES;

USE data_jobs;
-- were inside the data_jobs database

SELECT *
FROM information_schema.schemata;

SELECT schema_name
FROM information_schema.schemata
WHERE catalog_name = 'data_jobs';
--there is only 1 schema under the data_job database

SELECT
    table_name
FROM information_schema.tables
WHERE table_catalog = 'data_jobs'
  AND table_schema = 'main'
ORDER BY table_name;
/*
┌───────────────────┐
│    table_name     │
│      varchar      │
├───────────────────┤
│ company_dim       │
│ job_postings_fact │
│ skills_dim        │
│ skills_job_dim    │
└───────────────────┘
*/

DESCRIBE company_dim;
DESCRIBE job_postings_fact;


SELECT 
    job_title_short,
    (AVG(salary_hour_avg) * 40 * 52):: DECIMAL(10,2) AS salary_hour_annual,
    (AVG(salary_hour_avg) * 40 * 52):: INT AS salary_hour_annual_zero_decimals
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL   
    AND job_country = 'United States'
GROUP BY job_title_short
ORDER BY
salary_hour_annual DESC;
/*
┌───────────────────────────┬────────────────────┬──────────────────────────────────┐
│      job_title_short      │ salary_hour_annual │ salary_hour_annual_zero_decimals │
│          varchar          │   decimal(10,2)    │              int32               │
├───────────────────────────┼────────────────────┼──────────────────────────────────┤
│ Senior Data Engineer      │          125635.70 │                           125636 │
│ Data Engineer             │          120097.92 │                           120098 │
│ Cloud Engineer            │          119748.24 │                           119748 │
│ Machine Learning Engineer │          111617.61 │                           111618 │
│ Software Engineer         │          110129.89 │                           110130 │
│ Senior Data Scientist     │          107161.65 │                           107162 │
│ Data Scientist            │          102618.71 │                           102619 │
│ Senior Data Analyst       │           99168.53 │                            99169 │
│ Business Analyst          │           94320.83 │                            94321 │
│ Data Analyst              │           78113.29 │                            78113 │
└───────────────────────────┴────────────────────┴──────────────────────────────────┘
  10 rows                                                                 3 columns


Learnings:
- Remember you can't do any calculations in the WHERE and HAVING 
- DECIMAL() rounds the number 
- Annualized salary usually means 
    - take an hourly wage and convert it into a yearly salary 
    - when the question says find the average annualized salaries, it is not asking for the existing salary column. It is asking you to calculate yearly salary from hourly salary 
    - average hourly pay x hours per week x weeks per year
