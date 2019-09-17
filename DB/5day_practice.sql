--별찍기
--이름의 앞뒤 두글자를 제외하고 별표시
select ename, substr(ename,1,1) || lpad('*',length(ename)-2, '*') || substr(ename,1,1) from emp;

--subquery
--나머지 사원들의 이름을 출력하고 급여에서 CLARK의 급여를 뺀 급여를 출력하라.
select ename, sal, sal - (select sal from emp where ename = 'CLARK') sal_clark_s_sal
from emp;


select 