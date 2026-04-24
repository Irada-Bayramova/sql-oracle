 ----- DDL Create and manage Tables, Constranits -- Data Definition Language
 
 -- create
 -- alter (add, modify, drop, set unused)
 -- drop
 -- truncate
 -- rename
 -- comment
 drop table clients
 
 create table clients(
                        client_id number(6,0), 
                        clinet_name varchar2(50),
                        clinet_prefix varchar2(4),
                        client_phone number
                        );
                        
select * from user_tables
where table_name = 'CLIENTS';  

select * from user_objects
where trunc(created) = trunc(sysdate);

select * from user_tab_columns
where table_name = 'CLIENTS';

select * from clients;

insert into clients(client_id, 
                    clinet_name,
                    clinet_prefix,
                    client_phone)
values (1, 'King', '50', 5000000);                    


insert into clients(client_id, 
                    clinet_name,
                    clinet_prefix,
                    client_phone)
values (2, 'Kochhar', '70', 6000001);


insert into clients(client_id, 
                    clinet_name,
                    clinet_prefix,
                    client_phone)
values (3, 'De Hann', '70', 2000004);

select * from clients;

alter table clients
modify (client_id constraint pk_client_id primary key);

alter table clients
rename column clinet_name to client_name;  --old column to new column_name

alter table clients
rename column clinet_prefix to client_prefix;

alter table clients
modify (client_name constraint nn_client_name not null);

alter table clients
modify (client_prefix constraint ck_client_prefix check (client_prefix in ('50', '51', '55', '70', '77')));

select * from clients;

alter table clients
add constraint uq_client_ph unique (client_prefix, client_phone);

select * from user_cons_columns
where table_name = 'CLIENTS';

select * from user_constraints
where table_name = 'CLIENTS';


-------------------------------------

create table contracts(
                        contract_id number(7,0) GENERATED AS IDENTITY PRIMARY KEY,
                        open_date date not null,
                        close_date date,
                        CONSTRAINT ch_contract_dates CHECK (close_date >= open_date),
                        amount number(12,2) not null,
                        contract_no varchar2(20) not null unique,
                        client_id number(6,0),
                        constraint fk_contract_client_id foreign key (client_id)
                                                            references clients(client_id)
                        );

insert into contracts(
                        open_date,
                        close_date,                        
                        amount,
                        contract_no,
                        client_id
                        )
values (trunc(sysdate), null, 64648.34, 'con-001', 1);                        


insert into contracts(
                        open_date,
                        close_date,                        
                        amount,
                        contract_no,
                        client_id
                        )
values (trunc(sysdate), null, 55648.34, 'con-001-2', 1);


insert into contracts(
                        open_date,
                        close_date,                        
                        amount,
                        contract_no,
                        client_id
                        )
values (trunc(sysdate-5), null, 777748.34, 'con-002', 2);

select * from contracts;

select * from clients

commit;

select 
    cl.client_name,
    --cl.client_prefix || cl.client_phone as mobile_phone,
    cn.contract_no,
    cn.amount,
    cn.open_date
from clients cl inner join contracts cn 
        on (cl.client_id = cn.client_id);
        
select 
    cl.client_name,
    --cl.client_prefix || cl.client_phone as mobile_phone,
    LISTAGG(cn.contract_no|| ' - ' || cn.open_date, ', ') within group(order by cn.open_date),
    sum(cn.amount)
from clients cl inner join contracts cn 
        on (cl.client_id = cn.client_id)
group by
    cl.client_name
   -- cl.client_prefix || cl.client_phone
    ;

create table client_contracts_260225
as
select 
    cl.client_name,
  --  cl.client_prefix || cl.client_phone as mobile_phone,
    cn.contract_no,
    cn.amount,
    cn.open_date
from clients cl inner join contracts cn 
        on (cl.client_id = cn.client_id);

select * from client_contracts_260225;

insert into contracts(
                        open_date,
                        close_date,                        
                        amount,
                        contract_no,
                        client_id
                        )
