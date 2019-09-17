--1
SELECT E.ENAME,E.JOB,D.DNAME, D.LOC 
FROM DEPT D,EMP E
WHERE D.LOC = 'DALLAS'
AND D.DEPTNO = E.DEPTNO;

--2
SELECT E.ENAME, D.DNAME
FROM DEPT D, EMP E
WHERE D.DEPTNO = E.DEPTNO
AND E.ENAME LIKE 'A%';

--3
SELECT E.JOB,E.ENAME,D.DEPTNO
FROM DEPT D, EMP E
WHERE D.DEPTNO = E.DEPTNO
AND E.JOB = 'SALESMAN';

--4
SELECT D.DEPTNO,D.DNAME,E.ENAME,E.SAL
FROM DEPT D, EMP E
WHERE D.DEPTNO = E.DEPTNO
AND (E.DEPTNO = 10 OR E.DEPTNO = 20)
ORDER BY DEPTNO ASC,SAL DESC;

--5
SELECT *
FROM EMP E1, (SELECT * FROM EMP WHERE EMPNO = 7499) E2
WHERE E1.DEPTNO = E2.DEPTNO
AND E1.JOB = E2.JOB;

/* 6번 */
SELECT E1.ENAME, E1.SAL, E1.DEPTNO
FROM EMP E1, (SELECT * FROM EMP WHERE DEPTNO = 10) E2
WHERE E1.SAL = E2.SAL
AND E1.DEPTNO = E2.DEPTNO;

/* 7번 */
SELECT E1.ENAME, E1.HIREDATE
FROM EMP E1, (SELECT * FROM EMP WHERE ENAME = 'BLAKE') E2
WHERE E1.DEPTNO = E2.DEPTNO
AND E1.DEPTNO = E2.DEPTNO
AND E1.ENAME != 'BLAKE';

/* 8번 */
SELECT E1.ENAME, E1.SAL, E1.DEPTNO
FROM EMP E1, (SELECT * FROM EMP WHERE COMM IS NOT NULL) E2
WHERE E1.DEPTNO = E2.DEPTNO
AND E1.SAL = E2.SAL;

/* 9번 */
SELECT E1.ENAME,E1.SAL
FROM EMP E1 ,(SELECT * FROM EMP E2 WHERE ENAME = 'KING') E2
WHERE E1.MGR = E2.EMPNO;

/* 10번 */
SELECT E1.ENAME, E1.SAL, E1.COMM
FROM EMP E1, (SELECT * FROM EMP WHERE EMPNO = 30) E2
WHERE E1.SAL != E2.SAL;



/* 10번 */
select sal, nvl(comm,0) as comm from emp
where deptno=30;

select ename ,sal ,nvl(comm,0) as comm
from emp
where (sal,comm) not in (select sal,nvl(comm,0) as comm
                        from emp
                        where deptno=30);
                        
--12. EMP와 DEPT TABLE을 JOIN하여 부서 번호,  부서명,  이름, 급여를 출력하라.


--13. 이름이 'ALLEN'인 사원의 부서명을 출력하라.
select d.dname 
from dept d, emp e
where d.deptno = e.deptno
and ename = upper('allen');

select d.deptno, d.dname, e.ename, e.sal
from emp e, dept d
where e.deptno = d.deptno;

--14. DEPT Table에 있는 모든 부서를 출력하고, EMP Table에 있는 DATA와 JOIN하여 모든 사원의 이름, 부서번호, 부서명, 급여를 출력하라.
select e1.ename, e1.deptno, d.dname, e1.sal
from emp e1, dept d
where d.deptno = e1.deptno(+)
order by d.deptno;
--15. EMP 테이블의 모든 사원번호, 사원명, 매니저번호, 매니저명을 출력하라. 
select e1.empno, e1.ename, e1.mgr, e2.ename
from emp e1, emp e2
where e1.mgr = e2.empno
order by e1.mgr;

--17. 'JONES'가 속해있는 부서의 모든사람의 사원번호, 이름, 입사일, 급여를 출력하라.
select e1.deptno, e1.empno, e1.ename, e1.hiredate, e1.sal
from emp e1
where e1.deptno = (select deptno from emp where ename = 'JONES')
order by empno;

