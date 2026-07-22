-- Classify Job postings into: 
    -- remote, global, onsite 

WITH clean_job_location AS (
    SELECT 
        job_id,
        LOWER(TRIM(job_location)) AS job_location
    FROM job_postings_fact
)

SELECT 
    job_id, 
    job_location,
    CASE
        WHEN job_location LIKE '%remote%' or job_location LIKE '%anywhere' THEN 'Remote'
        WHEN NULLIF(job_location,'') IS NULL THEN 'Global' 
        ELSE 'On-site/Hybrid'
    END AS location_category 
FROM clean_job_location;

