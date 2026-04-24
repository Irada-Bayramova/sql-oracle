------------ VIEW -----------
CREATE TABLE customers (
    cust_id          NUMBER
        GENERATED AS IDENTITY,
    cust_name        VARCHAR2(30),
    cust_pin         VARCHAR2(7),
    cust_address     VARCHAR2(50),
    cust_open_date   DATE,
    cust_status      CHAR(1)
);

ALTER TABLE customers MODIFY (
    cust_id PRIMARY KEY,
    cust_pin
        CONSTRAINT uq_custid UNIQUE
);

ALTER TABLE customers
    ADD CONSTRAINT ck_custstatus CHECK ( cust_status IN (
        'A',
        'D'
    ) );

ALTER TABLE customers MODIFY (
    cust_status DEFAULT 'A' NOT NULL
);

INSERT INTO customers (
    cust_name,
    cust_pin,
    cust_address,
    cust_open_date
) VALUES (
    'CUSTOMER-3',
    '3234567',
    'ADDRESS-3',
    trunc(sysdate)
);

SELECT
    *
FROM
    customers;

CREATE TABLE contracts (
    con_id                NUMBER
        GENERATED AS IDENTITY
    PRIMARY KEY,
    con_number            VARCHAR2(10) UNIQUE,
    con_amount            NUMBER(12, 2) CHECK ( con_amount >= 0 ),
    con_ccy               VARCHAR2(3),
    con_interest_rate     NUMBER(2, 2) CHECK ( con_interest_rate >= 0 ),
    con_interest_amount   NUMBER(12, 2) CHECK ( con_interest_amount >= 0 ),
    con_open_date         DATE,
    con_end_date          DATE,
    CONSTRAINT ck_con_dates CHECK ( con_end_date >= con_open_date )
);

ALTER TABLE contracts ADD (
    cust_id NUMBER
        REFERENCES customers ( cust_id )
);

SELECT
    *
FROM
    contracts;

INSERT INTO contracts (
    con_number,
    con_amount,
    con_ccy,
    con_interest_rate,
    con_interest_amount,
    con_open_date,
    con_end_date,
    cust_id
) VALUES (
    'CON-23',
    23000,
    'USD',
    0.23,
    230,
    TO_DATE('01.09.2018', 'DD.MM.YYYY'),
    TO_DATE('01.09.2023', 'DD.MM.YYYY'),
    2
);

COMMIT;

SELECT
    *
FROM
    customers;

SELECT
    *
FROM
    contracts;

ALTER TABLE contracts DROP COLUMN con_interest_amount;

SELECT
    *
FROM
    contracts con
    INNER JOIN customers USING ( cust_id );

SELECT
    cn.con_number          AS contract_no,
    cs.cust_name           AS customer_name,
    cn.con_amount          AS contract_amount,
    cn.con_ccy             AS currency,
    cn.con_interest_rate   AS rate,
    round((trunc(sysdate) - cn.con_open_date) * cn.con_interest_rate / 360 * cn.con_amount, 2)
FROM
    contracts   cn
    INNER JOIN customers   cs USING ( cust_id )
WHERE
    cs.cust_status = 'A'
    AND cn.con_end_date >= trunc(sysdate);

CREATE VIEW v_active_contracts AS
    SELECT
        cn.con_number          AS contract_no,
        cs.cust_name           AS customer_name,
        cn.con_amount          AS contract_amount,
        cn.con_ccy             AS currency,
        cn.con_interest_rate   AS interest_rate,
        round((trunc(sysdate) - cn.con_open_date) * cn.con_interest_rate / 360 * cn.con_amount, 2) AS interest_amount
    FROM
        contracts   cn
        INNER JOIN customers   cs USING ( cust_id )
    WHERE
        cs.cust_status = 'A'
        AND cn.con_end_date >= trunc(sysdate);

SELECT
    *
FROM
    v_active_contracts;

