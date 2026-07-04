/*
Problem Statement
You will clear all existing records from the company_salary_stats table.
Emptying this table prepares the pipeline for a fresh data run, ensuring new salary metrics are calculated from a clean slate without data duplication.
*/

USE company_jobs;

SELECT COUNT(*)FROM company_salary_stats;
TRUNCATE TABLE company_salary_stats;