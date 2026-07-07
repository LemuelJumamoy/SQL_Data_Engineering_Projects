WITH core_skills AS (

    SELECT 
        sd.skill_id,
        sd.type AS skill_type
    FROM  data_jobs.skills_dim AS sd
    WHERE sd.type IN 
        ('programming','databases')
) 

--main query
SELECT 
    sd.type AS skill_type,
    COUNT(DISTINCT sjd.job_id) AS job_count,
FROM data_jobs.skills_job_dim AS sjd
INNER JOIN  data_jobs.skills_dim AS sd ON sjd.skill_id = sd.skill_id
INNER JOIN core_skills as cs ON sd.skill_id = cs.skill_id
GROUP BY sd.type
ORDER BY COUNT(DISTINCT sjd.job_id) DESC;


SHOW TABLES FROM data_jobs;
DESCRIBE data_jobs.skills_job_dim;





WITH core_skills AS (
    
    SELECT 
        sd.skill_id, 
        sd.type AS skill_type
    FROM 
        data_jobs.skills_dim AS sd 
    WHERE type IN ('programming', 'databases')
)
SELECT 
    cd.skill_type,
    COUNT(DISTINCT sjd.job_id) AS job_count
FROM 
    data_jobs.skills_job_dim AS sjd INNER JOIN core_skills AS cd
        ON sjd.skill_id = cd.skill_id
GROUP BY cd.skill_type 
ORDER BY job_count DESC;




/*
Why do we use DISTINCT here instead of just COUNT?

-the main reason is because of the skills_job_dim table
-this table countains multiple job_ids' and skill_ids'
- one job posting(job_id) can have multiple skills(skill_id) and vice versa
- if you count the amounf of job postings without DISTINCT, it will give you repeats of job_id
- remember we want for every skill_type(type), to count the amount of distinct(unique) jobs
