--각 부서별 평균 급여
select d.dname, d.deptno, round(avg(e.sal),0)
from emp e, dept d
where e.deptno(+) = d.deptno
group by d.dname, d.deptno
order by avg(e.sal);


--문제 : 각 부서별 평균급여 중 가장 적은 평균급여를 갖는 부서는
select d.deptno 부서번호, d.dname 부서명, round(avg(e.sal),0) 평균급여
from emp e, dept d
where e.deptno = d.deptno   
group by d.deptno, d.dname;
--

--서브쿼리를 from 말고 select에도 사용할수 있구나.
select d.deptno 부서번호, d.dname 부서명, round(avg(e.sal),0) as 평균급여
from emp e, dept d
where e.deptno = d.deptno   
group by d.deptno, d.dname
having avg(e.sal) = (select min(avg(sal)) from emp group by deptno)
;                          

--각 부서별 최소급여를 받는사람의 부서이름, 부서번호, 이름
select d.dname, d.deptno, e.sal
from emp e, dept d
where e.sal in (select min(sal) from emp group by deptno)
and e.deptno = d.deptno;

--부서별 최소급여 구하기.
select min(sal)
from emp
group by deptno;


--문제: emp 테이블에서 가장 많은 직업은?


--부서별 평균급여

select d.deptno, round(avg(e.sal))
from emp e, dept d
where e.deptno(+) = d.deptno
group by d.deptno
order by d.deptno;

select d.deptno, round(avg(e.sal))
from emp e, dept d
where e.deptno(+) = d.deptno
group by d.deptno
order by d.deptno;

--각 부서별 평균급여중 가장 작은 급여를 갖는부서 출력.
--어렵게 느껴지는 이유 : join을 사용하던 서브쿼리를 사용하던 두개의 테이블이 필요하고 그 두개의 테이블 모두 group by를 걸어야하기때문에

select e2.deptno, min(e2.avg_sal)
from (select e1.deptno, avg(e1.sal) as avg_sal 
              from emp e1
              group by e1.deptno) e2-- 테이블에서 as불가.

group by e2.deptno;

select e1.deptno, round(avg(e1.sal))
from emp e1
having avg(e1.sal) =  (select min(avg(sal))
              from emp
              group by deptno)
group by e1.deptno;


select e.deptno 부서번호, round(avg(e.sal),0) as 평균급여
from emp e
group by e.deptno
having avg(e.sal) = (select min(avg(sal)) from emp group by deptno);

--각 부서별 평균급여중 가장 작은 급여를 갖는부서 출력.
--어렵게 느껴지는 이유 : join을 사용하던 서브쿼리를 사용하던 두개의 테이블이 필요하고 그 두개의 테이블 모두 group by를 걸어야하기때문에
select e.deptno, d.dname, round(avg(e.sal))
from emp e, dept d
having avg(e.sal) = (select min(avg(sal)) from emp group by deptno)
group by e.deptno, d.dname;
