/*
Problem Statement
You will create a new summary table that aggregates average salaries and job posting volumes at the company level. 
This is important because pre-calculating these metrics allows analysts to quickly identify competitive employers without repeatedly running expensive aggregations on the raw fact table.
*/

USE company_jobs;

CREATE TABLE company_salary_stats AS
SELECT 
    jpf.company_id,
    AVG(jpf.salary_year_avg) AS avg_yearly_salary, 
    COUNT(jpf.job_id) AS job_count
FROM data_jobs.job_postings_fact AS jpf
WHERE jpf.salary_year_avg IS NOT NULL 
GROUP BY
    jpf.company_id;

SELECT * FROM company_salary_stats;


