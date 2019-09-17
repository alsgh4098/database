--1번 dallas에 근무하는 사원의 이름, 직업 , 부서번호, 부서이름을 출력하라.
select e.ename, e.job, e.empno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno and loc = 'DALLAS'
order by e.empno;

--2번 이름에 'A'가 들어가는 사원의 이름과 부서를 출력하라.
select e.ename, d.dname
from emp e, dept d
where e.deptno = d.deptno and e.ename like '%A%'
order by d.dname;

--3번 직업이 salesman인 사람들의 직업과 이름 부서이름을 출력하라.
select e.ename, d.dname, e.job
from emp e, dept d
where e.deptno = d.deptno and e.job = 'SALESMAN'
order by d.dname;


--4번 부서 10번 20번사원들
select d.deptno , d.dname , e.ename, e.sal
from emp e, dept d 
where (e.deptno = d.deptno) and (d.deptno = '10' or d.deptno = '20')
order by e.deptno , e.sal desc;


--5번 사원번호가 7499인 사원의 직업과 부서번호와 일치하는 사원의 정보를 출력해라.
select *
from emp e, dept d, (select deptno, job from emp where EMPNO = '7499') e2
where (e.deptno = d.deptno) and (e.deptno = e2.deptno and e.job = e2.job);

--6번 10번 부서의 사원들과 같은 월급을 갖는 월급을 받는 사원들의 이름, 월급, 부서
select e.ename, d.dname, e.sal
from emp e, dept d, (select sal from emp where deptno = '10') e2
where (e.deptno = d.deptno) and (e.sal = e2.sal);

--7번 blake와 같은 부서에 있는 사원들의 이름과 고용일 출력. 단, blake는 빼고.
select e.ename, e.hiredate
from emp e, (select ename,hiredate,deptno from emp where ename = 'BLAKE') e2
where e.deptno = e2.deptno and e.ename != 'BLAKE';


--8번 여러명의 사원중 커미션을 받는 사원은 몇명없다. 이 커미션을 받는 사원들의 부서번호와 월급이 같은 사원의 이름과 월급, 부서번호를 출력해라.
select e.ename, e.sal, e.deptno
from emp e, (select ename, sal, deptno from emp where emp.comm is not null) e2
where e.sal = e2.sal and e.deptno = e2.deptno;

--9번

--10. 30번 부서 사원들과 월급과 커미션이 같지 않은 사원들의 이름, 월급, 커미션을 출력하라.
select e.ename, e.sal, e.comm
from emp e, (select comm, sal from emp where deptno = 30) e2
where e.sal != e2.sal and e.comm != e2.comm
order by e.sal desc;

select sal, nvl(comm,0) as comm from emp
where deptno=30;
select ename ,sal ,nvl(comm,0) as comm
from emp
where (sal,comm) not in (select sal,nvl(comm,0) as comm
from emp
where deptno=30);
--12번 DEPT와 EMP를 JOIN하여 부서번호, 부서명, 이름, 급여
select e.deptno, d.dname, e.ename, e.sal
from emp e, dept d
where e.deptno = d.deptno;

--13번
select e.deptno, d.dname, e.ename, e.sal
from emp e, dept d
where e.deptno = d.deptno and e.ename = 'ALLEN';

--14번 DEPT Table에 있는 모든 부서를 출력하고, EMP Table에 있는 DATA와 JOIN하여 모든 사원의 이름, 부서번호, 부서명, 급여를 출력하라.
-- 아우터 조인/ 아우터 조인은 null값이 있는 레코드도 출력하기 위해서 사용함.
select d.dname, e.ename, d.deptno, e.sal
from emp e, dept d
where e.deptno(+) = d.deptno; --(+) 아우터 조인, null값도 출력해줌. 이 문법은 오라클에만 있는 오라클 문법이다.

select d.dname, e.ename, d.deptno, e.sal
from emp e, dept d
where e.deptno = d.deptno; -- 기본 조인. d.deptno에 있는 40은 출력되지 않는다.
                            
-- +를 emp테이블인 e에 적용한 이유는 조건절에 걸린 deptno의 값이 e에는 10,20,30까지 d에는 10,20,30,40까지 있기때문에 더 적은 종류를 가진 테이블에 걸어줘야한다.

select d.dname, e.ename, e.deptno, e.sal
from emp e, dept d
where e.deptno = d.deptno(+);
--and e.deptno(+) = 40;

