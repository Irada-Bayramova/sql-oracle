---- REGULAR EXPRESSIONS

select 'qwrty253euye2341tuirtu0' from dual;

select regexp_substr('qwxxxrty253euye2341tuirtu0', '[[:digit:]]+')  --0-9 
from dual;

select regexp_substr('qwxxxrty253euye2341tuirtu0', '[[:digit:]]') 
from dual;

select regexp_substr('qwxxxrty253euye2341tuirtu0', '[[:digit:]]+', 1, 2) 
from dual;

select regexp_replace('qwxxxrty253euye2341tuirtu0', '[[:alpha:]]+', '')  --a-zA-Z
from dual;

select regexp_replace('qwxxxrty253euye2341tuirtu0', '[[:digit:]]+', '') 
from dual;

select regexp_substr('qwxxxrty253euye2341tuirtu0', '[abcy]+') 
from dual;

select regexp_substr('qwxxxrty253euye2341tuirtu0', '[abc]')  --[a-f]
from dual;

select regexp_substr('qwxxxrty253euye2341tuirtu0', '[xwrt]') 
from dual;

select regexp_substr('qwxxxrty253euye2341tuirtu0', '[xwrt]+') 
from dual;

select regexp_substr('qwxxxrty253euye2341tuirtu0', '[0-9]+')  --[digit]
from dual;

select regexp_substr('qwxxxrty253euye2341tuirtu0', '[a-z]+') -- [alpa]
from dual;


select regexp_substr('qwXrty253euye2341tuirtu0', '[a-z]+') 
from dual;

select regexp_substr('qwXrty253euye2341tuirtu0', '[a-zA-Z]+') 
from dual;

select upper(regexp_substr('qwXrty253euye2341tuirtu0', '[a-zA-Z]+') )
from dual;

select regexp_substr('qwXrty253euye2341tuirtu0', 'qwX')  --anar
from dual;

select regexp_substr('qwXrty253euye2341tuirtu0', '[Xwq]+') --[anar]
from dual;

select regexp_substr('qwXrty253euye2341tuirtu0', '[Xwq]+') 
from dual;

select regexp_substr('Client1NameLastNameUSD2000.00Client2NameUSD1000.05Client3', 
                                                                        'USD[[:digit:].]+',1,2) 
from dual;

select regexp_replace('Aqwrty253E&*^uye2341tu!@irtu0', '[^[:alnum:]*]', '')  
from dual;

select regexp_replace('Aqwrty253E&*^uye2341tu!@irtu0', '[^[:alpha:][:digit:]]', '') 
from dual;

select regexp_replace('Aqwrty253Euye2341XXXirtu0', '[[:lower:]]', '')   --upper
from dual;

select 'Shefiqe-100;Parvin-150;Mehemmed-120' from dual;

select regexp_replace('Shefiqe-100;Parvin-150;Mehemmed-120', '[^;]','') from dual;

select regexp_substr('Shefiqe-100;Parvin-150;Mehemmed-120', '[^;]+') from dual;

select regexp_substr('Shefiqe-100;Parvin-150;Mehemmed-120', '[^;]+', 1, 2) from dual;

select regexp_substr('Shefiqe-100;Parvin-150;Mehemmed-120', '[^;]+$') from dual;

select regexp_substr('Shefiqe-100;Parvin-150;Mehemmed-120', '[^;]+', 1, level) 
from dual connect by level<=3;

select regexp_substr('Shefiqe-100;Parvin-150;Mehemmed-120', '[^;]+', 1, level) 
from dual connect by level<=regexp_count('Shefiqe-100;Parvin-150;Mehemmed-120', ';')+1;

select regexp_count(street_address, '[[:digit:]]') from locations;

select regexp_count('Shefiqe-100;Parvin-150;Mehemmed-120', ';') from dual;

select regexp_substr('Shefiqe-100;Parvin-150;Mehemmed-120;Ehmed-111', '[^;]+', 1, level) 
from dual connect by level<=regexp_count('Shefiqe-100;Parvin-150;Mehemmed-120;Ehmed-111', ';')+1;

select regexp_substr('A-B-C-D-E-F', '[^-]', 1, level) from dual connect by level <= regexp_count('A-B-C-D-E-F', '-')+1;

select chr(level+64)  from dual connect by level<=26;   65-A 66-B

select * from locations;


select last_name, regexp_substr(last_name, 'in|on|ng')  from employees;

select last_name, regexp_substr(last_name, '[in|on|ng]+')  from employees;

select 'Biz   onlyn SQL      dersi         kechirik' from dual;

select regexp_replace('Biz   onlyn SQL      dersi         kechirik', '[ ]+', ' ') 
from dual;

select regexp_replace('Biz  onlyn  SQL      dersi         kechirik', ' {2,}', ' ') 
from dual;


select regexp_replace('Biz  onlyn SQL       dersi         kechirik', ' {3,}', ' ') 
from dual;

select regexp_replace('Biz  onlyn SQL      dersi         kechirik', ' {2,}', '-') 
from dual;

select regexp_replace('Biz  onlyn SQL       dersi         kechirik', ' {3,}', '-') 
from dual;

select regexp_replace('Biz  onlyn SQL      dersi           kechirik', ' {2,3}', '-')  -- why 3
from dual;

select street_address from locations
where regexp_like(street_address, '[[:digit:]]'); -- icherisinde reqem olanlar

select street_address from locations
where regexp_like(street_address, '^[[:digit:]]'); -- reqemle bashlayanlar

select street_address from locations
where regexp_like(street_address, '[[:digit:]]$'); -- reqemle bitenler

select street_address from locations
where regexp_like(street_address, '^[[:alpha:]]'); -- herfle bashlayanlar

select street_address from locations
where regexp_like(street_address, '[[:alpha:]]$'); -- herfle bitenler

select street_address, regexp_replace(street_address, '[[:alpha:]]+', 'CITY') from locations;

select street_address, regexp_replace(street_address, '[[:alpha:] -.]+', ' CITY') from locations;

select regexp_substr('qwerty jkfj kjdfoie', 'qwerty') from dual;
select regexp_substr('qwerty jkfj kjdfoie', 'qertyw') from dual;
select regexp_substr('qwerty jkfj kjdfoie', '[qertyw]+') from dual;


select regexp_substr('fhgfg eqwwwertyy jkfj kjdeytrfoie', '[qertyw]+',1,2) from dual;

select regexp_substr('jkkkfj jkfj kjdfoie', 'j[fk]+j') from dual;

select regexp_substr('qwerty jkfj kjdfoie', 'j[fkj ]+j') from dual;


select '<tag><tag1>Name1</tag1><tag2>Name2</tag2></tag>'  from dual;

select regexp_replace('<tag><tag1>Name1</tag1><tag2>Name2</tag2></tag>', '<tag>|<tag1>|</tag1>|</tag>|<tag2>|</tag2>', ' ')  from dual;

select regexp_replace('<tag><tag1>Name1</tag1><tag2/>Name2</tag2></tag>', '<[[:alnum:]/]+>', ' ')  from dual;