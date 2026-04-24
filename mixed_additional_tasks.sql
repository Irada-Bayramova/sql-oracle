select * from employees;
select * from jobs;
/* 1.Display details of jobs where the minimum salary is greater than 10000. */
select job_title,min_salary from jobs 
where min_salary >10000;

/* 2.Display the first name and join date of the employees who joined between 2002 and 2005. */
select first_name, hire_date from employees 
where to_char(hire_date, 'yyyy')  between 2002 and 2005;

/* 3.Display first name and join date of the employees who is either IT Programmer or Sales Man. */
select first_name, hire_date, job_id from employees 
where job_id = 'IT_PROG' or job_id = 'SA_MAN';

/* 4.Display employees who joined after 1st January 2008. */
select first_name, hire_date from employees 
where hire_date > to_date('2008-01-01','yyyy-mm-dd');

/* 5.Display details of employee with ID 150 or 160. */
select * from employees 
where employee_id in (150, 160);

/* 6.Display first name, salary, commission pct, and hire date for employees with salary less than 10000. */
select first_name, salary , commission_pct, hire_date 
from employees 
where salary < 10000;

/* 7.Display job Title, the difference between minimum and maximum salaries for 
jobs with max salary in the range 10000 to 20000. */
select job_title, (max_salary- min_salary) as diff_sal 
from jobs
where max_salary between 10000 and 20000;

/* 8.Display first name, salary, and round the salary to thousands. */
select first_name,round(salary,-3) 
from employees; 
/* length = -1 rounds to the nearest ten.
length = -2 rounds to the nearest hundred.
length = -3 rounds to the nearest thousand.  */

/* 9.Display details of jobs in the descending order of the title. */
select * from jobs order by job_title desc;

/* 10.Display employees where the first name or last name starts with S. */
select first_name, last_name from employees 
where lower(first_name) like's%' or lower(last_name) like 's%';

/* 11.Display employees who joined in the month of May. */
select first_name,hire_date from employees
where extract(month from hire_date) = 5;

/* 12.Display details of the employees where commission percentage is null and 
salary in the range 5000 to 10000 and department is 30. */
select * from employees 
where commission_pct is null and (salary between 5000 and 10000) and department_id = 30;

/* 13.Display first name and date of first salary of the employees. */
select first_name, hire_date, last_day(hire_date) as first_salary_date 
from employees;

/* 14.Display first name and experience of the employees. */
select first_name, trunc(months_between(sysdate, hire_date)/12) as exp_emp from employees;

/* 15.Display first name of employees who joined in 2001. */
select first_name, hire_date from employees
where to_char(hire_date, 'yyyy')  = '2001';

select first_name, hire_date from employees
where to_char(hire_date, 'yyyy')  = '2013';

/* 16.Display first name and last name after converting the first letter of each 
name to upper case and the rest to lower case. */
select initcap(first_name), initcap(last_name) from employees ;

/* 17.Display the length of first name for employees where last name contain 
character ‘b’ after 3rd position. */
select first_name, length(first_name) as name_length
from employees
where instr(lower(last_name), 'b', 4) > 0;

/* 18.Display first name in upper case and email address in lower case for 
employees where the first name and email address are same irrespective of the case. */
select upper(first_name), lower(email) from employees
where lower(first_name) = lower(email);

/* 19.Display employees who joined in the current year. */
select first_name, hire_date from employees
where extract(year from hire_date) = extract(year from sysdate);

/* 20.Display the number of days between system date and 1st January 2011. */
select trunc(sysdate - to_date('01-JAN-2011','dd-MON-yyyy')) as days_diff
from dual;

/* 21.Display how many employees joined in each month of the current year. */
select count(employee_id),to_char(hire_date,'mm') as month 
from employees 
where to_char(hire_date,'yyyy') = to_char(sysdate,'yyyy')
group by to_char(hire_date, 'mm');


