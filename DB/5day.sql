------------------------------------------------------------------------------
--jones의 급여보다 많이 받는 사원을 출력
--join을 이용해서 출력.
select e1.ename, e1.sal
from emp e1, emp e2
where e2.ename = 'JONES'
and e1.sal > e2.sal
--and e1.ename = e2.ename --이거 있으면 오류남 왜 오류나는지? 왜냐면 e2.ename은 위쪽 조건에서 JONES라는 이름만 가져오게 했기 때문에,
--JONES보다 급여가 많고 이름이 JONES인 이름을 가진 사람은 없기때문에 오류가 난다.
order by e1.sal;
--서브쿼리를 이용해서 출력.
select e1.ename, e1.sal
from emp e1
where e1.sal > (select sal from emp where ename = 'JONES') -- 비교하려는 대상(컬럼)은 그 레코드,컬럼의 갯수가 같아야한다.
order by e1.sal;
------------------------------------------------------------------------------
--스콧의 직업과 같은 사원조회
select *
from emp
where job = (select job from emp where ename = 'SCOTT');
--위에 문제를 join으로 풀기
select e1.* -- *을 이런식으로
from emp e1, emp e2
where e2.ename = 'SCOTT'
and e1.job = e2.job;
------------------------------------------------------------------------------
--7900사원의 급여보다 많이 받는 사원 조회
select sal from emp order by sal;

select empno,ename,job,sal
from emp
where sal > (select sal 
              from emp 
              where empno = 7900)
order by sal;

--7900사원의 급여보다 많이 받는 사원 조회
--join으로 풀어보기
-- self join인 경우 필요없는데이터가 생기지 않음? 생김.
select e1.ename, e1.sal
from emp e1, emp e2;
------------------------------------------------------------------------------
select e1.ename, e1.sal
from emp e1, emp e2
where e2.empno = 7900
and e1.sal > e2.sal
order by e1.sal;
------------------------------------------------------------------------------
--급여가 2000이상인 사원들의 직업과 같은사원들의 정보출력
select *
from emp
where job = (select job 
                    from emp 
                    where sal > 2000)
order by deptno;
--위에 구문이 에러가 나는 이유는 where조건절에서 select된 job은 여럿이기때문에 '=' 연산자와 맞지 않는다.
-- '='은 하나씩만 비교하는 연산자이기 때문이다. 이런 연산자를 single low operator라고 한다.
-- 때문에 아래와 같이 'in'과 같은 multi low operator로 해줘야한다.
select *
from emp
where job in(select job 
                    from emp 
                    where sal > 2000)
order by job;
------------------------------------------------------------------------------
-- CLARK이라는 사람과 직업과 부서번호가 같은 사원의 정보를 조회해라.
select *
from emp
where job = (select (job) from emp where ename ='CLARK')
and deptno = (select deptno from emp where ename ='CLARK');
--아래와 같이 where절에 두개 이상의 컬럼을 동시비교할 수 있다.
select *
from emp
where (job,deptno) = (select job,deptno from emp where ename ='CLARK');
--결과는 조건에 나오는 사람과 동일인 CLARK자신밖에 안나온다. 
select *
from emp
order by deptno;
------------------------------------------------------------------------------
--7369사원의 직업과 같고, 7876인 사원의 급여보다 많은 급여를 받는 사원의 정보를 출력하라.
select *
from emp
where job = (select job from emp where empno = 7369)
and sal > (select sal from emp where empno = 7876);
------------------------------------------------------------------------------
--최소 급여출력
select min(sal)
from emp;

--최소급여를 받는 사원정보 조회 서브쿼리 없이
select e1.deptno,  e1.sal
from emp e1, emp e2
where e1.deptno = e2.deptno
group by e1.deptno
having e1.sal = min(e2.sal);
--왜 안되지
--당연히 안됨. e2.sal은 group by로 묶여있지 않은 상황임.


--최소급여를 받는 사원정보 조회 서브쿼리 사용
select *
from emp
where sal = (select min(sal) from emp);
------------------------------------------------------------------------------
--각 부서별 최소급여
select e.deptno, min(e.sal)
from emp e
group by e.deptno;

select e.deptno, e.sal
from emp e
order by e.deptno;
------------------------------------------------------------------------------
--20번 부서의 최소급여
select e.deptno, min(e.sal)
from emp e
where e.deptno = 20
group by e.deptno;

select min(e.sal)
from emp e
where e.deptno = 20;
------------------------------------------------------------------------------
--각 부서별 최소급여 중, 20번 부서의 최소급여보다 많이받는 부서의 번호와 최소급여를 출력하라.
select e.deptno, min(e.sal)
from emp e
group by e.deptno
having min(e.sal) > (select min(sal) from emp where deptno = 20);

select e.deptno, min(e.sal)
from emp e
group by e.deptno
having min(e.sal) > (select min(e.sal) from emp e where e.deptno = 20);


