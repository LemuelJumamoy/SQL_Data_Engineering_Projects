
USE company_jobs;


DELETE FROM job_skill_priorities AS tgt
WHERE NOT EXISTS (
    SELECT 1 
    FROM staging.priority_skills AS src 
    WHERE src.skill_id = tgt.skill_id)
;

SELECT * FROM job_skill_priorities WHERE skill_id = 183;
-- this deletes all the inactive rows

/* .read C:/Users/lemue/Documents/SQL_Data_Engineering_Projects/Lessons/1.24/1.24.7.sql */