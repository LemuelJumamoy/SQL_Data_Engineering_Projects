/*
Problem Statement
You will create a temporary table to identify high-volume hiring partners with more than 10 job postings. 
Isolating these companies into a temporary staging area allows you to prioritize their data pipelines for updates without altering the permanent database schema
*/

USE company_jobs;

CREATE TEMPORARY TABLE top_hiring_companies_temp AS

SELECT 
    cd.company_id, 
    cd.name AS company_name,
    COUNT(jpf.job_id) AS posting_count
FROM data_jobs.company_dim AS cd 
INNER JOIN data_jobs.job_postings_fact AS jpf
    ON cd.company_id = jpf.company_id
GROUP BY 
    cd.company_id,
    cd.name
HAVING COUNT(jpf.job_id) > 10;

SELECT *
FROM top_hiring_companies_temp;