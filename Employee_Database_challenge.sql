------------------------------------------------------------------------------------------------------------
------------------Deliverable 1: The Number of Retiring Employees by Title----------------------------------
------------------------------------------------------------------------------------------------------------

--1 : Retrieve the emp_no, first_name, and last_name columns from the Employees table.
select emp_no,first_name,last_name from employees ;

--2 : Retrieve the title, from_date, and to_date columns from the Titles table.
select title, from_date, to_date from titles ;

--3-4-5-6-7 : Export the Retirement Titles table from the previous step as retirement_titles.csv and save it to your Data folder in the Pewlett-Hackard-Analysis folder.
select 		emp.emp_no,emp.first_name,emp.last_name,tit.title, tit.from_date, tit.to_date
INTO   		retirement_titles
from        employees	AS emp
INNER JOIN 	titles 		AS tit
        ON 	(emp.emp_no = tit.emp_no)
	 WHERE 	(emp.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
  ORDER By	emp.emp_no;

Select * from retirement_titles;

--8-9-10-11-12-13-14 : Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO retirement_unique_titles
FROM retirement_titles 
ORDER BY emp_no asc , to_date desc;

Select * from retirement_unique_titles;

--15-16-17-18-19 : Number of employees by their most recent job title who are about to retire.
Select count(1) count, title
Into retiring_titles
from retirement_unique_titles
group by title
order by count desc;

------------------------------------------------------------------------------------------------------------
-----------------------Deliverable 2: The Employees Eligible for the Mentorship Program---------------------
------------------------------------------------------------------------------------------------------------

--1 : Retrieve the emp_no, first_name, last_name, and birth_date columns from the Employees table.
select	emp.emp_no,emp.first_name,emp.last_name
from	employees	AS emp
WHERE 	(emp.birth_date BETWEEN '1965-01-01' AND '1965-12-31');

select * from dept_emp
select dep.from_date,dep.to_date ;

--3 : Retrieve the title column from the Titles table.
Select title from titles;

--4-5-6-7-8-9- :The Employees Eligible for the Mentorship Program

select		DISTINCT ON (emp.emp_no) emp.emp_no,
			emp.first_name,emp.last_name,
			dep.from_date,dep.to_date,
			tit.title
Into mentorship_eligibilty
from		employees	AS emp
INNER JOIN 	dept_emp AS dep
		ON 	(emp.emp_no = dep.emp_no)
LEFT JOIN 	titles AS tit
		ON 	(emp.emp_no = tit.emp_no)
WHERE 		dep.to_date = ('9999-01-01')
AND			(emp.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
Order by    emp.emp_no asc;


SELECT * from mentorship_eligibilty;

------------------------------------------------------------------------------------------------------------
-------------------------------------------Summary-----------------------------------------------
------------------------------------------------------------------------------------------------------------
select count(title) count_title, title
from mentorship_eligibilty
group by title
order by count_title desc;


select count(mentorship_eligibilty.title) count_eligible, retiring_titles.title,
retiring_titles.count
from mentorship_eligibilty
RIGHT JOIN 	retiring_titles 
on (mentorship_eligibilty.title=retiring_titles.title)
group by retiring_titles.title,retiring_titles.count
order by retiring_titles.count desc;
