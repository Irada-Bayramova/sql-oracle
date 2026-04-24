/*  Set operator
union all
union
intersect
minus
*/

select department_id, manager_id, job_id from employees where commission_pct is not null; --35
select department_id, manager_id, job_id from employees where commission_pct is null; --72


select distinct department_id, manager_id, job_id from employees where commission_pct is not null; --7
select distinct department_id, manager_id, job_id from employees where commission_pct is null; --26

select department_id, manager_id, job_id from employees where commission_pct is not null --35
union all
select department_id, manager_id, job_id from employees where commission_pct is null; --72

select department_id, manager_id, job_id from employees where commission_pct is not null --35
union -- distinct, order by 1
select department_id, manager_id, job_id from employees where commission_pct is null; --72



select department_id, manager_id, job_id from employees where commission_pct is not null --35
intersect -- distinct, order by 1
select department_id, manager_id, job_id from employees where commission_pct is null; --72

select department_id, manager_id, job_id from employees where commission_pct is not null --35
minus -- distinct, order by 1
select department_id, manager_id, job_id from employees where commission_pct is null; --72


select department_id, manager_id, job_id from employees where commission_pct is null --26 distinct
minus
select department_id, manager_id, job_id from employees where commission_pct is not null --7 distinct

-----------------------------------

select level as lv  from dual connect by level <=10;  --LEVEL — CONNECT BY istifadə ediləndə avtomatik yaranan column-dur.Oracle-da “number generator” kimi istifadə olunur.

select level+7 as lv  from dual connect by level <=10;


select level as lv  from dual connect by level <=10
union all
select level+7 as lv  from dual connect by level <=10;


select level as lv  from dual connect by level <=10
union --DISTINCT
select level+7 as lv  from dual connect by level <=10;

select level as lv  from dual connect by level <=10
intersect
select level+7 as lv  from dual connect by level <=10; -- A/B = A-A&B

select level as lv  from dual connect by level <=10
minus
select level+7 as lv  from dual connect by level <=10;

select level+7 as lv  from dual connect by level <=10 -- B/A= B-B&A
minus
select level as lv  from dual connect by level <=10;
----------------------------------------------------------

select department_id, manager_id, job_id from employees where commission_pct is not null 
union all
select department_id, manager_id from employees where commission_pct is null; 
--- her iki select-de sutunlarin sayi eyni olmalidir

select department_id, manager_id, job_id from employees where commission_pct is not null 
union all
select department_id, manager_id, null from employees where commission_pct is null; 

select department_id, manager_id, job_id from employees where commission_pct is not null 
union all
select department_id, manager_id, 'X' from employees where commission_pct is null; 

select department_id, manager_id, job_id from employees where commission_pct is not null 
union all
select department_id, manager_id, 0 from employees where commission_pct is null; 
--- her iki selectin muvafiq sutunlarinin datatype-lari eyni olmalidir

select department_id, manager_id, job_id from employees where commission_pct is not null 
union all
select department_id, manager_id, '0' from employees where commission_pct is null; 


select department_id, manager_id, job_id from employees where commission_pct is not null 
union all
select department_id, manager_id, to_char(salary) from employees where commission_pct is null;

-------------


select department_id, manager_id, job_id from employees where commission_pct is not null 
union all
select department_id, manager_id, to_char(salary) salary from employees where commission_pct is null
order by job_id;


select department_id, manager_id, job_id from employees where commission_pct is not null 
union all
select department_id, manager_id, to_char(salary) salary from employees where commission_pct is null
order by salary; -- error

--------------------------------------------

select department_id, manager_id, job_id from employees where commission_pct is not null 
union all
select department_id, manager_id, job_id from employees where commission_pct is null; 

select department_id, manager_id, job_id from employees 
where commission_pct is not null or commission_pct is null; 

select * from employees where department_id = 40 or department_id=50;

select * from employees where department_id = 40
union all
select * from employees where department_id = 50;
------------------------------------------------------

select level from dual connect by level<=10;  --NUMBER SUTUNU

select level+sysdate from dual connect by level<=10; --ARTAN YA AZALAN DATE SUTUNU

select chr(level+64) from dual connect by level<=26;  --65 = 'A' 66 = 'B'  ... ASCII koduna görə simvol qaytarır.


select CHR(level+64)from dual connect by level<=26; 