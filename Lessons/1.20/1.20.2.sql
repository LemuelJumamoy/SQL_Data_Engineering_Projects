/*
Problem Statement
Count the total number of job postings from December 2024, grouped by job title and whether a degree is mentioned. You will analyze these requirements by converting the Boolean degree flag into an Integer (0 or 1) to segment the data.
*/

SELECT 
    table_schema,
    table_name, 
    column_name,
    data_type
FROM information_schema.columns;
WHERE table_name = 'job_postings_fact'

SELECT  
    job_title_short,
    COUNT(job_id) AS job_postings,
    CAST(job_no_degree_mention AS INT) AS job_no_degree_mention

FROM job_postings_fact

WHERE CAST(job_posted_date AS DATE) BETWEEN '2024-12-01' AND '2024-12-31'

GROUP BY 
    job_title_short,
    job_no_degree_mention
ORDER BY 
    job_title_short,
    job_no_degree_mention;

/*
┌───────────────────────────┬──────────────┬───────────────────────┐
│      job_title_short      │ job_postings │ job_no_degree_mention │
│          varchar          │    int64     │         int32         │
├───────────────────────────┼──────────────┼───────────────────────┤
│ Business Analyst          │         1432 │                     0 │
│ Business Analyst          │          621 │                     1 │
│ Cloud Engineer            │          331 │                     0 │
│ Cloud Engineer            │          361 │                     1 │
│ Data Analyst              │         5473 │                     0 │
│ Data Analyst              │         4458 │                     1 │
│ Data Engineer             │         4389 │                     0 │
│ Data Engineer             │         4075 │                     1 │
│ Data Scientist            │         5028 │                     0 │
│ Data Scientist            │          746 │                     1 │
│ Machine Learning Engineer │          850 │                     0 │
│ Machine Learning Engineer │           49 │                     1 │
│ Senior Data Analyst       │          789 │                     0 │
│ Senior Data Analyst       │          568 │                     1 │
│ Senior Data Engineer      │         1061 │                     0 │
│ Senior Data Engineer      │          942 │                     1 │
│ Senior Data Scientist     │         1064 │                     0 │
│ Senior Data Scientist     │          171 │                     1 │
│ Software Engineer         │          910 │                     0 │
│ Software Engineer         │          799 │                     1 │
└───────────────────────────┴──────────────┴───────────────────────┘
  20 rows                                                3 columns


Learnings: 
Reminder that we don’t need to include the row/columns from the WHERE clause within the SELECT statement 
GROUP BY combinations: 
data_engineer(job_title) = TRUE = COUNT 2
data_engineer(job_title) = FALSE = COUNT 1
 
data_analyst(job_title) = TRUE = COUNT 1 
data_analyst(job_title) = FALSE = COUNT 2

ORDER BY: 
ORDER BY
    job_title_short,
    job_no_degree_mention;
 
- Sort all rows alphabetically by job_title_short 
- If two rows have the same job_title_short, then sort those rows by job_no_degree_mention

- SQL first put all Data Analyst rows together
- Within the Data Analyst rows, it sorted by job_no_degree_mention 
- Then it did the same for Data Engineer
