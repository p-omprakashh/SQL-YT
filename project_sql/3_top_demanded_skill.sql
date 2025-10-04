/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Focus on all job postings
- Why? Retrives the top 10 skills with the highest deman in the job market,
    providing insights into the most valuable skills job seekers.
*/


WITH jobs_per_skill AS 
    (SELECT 
    skill_id,
    COUNT(*) AS skill_count
    
FROM job_postings_fact
INNER JOIN skills_job_dim 
    ON job_postings_fact.job_id = skills_job_dim.job_id
WHERE 
    job_title_short = 'Data Analyst' 
GROUP BY
    skill_id    
)

SELECT 
    skills_dim.skill_id,
    jobs_per_skill.skill_count,
    skills AS skill_name

FROM 
    jobs_per_skill    
INNER JOIN
    skills_dim ON jobs_per_skill.skill_id = skills_dim.skill_id
ORDER BY
        jobs_per_skill.skill_count DESC
LIMIT 10;        


           