SELECT
    ac.contract_no,
    ac.customer_name,
    ac.interest_amount
FROM
    v_active_contracts ac;

CREATE VIEW v_inactive_contracts AS
    SELECT
        cn.con_number          AS contract_no,
        cs.cust_name           AS customer_name,
        cn.con_amount          AS contract_amount,
        cn.con_ccy             AS currency,
        cn.con_interest_rate   AS interest_rate,
        round((cn.con_end_date - cn.con_open_date) * cn.con_interest_rate / 360 * cn.con_amount, 2) AS interest_amount
    FROM
        contracts   cn
        INNER JOIN customers   cs USING ( cust_id )
    WHERE
        cs.cust_status = 'A'
        AND cn.con_end_date < trunc(sysdate);

SELECT
    *
FROM
    v_inactive_contracts;

UPDATE contracts
SET
    con_end_date = trunc(sysdate) - 10
WHERE
    con_id = 3;

SELECT
    *
FROM
    v_inactive_contracts;

CREATE OR REPLACE VIEW v_active_contracts AS
    SELECT
        ROW_NUMBER() OVER(
            ORDER BY
                cn.con_amount DESC
        ) AS n,
        cn.con_number          AS contract_no,
        cs.cust_name           AS customer_name,
        cn.con_amount          AS contract_amount,
        cn.con_ccy             AS currency,
        cn.con_interest_rate   AS interest_rate,
        round((trunc(sysdate) - cn.con_open_date) * cn.con_interest_rate / 360 * cn.con_amount, 2) AS interest_amount
    FROM
        contracts   cn
        INNER JOIN customers   cs USING ( cust_id )
    WHERE
        cs.cust_status = 'A'
        AND cn.con_end_date >= trunc(sysdate);

SELECT
    *
FROM
    v_active_contracts;

SELECT
    c.customer_name,
    c.interest_amount
FROM
    v_active_contracts c
WHERE
    c.n = 2;

SELECT
    c.customer_name,
    SUM(c.interest_amount) AS sum_int_amount
FROM
    v_active_contracts c
GROUP BY
    c.customer_name;

SELECT
    *
FROM
    v_active_contracts
UNION ALL
SELECT
    ROWNUM,
    ic.*
FROM
    v_inactive_contracts ic;

CREATE OR REPLACE VIEW v_emp_stat_by_dept AS
    SELECT
        department_id       AS dept_id,
        d.department_name   AS dept_name,
        SUM(e.salary) AS salary,
        COUNT(*) employee_count,
        round(AVG(e.salary), 2) AS salary_avg
    FROM
        employees     e
        INNER JOIN departments   d USING ( department_id )
    GROUP BY
        d.department_name,
        department_id;

SELECT
    *
FROM
    v_emp_stat_by_dept esd
WHERE
    esd.dept_id > 70
ORDER BY
    esd.dept_id;

SELECT
    *
FROM
    user_views;

SELECT
    *
FROM
    contracts;

CREATE OR REPLACE VIEW v_contracts_ins AS
    SELECT
        cn.con_number,
        cn.con_amount,
        cn.con_ccy,
        cn.con_interest_rate,
        cn.con_open_date,
        cn.con_end_date,
        cn.cust_id
    FROM
        contracts cn
    WHERE
        cn.con_open_date >= trunc(sysdate)
WITH CHECK OPTION;

SELECT
    *
FROM
    v_contracts_ins;

INSERT INTO v_contracts_ins (
    con_number,
    con_amount,
    con_ccy,
    con_interest_rate,
    con_open_date,
    con_end_date,
    cust_id
) VALUES (
    'conT-xx10',
    500000.23,
    'EUR',
    0.30,
    TO_DATE('21.05.2020', 'DD.MM.YYYY'),
    TO_DATE('21.05.2021', 'DD.MM.YYYY'),
    3
);

SELECT
    *
FROM
    contracts;
    
-------------------- READ ONLY

