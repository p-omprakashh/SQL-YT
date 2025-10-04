/*
Question : What skills are required for the top-paying data nalyst jobs?
- Use the top 10 highest paying Data Analyst jobs from the first query
- Add the specific skills required for this role
-WHY? It provides a detailed look at which high paying jobs demand certain skills,
      helping job seekers understand which skills to develop that align with top salaries
*/



WITH top_job_salaries AS
(SELECT
    job_postings_fact.job_id,
    job_postings_fact.job_title,
    job_postings_fact.salary_year_avg,
   company_dim.name AS company_name
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
 )

SELECT  top_job_salaries.*,
        skills_dim.skills AS skill_name
FROM 
    top_job_salaries
INNER JOIN skills_job_dim ON top_job_salaries.job_id = skills_job_dim.job_id  
INNER JOIN skills_dim ON   skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
    top_job_salaries.salary_year_avg DESC



































































