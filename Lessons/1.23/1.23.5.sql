
-- High Job Volume
-- for every job_country Having (Counts of jobs > the global average job count per country) 

SELECT 
    jpf.job_id, 
    jpf.job_title_short, 
    jpf.job_location
FROM 
    data_jobs.job_postings_fact AS jpf
WHERE jpf.job_country IN (
    SELECT 
        job_country
    FROM 
        data_jobs.job_postings_fact
    GROUP BY 
        job_country
    HAVING 
        COUNT(job_id) > (
            SELECT AVG(country_count)
            FROM (
                SELECT COUNT(job_id) AS country_count
                FROM data_jobs.job_postings_fact
                GROUP BY job_country
        ) AS country_counts
    )
)
ORDER BY
    jpf.job_country, jpf.job_id;


DESCRIBE data_jobs.job_postings_fact;

/*
- while you need to always have a group by if there is an aggregate in the select statment, you don't have to put the the group by column in the select statement 
- you cannot have a table name within a select statement. You have to mention the direct column or alias from that column you are pulling from.
*/

SELECT 
    jpf.job_id,
    jpf.job_title_short, 
    jpf.job_location
FROM data_jobs.job_postings_fact AS jpf
WHERE jpf.job_country IN (
    SELECT jpf.job_country 
    FROM data_jobs.job_postings_fact AS jpf
    GROUP BY jpf.job_country 
    HAVING 
        COUNT(job_id) > (
            SELECT AVG(country_count)
            FROM ( 
                SELECT COUNT(job_id) AS country_count
                FROM data_jobs.job_postings_fact
                GROUP BY job_country
            )
        )

)

ORDER BY 
    jpf.job_country,
    jpf.job_id;