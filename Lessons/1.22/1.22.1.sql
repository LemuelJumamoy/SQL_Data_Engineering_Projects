/*
Problem Statement
You will create a new, targeted archive table containing only job postings located in the United Kingdom. Segmenting massive fact tables into smaller, regional datasets drastically improves query performance and makes the data much easier to manage.
*/

USE company_jobs;

CREATE TABLE uk_jobs_archive AS 
SELECT 
    jpf.*
FROM 
    data_jobs.job_postings_fact AS jpf
WHERE 
    job_country = 'United Kingdom'
;

SELECT * FROM uk_jobs_archive;
