--- GROUP FUNCTIONS Aggregate functions 
--group by categorical value 

--count
--sum
--min
--max
--avg
--stddev
--variance
--listagg
--rank(value) - index, 

select * from employees;

select count(*) from employees;

select count(*) from employees 
where salary >=10000;

select sum(salary) from employees 
where job_id like 'IT_%';

select count(*), sum(salary) from employees 
where job_id like 'IT_%';

select  count(*), 
        sum(salary), 
        max(salary), 
        min(salary) 
from employees 
where job_id like 'IT_%';

select 
        count(*), 
        sum(salary), 
        sum(salary)/count(*) 
from employees 
where job_id like 'IT_%';

select 
        count(*), 
        sum(salary), 
        sum(salary)/count(*), 
        avg(salary) 
from employees 
where job_id like 'IT_%';

select 
        count(*), 
        count(department_id), 
        count(manager_id), 
        count(commission_pct) 
from employees;

select 
        count(commission_pct)
from employees
where commission_pct is null;

select 
        count(*)
from employees
where commission_pct is null;

select 
    count(*)
from employees
where commission_pct is not null;

select 
        count(commission_pct) as "not null", 
        count(nvl2(commission_pct,null,1)) as "null"
from employees;


select 
        variance(salary)
from employees
where department_id=20;

select 
        stddev(salary)
from employees
where department_id=20;


----

select 
        job_id, 
        count(*), 
        sum(salary) 
from employees 
group by job_id;

select 
        job_id, 
        count(*), 
        sum(salary) 
from employees
where salary>6000
group by job_id;

select 
        job_id, 
        count(*), 
        sum(salary) 
from employees 
group by job_id
having count(*)>=20
;


select 
        job_id, 
        count(*), 
        sum(salary) 
from employees
where salary>6000
group by job_id
having count(*)>=20
;

select job_id, count(*), sum(salary) 
from employees
having count(*)>=20
group by job_id
;


select
        salary,
        count(salary)
from employees
group by salary
having count(salary) >=2
;


--------------

select 
        job_id, 
        count(*), 
        sum(salary) 
from employees 
; -- error

select 
        job_id, 
        count(*), 
        sum(salary) 
from employees 
group by job_id;

select 
        count(*), 
        sum(salary) 
from employees 
group by job_id;

select 
        count(*), 
        sum(salary) 
from employees 
group by job_id
order by count(*);


select 
        count(*), 
        sum(salary) 
from employees 
group by job_id
order by count(*) asc, sum(salary) asc;

select 
        count(*), 
        sum(salary) 
from employees 
group by job_id
order by 1, 2;

select 
        count(*) as say, 
        sum(salary) as cem 
from employees 
group by job_id
order by say, cem;

----------------

select 
        job_id, 
        department_id, 
        count(*), 
        sum(salary) 
from employees 
group by job_id, department_id
;


select 
        job_id, 
        department_id, 
        count(*), 
        sum(salary) 
from employees 
group by department_id, job_id
order by 1, 2;

select 
        job_id, 
        department_id, 
        manager_id, 
        count(*), 
        sum(salary) 
from employees 
group by job_id, department_id, manager_id
order by 1, 2, 3;

-------
select 
        max(sum(salary)) 
from employees
group by department_id; -- maximum nested level = 2

select count(max(sum(salary))) 
from employees
group by department_id; -- ORA-00935: group function is nested too deeply

select round(stddev(sum(salary)), 2) 
from employees
group by department_id; -- maximum nested level = 2


select 
        count(all job_id) 
from employees;  -- all default

select 
        count(distinct job_id) 
from employees; -- ferqlilerin sayi

---------------------------------------------------------------

select department_id, last_name from employees;

select  
        department_id, 
        listagg(last_name,' ,') within group (order by last_name) 
from employees
group by department_id;

select  
        department_id, 
        count(*), 
        listagg(last_name,' ,') within group (order by last_name) 
from employees
group by department_id;

select  department_id, count(*), listagg(last_name,' ,')  --- oraclec 12c versiyasindan sonra within group hissesini yazmamaq olar
from employees
group by department_id;

select  
        department_id, 
        count(*), 
        listagg(last_name ||'-'|| salary,' ,') within group (order by last_name) 
from employees
group by department_id;

select 
        count(*), 
        listagg(last_name || '-'|| salary,' ,') within group (order by last_name) 
from employees;


select  
        e.department_id, 
        count(*), 
        listagg(e.last_name || '-' || e.salary || '-' || c.country_name,' ,') within group (order by e.last_name) 
from employees e inner join departments d 
                    on (e.department_id = d.department_id)
                inner join locations l 
                    on (d.location_id = l.location_id)
                inner join countries c 
                    on (l.country_id = c.country_id)
group by e.department_id;


---------------------
select salary 
from employees
order by salary;

select rank(2100) within group (order by salary) from employees;
select rank(2200) within group (order by salary) from employees;
select rank(2400) within group (order by salary) from employees;
select rank(2450) within group (order by salary) from employees;
select rank(2499) within group (order by salary) from employees;
select rank(2500) within group (order by salary) from employees;


