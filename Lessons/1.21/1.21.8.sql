/*
Problem Statement
Rename the follow_up_timestamp column to follow_up_date in the applications fact table.
Since the column's data type was previously changed to store only dates, 
updating its name ensures the schema accurately reflects the data it holds and maintains clarity for downstream users.
*/

USE company_jobs;

ALTER TABLE dev.applications_fact
RENAME COLUMN follow_up_timestamp to follow_up_date;
SELECT * FROM dev.applications_fact;