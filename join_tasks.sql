
/* 1. Write a query in SQL to display the first name, last name, department number, 
and department name for each employee. */
select e.first_name, d.department_id ,d.department_name
from employees e
join departments d
    on e.department_id = d.department_id;

/* 2. Write a query in SQL to display the first and last name, department, 
city, and state province for each employee. */
select e.first_name,d.department_name,l.city,l.state_province
from employees e
join departments d
     on e.department_id = d.department_id
join locations l
     on d.location_id = l.location_id;

/* 3. Write a query in SQL to display the first name, last name, salary, and 
job grade for all employees. */
select * from jobs;

select e.first_name,e.salary,(j.max_salary - j.min_salary) as job_grade
from employees e
join jobs j 
    on e.job_id = j.job_id;


/* 4. Write a query in SQL to display the first name, last name, department number 
and department name, for all employees for departments 80 or 40. */
select e.first_name, e.department_id, d.department_name
from employees e
join departments d
    on e.department_id = d.department_id 
where d.department_id = 40 or d.department_id = 80;

/* 5. Write a query in SQL to display those employees who contain a letter z to 
their first name and also display their last name, department, city, and state province. */
select e.first_name,e.last_name, d.department_name,l.state_province
from employees e
join departments d
     on e.department_id = d.department_id
join locations l
     on d.location_id = l.location_id
where lower(e.first_name) like '%z%';

/* 6. Write a query in SQL to display all departments including those where does 
not have any employee. */
-- employees departments
select e.employee_id, d.department_id
from employees e
right join departments d
        on e.department_id = d.department_id;


/* 7. Write a query in SQL to display the first and last name and salary for those 
employees who earn less than the employee earn whose number is 182. */
select e.first_name,e.last_name, e.salary 
from employees e
join employees e1
    on   e1.employee_id =182 and e.salary< e1.salary ;


/* 8. Write a query in SQL to display the first name of all employees including 
the first name of their manager. */
select e.employee_id , e.first_name, m.manager_id, m.first_name
from employees e
join employees m
    on e.manager_id = m.employee_id;

/* 9. Write a query in SQL to display the department name, city, and state 
province for each department. */
select d.department_name,l.state_province,l.city
from employees e
join departments d
     on e.department_id = d.department_id
join locations l
     on d.location_id = l.location_id;

select * from locations;

/* 10. Write a query in SQL to display the first name, last name, department number 
and name, for all employees who have or have not any department. */
select e.first_name, d.department_id, d.department_name
from employees e
left join departments d
        on e.department_id = d.department_id;

/* 11. Write a query in SQL to display the first name of all employees and the 
first name of their manager including those who does not working under any manager. */
select  e.first_name as emp_name, m.first_name as man_name
from employees e
right join employees m
    on e.manager_id = m.employee_id
order by e.first_name nulls first;

/* 12. Write a query in SQL to display the first name, last name, and department 
number for those employees who works in the same department as the employee who holds the last name as Taylor. */
select e.first_name,e.last_name, d.department_id, d.department_name
from employees e
join departments d
        on e.department_id = d.department_id
where d.department_id in (select department_id from employees where e.last_name = 'Taylor');
--eyni netice ,hansi daha duz?
select e.first_name,e.last_name, d.department_id, d.department_name
from employees e
join departments d
        on e.department_id = d.department_id
where e.last_name = 'Taylor';

/* 13. Write a query in SQL to display the job title, department name, full name 
(first and last name ) of employee, and starting date for all the jobs which started 
on or after 1st January, 1993 and ending with on or before 31 August, 1997 */
select j.job_id,e.first_name || ' ' || e.last_name as full_name,
d.department_id, d.department_name , jh.start_date
from employees e
join departments d
        on e.department_id = d.department_id
join job_history jh
     on e.employee_id = jh.employee_id
join jobs j
     on jh.job_id = j.job_id
where jh.start_date >= to_date('01-jan-93','dd-mon-yy') and jh.end_date <= to_date('31-aug-97','dd-mon-yy');

select sysdate from dual;
select start_date, end_date from job_history; -- cedvelde 1993 ve 1997 tarixleri yoxdur

