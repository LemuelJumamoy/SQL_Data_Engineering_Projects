 # HEADING 1 
 ## HEADING 2 
 ### HEADING 3

 Normal Text 
 **Bold Text**
 *Italics Text* 
 'This is code'

 - Bullet 1 
 - Bullet 2

 1. number 1 
 2. Number 2 

 [Link Text](https://google.com)

 ![Project 1 Overview](../Images\1_1_Project1_EDA.png)

 ```sql
SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    COUNT(jpf.*) AS demand_count

FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_work_from_home IS TRUE
    AND jpf.job_title_short = 'Data Engineer'
GROUP BY 
    sd.skills
HAVING
    COUNT(jpf.*) > 100
ORDER BY median_salary DESC
LIMIT 25;
 ```