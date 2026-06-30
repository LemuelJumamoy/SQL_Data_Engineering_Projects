/*
Problem Statement
Update the core applications fact table by adding a new column to track when follow-up actions occur.
This new column will store time-zone-aware timestamps to accurately log application events for downstream analytics.
*/

USE company_jobs;

ALTER TABLE dev.applications_fact
ADD follow_up_timestamp TIMESTAMPTZ;

SELECT * FROM dev.applications_fact;