select salary, manager_id from employees
order by salary, manager_id;

select rank(2100, 121) within group (order by salary, manager_id) from employees;
select rank(2200, 120) within group (order by salary, manager_id) from employees;
select rank(2400, 121) within group (order by salary, manager_id) from employees;

--------------------------------

select department_id, salary from employees
where department_id between 20 and 50
order by department_id, salary;

select MIN(salary) KEEP (DENSE_RANK FIRST ORDER BY department_id)  lowest, -- 6000
       MAX(salary) KEEP (DENSE_RANK FIRST ORDER BY department_id)  highest --13000
from employees
where department_id between 20 and 50
;

select MIN(salary) KEEP (DENSE_RANK LAST ORDER BY department_id)  lowest, -- 2100
       MAX(salary) KEEP (DENSE_RANK LAST ORDER BY department_id)  highest --8200
from employees
where department_id between 20 and 50
;

select MIN(salary) KEEP (DENSE_RANK FIRST ORDER BY department_id desc)  lowest, -- 6000
       MAX(salary) KEEP (DENSE_RANK FIRST ORDER BY department_id desc)  highest --13000
from employees
where department_id between 20 and 50
;

select MIN(salary) KEEP (DENSE_RANK LAST ORDER BY department_id desc)  lowest, -- 2100
       MAX(salary) KEEP (DENSE_RANK LAST ORDER BY department_id desc)  highest --8200
from employees
where department_id between 20 and 50
;
-----------------------------------------


--Analtics function or Windows function

--row_number()
--rank()
--dense_rank()
--lead()
--lag
--min
--max
--sum()
--count()
-----------------------------------------------------------------------------------------
select employee_id, last_name, salary, rownum
from employees
order by salary asc;

select employee_id, last_name, salary, 
        row_number() over(order by employee_id)
from employees;

            
select employee_id, last_name, salary, rownum
from employees
order by salary asc; -- sehv rownum

select 
    employee_id, 
    last_name, 
    salary,
    row_number() over(order by salary desc) as rn
from employees;


select employee_id, last_name, department_id, salary,
    row_number() over(partition by department_id order by salary)
from employees;

select employee_id, last_name, department_id, salary,
    row_number() over(partition by department_id order by salary desc)
from employees;
-----

select employee_id, last_name, department_id, salary,
    rank() over(partition by department_id order by salary)
from employees;

select employee_id, last_name, department_id, salary,
    rank() over(order by salary, employee_id)
from employees;


select employee_id, last_name, department_id, salary,
    rank() over(partition by department_id order by salary, employee_id)
from employees;

select employee_id, last_name, department_id, salary,
    dense_rank() over(partition by department_id order by salary)
from employees;

select employee_id, last_name, department_id, salary,
    dense_rank() over(partition by department_id order by salary, employee_id)
from employees;

select employee_id, last_name, department_id, salary,
    dense_rank() over(order by salary) as dr
from employees; -- 107 rows

select count(distinct salary) from employees;

select employee_id, last_name, department_id,
    count(*) over(partition by department_id)
from employees;

select employee_id, last_name, department_id, salary,
    sum(salary) over(partition by department_id)
from employees;

select employee_id, last_name, department_id, salary,
    sum(salary) over(order by employee_id)
from employees;

select sum(salary ) from  hr.employees


select employee_id, last_name, department_id, salary,
    sum(salary) over(partition by department_id order by employee_id)
from employees;

select employee_id, last_name, department_id, salary,
    sum(salary) over(order by salary)
from employees;


select employee_id, last_name, department_id, salary,
    max(salary) over(order by employee_id desc)from employees;

select employee_id, last_name, department_id, salary,
    min(salary) over(order by employee_id desc)
from employees;

select employee_id, last_name, department_id, salary,
    lead(salary, 1, 0) over(order by salary)   -- ozunden 1 sonraki setrin datasini gosterir
from employees;



select employee_id, last_name, department_id, salary,
    lead(salary, 1, null) over(order by salary),  --(lead(value,step,son deyeri gosterir)
    lead(salary, 1, null) over(order by salary) -salary
from employees;

select employee_id, last_name, department_id, salary, -- ozunden 2 sonraki setrin datasini gosterir
    lead(salary, 2,1) over(order by salary)
from employees;

select employee_id, last_name, department_id, salary,
     lead(salary, 1,0) over(order by salary) - salary as "Delta salary"
from employees;


select employee_id, last_name, department_id, salary,
     lead(salary, 1, salary) over(order by salary) - salary as "Delta salary"
from employees;

select employee_id, last_name, department_id, salary,
     salary - lead(salary, 1,0) over(order by salary) AS "Delta"
from employees;

select employee_id, last_name, department_id, salary,
     lag(salary, 1, 0) over(order by salary)  -- ozunden 1 evvelki setrin datasini gosterir
from employees;

select employee_id, last_name, department_id, salary,
     lag(salary, 1, 0) over(partition by department_id order by salary)  -- ozunden 1 evvelki setrin datasini gosterir
from employees;