-- 지구상의 모든 db는 공통된 문법이 있다 '안시 sql'이라고함.
-- 안시 표준문법 equal join과 outer join
-- from ~~~ join ~~~ on ~~~~ = ~~~~ 여기서 on은 오라클문법 조인에서 where과 같은역할을 한다.


select d.deptno, d.dname
from emp e left join dept d on e.deptno = d.deptno;

select d.deptno, d.dname
from emp e right join dept d on e.deptno = d.deptno; -- 오른쪽으로(컬럼 종류가 더 많은 쪽으로) 조인 오라클문법과 방향이 반대라고 생각하면된다. 오라클 문법에서는 적은쪽에 +를 걸어주고 안시문법에서는 큰쪽으로 방향을 정해준다.

select d.deptno, d.dname
from emp e left outer join dept d on e.deptno = d.deptno;

select d.deptno, d.dname
from emp e right outer join dept d on e.deptno = d.deptno;

--사원번호, 사원명, 부서번호, 부서명, 보너스를 출력하시오. 단 부서에 사원이 없더라도 부서정보를 출력해야함. 보너스를 받지 않는다면 0으로 출력. 부서별 오름차순 정렬.
select nvl(e.empno,0), d.deptno, nvl(e.ename,'none'), d.dname, nvl(b.bonus,0)
from emp e, dept d, bonus b
where e.deptno(+) = d.deptno and e.empno = b.empno(+)
order by d.deptno asc;
--보너스를 안받는 사원. 부서번호만 존재하고 부서원이 없는 레코드도 같이 출련된다.

--안시문법으로 푼 방법.
select nvl(e.empno,0), d.deptno, nvl(e.ename,'none'), d.dname, nvl(b.bonus,0)
from (emp e right outer join dept d on e.deptno = d.deptno) left outer join bonus b on e.empno = b.empno
order by d.deptno asc;

--15. EMP 테이블의 모든 사원번호, 사원명과 그들의  매니저번호, 매니저명을 출력하라. 
-- self join 하나의 테이블이 스스로 데이터를 참조하는것.
-- 매니저가 없는 사장(king)도 출력하라).
select e.ename 사원이름 , nvl(e.empno,0) 사원번호, e2.ename 매니저이름 , nvl(e2.mgr,0) 매니저번호
from emp e, emp e2
where e.mgr = e2.empno(+); -- 출력하고자 하는 내용이 매니저이름, 매니저번호가 없어도 그 null값을 출력하고자 하는것이고 그 내용은 매니저이름
-- 매니저번호를 갖고온 테이블 e2에 있기때문에 e2를 아우터 조인 해줘야한다.

--16.

--24. 각 사원 별 시급을 계산하여 부서번호, 사원이름, 시급을 출력하시오.
--조건1. 한달 근무일수는 20일, 하루 근무시간은 8시간이다.
--조건2. 시급은 소수 두 번째 자리에서 반올림한다.
--조건3. 부서별로 오름차순 정렬
--조건4. 시급이 많은 순으로 출력.

select e.deptno, e.ename, round(e.sal/160,1) 시급
from emp e
order by deptno, 시급 desc; -- ALIAS 사용가능 ORDER BY에는 가능.

--오름차순 여러개 그냥 order by 하고 , , , , , ,연결하면됨.

--25. 각 사원 별 커미션(COMM)이 0 또는 NULL이고 부서위치가 ‘GO’로 끝나는 사원의 사원번호, 사원이름, 커미션, 부서번호, 부서명, 부서위치를 출력하여라. 
--조건1. 커미션(COMM)이 NULL이면 0으로 출력
select e.empno, e.ename, nvl(e.comm,0) , d.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno 
and (comm is null or comm = 0) and d.loc like '%GO';

--26. 1981년 6월 1일 ~ 1981년 12월 31일 입사자 중 부서명(DNAME)이 SALES인 사원의 부서번호, 사원명, 직업, 입사일을 출력하시오.
--조건1. 입사일 오름차순 정렬

select d.deptno, d.dname, e.job, e.hiredate 입사일
from emp e, dept d
where e.deptno = d.deptno
and d.dname = 'SALES' and e.hiredate between '1981-06-01' and '1981-12-31'  -- 일반적으로는 to_date를 이용해서 비교해야 데이터타입과 비교가 된다. 
order by 입사일 asc;

--27. 현재 시간과 현재 시간으로부터 한 시간 후의 시간을 출력하시오.
--조건1. 현재시간 포맷은 ‘4자리년-2자일월-2자리일  24시:2자리분:2자리초’ 
--조건2. 한시간후 포맷은 ‘4자리년-2자일월-2자리일  24시:2자리분:2자리초’ 

