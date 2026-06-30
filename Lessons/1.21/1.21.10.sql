/*
Problem Statement
Update the internal candidate status for specific job applications to reflect recent hiring changes.
Modifying these records ensures the database accurately identifies internal applicants for downstream reporting and tracking.
*/

UPDATE dev.applications_fact 
SET internal_candidate = TRUE
WHERE application_id = 1;

UPDATE dev.applications_fact 
SET internal_candidate = TRUE
WHERE application_id = 3;

SELECT * FROM dev.applications_fact;