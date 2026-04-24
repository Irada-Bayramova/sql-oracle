-------- JOIN

----- , -ORACLE SQL

----- JOIN ---ANSI SQL

select * from hr.employees; ---107 rows  106
select * from hr.departments;  --- 27 rows  27   


select * from hr.employees e inner join hr.departments d on e.department_id=d.department_id;


select d.*,e.* from hr.employees e right join hr.departments d on e.department_id=d.department_id;


select d.*,e.* from hr.employees e left join hr.departments d on e.department_id=d.department_id


select d.*,e.* from hr.employees e full join hr.departments d on e.department_id=d.department_id

122+107-106=123

select d.*,e.* from hr.employees e full join hr.departments d on e.department_id=d.department_id

-----cross join (cartesian product)

select * from hr.employees, hr.departments;  ---- 27 * 107  = 2889 rows 

select distinct employee_id from hr.employees

select hr.employees.employee_id,
hr.employees.first_name,
hr.employees.department_id,
hr.departments.department_id
from hr.employees, hr.departments
order by hr.employees.employee_id, hr.departments.department_id;

select e.employee_id,
e.first_name,
e.department_id,
d.department_id,
d.department_name
from hr.employees e , hr.departments d
order by e.employee_id, d.department_id;

select e.employee_id,
e.first_name,
e.department_id,
d.department_id,
d.department_name
from hr.employees e cross join hr.departments d  --no condition 
order by e.employee_id, d.department_id;    ----ansi sql 

---- INNER JOIN


select e.employee_id,
e.first_name,
e.department_id,
d.department_id,
d.department_name,
d.location_id,
l.location_id,
l.street_address,
l.postal_code
from hr.employees e , hr.departments d, hr.locations l
where   e.department_id = d.department_id 
    and l.location_id=d.location_id 
    
    
    --and e.department_id=80  


select e.employee_id,
e.first_name,
e.department_id,
d.department_id,
d.department_name,
d.location_id,
l.location_id,
l.street_address,
l.postal_code
from
hr.employees e 
inner join  hr.departments d on e.department_id = d.department_id
inner join hr.locations l on l.location_id=d.location_id 




select * from hr.locations


select * from hr.departments


select * from hr.employees
where department_id is null;






select e.employee_id,
e.first_name,
e.department_id,
e.manager_id,
d.department_id,
d.manager_id,
d.department_name
from hr.employees e , hr.departments d
where   e.department_id = d.department_id
and       d.manager_id = e.manager_id ;
        
        
        
        
select employee_id,
first_name,
e.department_id,
d.department_id,
d.department_name
from hr.employees e , hr.departments d
where e.department_id = d.department_id;   ----without alias





select employee_id,
first_name,
department_id,
d.department_name
from hr.employees e , hr.departments d
where e.department_id = d.department_id;    ---- ORA-00918: column ambiguously defined



select employee_id,
first_name,
e.department_id,
e.manager_id,
d.department_id,
d.manager_id,
d.department_name
from hr.employees e inner join hr.departments d
         on (e.department_id = d.department_id and e.manager_id = d.manager_id);  -- and e.hire_date > d.create_date
         
         --- ansi sql and 
         
select employee_id,
first_name,
e.department_id,
d.department_id,
d.department_name
from hr.employees e inner join hr.departments d
         on (e.department_id = d.department_id); 
         
         
         



        
select e.employee_id,
e.first_name,
department_id,
department_id,
d.department_name
from hr.employees e inner join hr.departments d
         using(department_id); 
         
         
select e.employee_id,
e.first_name,
department_id,
d.department_name
from hr.employees e inner join hr.departments d
         using(department_id); 
         
         
select e.employee_id,
e.first_name,
e.department_id,
d.department_name
from hr.employees e inner join hr.departments d
         using(department_id);  ----ORA-25154: column part of USING clause cannot have qualifier
         
        

   select e.employee_id,
          e.first_name,
          department_id,
          d.department_name,
          manager_id
