USE company_jobs;

UPDATE staging.priority_skills 
SET priority_lvl = 1
WHERE skill_id = 0
;

UPDATE staging.priority_skills 
SET priority_lvl = 2
WHERE skill_id = 1
;

MERGE INTO company_jobs.job_skill_priorities AS tgt
USING staging.priority_skills AS src
ON tgt.skill_id = src.skill_id

WHEN MATCHED AND (tgt.priority_lvl IS DISTINCT FROM src.priority_lvl OR tgt.priority_lvl IS NULL) THEN
    UPDATE SET
        skill_name = src.skill_name,
        priority_lvl = src.priority_lvl,
        status = 'PRIORITY_CHANGE'
;


SELECT * FROM company_jobs.job_skill_priorities;

-- .read C:/Users/lemue/Documents/SQL_Data_Engineering_Projects/Lessons/1.24/1.24.5.sql

/*
Merge the src table into the tgt table. We can use UPDATE commands to update the src table or we can just go into the source table file and update it ourselves. 
WHEN MATCHED?
  - where the skill_id's match, because they have to share the same data to connect, then update what rows you want updated. 
*/
