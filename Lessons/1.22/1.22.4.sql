/*
Problem Statement
You will create a view that filters job postings specifically for Data Engineer roles requiring AWS or GCP expertise. 
Encapsulating this logic into a virtual table provides a reusable dataset, making it easier for analysts to quickly query these specific cloud opportunities.
*/

USE company_jobs;
DROP VIEW cloud_engineering_roles_view;

CREATE VIEW cloud_engineering_roles_view AS 
SELECT 
    jpf.job_title,
    cd.name AS company_name,
    sd.skills
FROM 
    data_jobs.job_postings_fact AS jpf 
INNER JOIN data_jobs.company_dim AS cd ON jpf.company_id = cd.company_id 
INNER JOIN data_jobs.skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
INNER JOIN data_jobs.skills_dim AS sd 
    ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Engineer'
    AND (sd.skills = 'aws' OR sd.skills = 'gcp');

SELECT COUNT(*) FROM cloud_engineering_roles_view ;
DESCRIBE data_jobs.job_postings_fact;
DESCRIBE data_jobs.company_dim;
DESCRIBE data_jobs.skills_dim;
DESCRIBE data_jobs.skills_job_dim;





