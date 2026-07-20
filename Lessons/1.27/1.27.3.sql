SELECT 
    job_id,
    job_title_short, 
    job_location, 
    job_posted_date,
    EXTRACT(Year FROM job_posted_date) AS job_posted_year,
    EXTRACT(Month FROM job_posted_date) AS job_posted_month, 
    EXTRACT(DAY FROM job_posted_date) AS job_posted_day, 
    EXTRACT(Quarter FROM job_posted_date) AS job_posted_qurater
FROM job_postings_fact 
WHERE 
    job_posted_date::DATE 
    BETWEEN '2023-01-01' AND '2024-12-31';
