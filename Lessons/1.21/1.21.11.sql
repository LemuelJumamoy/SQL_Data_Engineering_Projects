/*
PROBLEM:
Rename the applications fact table to indicate it specifically stores internal application data.
Updating the table name improves schema clarity for downstream users, and querying the system metadata will verify the change was successfully registered.
*/

USE company_jobs;

ALTER TABLE dev.applications_fact 
RENAME TO internal_applications_fact; -- sql already knows that application_fact table is in the dev schema 

SELECT table_catalog AS database, table_schema, table_name 
FROM information_schema.tables
WHERE table_schema = 'dev';