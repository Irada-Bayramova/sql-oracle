create table dept(  
  deptno     number(2,0),  
  dname      varchar2(14),  
  loc        varchar2(13),  
  constraint pk_dept primary key (deptno)  
);
create table emp(  
  empno    number(4,0),  
  ename    varchar2(10),  
  job      varchar2(9),  
  mgr      number(4,0),  
  hiredate date,  
  sal      number(7,2),  
  comm     number(7,2),  
  deptno   number(2,0),  
  constraint pk_emp primary key (empno),  
  constraint fk_deptno foreign key (deptno) references dept (deptno)  
);

INSERT INTO dept VALUES(10, 'ACCOUNTING', 'BAKU');
INSERT INTO dept VALUES(20, 'RESEARCH', 'SUMQAYIT');
INSERT INTO dept VALUES(30, 'SALES', 'GANCA');
INSERT INTO dept VALUES(40, 'OPERATIONS', 'LANKARAN');

SELECT * FROM DEPT;

INSERT INTO EMP VALUES
  (7369, 'TURAL', 'CLERK', 7902, '17-DEC-1980', 800, NULL, 20);
INSERT INTO EMP VALUES
  (7499, 'ALI', 'SALESMAN', 7698, '20-FEB-1981', 1600, 300, 30);
INSERT INTO EMP VALUES
  (7521, 'MURAD', 'SALESMAN', 7698, '22-FEB-1981', 1250, 500, 30);
INSERT INTO EMP VALUES
  (7566, 'SONA', 'MANAGER', 7839, '2-APR-1981', 2975, NULL, 20);
INSERT INTO EMP VALUES
  (7654, 'ELVIN', 'SALESMAN', 7698, '28-SEP-1981', 1250, 1400, 30);
INSERT INTO EMP VALUES
  (7698, 'KAMIL', 'MANAGER', 7839, '1-MAY-1981', 2850, NULL, 30);
INSERT INTO EMP VALUES
  (7782, 'NARGIZ', 'MANAGER', 7839, '9-JUN-1981', 2450, NULL, 10);
INSERT INTO EMP VALUES
  (7788, 'ELNUR', 'ANALYST', 7566, '09-DEC-1982', 3000, NULL, 20);
INSERT INTO EMP VALUES
  (7839, 'ELCHIN', 'PRESIDENT', NULL, '17-NOV-1981', 5000, NULL, 10);
INSERT INTO EMP VALUES
  (7844, 'ELMIR', 'SALESMAN', 7698, '8-SEP-1981', 1500, 0, 30);
INSERT INTO EMP VALUES
  (7876, 'NURAY', 'CLERK', 7788, '12-JAN-1983', 1100, NULL, 20);
INSERT INTO EMP VALUES
  (7900, 'RUFAT', 'CLERK', 7698, '3-DEC-1981', 950, NULL, 30);
INSERT INTO EMP VALUES
  (7902, 'ETIBAR', 'ANALYST', 7566, '3-DEC-1981', 3000, NULL, 20);
INSERT INTO EMP VALUES
  (7934, 'NURLAN', 'CLERK', 7782, '23-JAN-1982', 1300, NULL, 10);
SELECT * FROM EMP;

select * from dept;

commit;

SELECT * FROM dept;

SELECT * FROM EMP


select deptno from dept
where loc='BAKU';

select * from emp;

select * from emp
where sal>(select SAL AS SALARY from emp
where empno =7844);

--  >,<,=,>=,<=  tek setrli alt sorgu operatoru

select * from emp
where deptno=  (select deptno from dept
where loc='BAKU');


select * from emp
where 
deptno !=(select deptno from dept where loc='BAKU') AND   -- SINGLE  ROW FOR OPERATORS (=,<>, >, < ETC.)
deptno !=(select deptno from dept where loc='GANCA')  ;


select * from emp
where 
deptno NOT IN (select deptno from dept where loc IN ('BAKU','GANCA'))  ;   -- MULTIPLE ROW 

SELECT * FROM EMP
WHERE EMPNO =any (SELECT EMPNO FROM EMP
                WHERE TO_CHAR(HIREDATE,'YYYY')=1981);  --CHOX SETRLI ALT SORGULAR   = ANY , IN 

