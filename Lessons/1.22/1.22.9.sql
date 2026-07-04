/*
Problem Statement
For demonstration purposes, you will copy a table and then use the DELETE keyword to remove pre-2023 records. 
While you would normally filter this data during the initial creation, we are doing it in two steps here specifically so you can practice deleting records from an existing table.
*/

USE company_jobs;

CREATE TABLE jan_2023_cleanup_copy AS 
SELECT jpf.* 
FROM data_jobs.job_postings_fact AS jpf;

DELETE FROM jan_2023_cleanup_copy
WHERE job_posted_date < '2023-01-01';

SELECT job_id, job_posted_date
FROM jan_2023_cleanup_copy
ORDER BY job_posted_date DESC;