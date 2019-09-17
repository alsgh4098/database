--연습문제1. 문제 5번
select *
from emp
where job = (select job from emp where empno = 7499)
and deptno = (select deptno from emp where empno = 7499);

--where절 멀티컬럼비교가능
select *
from emp
where (job,deptno) = (select job,deptno from emp where empno = 7499);

----------------------------------------------------------------
--연습문제1. 문제 6번
select ename, sal, deptno
from emp
where sal in (select sal from emp where deptno = 10);

--연습문제1. 문제 7번
select ename, hiredate
from emp
where deptno = (select deptno from emp where ename = 'BLAKE')
and ename != 'BLAKE';

--연습문제2. 문제 3번

select ename, empno
from emp
where empno = (select mgr 
                from emp 
                having count(mgr) = (select max(count(mgr)) 
                                      from emp 
                                      group by mgr)
                group by mgr);
--연습문제1. 문제8
select ename, sal, deptno
from emp
where (deptno,sal) in (select deptno,sal from emp where nvl(comm,0) != 0);

--연습문제2. 문제4.
select (select count(deptno) from emp where deptno = 10) as CNT10,
       (select count(deptno) from emp where deptno = 20) as CNT20
from dual;

--연습문제2. 문제5
select empno, ename, job, sal
from emp
where job = (select job from emp where empno = 7521)
and sal > (select sal from emp where empno = 7934);

--연습문제2. 문제6
select empno, ename, job, dname
from emp, dept
where emp.deptno = dept.deptno
and ename in (select ename 
              from emp 
              where sal in (select 
                            min(sal) 
                            from emp 
                            group by(job))
              )
order by job desc;

--연습문제2. 문제10
--여러가지 조건이 걸려있는 문제,서브쿼리나 조인이 필요한 문제는
--쪼개서 먼저 풀어보자.
--hiredate에서 제일 오래된값을 구하려면 min으로 구해야한다.
select empno, ename, deptno, hiredate
from emp
where hiredate in (select min(hiredate)
                      from emp
                      group by deptno);  

--부서별 입사일이 가장 오래된 사원을 구하시오.
select min(hiredate)
from emp
group by deptno;

--연습문제1. 문제9
select ename, sal
from emp
where mgr = (select empno from emp where ename = 'KING');

--join을 이용해서 풀기.
select e1.ename, e1.sal
from emp e1,emp e2
where e1.mgr = e2.empno
and e2.ename = 'KING';

--연습문제1. 문제10
--------------------------------------------------null값 not in과 = 으로도 비교불가능.
select ename,sal,nvl(comm,0)
from emp
where (sal,nvl(comm,0)) not in (select sal,nvl(comm,0) from emp where deptno = 30)
and deptno != 30;

select sal
from emp
where comm not in (null,0); --null값 비교 불가능. not null로만 가능.


--조건이 comm값이 다른거라고 했는데 null과 다른 comm을가진값이 없어 아래와 같이 나온다.
select ename,sal,nvl(comm,0)
from emp
where (sal) not in (select sal from emp where deptno = 30)
and (nvl(comm,0)) not in (select nvl(comm,0) from emp where deptno = 30)
and deptno != 30;





--연습문제2. 문제11
--어려움.
select deptno, dname, (select count(*) from emp where hiredate in (select hiredate from emp where to_date('19800101','YYYYMMDD') < hiredate and  hiredate < to_date('19810101','YYYYMMDD'))and deptno = d.deptno) as H1980,
                      (select count(*) from emp where hiredate in (select hiredate from emp where to_date('19810101','YYYYMMDD') < hiredate and  hiredate < to_date('19820101','YYYYMMDD'))and deptno = d.deptno) as H1981,
                      (select count(*) from emp where hiredate in (select hiredate from emp where to_date('19820101','YYYYMMDD') < hiredate)and deptno = d.deptno) as H198_
from dept d
order by deptno,dname;

--연습문제2. 문제12
--decode사용법.
select ename, decode(comm,0,500,null,500,comm)
from emp
where hiredate > to_date('19810531','YYYYMMDD');

--연습문제2. 문제13
select dept.deptno,ename,job,hiredate
from emp, dept
where hiredate between to_date('19810601','YYYYMMDD') and to_date('19811231','YYYYMMDD')
and dept.dname = 'SALES'
and emp.deptno = dept.deptno;

