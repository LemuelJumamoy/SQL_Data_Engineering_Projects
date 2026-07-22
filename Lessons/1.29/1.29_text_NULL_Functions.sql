SELECT LENGTH('SQL');

SELECT LOWER('SQL');

SELECT UPPER('SQL');

SELECT LEFT('SQL', 2);

SELECT SUBSTRING('SQL', 2, 1);

SELECT 'SQL' || '-' || 'Functions';

SELECT TRIM(' SQL '); 

SELECT REPLACE('SQL', 'Q', '-');

-- Final Example - Cleanup this using Text Functions

WITH title_lower AS (
    SELECT 
        job_title, 
        LOWER(TRIM(job_title)) AS job_title_clean
    FROM job_postings_fact)

SELECT 
    job_title,
    CASE 
        WHEN job_title_clean LIKE '%data%'
          AND job_title_clean LIKE '%analysts%' THEN 'data analyst'
        WHEN job_title_clean LIKE '%data%'
          AND job_title_clean LIKE '%scientist%' THEN 'data scientist'
        WHEN job_title_clean LIKE '%data%'
          AND job_title_clean LIKE '%engineer%' THEN 'data engineer'
        ELSE 'Other'
    END AS job_title_category 
FROM title_lower 
ORDER BY RANDOM()
LIMIT 30;


-- NULLIF (Returns NULL if values are equal)
SELECT NULLIF(10, 10) --> NULL;
SELECT NULLIF(10,20) --> 10
SELECT NULLIF('apple', 'orange')-->'apple'
SELECT NULLIF(5+5,10);

SELECT 
    NULLIF(salary_year_avg, 0),
    NULLIF(salary_hour_avg, 0)
FROM 
    job_postings_fact 
WHERE salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL
ORDER BY salary_year_avg 
LIMIT 10;

--COALESCE (Returns first non_NULL value)
COALESCE(NULL,'A','B') --> 'A'
COALESCE(NULL, NULL, '100') --> 100
COALESCE('First', NULL, 'Second') --> 'First'

SELECT 
    NULLIF(salary_year_avg, 0),
    NULLIF(salary_hour_avg, 0)
FROM 
    job_postings_fact 
WHERE salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL
ORDER BY salary_year_avg 
LIMIT 10;

SELECT 
  salary_year_avg, 
  salary_hour_avg,
  COALESCE(salary_year_avg, salary_hour_avg * 2080)
  
FROM 
    job_postings_fact 
WHERE salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL 
LIMIT 10;

-- Final Example - Simplify with Coalesce 


SELECT 
    job_title_short, 
    salary_year_avg, 
    salary_hour_avg,
    COALESCE(salary_year_avg, salary_hour_avg * 2080) AS standardized_salary,
    CASE 
        WHEN COALESCE(salary_year_avg, salary_hour_avg * 2080) IS NULL THEN 'Missing' -- returns salary, but if its null, then salary_hour_avg * 2080 to find it. If that is null then missing
        WHEN COALESCE(salary_year_avg, salary_hour_avg * 2080) < 75000 THEN 'Low'
        WHEN COALESCE(salary_year_avg, salary_hour_avg * 2080) < 150000 THEN 'Mid'
        ELSE 'High'
    END AS salary_bucket 
FROM job_postings_fact
ORDER BY standardized_salary DESC; 