/* 22.Display manager ID and number of employees managed by the manager. */
select manager_id, count(employee_id) 
from employees
where manager_id is not null
group by manager_id
order by manager_id asc;

/* 23.Display number of employees joined after 15th of the month. */
select count(employee_id)
from employees
where to_char(hire_date, 'dd') > '15';

select employee_id, hire_date 
from employees
where to_number(to_char(hire_date, 'dd')) > 15;

/* 24.Display the country ID and number of cities we have in the country. */
select country_id, count(city) 
from locations 
group by country_id;

/* 25.Display average salary of employees in each department who have commission percentage. */
select department_id,avg(salary)
from employees
where commission_pct is not null
group by department_id;

/* 26.Display job ID, number of employees, sum of salary, and difference between 
highest salary and lowest salary of the employees of the job. */
select * from jobs; -- job_id, min_salary,max_salary
select * from employees; -- job_id, salary

select j.job_id, count(employee_id), sum(salary), j.max_salary-j.min_salary
from jobs j
join employees e
    on j.job_id = e.job_id
group by j.job_id,j.max_salary, j.min_salary;


/* 27.Display job ID for jobs with average salary more than 10000. */
select j.job_id, avg(e.salary)
from employees e
join jobs j
    on e.job_id =j.job_id
group by j.job_id
having avg(salary)>10000;

/* 28.Display years in which more than 10 employees joined. */
select to_char(hire_date,'yyyy'), count(employee_id) from employees
group by to_char(hire_date,'yyyy')
having count(employee_id) > 10;

/* 29.Display departments in which more than five employees have commission percentage. */
select department_id from employees
where commission_pct is not null
group by department_id
having count(employee_id)> 5;


/* 30.Display employee ID for employees who did more than one job in the past. */
select * from job_history;

select employee_id from job_history
group by employee_id
having count(job_id)> 1;


/* 31.Display job ID of jobs that were done by more than 3 employees for more than 100 days. */
select job_id from job_history
where (end_date - start_date) > 100
group by job_id 
having count(employee_id)>3;

/* 33.Display department ID, year, and number of employees joined. */
select department_id, to_char(hire_date, 'yyyy'),
    count(*) over(partition by department_id,to_char(hire_date, 'yyyy'))
from employees;

/* 34.Display departments where any manager is managing more than 5 employees. */
select department_id, count(manager_id) as count_of_managers
from employees
group by department_id
having count(manager_id) > 5;

/* 35.Change salary of employee 115 to 8000 if the existing salary is less than 6000. */
select employee_id,
case 
    when salary < 6000 then 8000
    else salary
end as new_sal
from employees
where employee_id = 115;

update employees
set salary = 8000
where employee_id = 115 and salary < 6000;

/* 36.Insert a new employee into employees with all the required details. */
describe employees;
insert into employees (employee_id, first_name, last_name, email, phone_number,hire_date, job_id, 
salary, commission_pct, manager_id,department_id)
values( 250, 'Irada', 'Bayramova','irabayramova', '1.051.757.874.000','30-MAY-2026','IT_PROG', 7000,null,102,60);

/* 37.Delete department 20. */
delete from employees
where department_id = 20;

/* 38.Change job ID of employee 110 to IT_PROG if the employee belongs to 
department 10 and the existing job ID does not start with IT. */
update employees
set job_id = 'IT_PROG'
where employee_id = 110 and department_id = 10 and job_id not like 'IT%';
  
/* 39.Insert a row into departments table with manager ID 120 and location ID in any location ID for city Tokyo. */

insert into departments(department_id, department_name, manager_id, location_id)
values(300,'New Department', 102,
(select(location_id from locations where city = 'Tokyo')));

select * from departments;

/* 40.Display department name and number of employees in the department. */
select d.department_name, count(e.employee_id) from departments d
join employees e
on d.department_id = e.department_id
group by d.department_name;