from hr.employees e natural join hr.departments d;  ----result inner join     iki cedvelde de olan eyni adli sutunlari join edir. ( on d.department_id=e.department_id and e.manager_id=d.manager_id

--inner join vasitesi ile yuxardaki natural join bele yazilir
  select e.employee_id,
          e.first_name,
          e.department_id,
          d.department_name,
          d.manager_id
from hr.employees e inner join hr.departments d on d.department_id=e.department_id and e.manager_id=d.manager_id

--------------------------

select * from hr.employees natural join hr.locations;   ----- netice cross join



----- OUTER JOIN


select e.employee_id,
e.first_name,
e.department_id,
d.department_id,
d.department_name
from hr.employees e , hr.departments d
where e.department_id= d.department_id(+) ;   -----left outer join ---with null 107 rows



select e.employee_id,
e.first_name,
e.department_id,
d.department_id,
d.department_name
from hr.employees e left join hr.departments d
on e.department_id=d.department_id ;

select e.employee_id,
e.first_name,
e.department_id,
d.department_id,
d.department_name
from hr.employees e , hr.departments d
where e.department_id= d.department_id(+)
order by d.department_id nulls first; 



select e.employee_id,
e.first_name,
e.department_id,
d.department_id,
d.department_name
from hr.employees e , hr.departments d
where e.department_id(+)= d.department_id
order by d.department_id nulls first;  -----right outher join 122 rows



select e.employee_id,
e.first_name,
e.department_id,
d.department_id,
d.department_name
from hr.employees e , hr.departments d
where d.department_id(+)= e.department_id;  ----left outer join ---107 rows


select e.employee_id,
e.first_name,
e.department_id,
d.department_id,
d.department_name
from  hr.departments d, hr.employees e ,
where d.department_id(+)= e.department_id;  ------ left or right ?


select e.employee_id,
e.first_name,
e.department_id,
d.department_id,
d.department_name
from  hr.departments d left outer join hr.employees e 
on (d.department_id= e.department_id);  ---left outer join 122 rows


select e.employee_id,
e.first_name,
e.department_id,
d.department_id,
d.department_name 
from hr.departments d  left outer join hr.employees e   
on (d.department_id= e.department_id);    ----right outer joins 107 rows


---right 106 +1 = 107
--- left 106+16 = 122
--- full 106+1+16=123

select e.employee_id,
e.first_name,
e.department_id,
d.department_id,
d.department_name 
from hr.departments d  full outer join hr.employees e   
on (d.department_id= e.department_id); ---123 rows



--------

select 
        e.employee_id,
        e.last_name,
        e.department_id,
        d.department_id,
        d.department_name,
        d.location_id,
        l.location_id,
        l.city
    from hr.employees e,
   hr.departments d,
    hr.locations l
where e.department_id = d.department_id
and d.location_id = l.location_id;





select 
        e.employee_id,
        e.last_name,
        e.department_id,
        d.department_id,
        d.department_name,
        d.location_id,
        l.location_id,
        l.city
    from hr.employees e inner join hr.departments d
         on (e.department_id = d.department_id)
    inner join  hr.locations l
         on ( d.location_id = l.location_id);

------ self join

select 
employee_id,
last_name,
manager_id
from hr.employees;

select 
emp.employee_id,
emp.last_name,
emp.manager_id,
manager.employee_id,
manager.last_name
from hr.employees emp, hr.employees manager
where emp.manager_id = manager.employee_id
order by 1;

102=102

 select e1.last_name l1, -- ishchi 
       e2.last_name l2, -- l1-in manageri
       e3.last_name l3 -- l2-nin manageri
from 
    hr.employees e1, 
    hr.employees e2, 
    hr.employees e3
where 
    e1.manager_id = e2.employee_id(+)
    and 
    e2.manager_id = e3.employee_id(+)
order by e1.employee_id;      


--- non-equi join

select 
    d1.department_id, 
    d1.department_name, 
    d2.department_id, 
    d2.department_name
from hr.departments d1 , hr.departments d2
where d1.department_id < d2.department_id;

/*
    1. CROSS JOIN (CARTESIAN PRODUCT)
    2. INNER JOIN
    3. OUTER JOINS
        3.1 LEFT OUTER JOIN
        3.2 RIGHT OUTER JOIN
        3.3 FULL OUTER JOIN
*/

select 
    e.last_name, 
    r.region_name
from 
    hr.employees e, 
    hr.departments d, 
    hr.locations l, 
    hr.countries c, 
    hr.regions r
where
    e.department_id = d.department_id
    and 
    d.location_id = l.location_id
    and 
    l.country_id = c.country_id
    and 
    c.region_id = r.region_id;
    




select 
    e.last_name, 
    r.region_name
from 
    hr.employees e, 
    hr.departments d, 
    hr.locations l, 
    hr.countries c, 
    hr.regions r
where
  ( e.department_id = d.department_id
    and 
    d.location_id = l.location_id
    and 
    l.country_id = c.country_id
    and 
    c.region_id = r.region_id
    and   
    salary>1000 )and e.job_id like 'ST%';  -- wrong


--false or true 

select * from hr.employees e where e.job_id like 'ST%'; 
select * from hr.employees e where salary>1000

select 
    e.last_name, 
    r.region_name
from hr.employees e inner join hr.departments d
    on (e.department_id = d.department_id)
    inner join hr.locations l
    on (d.location_id = l.location_id) 
    inner join hr.countries c
    on (l.country_id = c.country_id)
    inner join hr.regions r
    on (c.region_id = r.region_id)
where    
    e.salary >10000 or e.job_id like 'ST';  --- it is okay