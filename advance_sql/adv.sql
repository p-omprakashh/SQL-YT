SELECT job_posted_date
FROM job_postings_fact
LIMIT 100;

SELECT
    '2023-02-19':: DATE,
    '123':: INTEGER,
    'true':: BOOLEAN,
    '3.14' REAL;

SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date,
    EXTRACT(MONTH FROM job_posted_date) AS date_month,
    EXTRACT(YEAR FROM job_posted_date) AS date_year
FROM 
    job_postings_fact
LIMIT 5;   


SELECT
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS date_month
FROM
    job_postings_fact
WHERE
        job_title_short = 'Data Analyst'    
GROUP BY
    date_month
ORDER BY
    job_posted_count DESC;    

SELECT  
    job_posted_date:: DATE
FROM   job_postings_fact;  

SELECT job_posted_date
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date ) = 1
LIMIT 5;

CREATE TABLE january_job AS 
    SELECT job_posted_date
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date ) = 1;


CREATE TABLE february_jobs AS 
    SELECT job_posted_date
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_jobs AS 
    SELECT job_posted_date
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 3;


/* New York,NY -LOCAL
   Anywhere    -REMOTE
   ELSE        -onsite*/  

SELECT 
    COUNT(job_id) AS no_of_jobs,
    CASE
        WHEN job_location = 'New York, NY' THEN 'Local'
        WHEN job_location = 'Anywhere' THEN 'Remote'
        ELSE 'Onsite'
    END AS job_work_category
FROM 
    job_postings_fact
WHERE job_title_short = 'Data Analyst'    
GROUP BY 
    job_work_category;    

SELECT
   job_no_degree_mention
FROM 
    job_postings_fact
WHERE job_no_degree_mention = true;    


SELECT 
    company_id,
    name AS company_name
FROM company_dim
WHERE company_id IN (
SELECT
    company_id
FROM 
    job_postings_fact
WHERE job_no_degree_mention = true   
ORDER BY
company_id) ;   


WITH company_job_count AS (
SELECT 
    company_id,
    COUNT(*) AS total_jobs
FROM job_postings_fact
GROUP BY 
    company_id
)

SELECT 
    company_dim.name AS comapany_name,
    company_job_count.total_jobs
FROM company_dim
LEFT JOIN company_job_count ON
    company_dim.company_id = company_job_count.company_id
ORDER BY  
    total_jobs DESC  ;

SELECT skill_id
FROM skills_dim;

SELECT *
FROM skills_job_dim;

SELECT * 
FROM skills_job_dim
LIMIT 10;

SELECT * 
FROM skills_dim
LIMIT 10;


WITH remote_jobs_skills AS 
(SELECT 
     skills_dim.skill_id,
    COUNT(skills_dim.skill_id) AS skill_count,
    skills_dim.skills
    
FROM(SELECT * 
    FROM skills_job_dim
    INNER JOIN job_postings_fact ON
    job_postings_fact.job_id = skills_job_dim.job_id
    WHERE job_postings_fact.job_work_from_home = true)

INNER JOIN (skills_job_dim
ON skills_job_dim.skill_id = skills_dim.skill_id 
GROUP BY 
    skills_dim.skill_id
  
) 
SELECT *
FROM remote_jobs_skills
INNER JOIN 
    skill_dim ON
    skill_dim.skill_id = remote_jobs_skills.skill_id
        ;

WITH job_skill_count AS (
SELECT
    skill_id,
    count(*) as skill_count
FROM 
    skills_job_dim
INNER JOIN 
    job_postings_fact ON 
        job_postings_fact.job_id = skills_job_dim.job_id
WHERE 
    job_postings_fact.job_work_from_home = True AND
    job_postings_fact.job_title_short = 'Data Analyst'
GROUP BY
    skill_id
)

SELECT
    skills_dim.skill_id,
    skills AS skill_name,
    skill_count
FROM
    job_skill_count
INNER JOIN 
    skills_dim ON skills_dim.skill_id = job_skill_count.skill_id
ORDER BY 
    job_skill_count.skill_count DESC
LIMIT 5;

SELECT
    *
FROM january_job
    
UNION ALL

SELECT
    *
FROM 
    february_jobs









SELECT
    job_id,
    job_title_short,
    job_posted_date::DATE,
    salary_year_avg,
    job_via
FROM
    job_postings_fact
WHERE 
    EXTRACT(MONTH FROM job_posted_date) < 4 AND
    salary_year_avg > 70000 AND
    job_title_short = 'Data Analyst'    
ORDER BY salary_year_avg DESC
               


