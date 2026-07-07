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

-- The SELECT 1 is saying "i don't care what value you return. I only care whether at least one row exists"
-- The TGT table is the outter query and the SRC table is the subquery

SELECT * 
FROM job_postings_fact AS tgt
WHERE NOT EXISTS ( -- checks which primary keys are not matching in different tables
    SELECT 1
    FROM skills_job_dim AS src 
    WHERE tgt.job_id = src.job_id
)
ORDER BY job_id ;