select e.deptno, min(e.sal)
from emp e
group by e.deptno;
------------------------------------------------------------------------------
--아래와 같은경우 SMITH와 이름의 같은 여러명의 사람들이 있을수 있기 때문에
-- where 절에 '='대신에 in을 사용해주는것이 좋다.
select ename, job
from emp 
where job = (select job from emp where ename = 'SMITH');
------------------------------------------------------------------------------
-- any
-- 직업이 CLERK인 사원들의 급여의 최대급여보다 작은 급여를 갖는 사원의 정보.
select empno, ename, job, sal
from emp
where sal < any (select sal from emp where job = 'CLERK')
order by sal;

select sal from emp where job = 'CLERK' order by sal;
--위 아래 차이를 이해하자
-- all
select empno, ename, job, sal
from emp
where sal <= all(select sal from emp where job = 'CLERK')
order by sal;
------------------------------------------------------------------------------
--from절에 subquery사용하기
--10번 부서사람뽑기
select emp10.*
from (select * from emp where deptno = 10) emp10;
--위아래 같은거
select *
from (select * from emp where deptno = 10) emp10;
------------------------------------------------------------------------------
--사원들의 이름과 부서번호를 출력하되 급여는 CLARK사원의 급여를 계속해서 출력한다.
--select절의 subquery
select ename, deptno, (select sal from emp where ename = 'CLARK') as CLARK_SAL
from emp
order by deptno;

select ename, deptno, 2450 as csal
from emp
order by deptno;

select ename, deptno, sal
from emp
where sal = (select sal from emp where ename = 'CLARK');

------------------------------------------------------------------------------
--from에 subquery사용.
--  나머지 사원들의 이름을 출력하고 급여에서 CLARK의 급여를 뺀 급여를 출력하라.

select e.sal, csal.sal, e.sal- csal.sal
from emp e ,(select sal from emp where ename = 'CLARK') csal;
--위에 됨.

select sal,t.csal,sal - t.csal
from ( select sal, (select sal from emp where ename = 'CLARK') as csal from emp) t;
--위에 됨. 여기의 csal은 컬럼이다. from에서 참조한것은 emp테이블에서 sal과 (select sal from emp where ename = 'CLARK')로 만들어진 테이블

select sal, csal, sal - csal
from ( select sal, (select sal from emp where ename = 'CLARK') as csal from emp);
--바로  맨위 select절에 바로 csal이 불러와짐. 이해잘안감.

select ename,deptno, sal, sal - (select sal from emp where ename = 'CLARK')
from emp;
--위에 됨. 그러나 from절이 2번 사용됨 비효율적.
--from절 안에있는 from절은 효율적? 아직 이해가안됨.

select ename,deptno from emp; 
--emp에서 이름과 부서번호컬럼을 선택해서 새로운 테이블을만든다.

select sal, t, sal - t
from ( select sal, (select sal from emp where ename = 'CLARK') as t from emp);

--cnt 10 cnt 20 cnt 30
--각 부서별 사원수를 출력하시오
--가로로 출력.
select distinct (select count(*) from emp where deptno = 10 group by deptno ) as cnt10,
                (select count(*) from emp where deptno = 20 group by deptno ) as cnt20, 
                (select count(*) from emp where deptno = 30 group by deptno ) as cnt30
from emp;
--group by 안넣어도 됨.
--위에랑 차이점 group by의 유무와 from emp, from dual.
--from emp하면 레코드 개수만큼 출력되기 때문에 dual로 해주자.
select          (select count(deptno) from emp where deptno = 10) as cnt10,
                (select count(deptno) from emp where deptno = 20) as cnt20, 
                (select count(deptno) from emp where deptno = 30) as cnt30
from dual;

select          (select count(*) from emp where deptno = 10) as cnt10,
                (select count(*) from emp where deptno = 20) as cnt20, 
                (select count(*) from emp where deptno = 30) as cnt30
from dual;

--유동형 통계
--피봇
--group by 와 decode를 이용해서.
select e.deptno, count(e.deptno)
from emp e
group by e.deptno
order by e.deptno;
--계단식은 decode
--납작한건 group by
select sum(decode(deptno,10,1,0))as cnt10,
       sum(decode(deptno,20,1,0))as cnt20,
       sum(decode(deptno,30,1,0))as cnt30
from emp;

select decode(deptno,10,1,0)as cnt10,
       decode(deptno,20,1,0)as cnt20,
       decode(deptno,30,1,0)as cnt30
from emp;


select deptno,
       decode(deptno,10, count(*),0) as cnt10,
       decode(deptno,20, count(*),0) as cnt20,
       decode(deptno,30, count(*),0) as cnt30
from emp
group by deptno;
-- not a single-group group function
-- group by로 묶어야한다는 에러.
select deptno,
       decode(deptno,10, count(*),0) as cnt10
       --decode(deptno,20, count(*),0) as cnt20,
       --decode(deptno,30, count(*),0) as cnt30
from emp
group by deptno;
