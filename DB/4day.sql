--1. EMP 테이블에서 부서 인원이 4명보다 많은 부서의 부서번호, 인원수, 급여의 합을 출력하시오. 
select d.deptno, d.dname, count(d.deptno) 사원수, sum(e.sal) 급여합
from emp e, dept d
where e.deptno(+) = d.deptno
group by d.deptno, d.dname
having count(d.deptno) > 4
order by d.deptno;

--2.  EMP 테이블에서 가장 많은 사원이 속해있는 부서번호와 사원수를 출력하시오.
select e.deptno, d.dname, count(d.deptno)
from emp e, dept d
where e.deptno = d.deptno
having count(d.deptno) = (select max(count(deptno)) from emp group by deptno) -- 서브쿼리에서는 e.deptno를 출력할 필요가 없기때문에 max(count(deptno)만 select해준다.
group by e.deptno, d.dname
order by count(d.deptno);


--3. EMP 테이블에서 가장 많은 사원을 갖는 MGR의 사원번호를 출력하시오.
-- 다시 말해서 부사수를 가장 많이 가지고있는 사원번호를 출력하시오.
-- 어렵다 이거

--아래는 emp테이블 두개를 불러서 하나의 mgr과 다른 하나의 empno가 일치한것만 골라서 
--group by 사수테이블의 사원번호로 묶어서 행을세고 가장 많은 부사수가있는 사수번호를 고른것. 
select max(count(e2.empno)) 
from emp e1, emp e2 
where e1.deptno = e2.deptno 
and e1.mgr = e2.empno 
group by e2.empno;

--
select e2.empno, count(e2.empno)
from emp e1, emp e2 
where e1.deptno = e2.deptno and e1.mgr = e2.empno --여기서 핵심은 el.mgr = e2.empno
having count(e2.empno) = (select max(count(e2.empno)) 
                        from emp e1, emp e2 
                        where e1.deptno = e2.deptno 
                        and e1.mgr = e2.empno 
                        group by e2.empno)
group by e2.empno;




--4. EMP 테이블에서 부서번호가 10인 사원수와 부서번호가 30인 사원수를 각각 출력하시오.


--5. EMP 테이블에서 사원번호(EMPNO)가 7521인 사원의 직업(JOB)과 같고 사원번호(EMPNO)가 7934인 사원의 급여(SAL)보다 많은 사원의 사원번호, 이름, 직업, 급여를 출력하시오.


--6. 직업(JOB)별로 최소 급여를 받는 사원의 정보를 사원번호, 이름, 업무, 부서명을 출력하시오. 
--조건1 : 직업별로 내림차순 정렬

--7. 각 사원 별 시급을 계산하여 부서번호, 사원이름, 시급을 출력하시오.
--조건1. 한달 근무일수는 20일, 하루 근무시간은 8시간이다.
--조건2. 시급은 소수 두 번째 자리에서 반올림한다.
--조건3. 부서별로 오름차순 정렬
--조건4. 시급이 많은 순으로 출력.


--8. 각 사원 별 커미션(COMM)이 0 또는 NULL이고 부서위치가 ‘GO’로 끝나는 사원의 정보를 사원번호, 사원이름, 커미션, 부서번호, 부서명, 부서위치를 출력하여라. 
--조건1. 커미션(COMM)이 NULL이면 0으로 출력
select  e.empno, e.ename, nvl(e.comm,0), d.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno(+) = d.deptno and (e.comm = 0 or e.comm is null) and d.loc like '%GO'
order by d.deptno;





--9. 각 부서 별 평균 급여가 2000 이상이면 초과, 그렇지 않으면 미만을 출력하시오.
select d.dname, d.deptno, round(avg(e.sal),0), decode(    substr    (   to_char(avg(e.sal))  ,  length(to_char(round(avg(e.sal) , 0)))  -3  ,  1  ),    '2'    ,    '초과'    ,    '미만'    )
from emp e, dept d
where e.deptno = d.deptno
group by d.dname, d.deptno
order by d.deptno, avg(e.sal);


-- case when ~then~ end 문으로 쉽게.
select d.dname, d.deptno, round(avg(e.sal),0), 
(case
  when round(avg(e.sal),0) > 2000 then '초과'
  when round(avg(e.sal),0) <= 2000 then '미만' -- 또는 else ' '
end)
from emp e, dept d
where e.deptno = d.deptno
group by d.dname, d.deptno
order by d.deptno, avg(e.sal);

--10. 각 부서 별 입사일이 가장 오래된 사원을 한 명씩 선별해 사원번호, 사원명, 부서번호, 입사일을 출력하시오.

--11. 1980년~1980년 사이에 입사된 각 부서별 사원수를 부서번호, 부서명, 입사1980, 입사1981, 입사1982로 출력하시오. 

--12. 1981년 5월 31일 이후 입사자 중 커미션(COMM)이 NULL이거나 0인 사원의 커미션은 500으로 그렇지 않으면 기존 COMM을 출력하시오.
select e.hiredate, e.ename, decode(e.comm,0,500,null,500,comm)
from emp e
where e.hiredate > to_date('1981-05-31','YYYY-MM--DD')
order by e.hiredate;

----------------------------------------------------------------------------------
select e.hiredate, e.ename, decode(nvl(e.comm,0),0,500,comm)
from emp e
where e.hiredate > to_date('1981-05-31','YYYY-MM-DD')
order by e.hiredate;

select nvl(e.comm,0)
from emp e;

select substr('ascdefg',1,2)
from emp;

select ename, substr(ename, 1,2)||
lpad(substr(ename, -2,2), length(ename)-2, '*')
from emp;

--Q.각 부서의 직업별로 속해 있는 사원수를 출력하시오.
--조건1. 직업에는 반드시 매니저(mng)가 있다.
--조건2. 직업별 사원수는 최소 2명 이상인 직업을 대상으로 한다.
--조건3. 직업별 사원은 1981년3월이후 입사자를 대상으로 한다.

select e.deptno, count(deptno) 사원수
from emp e
where e.mgr != 0 
and e.mgr is not null 
and e.hiredate > to_date('1981-03-01','YYYY-MM-DD')
group by e.deptno
having count(deptno) >= 2
order by e.deptno;

select decode(to_char(1), (2001>2000) ,'초과','미만')
from emp;

--9. 각 부서 별 평균 급여가 2000 이상이면 초과, 그렇지 않으면 미만을 출력하시오.
select d.dname, d.deptno, round(avg(e.sal),0), decode(substr(to_char(avg(e.sal)), to_char(avg(e.sal)),1), '2','초과','미만')
from emp e, dept d
where e.deptno = d.deptno
group by d.dname, d.deptno
order by d.deptno, avg(e.sal);

select d.dname, d.deptno, round(avg(e.sal),0), decode(    substr    (   to_char(avg(e.sal))  ,  length(to_char(round(avg(e.sal) , 0)))-3  ,  1  ),    '2'    ,    '초과'    ,    '미만'    )
from emp e, dept d
where e.deptno = d.deptno
group by d.dname, d.deptno
order by d.deptno, avg(e.sal);

select d.dname, d.deptno, length(to_char(round(avg(e.sal),0)))
from emp e, dept d
where e.deptno = d.deptno
group by d.dname, d.deptno
order by d.deptno, avg(e.sal);


select d.dname, d.deptno, round(avg(e.sal),0), decode( substr ( to_char(avg(e.sal)), length(to_char(round(avg(e.sal),0)))-3,1), '2','초과','미만')
from emp e, dept d
where e.deptno = d.deptno
group by d.dname, d.deptno
order by d.deptno, avg(e.sal);

--13. 1981년 6월 1일 ~ 1981년 12월 31일 입사자 중 부서명(DNAME)이 SALES인 사원의 부서번호, 사원명, 직업, 입사일을 출력하시오.
--조건1. 입사일 오름차순 정렬
select d.dname, e.ename, e.job, e.hiredate
from emp e, dept d
where e.deptno(+) = d.deptno
and e.hiredate between to_date('1981-06-01','YYYY-MM-DD') and to_date('1981-12-31','YYYY-MM-DD')
and d.dname = 'SALES'
order by e.hiredate;