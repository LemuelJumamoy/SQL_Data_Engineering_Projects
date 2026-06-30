/*
Problem Statement
To streamline our database, we are deprecating columns that are no longer used for reporting.
Your objective for this schema cleanup is to permanently remove the internal_candidate column from the internal_applications_fact table.
*/


USE company_jobs;

SELECT *
FROM dev.internal_applications_fact;