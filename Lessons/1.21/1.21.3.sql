/*
Problem Statement
In this exercise, you will practice managing database namespaces by creating and deleting schemas using Data Definition Language (DDL) commands.
 You will then verify your structural changes by querying the database's internal metadata.
*/

USE company_jobs;
CREATE SCHEMA IF NOT EXISTS staging;

SELECT current_database();

SELECT catalog_name, schema_name
FROM information_schema.schemata
WHERE schema_name = 'staging';

/*
┌──────────────┬─────────────┐
│ catalog_name │ schema_name │
│   varchar    │   varchar   │
├──────────────┼─────────────┤
│ company_jobs │ staging     │
│ jobs_mart    │ staging     │
└──────────────┴─────────────┘
- there is a staging scehma in the data_jobs database
*/



DROP SCHEMA staging;

CREATE SCHEMA IF NOT EXISTS dev;  

SELECT * FROM information_schema.schemata WHERE catalog_name = 'company_jobs';
/*
┌──────────────┬─────────────┬──────────────┬───────────────────────────────┬──────────────────────────────┬────────────────────────────┬──────────┐
│ catalog_name │ schema_name │ schema_owner │ default_character_set_catalog │ default_character_set_schema │ default_character_set_name │ sql_path │
│   varchar    │   varchar   │   varchar    │            varchar            │           varchar            │          varchar           │ varchar  │
├──────────────┼─────────────┼──────────────┼───────────────────────────────┼──────────────────────────────┼────────────────────────────┼──────────┤
│ company_jobs │ dev         │ duckdb       │ NULL                          │ NULL                         │ NULL                       │ NULL     │
│ company_jobs │ main        │ duckdb       │ NULL                          │ NULL                         │ NULL                       │ NULL     │
└──────────────┴─────────────┴──────────────┴───────────────────────────────┴──────────────────────────────┴────────────────────────────┴──────────┘
- the dev scehma within the company_jobs database is used for development work 