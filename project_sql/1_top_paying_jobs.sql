/*
Question: What are the top paying Data Aanalyst jobs?
- Identify the top 10 data analyst roles that are available remotely
-Focus on job postings with specified salaries (remove nulls).
Why? Highlight the top-paying opportunities for data analyst, offering insights 


*/


SELECT
    job_postings_fact.job_id,
    job_postings_fact.job_title,
   company_dim.name AS company_name,
    job_postings_fact.job_location,
    job_postings_fact.salary_year_avg,
    job_postings_fact.job_schedule_type

FROM 
    job_postings_fact   
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id  
WHERE 
    job_location = 'Anywhere' AND
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL  
ORDER BY 
    salary_year_avg DESC    
LIMIT 10        








































