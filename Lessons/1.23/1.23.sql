-- Subquery 
SELECT * 
FROM (
    SELECT * 
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL 
        OR salary_hour_avg IS NOT NULL
) AS valid_salaries -- good practice to provide Alias for subquery 
LIMIT 10;

--CTE
WITH valid_salaries AS ( 
    SELECT * 
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL 
        OR salary_hour_avg IS NOT NULL
)
SELECT * 
FROM valid_salaries
LIMIT 10;

-- Scenario 1 -- Subquery in 'SELECT'
-- Show each job's salary nect to the overall market media: 

SELECT
    job_title_short, 
    salary_year_avg,
    (
        SELECT MEDIAN(salary_year_avg)
        FROM job_postings_fact 
    )   AS market_median_salary
FROM job_postings_fact 
WHERE salary_year_avg IS NOT NULL 
LIMIT 10;

-- Scenario 2 -- Subquery in FROM 
-- Stage Only jobs that are remote before aggregating to determine the remote median salary per job

SELECT
    job_title_short, 
    MEDIAN(salary_year_avg) AS median_salary, -- this outter query is affected by the where clause
    (
        SELECT MEDIAN(salary_year_avg) -- this query is not 
        FROM job_postings_fact
        WHERE job_work_from_home = TRUE
    )   AS market_remote_median_salary
FROM (
    SELECT 
        job_title_short, 
        salary_year_avg
        FROM job_postings_fact 
        WHERE job_work_from_home = TRUE
    ) AS clean_jobs
    WHERE salary_year_avg IS NOT NULL -- aggregate functions such as median, avg, sum, and count ignore null values so we can remove this
    GROUP BY job_title_short
    LIMIT 10;

-- Scenario 3 -- Subquery in Having 
-- Keep only job titles whose median salary is above the overall median
-- Its good to execute the subqueries first before implementing them into the overall query 

SELECT
    job_title_short, 
    MEDIAN(salary_year_avg) AS median_salary, -- this outter query is affected by the where clause
    (
        SELECT MEDIAN(salary_year_avg) -- this query is not affected -- also this has to be a single value(aggregate)
        FROM job_postings_fact
        WHERE job_work_from_home = TRUE
    )   AS market_remote_median_salary
FROM (
    SELECT 
        job_title_short, 
        salary_year_avg
        FROM job_postings_fact 
        WHERE job_work_from_home = TRUE
    ) AS clean_jobs
WHERE salary_year_avg IS NOT NULL -- aggregate functions such as median, avg, sum, and count ignore null values so we can remove this
GROUP BY job_title_short
HAVING MEDIAN(salary_year_avg) > (
    SELECT MEDIAN(salary_year_avg)
    FROM job_postings_fact
    WHERE job_work_from_home = TRUE
    )
    LIMIT 10;

-- CTEs Common Table Expressions which is a temporary result set that you can reference within: 
    -- FROM: used like a table 
    -- JOIN
    -- OTHER CtEs: later CTE;s can reference earlier ones 
    -- SELECT/INSERT/UPDATE/DELETE: main statement 
-- WITH is used to define CTE at the beginning of a query

-- CTE Example
-- Compare how much more (or less) remote roles pay compared to onsite roles for each job title
-- USE a CTE to calculate the median salary by title and work arrangement, then compare those medians

WITH title_median AS (
    SELECT 
        job_title_short, 
        job_work_from_home,
        MEDIAN(salary_year_avg)::INT AS median_salary
    FROM job_postings_fact 
    WHERE job_country = 'United States'
    GROUP BY 
        job_title_short, 
        job_work_from_home
)

SELECT 
   r.job_title_short, 
   r.median_salary AS remote_median_salary,
   o.median_salary AS onsite_medium_salary,
   (r.median_salary - o.median_salary) AS remote_premium
FROM title_median AS r
INNER JOIN title_median AS o 
    ON r.job_title_short = o.job_title_short
WHERE r.job_work_from_home = TRUE
    AND o.job_work_from_home = FALSE
ORDER BY remote_premium DESC;

-- WHERE EXISTS

SELECT * 
FROM range(3) AS src(key);

SELECT * 
FROM range(2) AS src(key);

SELECT * 
FROM range(3) AS src(key)
WHERE EXISTS (
    SELECT 1
    FROM range(2) AS tgt(key)
    WHERE tgt.key = src.key
);

SELECT * 
FROM range(3) AS src(key)
WHERE NOT EXISTS (
    SELECT 1 -- dosn't really matter
    FROM range(2) AS tgt(key)
    WHERE tgt.key = src.key
);
/* FROM range(3), get out range(2), than look in that range(2) 
 WHERE the target key matches or does not match the source key
*/

-- Final Example
-- Identify job postings that have no associated skills before loading them into a data mart
SELECT * 
FROM job_postings_fact 
ORDER BY job_id 
LIMIT 10;

SELECT * 
FROM skills_job_dim
ORDER BY job_id 
LIMIT 40;

SELECT * 
FROM job_postings_fact AS tgt
WHERE NOT EXISTS ( -- checks which primary keys are not matching in different tables
    SELECT 1
    FROM skills_job_dim AS src 
    WHERE tgt.job_id = src.job_id
)
ORDER BY job_id ;

