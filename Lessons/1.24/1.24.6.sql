USE company_jobs;

DELETE FROM staging.priority_skills 
WHERE skill_id = '183'
;

MERGE INTO company_jobs.job_skill_priorities AS tgt
USING staging.priority_skills AS src 
ON tgt.skill_id = src.skill_id 

WHEN NOT MATCHED BY SOURCE THEN 
UPDATE SET 
    status = 'INACTIVE'
;

SELECT * FROM company_jobs.job_skill_priorities;

/* .read C:/Users/lemue/Documents/SQL_Data_Engineering_Projects/Lessons/1.24/1.24.6.sql */