--18. 10번 부서의 사람들중에서 20번 부서의 사원과 같은 업무를 하는 사원의 사원번호, 이름, 부서명, 입사일, 지역을 출력하라.
select *
from emp e1
where e1.deptno = 10
and e1.job in (select job from emp where deptno = 20);

--20. 10번 부서 중에서 30번 부서에는 없는 임무를 하는 사원의 사원번호, 이름, 부서명, 입사일, 지역을 출력하라.
select *
from emp e1
where e1.deptno = 10
and e1.job not in(select job from emp where deptno = 30);

--21. 10번 부서와 같은 일을 하는 사원의 사원번호, 이름, 부서명, 지역, 급여를 급여가 많은 순으로 출력하라.
select *
from emp
where job in(select job from emp where deptno = 10);

--22. 'MARTIN'이나 'SCOTT'의 급여와 같은 사원의 사원번호, 이름, 급여를 출력하라.
select empno, ename, sal
from emp
where sal in(select sal from emp where ename = 'MARTIN' or ename = 'SCOTT')
and ename != 'MARTIN' and ename != 'SCOTT';

--23. EMP 테이블에서 사원번호(EMPNO)가 7521인 사원의 직업(JOB)과 같고 사원번호(EMPNO)가 7934인 사원의 급여(SAL)보다 많은 사원의 사원번호, 이름, 직업, 급여를 출력하시오.
select empno, ename, sal, job
from emp
where job = (select job from emp where empno = 7521)
and sal > (select sal from emp where empno = 7934);

--24. 각 사원 별 시급을 계산하여 부서번호, 사원이름, 시급을 출력하시오.
select deptno, ename, round(sal/160,1)
from emp
order by deptno,sal desc;

--25. 각 사원 별 커미션(COMM)이 0 또는 NULL이고 부서위치가 ‘GO’로 끝나는 사원의 정보를 사원번호, 사원이름, 커미션, 부서번호, 부서명, 부서위치를 출력하여라. 
select e.empno, e.ename, nvl(e.comm,0), d.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno
and nvl(comm,0) = 0
and loc like '%GO';

--26. 1981년 6월 1일 ~ 1981년 12월 31일 입사자 중 부서명(DNAME)이 SALES인 사원의 부서번호, 사원명, 직업, 입사일을 출력하시오.
select d.deptno, e.ename, e.job, e.hiredate
from emp e, dept d
where e.deptno = d.deptno
and e.hiredate between '1981-06-01' and '1981-12-31'
and dname = 'SALES';

--27. 현재 시간과 현재 시간으로부터 한 시간 후의 시간을 출력하시오.
select to_char(sysdate,'YYYY-MM-DD  HH24:MI:SS') 현재시간 ,to_char(sysdate+(1/24),'YYYY-MM-DD  HH24:MI:SS') 한_시간_후 from dual;

--28. 각 부서별 사원수를 출력하시오.
select d.deptno, d.dname, decode(count(empno),'0','없음',to_char(count(empno)) )
from emp e, dept d
where d.deptno = e.deptno(+)
group by d.deptno, d.dname
order by d.deptno;

--29.사원 테이블에서 각 사원의 사원번호, 사원명, 매니저번호, 매니저명을 출력하시오.
select e1.empno, e1.ename, e2.empno, e2.ename
from emp e1, emp e2
where e1.mgr = e2.empno
and e1.sal >= e2.sal;

--************************************************
--30. 각 부서별로 1981년 5월 31일 이후 입사자의 부서번호, 부서명, 사원번호, 사원명, 입사일을 출력하시오.
select d.deptno, d.dname, e.ename, e.hiredate
from emp e, dept d
where e.deptno(+) = d.deptno
and e.hiredate(+) > to_date('1981-05-31','yyyy-mm-dd')
order by d.deptno, e.hiredate asc;

--*************************************************
--31. 입사일로부터 지금까지 근무년수가 30년 이상인 사원의 사원번호, 사원명, 입사일, 근무년수를 출력하시오.
select empno, ename, hiredate, trunc((sysdate-hiredate)/365) as 근무년수
from emp
where trunc((sysdate-hiredate)/365) >= 30;