---------  Single-Row SQL Functions

1.Single -row
2.Multiple-row (group fuctions)
3.Analytic


--- character
---number
--- date
--- datatype convertion
--- General (if then else, null)



---- character functions

-- case manipulation

1)Select lower('Oracle SQL Lessons'),
         upper('Oracle SQL Lessons'),
         initcap('Oracle sQL lessons')
         from dual;


 2)  select lower(last_name) from hr.employees;

3)         select lower(last_name) from hr.employees;
4)  select last_name from hr.employees
         where lower(last_name) like '%a%'; --- or upper A

----- data manuplation

5) select last_name, length(last_name) from hr.employees;
select last_name, length(last_name) as LEN from hr.employees;


6)select * from hr.employees
where length(last_name)= 6;

select * from hr.employees
order by length(last_name) asc;

7)select last_name, first_name, concat(last_name , first_name) from hr.employees;

8)select last_name, first_name, concat(last_name|| ' ' , first_name) from hr.employees;

9) select last_name, first_name, concat(concat(last_name, ' ') , first_name) from hr.employees; --- nested function

10) select last_name , substr(last_name , 3, 4) from hr.employees;

11) select last_name , substr(last_name , 3) from hr.employees;

12)select last_name , substr(last_name , -3, 2) from hr.employees;

13)select last_name , substr(last_name , -8, 7) from hr.employees;

14)select last_name , substr(last_name , -1), substr(last_name , -2), substr(last_name , -4)   from hr.employees;

15) --- phone number mask

 select phone_number , substr(phone_number, 1,3) || '***' || substr(phone_number,-4) as phone
from hr.employees;


16 ) select last_name, instr(last_name, 'a', 1, 1) from hr.employees;

select last_name, instr(last_name, 'a', 1, 2) from hr.employees;

select last_name, instr(last_name, 'a', 3, 2) from hr.employees;

select last_name, instr(last_name, 'a', 1) from hr.employees; ---1, 1

select last_name, instr(last_name, 'a') from hr.employees; ---1,1

select last_name, instr(last_name, 'a', -2, 1) from hr.employees; ---1,1


17) select last_name, lpad(last_name, 8, '*'),
 rpad(last_name, 8, '*') 
from hr.employees
where length(last_name) > 8; ---1,1


---- IBAN 28 ( 6 simvol id ) 000001, 000002, 000003, 0000101, 012345
select salary , lpad(salary, 6 , '0') from hr.employees;

18) select trim( '    Oracle SQL examples     ') from dual;

select ltrim('    Oracle SQL examples     ') from dual;

Select rtrim( 'xxxx   Oracle  SQL example   xxxxx' , 'x') from dual;
Select ltrim( 'xxxx   Oracle  SQL example   xxxxx' , 'x') from dual;
Select ltrim( 'xxxttt   Oracle  SQL example   xxxxxtt' , 'x') from dual;



19)Select last_name, replace(last_name, 'a', '#') from hr.employees;
Select last_name, replace(last_name, 'id', '@') from hr.employees;
Select last_name, replace(last_name, 'id', '@') from hr.employees;

Select last_name, replace(last_name, 'a', '') from hr.employees;
Select last_name, replace(last_name, 'a') from hr.employees; --same empty

Select last_name, replace(last_name, 'a', '_') from hr.employees;


Select last_name, replace(last_name, 'A', '_') from hr.employees;


Select last_name, replace(lower(last_name), 'a', '_') from hr.employees; --nested function



select last_name, replace(replace(last_name, 'a', '_'), 'A','_') from hr.employees ;  ---nested function



20) select last_name, translate(last_name, 'abcdi', '@$!.*l') from hr.employees;

select street_address , translate(street_address, '*0123456789', '*') from hr.locations;

select street_address , reverse(street_address) from hr.locations;


select street_address , translate(street_address, '*0123456789', '*') from hr.locations
where length(translate(street_address, '*0123456789', '*')) > 0;  ---regemden basqa her hansi simvolun yoxlanmasi


----------NUMBER

21) select round(3455.36) from dual;

select round(43451.67) from dual;

select round(2231.68 , 0) from dual;

select round(2231.68 , 1) from dual;

select round(5631.674764, 3) from dual;

select round(265231.674264, 3) from dual;

select round(265231.674264, -1) from dual;

select round(265261.674264, -2) from dual;
select round(42.67, 0) from dual;
select round(42.67, -1) from dual;


22)select trunc(1234.38) from dual;

select trunc(1234.87) from dual;

select trunc(1234.78, 0) from dual;
select trunc(1234.38,1) from dual;
select trunc(1234.38,-2) from dual;

23) select employee_id as "Odd",
last_name,
first_name
from hr.employees
where mod(employee_id,2) =1;

select employee_id as "Even",
last_name,
first_name
from hr.employees
where mod(employee_id,2) =0;


select trunc(10/3) from dual; --- tam hisseye baxmaq , same as div
select trunc(15/4) from dual;


24)
select abs(-13) from dual; --mutleq qiymet modul

 25) 
select abs(-13) from dual;
select greatest(5,10) from dual;
select least(2,5,8) from dual;

26) select floor(123.79) from dual;
select ceil(123.24) from dual;









