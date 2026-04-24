--group by
-- 1. List the number of employees in each department.
select count(*),department_id 
from employees
group by department_id;

-- 2. Display the average salary for each job_id.
select avg(salary),job_id
from employees
group by job_id;

-- 3. Show how many employees receive a commission and how many do not.
select count(*),
case
    when commission_pct is not null then 'with_cms_pct'
    else 'no_cms_pct'
end
from employees
group by case
    when commission_pct is not null then 'with_cms_pct'
    else 'no_cms_pct'
end;
    

-- 4. Display the number of cities in each country.
select count(city),country_id 
from locations
group by country_id;

-- 5. Show the minimum and maximum salary for each job.
select min(salary),max(salary), job_id
from employees
group by job_id;

-- 6. For each department, display the total salary, minimum salary, and maximum salary of employees.
select department_id, min(salary),max(salary), round(avg(salary))
from employees
group by department_id;

-- 7. Display the number of departments available in each country.
select l.country_id,count(d.department_id)
from departments d
join locations l
    on d.location_id = l.location_id
group by l.country_id;


-- 8. Show the number of employees hired in each year.
select count(employee_id),extract(year from hire_date)
from employees
group by extract(year from hire_date);

-- 9. For each job_id, display how many employees have previously done this job (job_history).
select job_id, count(employee_id)
from job_history
group by job_id;

-- 10. Display the average salary of employees with commission, grouped by department.
select trunc(avg(salary)),department_id
from employees
where commission_pct is not null
group by department_id;

-- 11. For each department and each hiring year, display the number of employees hired.
select count(*),department_id,extract(year from hire_date)
from employees
group by department_id,extract(year from hire_date);

-- 12. Display the number of employees in each region.
select r.region_name,count(e.employee_id) 
from employees e
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id
join countries c on l.country_id = c.country_id
join regions r on c.region_id = r.region_id
group by r.region_id,r.region_name;

-- 13. Show only those jobs where the total salary is greater than the HR department’s total salary.
select sum(salary) 
from employees
group by job_id
having sum(salary) > (select sum(salary) from employees 
join departments  using(department_id)
where lower(department_name) = 'human resources');


-- 14. Display departments where the minimum salary is lower than the company-wide average salary.
select department_id from employees
group by department_id
having min(salary) < (select avg(salary) from employees );

-- 15. Display employees whose salary is higher than the average salary of their own department.
select * from employees e
where salary > (select avg(salary) from employees where department_id = e.department_id);



--partition by
-- 1. Display each employee along with the average salary of their department.
select first_name, last_name,department_id,
round(avg(salary) over(partition by department_id))
from employees;

-- 2. Rank employees within each department based on salary in descending order.
select first_name, last_name,department_id,
rank() over(partition by department_id order by salary desc)
from employees;

-- 3. For each employee, show the minimum and maximum salary within their department.
select employee_id, first_name,
max(salary) over(partition by department_id),
min(salary) over(partition by department_id)
from employees;

-- 4. Show the total salary per job_id while displaying the result for every employee.
select first_name,job_id,
sum(salary) over(partition by job_id)
from employees;

-- 5. Display each employee with the number of employees in their department.
select first_name,department_id,
count(employee_id) over(partition by department_id)
from employees;

-- 6. Display the running total of salaries within each department based on hire_date.
select department_id,hire_date,
avg(salary) over(partition by department_id order by hire_date)
from employees;

-- 7. Show each employee’s salary compared to the department average (difference).
select first_name,salary,trunc(avg(salary) over (partition by department_id)),
trunc(salary - avg(salary) over (partition by department_id))
from employees;


-- 8. Number employees within each job_id based on hire_date using ROW_NUMBER().
select first_name, job_id, hire_date,
row_number() over(partition by job_id order by hire_date)
from employees;

-- 9. Display the number of employees partitioned by region.
select first_name, r.region_name,
count(e.employee_id) over(partition by r.region_id)
from employees e
join departments d
     on e.department_id = d.department_id
join locations l
     on d.location_id = l.location_id
join countries c
     on l.country_id = c.country_id
join regions r
     on c.region_id = r.region_id;

-- 10. Show the highest salary per job_id using window functions.
select salary,job_id,
max(salary) over(partition by job_id)
from employees;

-- 11. Display the top 3 highest-paid employees in each department.
select * from 
(select first_name,salary,department_id,
row_number() over(partition by department_id order by salary desc)as rn
from employees )
where rn <=3;

-- 12. Display the salary difference between each employee and the employee hired just before them (using LAG).
select salary,
salary - lag(salary) over (order by hire_date)
from employees;

-- 13. Display the salary difference between each employee and the employee hired after them (using LEAD).
select first_name, hire_date,salary,
salary - lead(salary) over (order by hire_date)
from employees;

-- 14. Display the median salary for each job_id using analytic window functions.
select salary,job_id,
median(salary) over(partition by job_id)
from employees;

-- 15. For each employee, display how many colleagues in the same department earn more than them.
select employee_id, first_name,salary,department_id,
count(*) over ( partition by department_id order by salary desc) - 1 
from employees;


select e.first_name, e.department_id, e.salary,
count(*) over (partition by e.department_id order by e.salary desc
rows between unbounded preceding and current row) - 1 as higher_earners_in_dept
from hr.employees e
order by e.department_id, e.salary desc;
