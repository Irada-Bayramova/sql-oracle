/*DML*/ --Data Manipulation Language

-- insert   cedvele yeni setr elave etmek uchundur
-- update   cedvelde olan setirlerin datasini deyishmek uchundur
-- delete   cedvelde olan ser=tirleri silmek uchundur


-- TRANSACTION - TCL -Transaction Control Language
--

----- insert

select * from departments;

describe departments;

/*
DEPARTMENT_ID   NOT NULL NUMBER(4)      -- serbest max 4 reqemli ID (tekrar olmamalidir)     
DEPARTMENT_NAME NOT NULL VARCHAR2(101)  -- serbest max 101 bayt metn
MANAGER_ID               NUMBER(6)      -- employees cedvelindeki her hansi employee_id
LOCATION_ID              NUMBER(4)      -- locations cedvelindeki her hansi location_id
*/

insert into departments(
                        DEPARTMENT_ID, 
                        DEPARTMENT_NAME, 
                        MANAGER_ID, 
                        LOCATION_ID)
                values (
                        500, 
                        'Huquq', 
                        100, 
                        1400);

select * from departments order by 1 desc;

commit;

insert into departments(DEPARTMENT_ID, DEPARTMENT_NAME)
values (600, 'Perakende');

select * from departments order by 1 desc;

rollback;

insert into departments(DEPARTMENT_ID, DEPARTMENT_NAME)
values (600, 'Perakende');

select * from departments order by 1 desc;

commit;

select * from user_tab_columns -- data dictionary view
where table_name ='DEPARTMENTS'; -- default


insert into departments(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
values (700, 'Korporativ', null, null);

select * from departments order by 1 desc;

commit;

insert into departments(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
values (800, 'Korporativ', default, default);

select * from departments order by 1 desc;

commit;

insert into departments 
values (900, 'Bank Cards', 101, 1500); -- yaxshi praktika deyil


insert into departments (department_id,location_id,DEPARTMENT_NAME)
values (920, 1700,'Bank Cards'); 

select * from departments order by 1 desc;

commit;

insert into departments 
values (1000, 101, 'Risk', 1500);  -- ERROR


insert into departments(DEPARTMENT_ID, MANAGER_ID, DEPARTMENT_NAME, LOCATION_ID)
values (1000, 101, 'Risk', 1500);

commit;

select * from departments order by 1 desc;

insert into departments(DEPARTMENT_ID, MANAGER_ID)
values (1100, 105); --ERROR (DEPARTMENT_NAME NOT NULL)

select * from departments order by 1 desc;


insert into departments(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
SELECT 
    EMPLOYEE_ID+3000, 
     (SELECT MAX(JOB_ID) FROM EMPLOYEES),
    MANAGER_ID, 
    1700 
FROM EMPLOYEES
WHERE DEPARTMENT_ID<=30;
    
select * from departments order by 1 desc;


insert into departments(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
SELECT 6000, 'XXXXX', 200, 1800 FROM DUAL;

select * from departments order by 1 desc;


insert into departments(DEPARTMENT_ID, 
                        DEPARTMENT_NAME, 
                        MANAGER_ID, 
                        LOCATION_ID)
VALUES(
        (SELECT MAX(DEPARTMENT_ID)+1 FROM DEPARTMENTS), 
        (SELECT MAX(JOB_ID) FROM EMPLOYEES), 
        101, 
        1500
        
        );

select * from departments order by 1 desc;

insert into  (select * from departments)
values (-1, 'YYYYY', 100, 1400);

commit;

insert into (select * from departments where department_id > 0 WITH CHECK OPTION)
values (111, 'YYYYY', 100, 1400);


--------------- update

update departments
    set department_name = 'Huquq Departamenti';

select * from departments;

rollback;

select * from departments;

select * from departments 
where department_id=500;

update departments
    set department_name = 'Huquq Departamenti'
where department_id=500;

select * from departments 
where department_id=500;

commit;

select * from departments 
where department_id=600;

update departments
    set manager_id = 107
where department_id=600;

select * from departments 
where department_id=600;

commit;


select * from departments 
where department_id=700;

update departments
    set department_name = department_name || ' Satishlar',
        manager_id = 107, 
        location_id = 1400
where department_id = 700;

select * from departments 
where department_id=700;

commit;

select * from departments 
where department_id=800;

update departments
    set location_id = (select max(location_id) from locations)
where department_id=800;

select * from departments 
where department_id=800;

commit;

select * from departments
where department_id between 50 and 80;

update departments d
    set d.manager_id = null
where d.department_id  between 50 and 80;

select * from departments
where department_id between 50 and 80;


update departments d
    set d.manager_id = (select min(e.employee_id) from employees e 
                                                  where e.department_id = 60)
where d.department_id  between 50 and 80;

select * from departments
where department_id between 50 and 80;

ROLLBACK;

select * from departments
where department_id between 50 and 80;

update  (select * from employees where salary>16000 with check option)
set salary =1000
where employee_id = 100; -- ORA-01402: view WITH CHECK OPTION where-clause violation


update (select * from employees where salary> 16000 with check option)
set salary =100000
where employee_id = 100; -- SUCCESS

rollback;


----- delete

select * from departments 
where department_id>270;

delete from departments 
where department_id>270;

rollback;

delete departments 
where department_id>270;

select * from departments 
where department_id>270;

commit;

select * from departments 
where department_id>270;
------------------


insert into departments(DEPARTMENT_ID, DEPARTMENT_NAME)
values (1001, 'XXX');

SAVEPOINT A;

insert into departments(DEPARTMENT_ID, DEPARTMENT_NAME)
values (1002, 'YYY');

SAVEPOINT B;

insert into departments(DEPARTMENT_ID, DEPARTMENT_NAME)
values (1003, 'ZZZ');
insert into departments(DEPARTMENT_ID, DEPARTMENT_NAME)
values (1004, 'KKK');

select * from departments
where department_id in (1001, 1002, 1003, 1004);

ROLLBACK TO SAVEPOINT B;

select * from departments
where department_id in (1001, 1002, 1003, 1004);

ROLLBACK;

select * from departments
where department_id in (1001, 1002, 1003, 1004);
---- SAVEPOINT yalniz Rollback ile ishleyir, Commit ile ishlemir