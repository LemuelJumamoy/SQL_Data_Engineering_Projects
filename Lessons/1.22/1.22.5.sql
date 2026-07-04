/*
Problem Statement
You will create a temporary table that counts the most frequently requested skills for Data Science roles.
Storing this intermediate data in a temporary table allows you to quickly analyze technical requirements without modifying your permanent schema.
*/

DESCRIBE data_jobs.skills_dim;
USE company_jobs;

CREATE TEMPORARY TABLE ds_skills_count_temp AS

SELECT
    sd.skills, 
    COUNT(jpf.job_id) AS skill_count
FROM data_jobs.skills_dim AS sd 
INNER JOIN data_jobs.skills_job_dim AS sjd 
    ON sd.skill_id = sjd.skill_id 
INNER JOIN data_jobs.job_postings_fact AS jpf
    ON sjd.job_id = jpf.job_id
WHERE job_title_short = 'Data Scientist'
GROUP BY sd.skills
;

SELECT * FROM ds_skills_count_temp;



