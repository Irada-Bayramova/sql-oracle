/* 1. Write a query to display the name (first name and last name) for those 
employees who gets more salary than the employee whose ID is 163. */
select first_name, last_name, salary 
from hr.employees 
where salary > (select salary from hr.employees where employee_id = 163);

/* 2. Write a query to display the name (first name and last name), salary, department id,
job id for those employees who works in the same designation as the employee works whose id is 169. */
select first_name, last_name , salary ,department_id, job_id
from hr.employees
where job_id = (select job_id from hr.employees where employee_id = 169);

/* 3. Write a query to display the name (first name and last name), salary, 
department id for those employees who earn such amount of salary which is the smallest salary of any of the departments. */
select first_name, last_name , salary ,department_id
from hr.employees
where salary = (select min(salary) from hr.employees);

/* 4. Write a query to display the employee id, employee name (first name and last name)
for all employees who earn more than the average salary. */
select employee_id,first_name, last_name 
from hr.employees
where salary > (select avg(salary) from hr.employees);

/* 5. Write a query to display the employee name (first name and last name), 
employee id and salary of all employees who report to Payam. */
select employee_id,manager_id, first_name, last_name, salary
from hr.employees
where manager_id = (select employee_id from hr.employees where first_name = 'Payam');

/* 6. Write a query to display the department number, name (first name and last name), 
job_id and department name for all employees in the Finance department. */
select department_id, first_name,last_name,job_id
from hr.employees
where department_id = (select department_id from hr.departments where department_name = 'Finance');

/* 7. Write a query to display all the information of an employee 
whose salary and reporting person id is 3000 and 121, respectively. */
select * from hr.employees
where salary in (select salary from hr.employees where salary = 3000 and manager_id = 121);

/* 8. Display all the information of an employee whose id is 
any of the number 134, 159 and 183. */
select * from hr.employees
where employee_id = any -- in
(select employee_id from hr.employees where employee_id in(134,159,183));

/* 9. Write a query to display all the information of the employees 
whose salary is within the range 1000 and 3000. */
select * from hr.employees
where salary in (select salary from hr.employees where salary between 1000 and 3000);

/* 10. Write a query to display all the information of the employees 
whose salary is within the range of smallest salary and 2500. */
select * from employees
where salary between (select min(salary) from employees )
and 2500; 

/* 11. Write a query to display all the information of the employees 
who does not work in those departments where some employees works 
whose manager id within the range 100 and 200. */
select * from hr.employees
where department_id not in (select department_id from hr.employees where manager_id between 100 and 200);

/* 12. Write a query to display all the information for those employees 
whose id is any id who earn the second highest salary. */
select * from hr.employees
where salary = (select max(salary) from hr.employees where salary < (select max(salary) from hr.employees));

select * from hr.employees
where employee_id = 
(select employee_id from (
select salary,employee_id,
row_number()over (order by salary desc) as new_sal
from hr.employees)
where new_sal = 2);


/* 14. Write a query to display the employee number and name (first name and last name) 
for all employees who work in a department with any employee whose name contains a T. */
select employee_id, first_name, last_name from employees
where department_id in (select department_id from employees where upper(first_name) like '%T%');

/* 15. Write a query to display the employee number, name (first name and last name), 
and salary for all employees who earn more than the average salary and who work in 
a department with any employee with a J in their name. */
select employee_id, first_name, last_name,salary  from employees
where salary >(select avg(salary) from employees)
and
department_id in(select department_id from employees where lower(first_name) like '%j%');

/* 16. Display the employee name (first name and last name), employee id, and 
job title for all employees whose department location is Toronto. */
select e.employee_id, e.first_name,e.job_id from employees e
join departments d
on e.department_id = d.department_id
where location_id in (select location_id from locations where city = 'Toronto');

select e.employee_id, e.first_name,e.job_id from employees e
where department_id = (select department_id from departments where location_id in 
(select location_id from locations where city = 'Toronto'));

select * from employees;
select * from locations;
select * from departments;

/* 17. Write a query to display the employee number, name (first name and last name) 
and job title for all employees whose salary is smaller than any salary of those 
employees whose job title is MK_MAN. */
select employee_id, first_name,job_id,salary from employees
where salary < (select salary from employees where job_id = 'MK_MAN'); --13000 , <any


/* 18. Write a query to display the employee number, name (first name and last name) 
and job title for all employees whose salary is smaller than any salary of those 
employees whose job title is MK_MAN. Exclude Job title MK_MAN. */
select employee_id, first_name,job_id ,salary
from employees
where salary <all (select salary from employees where job_id = 'SH_CLERK');


/* 19. Write a query to display the employee number, name (first name and last name)
and job title for all employees whose salary is more than any salary of those e
mployees whose job title is PU_MAN. Exclude job title PU_MAN. */
select employee_id, first_name,job_id ,salary
from employees
where salary > (select salary from employees where job_id = 'PU_MAN')
and job_id<>'PU_MAN';

