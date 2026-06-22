# Exploratory Data Analysis w/SQL: Job Market Analysis

![Project 1 Overview](../Images/1_1_Project1_EDA.png)

A SQL project analysing the data engineer job market using real world job posting data. It demonstrates my ability to **write production-quality analytical SQL, design efficient queries, and turn business questions into data-driven insights**.

## Executive Summary 
- **Project scope** Built **3 analytical queries** that answer key questions about the data engineer job market 
- **Data modeling:** Used **multi-table joins** across fact and dimension tables to extract insights 
- **Analytics:** Applied **aggregations, filtering, and sorting** to find top skills by demand, salary, and overall value 
- **Outcomes:** Delivered **actionable insights** on SQL/Python dominance, cloud trends, and salary patterns

If you only have a minute, review these: 
1. [`01_top_demanded_skills.sql`](../1_EDA\01_top_demanded_skills.sql) - demand analysis with multi-table joins
2. [`02_highest_paying_skills.sql`](../1_EDA\02_highest_paying_skills.sql) - salary analysis with aggregations
3. [`03_optimal_skills.sql`](../1_EDA\03_optimal_skills.sql) - combined demand/salary optimization query

## Problem & Context 

Job Market analysts need to answer questions like: 
- **Most in-demand:** *Which skills are most in-demand for data engineers?*
- **Highest paid:** *Which skills command the highest salaries?*
- **Best trade-off:** *What is the optimal skill set balancing demand and compensation?*

This project analyzes a **data warehouse** built using a star schema design. The warehouse structure consists of: 

![Data Warehouse](../Images/1_2_Data_Warehouse.png)

- **Fact table:** `job_postings_fact` -Central table containing job postings details (job titles, locations, salaries, dates, etc.)
- **Dimension Tables:**
    - `company_dim` - Company infromation linked to job postings 
    - `skills_dim` - Skills catalog with skill names and types 
    - **Bridge Table:** `skills_job_dim` Resolves the many-to-many relationship between job postings and skills

    By querying across these interconnected tables, I extracted insights about skill demand, salary patterns, and optimal skill combinations for data engineering roles

## Tech Stack 
- **Query Engine:** DuckDB for fast OLAP-style analytical queries 
- **Language:** SQL (ANSI-style with analytical functions)
- **Data Model:** Star schema with fact + dimension + bridge tables 
- **Development:** VS Code for SQL editing + Terminal for DuckDB CLI
- **Version Control:** Git/GitHub for versioned SQL scripts 

## Analysis Overview 

1. **[Top Demanded Skills](./01_top_demanded_skills.sql)** - Identifies the 10 most in-demand skills for remote data engineer postions
2. **[Top Paying Skills](./02_top_paying_skills.sql)** - Analyzes the 25 highest-paying skills with salary and demand metrics 
3. **[Optimal Skills](./03_optimal_skills.sql)** - Calculates an optimal score using natural log of demand combined with median salary to identify the most valuable skills to learn

### Key Insights 
- Core languages: SQL and Python each appear in ~29,000 job postings, making them the most demanded skills 
- Cloud platforms: AWS and Azure are critical for modern data engineering roles-
- Infra & tooling: Kubernetes, Docker, and Terraform are associated with premium salaries 
- Big data tools: Apache Spark shows strong demand with competitve compensation

## SQL Skills Demonstrated

- **Complex Joins**: Multi-table `INNER JOIN` 
operations across `job_postings`, 
`skills_job_dim`, and `skills_dim`
- **Aggregations**: Boolean logic with `WHERE` clauses and multiple conditions 
(`job_title_short`, `job_work_from_home`, `salary_year_avg IS NOT NULL`) 
- **Sorting & Limiting**: `ORDER BY` with `DESC` and `Limit` for top-N analysis

### Data Analysis Techniques 

- **Groupings**: `Group By` for categorical analysis by skill 
- **Conditional Logic**: `CASE WHEN` statements for derived metrics 
- **Mathematical Functions** `LN()` for natural logrithm transfromation to normalize demand metrics 
- **Calcualted Metrics**: Derived optimal score combining log-transformed dmand with media salary 
- **Having Clause**: Filtering aggregated results(skills with >= 100 postings)
- **NULL Handeling**: Proper filtering of incomplete records (`salary_year_avg IS NOT NULL`)