values (trunc(sysdate-10), null, 1111111.34, 'con-002-3', 2);
select * from contracts;



select 
    cl.client_name,
    --cl.client_prefix || cl.client_phone as mobile_phone,
    cn.contract_no,
    cn.amount,
    cn.open_date
from clients cl inner join contracts cn 
        on (cl.client_id = cn.client_id);

select * from client_contracts_260225;

drop table client_contracts_260225;

create table client_contracts_230521
as
select 
    cl.client_name,
  --  cl.client_prefix || cl.client_phone as mobile_phone,
    cn.contract_no,
    cn.amount,
    cn.open_date
from clients cl inner join contracts cn 
        on (cl.client_id = cn.client_id);

select * from client_contracts_230521;

truncate table client_contracts_230521;  -- suretli silir
select * from client_contracts_230521;

delete  client_contracts_230521 where  client_name='King' -- sert verib, istenilen datani sile bilersen , yavas silir

drop table client_contracts_230521; -- cedvelin ozunu ve datasini silir

insert into client_contracts_230521
select 
    cl.client_name,
  --  cl.client_prefix || cl.client_phone as mobile_phone,
    cn.contract_no,
    cn.amount,
    cn.open_date
from clients cl inner join contracts cn 
        on (cl.client_id = cn.client_id);

select * from client_contracts_2304;

rename client_contracts_230521 to client_contracts_2304;  -- rename table_old_name to new_name

select * from client_contracts_2304;

delete clients 
where client_id = 2;

-------------------------
drop table books

create table books (book_id number generated as identity primary key,
                    book_subject varchar2(100) not null unique,
                    book_page_size number);
comment on table books is 'Kitablarin siyahisi';                    
comment on column books.book_id is 'Kitablarin unikal id-si, primary key, identity';
comment on column books.book_subject is 'Kitabin movzusu ve yaxud adi, unikal';
comment on column books.book_page_size is 'Kitabin sehifelerinin sayi';


select * from books;

select * from user_tab_comments
where table_name ='BOOKS';

select * from user_col_comments
where table_name ='BOOKS';

comment on column books.book_page_size is '';
comment on column books.book_id is 'Kitabin unikal id-si, primary key, identity';

select * from user_col_comments
where table_name ='BOOKS';

------ Types of constraints
/*
1. Primary key - Unikal olur ve null olmur. Bir cedvelde yalniz bir primary key ola biler.
2. Foreign key - Diger ve yaxud eyni cedvelin sutununa baglanir. Hemin sutun uzerinde ya primary key ya da unique constraint olmalidir.
                Child cedvele Parent-de olmayan ID-ni yazmaq olmur, 
                Parent-den Chile-da bagli ID-ni silmek/deyishmek olmur
                Child cedvelde hemin sutunu null saxlamaq olar.
                Primary key olan cedvel - Parent
                Foreign key olan cedvel - Child
                Child >> Parent
3. NOT NULL - Sutunu vacib edir, yeni hemin sutunu bosh saxlamaq olmaz.
4. UNIQUE - Sutunda olan qiymetler unikal (tekrarsiz) olur. Ancaq, istenilen sayda NULL yazila biler.
*/

alter table clients
drop column client_prefix;

select * from contracts

alter table contracts
drop column close_date;



select 
    cols.table_name, 
    cols.column_name, 
    cols.constraint_name, 
    cons.constraint_type, 
    cons.search_condition
from user_cons_columns cols inner join user_constraints cons
                        on (cols.constraint_name = cons.constraint_name)
where cols.table_name = 'CONTRACTS';


alter table contracts
drop constraint NN_CLIENT_NAME;


alter table contracts
drop constraint CH_CONTRACT_DATES;


alter table clients 
drop constraint PK_CLIENT_ID


SELECT * FROM contracts;

alter table contracts
set unused column amount; -- dropla oxshar

select * from user_unused_col_tabs;

alter table contracts
drop unused columns;