/* 20. Write a query to display the employee number, name (first name and last name) 
and job title for all employees whose salary is more than any average salary of any department. */
select employee_id, first_name,job_id ,department_id,salary
from employees
where salary >any (select avg(salary) from employees group by department_id); --6461.8

/* 21. Write a query to display the employee name( first name and last name ) 
and department for all employees for any existence of those employees whose salary is more than 3700. */
select first_name, last_name, department_id 
from employees
where department_id in (select department_id from employees where salary >3700);

select * from departments;

select e.first_name, e.last_name, d.department_id , d.department_name, e.salary
from employees e
join departments d
    on e.department_id = d.department_id
where d.department_id in (select department_id from employees where salary >3700);


/* 22. Write a query to display the department id and the total salary for those 
departments which contains at least one employee. */

select first_name, last_name, department_id ,
(select sum(salary)from hr.employees e1 where e.department_id = e1.department_id 
group by department_id)
from hr.employees e
where department_id is not null;


/* 23. Write a query to display the employee id, name (first name and last name) 
and the job id column with a modified title SALESMAN for those employees whose job 
title is ST_MAN and DEVELOPER for whose job title is IT_PROG. */
select employee_id, first_name, job_id ,
case
    when job_id in (select job_id from employees where job_id = 'ST_MAN') then 'SALESMAN'
    when job_id in (select job_id from employees where job_id = 'IT_PROG') then 'DEVELOPER'
    end as nese
from employees;


/* 24. Write a query to display the employee id, name (first name and last name), 
salary and the SalaryStatus column with a title HIGH and LOW respectively for those 
employees whose salary is more than and less than the average salary of all employees. */
select employee_id , first_name, salary,
case
    when salary >(select avg(salary) from employees) then 'High'
    else 'Low'
    end as SalaryStatus
from employees;


/* 25. Write a query to display the employee id, name (first name and last name), 
Salary, AvgCompare (salary - the average salary of all employees) and the SalaryStatus 
column with a title HIGH and LOW respectively for those employees whose salary is 
more than and less than the average salary of all employees. */

select employee_id, first_name, salary,
(select round(avg(salary),2)as avg_salary from employees),
case
    when salary >(select avg(salary) from employees) then 'High'
    else 'Low'
    end as SalaryStatus
from employees;


/* 26. Write a subquery that returns a set of rows to find all departments that do 
actually have one or more employees assigned to them. */
select * from employees;
select * from departments;

select * from departments
where department_id in (select department_id from employees where department_id is not null);

/* 27. Write a query that will identify all employees who work in 
departments located in the United Kingdom. */
select * from locations;
select * from regions;
select * from countries;

select employee_id, first_name from employees
where department_id in (select department_id from departments where location_id in
(select location_id from locations where country_id in(select country_id from countries where 
country_name = 'United Kingdom of Great Britain and Northern Ireland')));
    
/* 28. Write a query to identify all the employees who earn more than the average 
and who work in any of the IT departments. */
select department_id,first_name from employees
where salary > (select avg(salary) from employees) --6461
and department_id in
(select department_id from departments where department_name like '%IT%');

select * from departments;

/* 29. Write a query to determine who earns more than Mr. Ozer. */
select last_name from employees
where salary > (select salary from employees where last_name = 'Ozer');

/* 30. Write a query to find out which employees have a manager who 
works for a department based in the US. */
select first_name, manager_id from employees
where manager_id in (select employee_id from employees where department_id in
(select department_id from departments where location_id in
(select location_id from locations where country_id = 'US')));

select * from locations;
select * from countries;

/* 31. Write a query which is looking for the names of all employees whose salary 
is greater than 50% of their department’s total salary bill. */
select first_name,department_id from employees e where salary >any 
(select sum(salary)/2 from employees  where department_id = e.department_id);

/* 32. Write a query to get the details of employees who are managers. */
select * from employees where employee_id in (select manager_id from employees where manager_id is not null);

/* 33. Write a query to get the details of employees who manage a department. */
select * from employees 
where manager_id in (select manager_id from departments where manager_id is not null);

/* 34. Write a query to display the employee id, name (first name and last name),
salary, department name and city for all the employees who gets the salary as
the salary earn by the employee which is maximum within the joining person January 1st, 2002 and December 31st, 2003. */
select e.employee_id,e.first_name || ' ' || e.last_name as full_name,e.salary,d.department_name,l.city
from employees e
join departments d
  on e.department_id = d.department_id
join locations l
  on d.location_id = l.location_id
where e.salary = (select max(salary) from employees
where hire_date between to_date ('2012-01-01','yyyy.mm.dd') and to_date ('2013-12-31','yyyy.mm.dd'));
--2002 ve 2003 cedvelde yoxdur deye deyisdim

