USE data_jobs;

DESCRIBE job_postings_fact;

SELECT 
    COUNT(DISTINCT 
        CASE  
          WHEN jpf.job_work_from_home IS TRUE THEN company_id END) AS wfh_companies,
    COUNT(DISTINCT 
        CASE 
            WHEN jpf.job_work_from_home IS FALSE THEN company_id END) AS non_wfh_companies
FROM job_postings_fact AS jpf;
