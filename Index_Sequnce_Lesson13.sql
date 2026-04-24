/*  INDEX, SEQUENCE */
select employee_id, first_name, job_id from employees
where first_name like 'A%';

select * from user_indexes;

select * from user_ind_columns where table_name ='EMPLOYEES' and column_name='FIRST_NAME';

drop index IND_EMP_FNAME;

create index ind_emp_fname on employees(first_name);  -- btree index

select employee_id, first_name, job_id from employees
where first_name like 'A%';

select employee_id, first_name, job_id from employees
where upper(first_name) like 'A%';

drop index iND_emp_fname_upp;

create index ind_emp_fname_upp on employees(upper(first_name)); -- btree function based index


select employee_id, first_name, job_id from employees
where upper(first_name) like 'A%';

---------------------
select * from user_ind_columns where table_name= 'EMPLOYEES' and column_name = 'JOB_ID';
drop index ind_bm_emp_job;
create bitmap index ind_bm_emp_job on employees(job_id);

select employee_id, first_name, job_id from employees
where job_id = 'SA_MAN';
------------

select employee_id, first_name, job_id from employees
where job_id = 'SA_MAN' and first_name like 'A%';

-----
/*
btree - sutundaki qiymetlerin distinct sayi chox olduqda (meselen: id, pincode, passport_no, email)
bitmap - sutundaki qiymetlerin distinct sayi az olduqda (meselen: rengler, heftenin gunleri)
*/

-----------------------------------------------------------------------
 --- SEQUENCE
 DROP SEQUENCE seq005
 
 
 create sequence seq001
 --start with 1
 --increment by 1
 --maxvalue nomaxvalues
 --minvalue 1
 --cycle nocycle
 --cache 20
 ;
 
 select seq001.nextval from dual;
 select seq001.currval from dual;

create sequence seq002
 start with 10
 increment by 10
 --maxvalue nomaxvalues
 --minvalue 1
 --cycle nocycle
 --cache 20
 ;

 select seq002.nextval from dual;
 select seq002.currval from dual;


create sequence seq003
 start with 10
 increment by 10
 maxvalue 100
 --minvalue 1
 --cycle nocycle
 --cache 20
 ;

 select seq003.nextval from dual;
 select seq003.currval from dual;
 
 
create sequence seq004
 start with 10
 increment by 10
 maxvalue 100
 --minvalue 1 --DEFAULLT
 cycle 
 cache 2
 ;

 select seq004.nextval from dual;
 select seq004.currval from dual;

 
create sequence seq005
 start with 10
 increment by 10
 maxvalue 100
 minvalue 5
 cycle 
 cache 2
 ;

 select seq005.nextval from dual;
 select seq005.currval from dual;

DROP TABLE seqtest01

create table seqtest01 (id number primary key, name varchar2(10));



create sequence ST01
start with 10
increment by 5;

insert into seqtest01(id, name)
values(ST01.nextval, 'D');

select ST01.currval from dual;

select * from seqtest01;

-----------------------------

/* PIVOT  */

select department_id, count(*) from employees
group by department_id;

select * from 
(select department_id from employees) 
pivot
(
    count(*)
    for department_id in (10, 20, 30, 40, 50)
);

select  department_id, sum(salary) from employees
group by department_id

select * from 
(select department_id, salary from employees) 
pivot
(
    sum(salary)
    for department_id in (10, 20, 30, 40, 50)
);
select department_id, job_id, salary from employees

select * from 
(select department_id, job_id, salary from employees where job_id in ('IT_PROG','AD_VP','AD_PRES')) 
pivot
(
    sum(salary)
    for department_id in (90,60)
);


select * from 
(select department_id, job_id, salary from employees) 
pivot
(
    sum(salary)
    for department_id in (10,20,30,40,50)
);

select * from 
(select to_char(hire_date, 'yyyy') as yr, to_char(hire_date, 'month') as mn  from employees) 
pivot
(
    count(*)
    for yr in (2011,2012,2013,2014,2015,2016,2017,2018)
);

select * from 
(select to_char(hire_date, 'yyyy') as yr,  department_id from employees) 
pivot
(
    count(*)
    for yr in (2011,2012,2013,2014,2015,2016,2017,2018)
);


with tab as (select distinct to_char(hire_date, 'yyyy') as yr  from employees)
select LISTAGG(yr, ',') within group(order by yr) from tab;

with
tab as (select distinct '''' || to_char(hire_date, 'fmmonth') ||'''' as mn  from employees)
select LISTAGG(mn, ',') within group(order by mn) from tab;


select * from 
(select to_char(hire_date, 'yyyy') as yr, to_char(hire_date, 'fmmonth') as mn  from employees) 
pivot
(
    count(*)
    for mn in ('april','august','december','february','january','july','june','march','may','november','october','september')
);

select * from 
(select to_char(hire_date, 'yyyy') as yr, to_char(hire_date, 'month') as mn  from employees) 
pivot
(
    count(*)
    for yr in (2011 as "Y_2011",2012 as "Y_2012")
);

-- Rollup and cube and group setting
/* ROLLUP grouping produces a results set
containing the regular grouped rows and the
subtotal values.

CUBE grouping produces a results set containing
the rows from ROLLUP and cross-tabulation rows.*/
SELECT department_id, job_id, SUM(salary)
FROM employees
WHERE department_id < 60
GROUP BY department_id, job_id
order by 1,2;


SELECT department_id, job_id,SUM(salary)
FROM employees
WHERE department_id < 60
GROUP BY ROLLUP(department_id, job_id);

select sum(salary )  from employees WHERE department_id < 60
/*
without group by  sum()
group by department_id sum()
group by department_id,job_id sum()
*/

SELECT department_id, job_id, SUM(salary)
FROM employees
WHERE department_id < 60
GROUP BY CUBE (department_id, job_id)

GROUP BY CUBE (department_id- x, job_id - y)

group by without both
group  by x 
group  by y 
group  by x, y


SELECT department_id DEPTID, job_id JOB, SUM(salary),
GROUPING(department_id) GRP_DEPT,GROUPING(job_id) GRP_JOB
FROM employees
WHERE department_id < 50
GROUP BY ROLLUP(department_id, job_id)


SELECT department_id DEPTID, job_id JOB, SUM(salary),
GROUPING(department_id) GRP_DEPT,GROUPING(job_id) GRP_JOB
FROM employees
WHERE department_id < 50
GROUP BY CUBE(department_id, job_id)


SELECT department_id, job_id, manager_id,sum(salary)
FROM employees
GROUP BY GROUPING SETS
((department_id,job_id), (job_id,manager_id));

