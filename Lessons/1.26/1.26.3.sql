SELECT 
    cd.name AS company_name,
    COUNT(jpf.job_id) AS job_count,
    CASE 
        WHEN COUNT(jpf.job_id) >= 100 THEN '100+ WFH DE Jobs'
        WHEN COUNT(jpf.job_id) >= 50  THEN '50-100 WFH DE Jobs'
        WHEN COUNT(jpf.job_id) >= 25  THEN '25-49 WFH DE Jobs'
        WHEN COUNT(jpf.job_id) >= 0  THEN 'Less than 25 WFH DE Jobs'
    END AS WDF_DE_Job_Category
    
FROM 
    job_postings_fact AS jpf 
    INNER JOIN company_dim AS cd 
        ON jpf.company_id = cd.company_id 
WHERE 
    jpf.job_work_from_home IS TRUE 
    AND jpf.job_title_short = 'Data Engineer'
GROUP BY 
    cd.name 
HAVING 
    COUNT(jpf.job_id) BETWEEN 50 AND 100
    
ORDER BY job_count DESC;