--연습문제2. 문제16
select e1.empno, e1.ename, e2.empno, e2.ename
from emp e1, emp e2
where e1.sal > e2.sal
and e1.mgr = e2.empno;

--연습문제2. 문제19
--부서별 사원정보가 없더라도 부서번호, 부서명을 출력해라.
--출력해줄 null값이 있으면 그것의 조건절에도 outer join을 해주어야한다.
select d.deptno, d.dname, e.empno, e.ename, e.hiredate
from emp e, dept d
where e.hiredate(+) > to_date('19810531','YYYYMMDD')
and e.deptno(+) = d.deptno
order by d.deptno, e.hiredate;

--연습문제2. 

--연습문제1. 문제12.
select d.deptno, d.dname, e.ename, e.sal
from emp e, dept d
where e.deptno(+) = d.deptno
order by e.deptno;
--연습문제1. 문제16.
select ename, dname, sal, job
from emp ,dept
where emp.deptno = dept.deptno
and emp.job = (select job from emp where ename = 'JONES');

--연습문제1. 문제17.
select empno,ename,hiredate,sal
from emp
where deptno = (select deptno from emp where ename = 'JONES')
order by deptno;

--연습문제1. 문제18.
select empno,ename,dname,hiredate,loc
from emp, dept
where emp.deptno(+) = dept.deptno
and job in (select job from emp where deptno = 20)
and dept.deptno = 10
order by dept.deptno;

--연습문제2. 문제1.
select deptno, count(*), sum(sal)
from emp
having count(*) > 4
group by deptno;

--연습문제1. 문제20.
select emp.deptno,job,empno,ename,dname,hiredate
from emp, dept
where job not in (select job from emp where deptno = 30)
and emp.deptno = 10
and emp.deptno = dept.deptno
order by emp.deptno;


--연습문제1. 문제21.
select empno,ename,dname,loc,sal
from emp, dept
where emp.deptno = dept.deptno
and job in (select job from emp where deptno = 10)
order by dept.deptno;

--연습문제1. 문제22.
select empno, ename, sal
from emp
where sal in (select sal from emp where ename = 'MARTIN' or ename = 'SCOTT')
order by sal;
---------------------------------------요건정리
--연습문제1. 문제23.
select empno,ename,job,sal
from emp
where job = (select job from emp where empno = 7521)
and sal > (select sal from emp where empno = 7934)
order by sal;

--연습문제1. 문제 24.
select deptno, ename, round((sal/160),1)
from emp
order by deptno,sal desc;

--연습문제1. 문제25.
select empno, ename,nvl(comm,0), dept.deptno, dname, loc
from emp, dept
where emp.deptno = dept.deptno
and loc like '%GO'
and nvl(comm,0) = 0
order by sal;

--연습문제1. 문제 29.
select e1.empno, e1.ename, e2.empno, e2.ename
from emp e1, emp e2
where e1.mgr = e2.empno
and e1.sal >= e2.sal;

--연습문제1. 문제 30.
select d.deptno, d.dname, e.empno, e.ename, e.hiredate
from emp e, dept d
where e.hiredate(+) > to_date('19810531','YYYYMMDD')
and e.deptno(+) = d.deptno
order by d.deptno, e.hiredate;

--연습문제1. 문제 31.
select empno, ename, hiredate, trunc((sysdate - hiredate)/365)
from emp
where trunc((sysdate - hiredate)/365) >= 30;

--to_char 에러
select to_char((sysdate - hiredate),'YYYY-MM-DD')
from emp;
--이미 데이터 형식을 갖고있음.
SELECT TO_CHAR(SYSDATE - hiredate)
FROM emp;

--연습문제2. 문제4.
select count(*)
from emp
group by deptno;

select sum(decode(deptno,10,1,0))as cnt10, sum(decode(deptno,30,1,0)) as cnt30
from emp;

--최소급여를 받는 사원정보 조회 
select *
from emp
where sal = (select min(sal) from emp);

--최소급여를 받는 사원정보 조회 서브쿼리 없이??????????????????????
select e1.*
from emp e1,emp e2
having e1.sal = min(e2.sal)
group by e2.empno;

--그룹별 최소급여를 받는 사원정보 조회
select *
from emp
where sal in (select min(sal) from emp group by deptno)
order by deptno;