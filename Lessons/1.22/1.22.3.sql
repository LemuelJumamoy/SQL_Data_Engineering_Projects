/*
Problem Statement
You will create a view that consolidates remote job postings and their respective companies.
This creates a reusable virtual table, making it easier to query flexible work opportunities without writing complex joins every time.
*/

USE company_jobs;

DROP VIEW remote_jobs_view ;
CREATE VIEW remote_jobs_view AS
SELECT
    jpf.job_id, 
    jpf.job_title_short, 
    cd.name AS company_name
FROM data_jobs.job_postings_fact AS jpf 
INNER JOIN data_jobs.company_dim AS cd 
    ON jpf.company_id = cd.company_id
WHERE jpf.job_work_from_home IS TRUE;

SELECT 
    company_name, 
    COUNT(job_id) AS job_count
FROM remote_jobs_view
GROUP BY company_name 
ORDER BY COUNT(job_id) DESC;

-- VIEWS are is a snapshot of the most up to date data 
-- CTAS is a snapshot of the data at a certain point of time that will not change
-- We use an inner join because we want to only return where the company_id exists in both tables 