SELECT COUNT(EMPNO) NUMBER_OF_EMPS FROM EMP
WHERE EMPNO =any (SELECT EMPNO FROM EMP
                WHERE TO_CHAR(HIREDATE,'YYYY')=1981);
                

SELECT * FROM EMP
WHERE EMPNO IN (SELECT EMPNO FROM EMP
                WHERE TO_CHAR(HIREDATE,'YYYY')=1981);  --CHOX SETRLI ALT SORGULAR
    
--   =ANY   =  IN    SINONIM


SELECT * FROM EMP
WHERE  SAL  >ANY(SELECT SAL FROM EMP
            WHERE JOB='MANAGER');   --  > - MINIUMUM
            
SELECT * FROM EMP
WHERE  SAL  >ALL(SELECT SAL FROM EMP
            WHERE JOB='MANAGER');   -- ALL 
            
SELECT * FROM EMP
WHERE  SAL  <=ANY(SELECT SAL FROM EMP  --MAXIMUM
            WHERE JOB='MANAGER');
            
SELECT * FROM EMP
WHERE  SAL  < ALL(SELECT SAL FROM EMP
            WHERE JOB='MANAGER');

--en ashaghi maash olan shobeler
SELECT * FROM DEPT
WHERE deptno =(SELECT deptno from emp
                where sal = (select min(sal) from emp));
                
                
                
SELECT D.DNAME, MIN(E.SAL) FROM DEPT D
JOIN EMP E
ON D.DEPTNO = E.DEPTNO 
GROUP BY D.DNAME ;

SELECT D.* FROM DEPT D
JOIN EMP E
ON D.DEPTNO = E.DEPTNO 
WHERE sal = (select min(sal) from emp) ;        
     
     
     
                
SELECT * FROM emp 
WHERE (JOB, MGR) IN (SELECT JOB, MGR FROM emp 
				                     WHERE ENAME='NARGIZ')
and ename!='NARGIZ';

select * from dept;

create table department
(id number primary key,
name varchar2(20) not null);
select * from department;

select * from dept;

--alt sorgular INSERT ile
INSERT INTO DEPARTMENT
SELECT DEPTNO,DNAME FROM DEPT
WHERE LOC IN('BAKU','GANCA');


select * from emp WHERE    empno    =  7369;
UPDATE   emp
SET      JOB  = (SELECT  job 
                    FROM    emp 
                    WHERE   empno = 7788),
         sal  = (SELECT  sal 
                    FROM    emp 
                    WHERE   empno = 7902)
WHERE    empno    =  7369;


delete from emp
where empno in (select empNO from emp
                where job LIKE '%MAN');

 SELECT * FROM EMP;
 
 
 
 
 --SELECT , FROM (JOIN) , WHERE (HAVING) 
 
 
 SELECT 
     EMPNO,
     ENAME, 
     DEPTNO,
     NULL,
     (SELECT MAX(SAL) FROM EMP E  WHERE E.DEPTNO=EE.DEPTNO )
FROM EMP  EE
 
 
  SELECT 
     EMPNO,
     ENAME, 
     DEPTNO
FROM ( SELECT * FROM EMP E  WHERE JOB='SALESMAN') A
 
 
SELECT * FROM EMP E  WHERE JOB='SALESMAN'



SELECT * FROM EMP;

SELECT * FROM EMP
WHERE SAL > (SELECT SAL FROM EMP WHERE ENAME = 'TURAL');


SELECT ENAME,SAL FROM EMP
WHERE SAL IN (SELECT SAL FROM EMP WHERE DEPTNO = 20);


SELECT MGR FROM EMP 


SELECT * FROM EMP WHERE EMPNO IN (SELECT MGR FROM EMP );

SELECT DISTINCT M.ENAME FROM EMP E JOIN EMP M ON E.MGR=M.EMPNO


create table SALES_REPS(  
  ID     number(5,0),  
  NAME      varchar2(14),  
  SALARY        NUMBER(7,2),  
  commission_pct     number(7,2)
  
);


INSERT INTO sales_reps(id, name, salary,
commission_pct)

SELECT employee_id, last_name, salary,
commission_pct

FROM employees

WHERE job_id LIKE '%REP%';

SELECT * FROM sales_reps