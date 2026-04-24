select sysdate from dual;

select sysdate + 1 from dual;  --- + 1 day 
select sysdate - 2 from dual;  ---- - 2 days

select hire_date, sysdate- hire_date from hr.employees;

select hire_date, trunc(sysdate- hire_date) from hr.employees;

select hire_date,
       months_between(sysdate, hire_date) as month_diff
from hr.employees;

select add_months(sysdate,5) from dual;   --- +5 months

select sysdate, hire_date, months_between(sysdate, hire_date) from hr.employees;


select last_day(sysdate) from dual;  --- last day of currently months

select hire_date , last_day(hire_date) from hr.employees;

select next_day(sysdate, 'mon') from dual; 

select next_day(sysdate-1, 'sat') from dual; 

select round(sysdate, 'dd') from dual;  

select round(sysdate, 'day') from dual;  -- 12 PM 
select round(sysdate, 'month') from dual;  --ayin 15 

select round(sysdate, 'year') from dual; -- JULY 1


select trunc(sysdate) from dual;
select trunc(sysdate, 'dd') from dual;
select trunc(sysdate, 'day') from dual;
select trunc(sysdate, 'month') from dual;
select TRUNC(sysdate, 'year') from dual;


---- datatype convertion



select sysdate from dual;

select to_char(sysdate, 'dd.mm.yyyy') from dual;

select to_char(sysdate, 'dd.mm.yyyy hh24:mi:ss') from dual;

select to_char(sysdate, 'DAY dd.mm.yyyy hh24:mi:ss') from dual;

select to_char(sysdate, 'Day, ddth "of" Month yyyy hh24:mi:ss') from dual;

select to_char(sysdate, 'Day, Ddspth "of" Month yyyy hh24:mi:ss') from dual;

select to_char(sysdate, 'fmDay, Ddth "of" Month yyyy hh24:mi:ss') from dual;

select to_char(sysdate, 'fmDay, Ddth "of" Month yyyy hh12:mi:ss PM') from dual;


select sysdate +1 from dual;


select to_char(sysdate, 'dd.mm.yyyy') +1 from dual;
select to_char(sysdate, 'ddmmyyyy') +1 from dual;


/*
select to_char(sysdate,'d') as week,
to_char(sysdate,'dd') as month,
to_char(sysdate,'ddd') as year
from dual;
*/


select to_char(sysdate, 'dd.mm.yyyy'),
to_char(sysdate, 'dd.mon.yyyy'),
to_char(sysdate, 'fmdd.month.yyyy'),
to_char(sysdate, 'fmdd.RM.yyyy'),
to_char(add_months(sysdate,4), 'fmdd.RM.yyyy'),
to_char(sysdate,'fmdd, RM "ay", yyyy "il"')
from dual;

select to_char(sysdate, 'dd.mm.yy'),
to_char(sysdate, 'yyyymmdd')
from dual;


select to_char(sysdate, 'hh24:mi:ss'),
to_char(sysdate, 'dd.mm.yyyy hh12:mi:ss PM'),
to_char(sysdate-12/24, 'dd.mm.yyyy hh12:mi:ss PM')
from dual;


select last_name,
salary,
hire_date
from hr.employees
where to_char(hire_date, 'dd.mm') = '24.03';


select first_name,
last_name,
salary,
hire_date
from hr.employees
where to_char(hire_date , 'dd.mm') =  to_char(sysdate, 'dd.mm');



-----to_char number


select salary, to_char(salary, '999,999.00') as formatted from hr.employees;

select salary, to_char(salary, 'fm999,999.00') as formatted from hr.employees;

select salary/7,
to_char(salary/7, '999,9999.00')
from hr.employees;

select salary/7,
to_char(salary/7, '999.00')
from hr.employees;


select to_char(commission_pct, '999,999.99'),
to_char(commission_pct, 'fm999,999.00'),
to_char(commission_pct, 'fm999,999.99')
from hr.employees
where commission_pct is not null;