CREATE OR REPLACE VIEW v_contracts_view AS
    SELECT
        cn.con_number,
        cn.con_ccy,
        cn.con_interest_rate,
        cn.con_open_date,
        cn.con_end_date,
        cn.cust_id
    FROM
        contracts cn
WITH READ ONLY;

SELECT
    *
FROM
    v_contracts_view;

INSERT INTO v_contracts_view (
    con_number,
    con_ccy,
    con_interest_rate,
    con_open_date,
    con_end_date,
    cust_id
) VALUES (
    'conT-xx20',
    'EUR',
    0.30,
    TO_DATE('21.05.2020', 'DD.MM.YYYY'),
    TO_DATE('21.05.2021', 'DD.MM.YYYY'),
    3
);

SELECT
    *
FROM
    contracts;
    
--CTE COMMAN TABLE EXPRESSION 

WITH high_salary AS (
    SELECT
        employee_id,
        first_name,
        salary
    FROM employees
    WHERE salary > 10000
)
SELECT *
FROM high_salary;


--Subqueris version
SELECT *
FROM (
    SELECT employee_id, first_name, salary
    FROM employees
    WHERE salary > 10000
);


WITH high_salary AS (
    SELECT *
    FROM employees
    WHERE salary > 10000
),
emp_dept AS (
    SELECT
        h.employee_id,
        h.first_name,
        d.department_name
    FROM high_salary h
    JOIN departments d
        ON h.department_id = d.department_id
)
SELECT *
FROM emp_dept;

WITH dept_avg AS (
    SELECT department_id, AVG(salary) avg_sal
    FROM employees
    GROUP BY department_id
)
SELECT *
FROM dept_avg
WHERE avg_sal > 8000;


--Department üzrə orta maaşdan yüksək qazanan işçilər
WITH dept_avg_salary AS (
    SELECT
        department_id,
        AVG(salary) avg_salary
    FROM employees
    GROUP BY department_id
)
SELECT
    e.employee_id,
    e.first_name,
    e.salary,
    d.department_name
FROM employees e
JOIN dept_avg_salary a
    ON e.department_id = a.department_id
JOIN departments d
    ON e.department_id = d.department_id
WHERE e.salary > a.avg_salary;

--Hər department-də ən yüksək maaş alan işçi

WITH max_salary AS (
    SELECT
        department_id,
        MAX(salary) max_sal
    FROM employees
    GROUP BY department_id
)
SELECT
    e.employee_id,
    e.first_name,
    e.salary,
    d.department_name
FROM employees e
JOIN max_salary m
    ON e.department_id = m.department_id
   AND e.salary = m.max_sal
JOIN departments d
    ON e.department_id = d.department_id;
    
--Ən çox işçisi olan department
WITH dept_count AS (
    SELECT
        department_id,
        COUNT(*) emp_count
    FROM employees
    GROUP BY department_id
)
SELECT
    d.department_name,
    dc.emp_count
FROM dept_count dc
JOIN departments d
    ON dc.department_id = d.department_id
WHERE dc.emp_count = (
    SELECT MAX(emp_count)
    FROM dept_count
);

--Eyni job title və department olan işçilər

WITH emp_info AS (
    SELECT
        e.employee_id,
        e.first_name,
        e.job_id,
        e.department_id,
        j.job_title,
        d.department_name
    FROM employees e
    JOIN jobs j
        ON e.job_id = j.job_id
    JOIN departments d
        ON e.department_id = d.department_id
)
SELECT *
FROM emp_info
WHERE job_title = 'Sales Manager';

--Department üzrə maaş sıralaması (ranking)
WITH ranked_emp AS (
    SELECT
        employee_id,
        first_name,
        department_id,
        salary,
        RANK() OVER (
            PARTITION BY department_id
            ORDER BY salary DESC
        ) rnk
    FROM employees
)
SELECT *
FROM ranked_emp
WHERE rnk <= 3;