/* 41.Display job title, employee ID, number of days between ending date and 
starting date for all jobs in department 30 from job history. */
select j.job_title,jh.employee_id,end_date -start_date from jobs j
join job_history jh
on j.job_id= jh.job_id
where department_id = 30;
select * from job_history;

/* 42.Display department name and manager first name. */
select d.department_name, m.first_name from employees e
join employees m
on e.manager_id = m. employee_id
join departments d
on e.department_id = d.department_id;


/* 43.Display department name, manager name, and city. */
select d.department_name, m.first_name, l.city from employees e
join employees m
on e.manager_id = m. employee_id
join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id;

/* 44.Display country name, city, and department name. */
select d.department_name,c.country_name,l.city from departments d
join locations l
on d.location_id = l.location_id
join countries c
on l.country_id = c.country_id;

/* 45.Display job title, department name, employee last name, starting date for all jobs from 2000 to 2005. */
select e.last_name, d.department_name,j.job_title from employees e
join departments d
on e.department_id = d.department_id
join jobs j
on e.job_id = j.job_id
join job_history jh
on j.job_id = jh.job_id
where jh.start_date between to_date('2000', 'yyyy') and to_date('2005', 'yyyy');

select * from jobs;
select * from job_history;
select * from departments;
select * from employees;

/* 46.Display job title and average salary of employees. */
select j.job_title, avg(e.salary) from employees e
join jobs j
on e.job_id = j.job_id
group by j.job_title;


/* 47.Display job title, employee name, and the difference between maximum salary 
for the job and salary of the employee. */
select e.first_name, j.job_title, j.max_salary - e.salary from employees e
join jobs j
on e.job_id = j.job_id;


/* 48.Display last name, job title of employees who have commission percentage and belongs to department 30. */
select e.last_name,j.job_title,e.department_id from employees e
join jobs j
on e.job_id = j.job_id
where commission_pct is not null and department_id = 30; --- dept 30 are all null


/* 49.Display details of jobs that were done by any employee who is currently drawing more than 15000 of salary. */
select j.*  from jobs j
join employees e
on e.job_id = j.job_id
where e.salary > 15000;


/* 50.Display department name, manager name, and salary of the manager for all 
managers whose experience is more than 5 years. */
select d.department_name, m.first_name, e.salary,
to_number(to_char(jh.end_date, 'yyyy' ))- to_number(to_char(jh.start_date,'yyyy')) 
from employees e
join employees m
on e.manager_id = m. employee_id
join departments d
on e.department_id = d.department_id
join job_history jh
on e.job_id = jh.job_id
where (to_number(to_char(jh.end_date, 'yyyy' ))- to_number(to_char(jh.start_date,'yyyy'))) > 5; 


/* 51.Display employee name if the employee joined before his manager. */
select e.first_name, e.hire_date, m.hire_date from employees e
join employees m
on e.manager_id = m.employee_id
where m.hire_date > e.hire_date;

/* 52.Display employee name, job title for the jobs employee did in the past 
where the job was done less than six months. */
select e.first_name, jh.job_id from employees e
join job_history jh
on jh.employee_id = e.employee_id
where months_between(end_date,start_date) < 6;

select * from job_history;

/* 53.Display employee name and country in which he is working. */
select e.first_name, c.country_name 
from employees e
join departments d
on d.department_id = e.department_id
join locations l
on l.location_id = d.location_id
join countries c
on l.country_id = c.country_id;

select * from departments;
select * from locations;
select * from countries;
select * from regions;

/* 54.Display department name, average salary and number of employees with commission within the department. */
select d.department_name , trunc(avg(e.salary)), count(e.employee_id)
from employees e
join departments d
on d.department_id = e.department_id
where commission_pct is not null
group by d.department_name;

/* 55.Display the month in which more than 5 employees joined in any department located in Sydney. */
select to_char(e.hire_date, 'mm') from employees e
join departments  d
on d.department_id = e.department_id
join locations l 
on l.location_id = d.location_id
where l.city = 'Sydney'
group by to_char(e.hire_date, 'mm')
having count(e.employee_id) > 5;


