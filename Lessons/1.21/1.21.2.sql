/*
Problem Statement
Clean up the database environment by removing the sql_problems database and establishing a new one dedicated to storing company job information.
*/

DROP DATABASE sql_problems;
SHOW DATABASES;
CREATE DATABASE IF NOT EXISTS company_jobs;
USE company_jobs;
