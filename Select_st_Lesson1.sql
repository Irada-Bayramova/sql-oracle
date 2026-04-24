--basic SQL statement

/*
 sql is 
case-insensitive
*/

--1)
select * from hr.employees;


--2)
Select  /* select list */
        employee_id,
        first_name,
        last_name
from hr.employees;

---  Projection (you can choose a few or as many columns of the tables as you require)


--3) 
Select   /* alias */
        employee_id as empid,
        first_name as empname,
        last_name as empsurname,
        salary 
from hr.employees;

--4) 
Select 
        employee_id as empid,
        first_name as empname,
        last_name empsurname, --(without as, its okay )
        salary 
from hr.employees;

 /* Start with: A-Z   ,
    Contain : 0-9  _  $  #   ,
    Length of alias mast be less than 30 (included)	
    Oracle 11g or prior,
    Oracle 12c or later 125
*/
--5)
Select 
        employee_id as emp_id,
        first_name as emp_name,
        last_name as "last name",
        salary 
from hr.employees;

--6) )
Select 
        employee_id as empid#,
        first_name as emp_name,
        last_name as "last name",
        salary 
from hr.employees;
    

---------------------

-- NUll is Empty, missing value

--7) 
Select 
        employee_id,
        first_name,
        last_name,
        salary,
        commission_pct
from hr.employees;


---------------

--8) 
Select 
        employee_id,
        first_name,
        'and',      /* String literal*/ 
        last_name,
        salary,
        commission_pct
from hr.employees;

--9)
 Select 
        employee_id,
        first_name,
        last_name,
        salary,
        12,      /* numeric literal */
        commission_pct
from hr.employees;

--10) 
Select 
        employee_id,
        first_name || last_name, /* double pipe is concat */
        salary,
        commission_pct
from hr.employees;

--11) 
Select 
        employee_id,
        first_name || ' ' || last_name, 
        salary,
        commission_pct
from hr.employees;

 ----------

--12) 
Select 
        employee_id,
        first_name || ' and ' || last_name, 
        salary,
        commission_pct
from hr.employees;


--13)
Select 
        employee_id,
        first_name,
        last_name, 
        salary * 12 as "Annual Salary",  
        commission_pct
from hr.employees;


--14) 
Select 
        employee_id,
        first_name,
        last_name, 
        salary * 12 as "Annual Salary",  
        commission_pct
from hr.employees;

--15) 
Select 
        employee_id,
        first_name,
        last_name, 
        salary,
        salary + 1000 * 12 as "New Salary"  /* (how will it work ?) */
from hr.employees;


--16) 
Select 
        employee_id,
        first_name,
        last_name, 
        salary,
        (salary + 1000) * 12 as "New Salary"  /* (how will it work ?) */
from hr.employees;


--17) 
Select 
        employee_id,
        first_name,
        last_name, 
        salary as "Gross Salary",
        commission_pct as "Fee",
        salary- salary * commission_pct as "Net Salary" 
        
from hr.employees;



--18) 
Select * from dual;


select 1, 'oracle' from dual;


select sysdate from dual;
select user from dual;

select 14599/12.5 from dual;

select 'Steven''s salary' from dual;

select q'!Steven''s salary!' from dual;

select q'[Steven's salary]' from dual;

select q'!Steven''s salary!' from dual;

select q'<Steven''s salary>' from dual;


--------

--19) 
describe hr.employees;

--20)
select rownum,
       employee_id,
       first_name,
       last_name,
       email
from hr.employees;

--21) 
select rownum,
        EMP.*
       
from hr.employees EMP; /* EMP- Alias of Employees table */
