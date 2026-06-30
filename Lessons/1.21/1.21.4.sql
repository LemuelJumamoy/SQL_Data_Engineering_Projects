/*
Problem Statement
You are tasked with setting up the foundational fact table for a recruitment analytics system. 
You will create the applications_fact table to log every job application, defining strict data types and a unique primary key to ensure data integrity for downstream reporting.
*/

USE company_jobs;
SELECT current_database();

CREATE TABLE IF NOT EXISTS dev.applications_fact (
    application_id INT PRIMARY KEY,
    candidate_id INT,
    job_id INT, 
    data_applied DATE,
    application_status TEXT,
    internal_candidate BOOLEAN
    ) 
 ;

 SELECT * FROM dev.applications_fact;
 DESCRIBE dev.applications_fact;