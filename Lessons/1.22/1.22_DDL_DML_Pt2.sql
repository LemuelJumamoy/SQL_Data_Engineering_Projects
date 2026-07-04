-- CREATING the job_postings_flat table (combine job_postings_fact with company_dim table )
-- .read C:/Users/lemue/Documents/SQL_Data_Engineering_Projects/Lessons/1.22/1.22_DDL_DML_Pt2.sql
USE jobs_mart;

CREATE OR REPLACE TABLE staging.job_postings_flat AS
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_title,
    jpf.job_location,
    jpf.job_via,
    jpf.job_schedule_type,
    jpf.job_work_from_home,
    jpf.search_location,
    jpf.job_posted_date,
    jpf.job_no_degree_mention,
    jpf.job_health_insurance,
    jpf.job_country,
    jpf.salary_rate,
    jpf.salary_year_avg,
    jpf.salary_hour_avg,
    cd.name AS company_name
FROM data_jobs.job_postings_fact AS jpf
LEFT JOIN data_jobs.company_dim AS cd
    ON jpf.company_id = cd.company_id;
--we are in the jobs_mart database right now. If we are using tables from outside this 
--database, we have to specifiy. data_jobs.job_posstings_fact


SELECT COUNT(*)
FROM staging.job_postings_flat;

--Creating A VIEW within the jpbs_mart staging schema
CREATE OR REPLACE VIEW staging.priority_jobs_flat_view AS
SELECT 
    jpf.*
FROM staging.job_postings_flat AS jpf
JOIN staging.priority_roles AS r 
    ON jpf.job_title_short = r.role_name
WHERE r.priority_lvl = 1;

SELECT 
    job_title_short, 
    COUNT(*) AS job_count
FROM staging.priority_jobs_flat_view
GROUP BY job_title_short
ORDER BY job_count DESC;

--Creating a Temp Table

CREATE TEMPORARY TABLE senior_jobs_flat_temp AS
SELECT * 
FROM staging.priority_jobs_flat_view
WHERE job_title_short = 'Senior Data Engineer';

SELECT 
    job_title_short, 
    COUNT(*) AS job_count 
FROM senior_jobs_flat_temp 
GROUP BY job_title_short 
ORDER BY job_count DESC;

-- DELETING values before 2024 
SELECT COUNT(*) FROM staging.job_postings_flat; 
SELECT COUNT(*) FROM staging.priority_jobs_flat_view;
SELECT COUNT(*) FROM senior_jobs_flat_temp;


DELETE FROM staging.job_postings_flat
WHERE job_posted_date < '2024-01-01';

SELECT COUNT(*) FROM staging.job_postings_flat; 
SELECT COUNT(*) FROM staging.priority_jobs_flat_view;
SELECT COUNT(*) FROM senior_jobs_flat_temp;

-- TRUNCATE (want job postings that are 2024 and greater)
TRUNCATE TABLE staging.job_postings_flat;

INSERT INTO 
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_title,
    jpf.job_location,
    jpf.job_via,
    jpf.job_schedule_type,
    jpf.job_work_from_home,
    jpf.search_location,
    jpf.job_posted_date,
    jpf.job_no_degree_mention,
    jpf.job_health_insurance,
    jpf.job_country,
    jpf.salary_rate,
    jpf.salary_year_avg,
    jpf.salary_hour_avg,
    cd.name AS company_name
FROM data_jobs.job_postings_fact AS jpf
LEFT JOIN data_jobs.company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE job_posted_date >= '2024-01-01';

SELECT COUNT(*) FROM staging.job_postings_flat; 
SELECT COUNT(*) FROM staging.priority_jobs_flat_view;
SELECT COUNT(*) FROM senior_jobs_flat_temp;