select salary, to_char(salary, 'fm999,999.00') from hr.employees;
select salary, to_char(salary, 'fm999,990.00') from hr.employees;
select salary, to_char(salary, 'fm999999990.00') from hr.employees;


---- to_date(char)

select '11.04.2020' +1 from dual;
 
 
 


select to_date('11.04.2020', 'dd.mm.yyyy') + 1 from dual;

select last_name, hire_date from hr.employees
where hire_date < '01.jan.2014';  --- implicit datatype convertion (qeyri-ashkar)

select last_name, hire_date from hr.employees
where hire_date < '01.01.2003';  --- error

select last_name , hire_date from hr.employees
where hire_date < to_date('01.01.2014', 'dd.mm.yyyy') ;   ----explicit datatype convertion (ashkar )

select last_name , hire_date from hr.employees
where hire_date < to_date('20140101', 'yyyymmdd') ;

select last_name , hire_date from hr.employees
where hire_date < '20140101' ; --error





select to_date('05.07', 'dd.mm') from dual; --cari il

select to_date('05.2019', 'dd.yyyy') from dual;  --cari ay

select to_date('07.2019', 'mm.yyyy') from dual; -- cari ay , gun olsa default olaraq ayin 1


select *
from hr.employees
where to_char(hire_date, 'mmyyyy') = '082012';


select to_date('03.01.2022 07:12:55 PM', 'dd.mm.yyyy hh12:mi:ss PM') from dual;
select to_char(to_date('03.01.2022 07:12:55 PM', 'dd.mm.yyyy hh12:mi:ss PM'), 'dd.mm.yyyy hh12:mi:ss PM' ) from dual;



 ---- yminterval (year to month)
 ---- dsinterval ( day to second)
 
 select numtoyminterval(33, 'month') from dual; -- 2 years 9 months
 
 select numtoyminterval(1.4, 'year') from dual; -- 1 year 5 months
 
 select numtodsinterval(234.5, 'minute') from dual;  --- 3 hours 54 minutes 
 
 select numtodsinterval(95421, 'second') from dual;  ---- 2 hours 30 minutes 21 seconds
 
 select 
 to_char(sysdate, 'dd.mm.yyyy hh12:mi:ss PM') as "Product date",
 numtodsinterval(11234, 'minute'),
 to_char(sysdate + numtodsinterval(11234, 'minute'), 'dd.mm.yyyy hh12:mi:ss PM') as "Expiry date"
 from dual;
 
 select sysdate+1 from dual;

 select sysdate+ to_dsinterval('12 07:15:22' ) from dual;
 
 select to_char(sysdate + to_dsinterval('12 07:15:22'),'dd.mm.yyyy hh12:mi:ss PM')  from dual; --- error
 
 select to_char(sysdate + to_dsinterval('22 07:15:22'), 'dd.mm.yyyy hh12:mi:ss PM') from dual;
 
 select to_yminterval('13-01') from dual; --- error months>12


 
 -----to number(char)

 select '$12.376.33' + 1 as "Char" from dual; -- error
 
  select to_number('$12,376.33', '$999,999,999.99')+1 as "NUMBER" from dual;
  
    select to_number('$12,376.33', '$999,999,999.99') + 2000 as "NUMBER" from dual;
    
    SELECT to_number('12.376,33', '999.999,99') from dual; ---eror , default format is American
      
    SELECT to_number('12.376,33', '999G999D99', 'nls_numeric_characters = '',.''') from dual; 

SELECT to_number('12,376.33', '999G999D99', 'nls_numeric_characters = ''.,''') from dual;  -- russian format
  SELECT to_number('12#376*33', '999G999D99', 'nls_numeric_characters = ''*#''') from dual;


