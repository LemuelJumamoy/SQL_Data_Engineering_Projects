/*
Problem Statement: 
Calculate the total number of job postings for New Year's Eve in 2024. You will need to filter the data to include only postings from December 31, 2024, ensuring that the time component of the timestamp does not interfere with your selection.

*/

SELECT 
    table_schema, 
    table_name, 
    column_name, 
    data_type 
FROM information_schema.columns;

SELECT 
    COUNT(job_id) AS job_postings,
    CAST(job_posted_date AS DATE) AS dt
FROM job_postings_fact 
WHERE CAST(job_posted_date AS DATE) = '2024-12-31'
GROUP BY
    dt;

/*
┌──────────────┬────────────┐
│ job_postings │     dt     │
│    int64     │    date    │
├──────────────┼────────────┤
│         2736 │ 2024-12-31 │
└──────────────┴────────────┘

Learnings: 
- Had trouble with returning results because I needed to convert the values first in the where clause to change every date to DATE. The problem was that I did ‘WHERE = job_posted_date’ without converting it
- Also I i needed to group by dt which was the converted date not the job_posted_date
    - If i grouped by the job_posted_date, it would give me rows of job_postings because its gives me the count for every date thats not converted. (2024-12-31:variable times) 
    - if grouped by dt, it takes the date that has been converted, into one row
- Remember the Execution Order: 
    - FROM, WHERE/AND, SELECT, GROUP BY, ORDER, LIMIT
*/






    


