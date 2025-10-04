/*Question : Waht are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
-Focus on roles with specified salaries, regardless of location
-Why? It reveals how different skills impact salary levels for Data Analyst and 
    helps identify the most financially rewarding skills to acquire or improve*/






SELECT 
    ROUND(AVG(salary_year_avg),0) AS avg_salary,
    skills_dim.skills AS skill_name
FROM   job_postings_fact
INNER JOIN 
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id 
WHERE
       salary_year_avg IS NOT NULL AND
       job_work_from_home = true AND
       job_title_short = 'Data Analyst'
GROUP BY
skills_dim.skills
ORDER BY
    avg_salary DESC
LIMIT 25 ;   
  
