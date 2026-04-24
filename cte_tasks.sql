/*1. Using a CTE, extract employee_id, first_name, last_name, hire_date, and the year of hire,
   then return employees who were hired in the same year as employee 100.*/
with emp as(
select employee_id, first_name, last_name, hire_date,to_char(hire_date, 'yyyy') as yearss from employees)
select * from emp 
where yearss = (select to_char(hire_date, 'yyyy') from emp where employee_id = 100);


/*2. Using a CTE, calculate the average salary per department,
   then return employees whose salary is greater than their department average.*/
with emp as(
select round(avg(salary)) as avg_sal,department_id from employees group by department_id)
select  e.employee_id,e.department_id,e.salary, a.avg_sal from emp a
join employees e on a.department_id = e.department_id
where e.salary > a.avg_sal;


/*3. Using a CTE with ROW_NUMBER(), find the highest paid employee in each department.*/
with high_p as(
select first_name,salary,row_number() over(partition by department_id order by salary desc)as rn from employees)
select first_name, salary from high_p
where rn = 1;

/*4. Using a CTE with RANK() or DENSE_RANK(), assign a salary rank to employees within each department.*/
with ranke as(
select employee_id, salary, dense_rank() over(partition by department_id order by salary desc) as dsr from employees)
select employee_id, salary,dsr from ranke;

/*5. Using a CTE, count the number of employees in each department,
   then return departments that have more than 5 employees.*/
with counte as(
select department_id , count(employee_id) as ec  from employees group by department_id)
select department_id,ec from counte
where ec > 5;


/*6. Using a CTE, calculate the average salary of the whole company,
   then return employees whose salary is above the company average.*/

select * from employees
where salary > ( select avg(salary) as avg_sal  from employees);

with company_avg as (
    select avg(salary) as avg_sal
    from employees
)
select e.*
from employees e
cross join company_avg c
where e.salary > c.avg_sal;


/*7. Using a CTE, calculate the total salary per department,
   then join the result with the DEPARTMENTS table to return department name and total salary.*/
with tot as(
select department_id, sum(salary) as sum_sal from employees group by department_id)
select  d.department_name,t.sum_sal from tot t
join departments d
on t.department_id = d.department_id;


/*8. Using a CTE, find the number of employees per job,
   then return jobs where more than 3 employees share the same job.*/
with counte as(
select job_id, count(employee_id) as c_e from employees group by job_id)
select job_id , c_e from counte
where c_e> 3;


/*9. Using a CTE, calculate employee tenure (years worked) from hire_date,
   then return employees who have worked less than 3 years.*/
with tenure as(
select first_name, hire_date,
to_number(to_char(sysdate, 'yyyy')) - to_number(to_char(hire_date, 'yyyy')) as years_worked
--to_char(sysdate,'yyyy') - to_char(hire_date,'yyyy') as years_worked
from employees)
select first_name, hire_date,years_worked from tenure
where years_worked < 3
order by years_worked;

/*10. Using a CTE, display the management hierarchy starting from employee 100,
    including all employees reporting directly or indirectly to them.*/
select employee_id, first_name, last_name, manager_id, level as hierarchy_level
from employees
start with employee_id = 100
connect by prior employee_id = manager_id
order by level;

/*11. Using a CTE, calculate the total salary per department, then compute each 
employee’s percentage contribution to their department’s total salary.*/
with dep_total as (
select department_id, sum(salary) as total_salary
from employees
group by department_id)

select e.first_name,e.department_id, e.salary,d.total_salary,
round(e.salary / d.total_salary * 100,2)
from dep_total d
join employees e
on e.department_id = d.department_id
order by e.department_id;

/*12. Using a CTE with ROW_NUMBER(), return the top 3 highest-paid employees in each department.*/
with top3 as(
select employee_id, first_name, department_id, salary, 
row_number() over(partition by department_id order by salary desc) as rn from employees)

select employee_id, first_name, department_id, salary,rn from top3
where rn <=3;

/*13. Using a CTE, find the maximum salary in each department, then return employees 
whose salary equals the department maximum.*/
with maxe as(
select department_id, max(salary) as max_sal from employees group by department_id)

select m.department_id,e.salary, m.max_sal from maxe m
join employees e
on e.department_id = m.department_id
where e.salary = m.max_sal;


/*14. Using a CTE, calculate the number of employees hired per year, then return 
years where more than 5 employees were hired.*/
with per_year as (
select to_char(hire_date,'yyyy') as hire_year, count(*) as emp_count
from employees
group by to_char(hire_date,'yyyy'))

select hire_year,emp_count from per_year
where emp_count > 5
order by hire_year;

/*15. Using a CTE with a window function, calculate a running total of salaries ordered by hire date.*/
with wind as(
select first_name,hire_date,salary, sum(salary) over (order by hire_date) as tot_sal from employees)

select first_name,hire_date,salary,tot_sal
from wind
order by hire_date;


/*16. Using a CTE, find the minimum salary for each job, then return employees 
who earn more than the minimum salary of their job.*/
with mine as (
select job_id, min(salary) as min_sal from employees group by job_id)

select e.employee_id,m.job_id, m.min_sal,e.salary from mine m
join  employees e
on m.job_id = e.job_id
where e.salary > m.min_sal;


/*17. Using a CTE, list employees and their managers, then return employees whose 
manager works in a different department.*/
with emp as (
select e.employee_id, e.first_name as emp_name,e.department_id as emp_dept,
m.employee_id as manager_id,m.first_name as man_name,m.department_id as man_dept
from employees e
join employees m
    on e.manager_id = m.employee_id)
    
select employee_id,emp_name,emp_dept, manager_id, man_name, man_dept
from emp 
where emp_dept <> man_dept
order by employee_id;

/*18. Using a CTE, display the full manager chain for employee 150 up to the top-level manager.*/
select employee_id, first_name, last_name, manager_id, level as hierarchy_level
from employees
start with employee_id = 150
connect by prior manager_id = employee_id;

/*19. Using a CTE with ROW_NUMBER(), assign a row number to employees ordered by 
salary descending, then return employees ranked between 5 and 10.*/
with ranke as (
select employee_id, salary, row_number() over (order by salary desc) as rn from employees)
select employee_id, salary, rn from ranke
where rn between 5 and 10;

/*20. Using a CTE, calculate the average salary per job, then return employees whose salary is above the job average.*/
with jobe as (
select job_id, avg(salary) as avg_sal from employees group by job_id)

select e.employee_id, j.job_id, j.avg_sal,e.salary from jobe j
join employees e
on e.job_id = j.job_id
where e.salary > j.avg_sal;