/* 56.Display details of departments in which the maximum salary is more than 10000. */
select department_id,max(salary) from employees 
group by department_id
having max(salary)> 10000;


/* 57.Display details of departments managed by ‘Smith’. */
select d.* from departments d
join employees e
on e.department_id = d.department_id
join employees m
on e.manager_id = m.employee_id
where m.last_name /*m.first_name*/ = 'Smith'; 


/* 58.Display jobs into which employees joined in the current year. */
select job_id, hire_date from employees 
where to_char(hire_date, 'yyyy') = to_char(sysdate, 'yyyy');


/* 59.Display employees who did not do any job in the past. */
select first_name from employees 
where employee_id not in (select employee_id from job_history);

select * from job_history;

/* 60.Display job title and average salary for employees who did a job in the past. */
select j.job_title, avg(e.salary)
from employees e
join jobs j on e.job_id = j.job_id
where e.employee_id in (select employee_id from job_history)
group by j.job_title;

/* 61.Display country name, city, and number of departments where department has more than 5 employees. */
select  c.country_name, l.city, count(d.department_id), count(e.employee_id)
from employees e
join departments d on d.department_id = e.department_id
join locations l   on l.location_id = d.location_id
join countries c   on l.country_id = c.country_id
group by c.country_name, l.city
having count(e.employee_id) > 5;

select * from departments;
select * from locations;
select * from countries;
select * from regions;


/* 62.Display details of manager who manages more than 5 employees. */
select m.first_name 
from employees m
join employees e
on e.manager_id = m.employee_id
group by m.first_name
having count(e.employee_id)> 5;

/* 63.Display employee name, job title, start date, and end date of past jobs of 
all employees with commission percentage null. */
select e.first_name, j.job_title ,jh.start_date, jh.end_date
from employees e
join jobs j 
    on e.job_id = j.job_id 
join job_history jh 
    on jh.job_id = j.job_id
where commission_pct is null;

/* 64.Display the departments into which no employee joined in last two years. */
select d.department_name from departments d
join employees e
on e.department_id= d.department_id
where d.department_id not in (select department_id from employees where hire_date > sysdate - 730); 


/* 65.Display the details of departments in which the max salary is greater than 10000 
for employees who did a job in the past. */
select d.department_id, d.department_name, max(e.salary) from departments d
join employees e
on e.department_id = d.department_id
join jobs j
on j.job_id = e.job_id
where e.employee_id in (select employee_id from job_history)
group by d.department_id,d.department_name
having max(salary)> 10000;


/* 66.Display details of current job for employees who worked as IT Programmers in the past. */
select e.employee_id, e.first_name, j.job_title
from employees e
join jobs j on e.job_id = j.job_id
where e.employee_id in (select employee_id from job_history  where job_id = 'IT_PROG');

select * from jobs;
select * from job_history;


/* 67.Display the details of employees drawing the highest salary in the department. */
select e.employee_id , department_id  from employees e
where salary in (select max(salary) from employees where department_id = e.department_id);

select e.employee_id,e.first_name , e.department_id, (select max(e1.salary) from employees e1
where e.department_id = e1.department_id group by department_id ) from employees e ;

/* 68.Display the city of employee whose employee ID is 105. */
select l.city from employees e
join departments d
on d.department_id = e.department_id
join locations l
on l.location_id = d.location_id
where e.employee_id = 105;


/* 69.Display third highest salary of all employees */
select * from (select salary,rownum as rn
from (select * from employees order by salary desc))
where rn = 3;

select salary
from (select salary, dense_rank() over(order by salary desc) as rnk
      from employees)
where rnk = 3;

select * from 
(select salary ,row_number()over( order by salary desc)as rn from employees) 
where rn = 3;