/* 35. Write a query in SQL to display the department code and name for all 
departments which located in the city London. */
select department_id,department_name from departments
where location_id = (select location_id from locations where city = 'London');

/* 36. Write a query in SQL to display the first and last name, salary, and 
department ID for all those employees who earn more than the average salary and 
arrange the list in descending order on salary. */
select first_name,salary,department_id from employees
where salary > (select avg(salary) from employees)
order by salary desc;


/* 37. Write a query in SQL to display the first and last name, salary, and 
department ID for those employees who earn more than the maximum salary of a department which ID is 40. */
select first_name, salary, department_id from employees
where salary > (select max(salary) from employees where department_id = 40);

/* 38. Write a query in SQL to display the department name and Id for all departments 
where they located, that Id is equal to the Id for the location where department number 30 is located. */
select department_name,department_id from departments
where location_id = (select location_id from departments where department_id = 30);

/* 39. Write a query in SQL to display the first and last name, salary, and 
department ID for all those employees who work in that department where the employee works who hold the ID 201. */
select first_name,salary,department_id from employees
where department_id = (select department_id from employees where employee_id = 201);

/* 40. Write a query in SQL to display the first and last name, salary, and 
department ID for those employees whose salary is equal to the salary of the 
employee who works in that department which ID is 40. */
select first_name, salary, department_id from employees
where salary in (select salary from employees where department_id = 40);

/* 41. Write a query in SQL to display the first and last name, and department code 
for all employees who work in the department Marketing. */
select first_name,last_name, department_id from employees
where department_id = (select department_id from departments where department_name = 'Marketing');

/* 42. Write a query in SQL to display the first and last name, salary, and 
department ID for those employees who earn more than the minimum salary of a department which ID is 40. */
select first_name,salary,department_id
from employees
where salary > (select min(salary) from employees where department_id = 40);

/* 43. Write a query in SQL to display the full name, email, and hire date for 
all those employees who was hired after the employee whose ID is 165. */
select first_name, email, hire_date
from employees
where hire_date > (select hire_date from employees where employee_id = 165);

/* 44. Write a query in SQL to display the first and last name, salary, and 
department ID for those employees who earn less than the minimum salary of a department which ID is 70. */
select first_name, salary, department_id
from employees
where salary < (select min(salary) from employees where department_id = 70);

/* 45. Write a query in SQL to display the first and last name, salary, and 
department ID for those employees who earn less than the average salary, 
and also work at the department where the employee Laura is working as a first name holder. */
select first_name,salary,department_id 
from employees
where salary < (select avg(salary) from employees)
and department_id = (select department_id from employees where first_name = 'Laura');

/* 46. Write a query in SQL to display the first and last name, salary, and 
department ID for those employees whose department is located in the city London. */
select e.first_name, e.salary,d.department_id from departments d
join employees e 
on e.department_id= d.department_id
where location_id = (select location_id from locations where city = 'London');

/* 47. Write a query in SQL to display the city of the employee whose ID 134 and works there. */
select city from locations
where location_id = (select location_id from departments where department_id = 
(select department_id from employees where employee_id = 134));

/* 48. Write a query in SQL to display the the details of those departments which 
max salary is 7000 or above for those employees who already done one or more jobs. */
select * from departments d 
where d.department_id in (select e.department_id from employees e where e.employee_id in 
(select jh.employee_id from job_history jh group by jh.employee_id having count(jh.employee_id) >= 1)
group by e.department_id
having max(e.salary) >= 7000);

/* 49. Write a query in SQL to display the detail information of those departments 
which starting salary is at least 8000. */
select * from departments 
where department_id in(select department_id from employees where salary <=8000);

/* 50. Write a query in SQL to display the full name (first and last name) of 
manager who is supervising 4 or more employees. */
select first_name || ' ' || last_name from employees
where employee_id in (select manager_id from employees group by manager_id having count(employee_id) >= 4);


/* 51. Write a query in SQL to display the details of the current job for those employees 
who worked as a Sales Representative in the past. */
select employee_id,first_name,job_id
from employees 
where employee_id in (select employee_id from job_history where job_id = 'SA_REP');


/* 52. Write a query in SQL to display all the information about those employees 
who earn second lowest salary of all the employees. */
select * from employees
where salary = (select min(salary) from employees where salary > (select min(salary) from employees));

/* 53. Write a query in SQL to display the details of departments managed by Susan. */
select * from departments
where manager_id = (select employee_id from employees where first_name = 'Susan');

/* 54. Write a query in SQL to display the department ID, full name (first and last name),
salary for those employees who is highest salary drawer in a department. */
select department_id,first_name,salary
from employees e
where salary = (select max(salary) from employees where department_id = e.department_id);


/* 55. Write a query in SQL to display all the information of those employees who did not have any job in the past. */
select * from employees
where employee_id not in (select employee_id from job_history);
