USE company_jobs;

-- answer
CREATE OR REPLACE TABLE job_skill_priorities (
    job_id INT, 
    skill_id INT, 
    skill_name VARCHAR, 
    priority_lvl INT, 
    status VARCHAR 
);

INSERT INTO job_skill_priorities (job_id, skill_id, status)
SELECT 
    sjd.job_id, 
    sjd.skill_id, 
    'ACTIVE' AS status 
FROM data_jobs.skills_job_dim AS sjd 
INNER JOIN staging.priority_skills AS ps 
    ON sjd.skill_id = ps.skill_id;

SELECT *
FROM job_skill_priorities;

--.read C:/Users/lemue/Documents/SQL_Data_Engineering_Projects/Lessons/1.24/1.24.2.sql
-- notes: 
  -- you can add any amount of column values in the insert but you will get null values int he other rows. 