/* 14. Write a query in SQL to display job title, full name (first and last name ) 
of employee, and the difference between maximum salary for the job and salary of the employee. */ --natural join
select j.job_title, e.first_name || ' ' || e.last_name as full_name,
(j.max_salary - e.salary) as diff
from employees e
natural join jobs j;

/* 15. Write a query in SQL to display the name of the department, average salary
and number of employees working in that department who got commission. */
select d.department_name,avg(e.salary),count(e.employee_id)
from employees e
join departments d
     on e.department_id = d.department_id
where e.commission_pct is not null
group by d.department_name;

/* 16. Write a query in SQL to display the full name (first and last name ) of employees, 
job title and the salary differences to their own job for those employees who is working in the department ID 80. */
select e.first_name || ' ' || e.last_name,e.department_id ,j.job_title, e.salary
from employees e
join jobs j
    on j.job_id = e.job_id 
where e.department_id = 80;

/* 17. Write a query in SQL to display the name of the country, city, and the departments which are running there. */
--Note: This also works using JOIN and USING on the common columns.
select c.country_name, l.city, d.department_id 
from departments d
join locations l using (location_id)
join countries c using (country_id);

/* 18. Write a query in SQL to display department name and the full name (first and last name) of the manager. */
select m.first_name || ' ' || m.last_name, d.department_name
from employees m 
join employees e 
    on m.employee_id = e.manager_id
join departments d 
    on e.department_id = d.department_id;


/* 19. Write a query in SQL to display job title and average salary of employees. */
select j.job_title , avg(e.salary) 
from employees e
join jobs j using(job_id)
group by j.job_title;

/* 20. Write a query in SQL to display the details of jobs which was done by any 
of the employees who is presently earning a salary on and above 12000. */
select * from jobs 
join employees 
using(job_id)
where salary > 12000;

/* 21. Write a query in SQL to display the country name, city, and number of those 
departments where at least 2 employees are working. */
select c.country_name, l.city, count(d.department_id)
from departments d
join locations l using (location_id)
join countries c using (country_id)
where d.department_id in (select department_id from employees group by department_id having count(employee_id)>=2)
group by c.country_name, l.city;


/* 22. Write a query in SQL to display the department name, full name (first and last name) 
of manager, and their city. */
select m.first_name || ' ' || m.last_name, d.department_name, l.city
from employees m 
join employees e 
    on m.employee_id = e.manager_id
join departments d 
    on e.department_id = d.department_id
join locations l
    on d.location_id = l.location_id;

/* 23. Write a query in SQL to display the employee ID, job name, number of days worked 
in for all those jobs in department 80. */
/*Note: This also works using a NATURAL JOIN which creates an implicit join based on 
the common columns in the two tables being joined.*/
select employee_id,job_title,trunc(sysdate - hire_date) 
from employees
natural join jobs
where department_id = 80;


/* 24. Write a query in SQL to display the full name (first and last name), and 
salary of those employees who working in any department located in London. */
select e.first_name || ' ' || e.last_name,e.salary
from employees e
join departments d
  on e.department_id = d.department_id
join locations l
  on d.location_id = l.location_id
where l.city = 'London';

/* 25. Write a query in SQL to display full name(first and last name), job title, 
starting and ending date of last jobs for those employees with worked without a commission percentage. */
select e.first_name || ' ' || e.last_name,j.job_id,j.start_date, j.end_date, e.commission_pct
from employees e
join job_history j 
on e.employee_id = j.employee_id
where end_date in (select max(end_date) from job_history where employee_id = j.employee_id) and
e.commission_pct is null;


/* 26. Write a query in SQL to display the department name and number of employees in each of the department. */
select d.department_name, count(e.employee_id) 
from departments d
join employees e 
    on e.department_id = d.department_id
group by d.department_name;

/* 27. Write a query in SQL to display the full name (first and last name) of employee 
with ID and name of the country presently where (s)he is working. */
select e.employee_id, e.first_name || ' ' || e.last_name, c.country_name
from employees e
join departments d 
    on e.department_id = d.department_id
join locations l 
    on l.location_id = d.location_id
join countries c
    on c.country_id = l.country_id;


