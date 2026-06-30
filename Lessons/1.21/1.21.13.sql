/*
Problem Statement
Write an idempotent script that clears the internal_applications_fact table from your environment. 
We will no longer be using this table for the remainder of the course, and this is part of our data cleanup.
*/

USE company_jobs;

DROP TABLE IF EXISTS dev.internal_applications_fact;

SELECT * 
FROM information_schema.tables;