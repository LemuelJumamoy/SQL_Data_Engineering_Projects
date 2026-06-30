/*
Problem Statement
Simplify the applications fact table by converting the follow-up timestamp column to a date-only format. 
This schema update removes unnecessary time-level granularity, improving storage efficiency and consistency for daily reporting.
*/

USE company_jobs;
ALTER TABLE dev.applications_fact
ALTER COLUMN follow_up_timestamp TYPE DATE;

