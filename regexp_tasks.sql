--like
--1
select first_name from employees
where regexp_like(first_name, '^S');

--2
select last_name from employees
where regexp_like(last_name, 'n$');

--3
select first_name from employees 
where regexp_like(first_name, '^{5}$');

--4
select first_name from employees
where regexp_like(first_name, '[[:alpha:]]');

--5
select email from employees
where regexp_like(email, '[[:digit:]]');

select email from employees;

--6
select first_name from employees
where regexp_like(first_name, 'A|B|C');

--7 
select last_name from employees
where regexp_like(last_name, 'tt|ss');

SELECT *
FROM hr.employees
WHERE REGEXP_LIKE(last_name, '(.)\1\1');

--substr
--8
select email, regexp_substr(email,'^.{3}') from employees;

--9
SELECT job_id,
       REGEXP_SUBSTR(job_id, '[^_]+$', 1, 1) AS extracted_part
FROM hr.employees;

--10
select first_name, regexp_substr(lower(first_name),'[aeiou]')
from employees;


--replace
--11
select first_name, regexp_replace(lower(first_name),'[aeiou]','*')
from employees;

--12
select email, regexp_replace(email, '[[:digit:]]', '#')
from employees;

--13
select phone_number,regexp_replace(phone_number, '[^[:digit:]]','')
from employees;

--14
select first_name, regexp_replace(first_name, '[ ]+', ' ')
from employees;

--instr
--15
select first_name, regexp_instr(lower(first_name),'[aeiou]',1)
from employees;

--16
select email, regexp_instr(email, '[:digit:]') 
from employees;

--17
select job_id, regexp_instr(job_id, '_') from employees;

--combined
--18
select first_name,email from employees
where regexp_like(email, '^' || substr(first_name, 1,1));

--19
select phone_number from employees
where regexp_like(phone_number, '[.]');

--20
select last_name from employees
where regexp_like(lower(last_name), '[aouei]{2,}');

--21
SELECT *
FROM hr.employees
WHERE REGEXP_LIKE(first_name, '^(.).*\1$');

--22
select email, regexp_substr(email, '[A-Z]+')
from employees;

--23
select job_id from employees
where regexp_like(job_id, '^[A-Z]{2}_[A-Z]{3}$');

--24
select first_name from employees
where regexp_like(lower(first_name), '(.)\1');

--25 
select * from employees;

select email || '@gmail.com' from employees;

select regexp_substr(email, '^[^@]+') from employees;