select to_char(sysdate,'YYYY-MM-DD  HH24:MI:SS') 현재시간 ,to_char(sysdate+(1/24),'YYYY-MM-DD  HH24:MI:SS') 한_시간_후 from dual;

------------------------------------------------------------------------------------
--시간 더하기 sysdate에다가 1을 더하면 1일, 1/24를 더하면 한 시간 365를 더하면 1년
------------------------------------------------------------------------------------

--28. 각 부서별 사원수, 부서명을 출력하시오.
--조건1. 부서별 사원수가 없더라도 부서번호
--부서명은 출력
--조건2. 부서별 사원수가 0인 경우 ‘없음’ 출력
--조건3. 부서번호 오름차순 정렬

--커미션이 널이면 없음, 있으면 그대로

select decode(comm,null,'없음',comm)
from emp;


select nvl(to_char(comm),'없음')
from emp;

--부서번호가 10 20 30이면 각각 십 이십 삼십으로 출력
----------------------------------------------------------------------------------
                                        decode
----------------------------------------------------------------------------------
select decode(e.deptno,
10,'십',
20,'이십',
30,'삼십',
to_char(e.deptno)), e.ename
from emp e
order by e.deptno;

select d.deptno, d.dname, nvl(to_char(count(empno)),'없음') as 사원수 -- count는 null값을 받지도 않고 null값을 출력하지도 않는다 따라서 nvl을 아예 적용할 수 없다.
from emp e, dept d
where e.deptno(+) = d.deptno
group by d.deptno, d.dname
order by d.deptno asc;


select d.deptno, d.dname, decode(count(empno),0,'없음',to_char(count(empno))) as 사원수
from emp e, dept d
where e.deptno(+) = d.deptno
group by d.deptno, d.dname
order by d.deptno asc;

select e.deptno, d.dname, e.deptno
from emp e, dept d
where e.deptno(+) = d.deptno;



--29. 사원 테이블에서 각 사원의 사원번호, 사원명, 매니저번호, 매니저명을 출력하시오.
--조건1. 각 사원의 급여(SAL)는 매니저 급여보다 많거나 같다.

select  nvl(e.empno,0) 사원번호, e.ename 사원이름 , nvl(e2.empno,0) 매니저번호, e2.ename 매니저이름
from emp e, emp e2
where e.mgr = e2.empno and e.sal >= e2.sal;

--30. 각 부서별로 1981년 5월 31일 이후 입사자의 부서번호, 부서명, 사원번호, 사원명, 입사일을 출력하시오.
--조건1. 부서별 사원정보가 없더라도 부서번호, 부서명은 출력
--조건2. 부서번호 오름차순 정렬
--조건3. 입사일 오름차순 정렬

--내가 푼 방법
select d.deptno, d.dname , e.empno, e.ename, e.hiredate
from emp e, dept d
where e.deptno(+) = d.deptno 
and ((e.hiredate >= '1981-06-01') or e.hiredate is null)
order by  d.deptno, d.dname, e.hiredate;

--내가 푼 방법과 교수님이 푼 방법의 차이점이 무엇인지 왜 그런건지
--내가 푼 방법은 hiredate의 null값을 where조건문으로 
--교수님이 알려주신 방법. hiredate에 (+)붙이심.
select d.deptno, d.dname , e.empno, e.ename, e.hiredate
from emp e, dept d
where e.deptno(+) = d.deptno
and e.hiredate(+) > to_date('1981-06-01','YYYY-MM--DD') -- join했을 때 출력하기를 원하는 컬럼의 조건을 걸때마다 컬럼별로 아우터조인을 걸어줘야하는것같다.
order by d.deptno asc, e.hiredate asc;


--31입사일로부터 지금까지 근무년수가 30년 이상인 사원의 사원번호, 사원명, 입사일, 근무년수를 출력하시오.
--조건1. 근무년수는 월을 기준으로 버림
select e.empno, e.ename, e.hiredate, round((sysdate - e.hiredate)/365,0) 근속연수
from emp e
where round(((sysdate - e.hiredate)/365),0) >= 30
order by 근속연수 asc;

-- trunc() 버림함수 trunc(숫자,버릴소숫점위치)
-- round() 반올림함수
select e.empno, e.ename, e.hiredate, trunc((sysdate - e.hiredate)/365) 근속연수
from emp e
where trunc(((sysdate - e.hiredate)/365)) >= 30
order by 근속연수 asc;
