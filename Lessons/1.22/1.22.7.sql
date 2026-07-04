/*
Problem Statement
You will clear all historical records from the uk_jobs_archive table (Question 1.22.1).
Emptying a table while preserving its schema is essential for efficiently preparing the pipeline for a fresh data load.
*/

USE company_jobs;

DESCRIBE uk_jobs_archive;

SELECT COUNT(*) FROM uk_jobs_archive;
TRUNCATE TABLE uk_jobs_archive;


