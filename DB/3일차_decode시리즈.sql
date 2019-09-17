select sum(cnt10) as cnt10, sum(cnt20) as cnt20, sum(cnt30) as cnt30
from (
      select
       decode(deptno, 10, 1 ,0) as cnt10,
       decode(deptno, 20, 1 ,0) as cnt20,
       decode(deptno, 30, 1 ,0) as cnt30
      from emp	
 );
 
 select
     sum(decode(deptno, 10, 1 ,0)) as cnt10,
     sum(decode(deptno, 20, 1 ,0)) as cnt20,
     sum(decode(deptno, 30, 1 ,0)) as cnt30
from emp;
    
    
 select
     sum(decode(deptno, 10, count(*) ,0)) as cnt10,
     sum(decode(deptno, 20, count(*) ,0)) as cnt20,
     sum(decode(deptno, 30, count(*) ,0)) as cnt30
from emp
group by deptno;    
    