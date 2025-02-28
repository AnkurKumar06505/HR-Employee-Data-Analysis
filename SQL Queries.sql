
--- What is the gender breakdown of employee in the company ? 
SELECT gender, COUNT(*) employee_count
from hr
where termdate = ''
group by gender;

---  What is the race/ethnicity breakdown of employees in the company ? 
Select race, count(*) as emp_count from hr
Where termdate = ''
Group by race
order by emp_count desc;
 
--- What is the age distribution of employees in the company ? 
SELECT CASE 
	WHEN age>=18 AND age<=24 then '18-24'
    WHEN age>=25 AND age<=34 THEN '25-34'
    WHEN age>=35 AND age<=44 THEN '35-44'
    WHEN age>=45 AND age<=54 THEN '45-54'
    WHEN age>=55 AND age<=64 THEN '55-64'
    ElSE '65+'
END AS Age_group, gender,
count(*) AS emp_count
FROM hr
WHERE termdate = '' AND age > 18
GROUP BY Age_group,gender
order by Age_group,gender;    


--- How many employees work at the headquarters versus remote locations ? 
select location, count(*) from hr
where termdate = ''
group by location;

--- What is the average length of the employment for the employees who have been terminated?

SELECT 
	round(avg(datediff(termdate,hire_date))/365,0) AS avg_length_employement_in_years
FROM hr
WHERE termdate <= curdate() AND termdate != '';

--- How does the gender distribution vary across departments and job titles ?

select department, jobtitle, gender, count(*) emp_count
from hr where termdate != '' 
group by department, jobtitle, gender
order by emp_count desc;


--- What is the distribution of job titles across the company ? 

SELECT jobtitle, count(*) AS emp_count from hr
WHERE termdate = ''
GROUP BY jobtitle
ORDER BY jobtitle DESC;

--- Which department has the highest termination rate ?
select department,
total_count,
termination_count,
termination_count/total_count as termination_rate
from 
(select department,
count(*) as total_count,
sum(case when termdate <> '' and termdate < curdate() then 1 else 0 end) as termination_count
from hr
group by department) as subquery
order by termination_rate desc

--- What is the distribution of employees across locations by city and state ?
select location_state as State,
location_city as City, count(*) as emp_count
from hr
where termdate != ''
group by location_state,location_city
order by emp_count desc;

--- How has the company s employee count changed over time based on hire and termination dates ?

SELECT year,
hires,
terminations,
hires - terminations AS net_change,
round((hires - terminations)/hires * 100,2) AS net_change_percent
from 
(select year(hire_date) AS year,
count(*) AS hires,
sum(CASE WHEN termdate <> ''AND termdate <= curdate() then 1 else 0 end) AS terminations
FROM hr
WHERE termdate != ''
GROUP BY YEAR(hire_date)
) AS subquery
ORDER BY year asc;


--- What is the tenure distribution for each department ?
SELECT department, 
round(AVG(datediff(termdate,hire_date))/365,0) AS avg_tenure 
FROM hr
WHERE termdate <= curdate() AND termdate != '' 
GROUP BY  department; 


