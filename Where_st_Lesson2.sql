--- WHERE

select * from hr.employees;

1)Select * from hr.employees
where department_id = 90;

2) Select * from hr.employees
where department_id > 90;

3) select * from hr.employees
 where department_id <> 90;   --or !=  or ^=
 
4) select * from hr.employees
 where hire_date = '17-jun-13' ; -- write with number 
 
 5) select last_name, salary, department_id from hr.employees
 where department_id = null ; --erorr
 
 6) select last_name, salary, department_id from hr.employees
 where department_id is null ; 
 
 
 7)  select last_name, salary, department_id from hr.employees
 where department_id <> null ;  --error
 
 8) select last_name, salary, department_id from hr.employees
 where department_id is not null;
 
 
 ----- IN   ,  BETWEEN , LIKE
 
 9) select *
from hr.employees
where manager_id in (100, 110, 101); 

 10) select * from hr.employees
 where manager_id not in (100, 110, 101);

 
 11) select * from hr.employees
 where job_id in ('SA_MAN', 'IT_PROG');
 
 12) Select * from hr.employees
 where job_id not in ('SA_MAN', 'ST_MAN');
 
 13) Select * from hr.employees
 where salary between 6500 and 10000; ---6500<= salary <= 10000
 
 14) Select * from hr.employees
 where salary not between 6500 and 10000;  --- salary <5000 or 1000<salary
 
  
 15) select * from hr.employees
  where hire_date between '01-jan-07' and '31-dec-13';
  
  16) select * from hr.employees
  where job_id like 'SA%';
  
  17) select * from hr.employees
  where job_id not like 'SA%';
  
  17) select * from hr.employees
  where job_id like '%PROG';
 
 18) select * from hr.employees
 where last_name like '%n';
 
 19) select * from hr.employees
 where last_name like 'A%n';
 
 20) select * from hr.employees
 where last_name like '%st%'; --if you write St
 
 21) select * from hr.employees
 where last_name like '_r%'; ---second symbol is R

22) select * from hr.employees
 where last_name like '%n___';

23) create table EMP_TEST (
    Emp_id number not null,
    First_name varchar2(20),
    EMAIL varchar2(10)
);
/

alter table EMP_TEST add constraint emp_test_emp_id_uq unique (Emp_id);
insert into EMP_TEST VALUES('555', 'Azer', 'Test_1');

24)Select * from EMP_TEST
where email like '%_%';  ---- all--metacharacter 

 select * from hr.employees
where job_id like '%SA\_%'  ESCAPE '\';

Select * from EMP_TEST
where email like '%\_%' escape '\';




25) select 'yes' as x from dual
where 'aabcde' like 'a_e'; --False

select 'yes' as x from dual
where 'aabcde' like 'a%'; --TRUE

select 'yes' as x from dual
where 'a%bcde' like 'a\%%' escape '\';

26) select first_name,
       last_name,
       salary,
       department_id
    from hr.employees
where department_id = null ;
 
select first_name,
       last_name,
       salary,
       department_id
    from hr.employees
where department_id is null ; ---or is not null 

27) select first_name,
       last_name,
       salary
    from hr.employees
where first_name like 'A%' and salary > 10000 ;

28)  select first_name,
       last_name,
       salary
    from hr.employees
where first_name like 'A%' or salary > 10000 ;

--   T AND T = T           T OR T = T
--   T AND F = F           F OR T = T
--   F AND T = F           T OR F = T
--   F AND F = F           F OR F = F


29) select first_name,
       last_name,
       job_id,
       salary
    from hr.employees
where  salary < 10000 and job_id like '%PROG' ;


30) select first_name,
       last_name,
       job_id,
       department_id
    from hr.employees
where  department_id = 80 and job_id like 'SA%' ;


31) select first_name,
       last_name,
       job_id,
       department_id
    from hr.employees
where  job_id like 'SA%' OR job_id like 'ST%' ;


32)select first_name,
       last_name,
       department_id
    from hr.employees
where department_id in (10,30) ; ---- or use not in

33) select first_name,
       last_name,
       department_id
    from hr.employees
where department_id not in (10,30) or department_id is null ;


34) select first_name,
       last_name,
       department_id
    from hr.employees
where department_id not in (10,30, null); ---is it work?


35) select last_name, salary, department_id
     from hr.employees
where not (last_name like 'A%'  and salary > 50000);

36) select last_name, salary, department_id
from hr.employees
where not (last_name like 'A%'  and salary > 5000);   ---  not ( true and false ) -- not(false) = true

37) select last_name,
       job_id,
       commission_pct
from hr.employees
where last_name like '%n' or job_id like 'ST' and commission_pct is null;

38)select last_name,
       job_id,
       commission_pct
from hr.employees
where (last_name like '%n' or job_id like 'ST') and commission_pct is null;


39) select employee_id, first_name, last_name , job_id, salary, manager_id
from hr.employees
order by last_name; --- default ASC

40) select employee_id, first_name, last_name , job_id, salary, manager_id
from hr.employees
order by manager_id desc nulls first;  ---- or nulls last


41)select employee_id, first_name, last_name , job_id, salary, manager_id
from hr.employees
order by manager_id asc, employee_id desc; 

42) select  first_name, last_name , job_id, salary, manager_id
from hr.employees
order by 1 asc; 

 after oracle 12c 
43) select  first_name, last_name , job_id, salary, manager_id
from hr.employees
order by salary desc fetch next 7 rows only; 


select  first_name, last_name , job_id, salary, manager_id
from hr.employees
order by salary desc fetch next 7 rows with ties; 


select  first_name, last_name , job_id, salary, manager_id
from hr.employees
order by salary desc offset 5 rows fetch next 6 rows only;