----NULL Functions
  
  select commission_pct , nvl(commission_pct, 0) from hr.employees;
   select commission_pct , nvl(commission_pct, 1) from hr.employees;
   
   select salary, commission_pct,
   salary - salary * commission_pct as "net salary"
  from hr.employees;
  
     select salary, commission_pct,
   salary - salary * nvl(commission_pct, 0) as "net salary"
  from hr.employees;


    select commission_pct,
  nvl(to_char(commission_pct), ' 111') --- it is work without to char
  from hr.employees;
  
  select commission_pct,
  nvl(to_char(commission_pct), ' ')
  from hr.employees;

  select coalesce(1, null, 2, null, 3,4,5) from dual;
  
  
  select coalesce(null, null, 2, null, 3,4,5) from dual;
  
  select coalesce(null, null, null, null, 3,4,5) from dual;

  select last_name, commission_pct, manager_id, department_id, email, phone_number,
  coalesce(to_char(commission_pct), to_char(manager_id), to_char(department_id), email,phone_number,to_char(hire_date)) as "null_handle"
  from hr.employees;
  
  
  select coalesce(net_salary, gross_salary) as "income" from customer; --error
  

  select salary, commission_pct,
  salary - salary * coalesce(to_char(commission_pct), '1')
  from hr.employees;
  
  select commission_pct,
  coalesce(to_char(commission_pct), '111')
  from hr.employees;  --- error

----------------------------------------------------------------------------------
select commission_pct,
  nvl2(commission_pct, 'Have', 'Not Have')
  from hr.employees;
  
    
  select commission_pct,
  nvl2(commission_pct, 1, 0)
  from hr.employees;

  select length(last_name),
  length(first_name),
  nullif(length(last_name), length(first_name)) ---- if equal == null or show the first value
  from hr.employees;
    
select nullif(1,2) , nullif(2,1), nullif(1,1) from dual;




 ---- if then else
 
---simple case
 select last_name, job_id,
 case job_id
 when 'SA_REP' then 'Reporter'
 when 'IT_PROG' then 'Programmer'
 when 'SA_MAN' THEN 'Manager'
 else 'Other'
 end as "Prof"
 from hr.employees;
 
 
 
  select last_name, job_id,
 case 
 when job_id='SA_REP' then 'Reporter'
 when job_id='IT_PROG' then 'Programmer'
 when job_id='SA_MAN' THEN 'Manager'
 else 'Other'
 end as "Prof"
 from hr.employees;
 
 
----search case
 Select last_name, department_id, job_id,
 case
     when department_id = 50 then job_id
     when job_id like 'SA%' then 'SA-XXXXX'
     when job_id like '%PROG' then 'Programmer'
     else 'Other'
     end as "Prof"
     from hr.employees;


 select last_name, job_id,
 decode(job_id,
         'SA_REP' , 'Reporter',
          'IT_PROG' ,'Programmer',
          'SA_MAN' , 'Manager',
           'Other') 
  as "Prof-decode"
 from hr.employees;    --- if not write other or else output is null
  
  
  select employee_id, last_name
     from employees;
     
     select employee_id,
     last_name,
     case mod(employee_id, 2)
     when 1 then 'odd'
     else 'even'
     end as "Result"
from hr.employees;  





/*
    tax rate
    2000 0.1
    4000 0.25
    6000 0.3
    8000 0.45
    > 0.5    
*/

select
    last_name,
    salary,
    case
        when salary < 2000 or job_id='SA_MAN' then 0.1
        when salary < 4000 then 0.25  --2200
        when salary < 6000 then 0.3
        when salary < 8000 then 0.45  
        else 0.5
    end as "Tax rate"
from hr.employees
order by salary;   


select
    last_name,
    salary,
    trunc(salary/2000),
    case  trunc(salary/2000)
        when 0 then 0.1  -- 0-2000
        when 1 then 0.25 -- 2000-4000
        when 2 then 0.3  -- 4000-6000
        when 3 then 0.45 -- 6000-8000
        else 0.5
    end as "Tax rate"
from hr.employees
order by salary;  


select
    last_name,
    salary,
    decode(trunc(salary/2000)
        ,0 ,0.1  -- 0-2000
        ,1 ,0.25 -- 2000-4000
        ,2 ,0.3  -- 4000-6000
        ,3 ,0.45 -- 6000-8000
        ,0.5
    ) as "Tax rate"
from hr.employees
order by salary;
