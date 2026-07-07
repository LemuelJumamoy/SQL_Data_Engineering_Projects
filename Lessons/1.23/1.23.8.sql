SELECT 
    jpf.job_id, 
    jpf.job_title_short
FROM 
data_jobs.job_postings_fact AS jpf 
WHERE EXISTS (
    SELECT 1 
    FROM data_jobs.skills_job_dim AS sjd INNER JOIN data_jobs.skills_dim AS sd 
    ON sjd.skill_id = sd.skill_id 
    WHERE jpf.job_id = sjd.job_id
    AND sd.skills IN ('python')
)
AND jpf.job_title_short = 'Data Engineer'
;


SELECT 
    cd.name
FROM 
    data_jobs.company_dim AS cd 
WHERE EXISTS (
    SELECT 1
    FROM data_jobs.job_postings_fact AS jpf
    WHERE cd.company_id = jpf.company_id
)
;