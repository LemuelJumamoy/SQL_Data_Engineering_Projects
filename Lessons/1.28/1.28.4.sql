SELECT * FROM work_mode_mart.remote_jobs
UNION ALL
SELECT * FROM work_mode_mart.not_remote_jobs
ORDER BY 
    job_location,
    company_id, 
    job_title;