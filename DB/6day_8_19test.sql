--문제1) EMP 테이블에서 직업이 MANAGER인 사원의 사원번호, 사원명, 사수(MGR)번호, 사수명을 출력하여라.

select e1.empno 사원번호, e1.ename 사원명, e2.empno 사수번호, e2.ename 사수명
from emp e1, emp e2
where e1.mgr = e2.empno
and e1.job = 'MANAGER';

--문제2) EMP과 DEPT 테이블에서 직업이 MANAGER인 사원의 이름, 담당업무, 부서명, 근무지를 출력하여라.

select e.ename 사원명, e.job 직업, d.dname 부서명,d.loc 근무지
from emp e, dept d
where e.deptno = d.deptno
and e.job = 'MANAGER';


--문제3) EMP 테이블에서 이름의 첫글자가 ‘K’ 보다 크고 ‘Y’보다 적은 사원의 정보를 사원번호, 이름을 출력하여라. 단 이름순으로 정렬하여라.

select empno 사원번호, ename 사원명
from emp
where 'K' < substr(ename,1,1) 
and substr(ename,1,1) < 'Y'
order by ename;

--문제4) EMP 테이블에서 입사일부터 현재까지 근무일수를 출력하여라. 
--단 근무일수는 소수점 없이 출력하되 근무 일수가 많은 사람 순으로 출력하여라.

select ename 사원명, round(sysdate - hiredate) 근무일수
from emp
order by sysdate - hiredate desc;


--문제5) EMP 테이블에서 10번 부서 사람들의 급여의 총합을 계산하여 출력하여라.

select sum(sal) DEPT10급여총합
from emp
where deptno = 10;

--문제6) EMP 테이블에서 1981년 1월 1일 이후에 입사한 사원의 정보를 이름, 담당업무, 입사일자를 출력하여라.

select ename 사원명, job 직업, hiredate 입사일자
from emp
where hiredate > to_date('1981-01-01','YYYY-MM-DD') 
order by hiredate;

--문제7)  EMP과 DEPT 테이블에서 각 부서별 직업별 사원수를 출력하여라.
--단 사원이 없더라도 부서 정보를 출력하여라.

select d.deptno 부서번호, e.job 직업, count(e.job) 사원수
from emp e, dept d
where e.deptno(+) = d.deptno
group by d.deptno, e.job
order by d.deptno, e.job;

--문제8) EMP 테이블에서 부서 인원이 4명보다 많은 부서의 부서번호, 인원수를 출력하여라.

select e.deptno 부서번호 , count(e.deptno) 사원수
from emp e
having count(e.deptno) > 4
group by e.deptno;


--문제9) EMP 테이블에서 담당업무별 급여의 합이5000을 초과하는 담당업무와 급여의 합을 출력하여라. 단 급여의 합에 대해 정렬(내림차순)하여라.

select job 직업,  sum(sal) 급여의합
from emp
having sum(sal) > 5000
group by job
order by sum(sal) desc;

--문제 10) EMP 테이블에서 각 사원별 보너스가 0 또는 NULL이고 근무지가 ‘GO’로 끝나는 사원의 이름, 보너스, 부서번호, 부서명, 부서위치를 출력하여라. 
--단 보너스가 NULL이면 0으로 출력하여라.

select e.ename 이름, nvl(b.bonus,0) 보너스, d.deptno 부서번호, d.dname 부서명, d.loc 부서위치
from emp e, bonus b, dept d
where e.deptno(+) = d.deptno
and e.empno = b.empno(+)
and ((b.bonus = 0) or (b.bonus is null))
and d.loc like '%GO'
order by d.deptno;
