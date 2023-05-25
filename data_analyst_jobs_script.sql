SELECT * FROM data_analyst_jobs;

--Q1 # rows are the data_analyst_jobs table
-- 1793
SELECT COUNT(*)
FROM data_analyst_jobs;

--Q2 1st 10 rows
-- Exxon
SELECT * FROM data_analyst_jobs
LIMIT 10;

--Q3 # jobs in TN
-- 21
SELECT COUNT(title)
FROM data_analyst_jobs
WHERE location = 'TN';

--# jobs in TN or KY
-- 27 in KY\
-- 6 in KY
SELECT COUNT(title)
FROM data_analyst_jobs
WHERE location IN ('TN', 'KY');

--Q4 # jobs in TN with rating > 4
-- 3
SELECT COUNT(title)
FROM data_analyst_jobs
WHERE location = 'TN'
	AND star_rating > 4;

--Q5 # postings with review_count between 500 and 1k
-- 151
SELECT COUNT(title)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;

--Q6 avg star rating per state
-- Nebraska
SELECT location AS state, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
GROUP BY location
ORDER BY avg_rating DESC NULLS LAST;

--Q7 unique job titles and count
-- 881
SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs;

--Q8 unique titles per company in California
-- 230
SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE location = 'CA';

-- List of titles
SELECT title, COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE location = 'CA'
GROUP BY title;

--Q9 review count > 5k
-- 41
SELECT company,
		ROUND(AVG(star_rating),2) AS avg_rating,
		SUM(review_count) AS total_reviews
FROM data_analyst_jobs
	WHERE review_count > 5000
GROUP BY company;

SELECT company, AVG(star_rating)
FROM data_analyst_jobs
GROUP BY company
	HAVING SUM(review_count) > 5000;

--Q10 order #9 highest first
-- Gerneral Motors, 4.2 Rating
SELECT company,
		ROUND(AVG(star_rating),2) AS avg_rating,
		SUM(review_count) AS total_reviews
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY company
ORDER BY avg_rating DESC;

--Q11 all unique jobs with 'Analyst'
-- 774
SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%';

--Q12 title not including 'Analyst' or 'Analytics'
-- Tableua
SELECT title
FROM data_analyst_jobs
WHERE title NOT ILIKE '%Analyst%' 
	AND title NOT ILIKE '%Analytics%';
	
--BONUS
SELECT domain,
	COUNT(domain),
	COUNT(days_since_posting) AS number_jobs,
	(CASE WHEN days_since_posting > 21 THEN 'Hard to fill' 
	 	ELSE 'Easy to fill' END) as fill
FROM data_analyst_jobs
WHERE skill ILIKE '%SQL%'
	AND domain IS NOT NULL
GROUP BY domain, days_since_posting;

--BONUS class way
SELECT domain, COUNT(title) AS number_of_jobs
FROM data_analyst_jobs
WHERE days_since_posting > 21
	AND domain IS NOT NULL
	AND skill ILIKE '%SQL%'
GROUP BY domain
ORDER BY COUNT(title) DESC;
	








