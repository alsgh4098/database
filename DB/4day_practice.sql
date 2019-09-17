--count함수 null값 입출력 확인
select comm, count(comm) from emp group by comm;

--30. 각 부서별로 1981년 5월 31일 이후 입사자의 부서번호, 부서명, 사원번호, 사원명, 입사일을 출력하시오.
--조건1. 부서별 사원정보가 없더라도 부서번호, 부서명은 출력
--조건2. 부서번호 오름차순 정렬
--조건3. 입사일 오름차순 정렬
select d.deptno, d.dname , e.empno, e.ename, e.hiredate
from emp e, dept d
where e.deptno(+) = d.deptno
and hiredate(+) > to_date('1981-06-01','YYYY-MM--DD') -- hiredate에도 아우터조인을 걸어서 null값도 나오게함. 
order by d.deptno asc, e.hiredate asc;

-- single low function
-- 문자, 숫자, 날짜, 컨버젼등과 관련된 함수


select '---'||trim('    aaa   abcde    ')||'----' from dual; -- 맨앞과 맨뒤 공백을 제거.


--사원의 아이디 앞 한글자 뒤 한글자를 제외한 나머지는 별처리를 해라.
--개인정보보호에서 많이 쓰이는 문제.

/*concat('~','~') -- '~~'  // '~'와 '~'를 합침
합침

substr('string',1,3)  -- str  // string에서 1번째부터 3글자 출력
문자열에서 부분 출력

length('string') -- 6
문자열 길이 출력

instr('string','r')  -- 3
문자열에서 문자위치 출력

lpad(sal,10,'*') ---- ******5000
문자열만큼 출력하고 나머지를 별로채움

trim('s'from'ssmith') ---- mith
문자열에서 일부문자를 제거.*/

-- length만 잘 사용하면 된다.
-- 수정할 문자열을 부분으로 나눠서 생각하자.

--ward, king의 경우엔 앞뒤 두 글자씩하면 별표시가 하나도 없기때문에 앞뒤 한 글자로 변경했습니다.
select ename, substr(ename,1,1) || lpad('*',length(ename)-1,'*') || substr(ename,length(ename),1) from emp;

--앞뒤 두글자로 변경하실경우엔 이렇게하시면됩니다.
select ename, substr(ename,1,2) || lpad('*',length(ename)-4,'*') || substr(ename,length(ename)-1,2) from emp;

--다른 방법 rpad안에 substr을 사용.
--lpad일 경우엔 substr과 rpad순으로 입력.
--앞뒤 한글자
select ename, rpad( substr(ename,1,1) ,length(ename)-1, '*') || substr(ename,length(ename),1) from emp;
--앞뒤 두글자
select ename, rpad( substr(ename,1,2) ,length(ename)-2, '*') || substr(ename,length(ename)-1,2) from emp;


select to_char(123457,'999,999,999,999') from dual; -- 숫자형식의 단위는 ,로 끊는다.

select to_char(123457,'000,000,000,000') from dual; -- 빈자리는 0으로 채움.

select to_char(123457,'$000,000,000,000') from dual; -- 빈자리는 0으로 채움. 달러표시추가, 원화표시는 없다. 글자연결해서 해야함.

--각 부서별 평균 급여
select d.dname, d.deptno, round(avg(e.sal),0)
from emp e, dept d
where e.deptno(+) = d.deptno
group by d.dname, d.deptno
order by avg(e.sal);



--최대급여 받는사람 뽑기

select e.ename 이름, e.sal 급여
from emp e
group by e.ename, e.sal
having e.sal = (select max(sal) from emp); 

-- 부서별 최대급여.

select e.deptno, max(e.sal)
from emp e
group by e.deptno;

-- 부서별 최대급여, 단 3000이상

select e.deptno, max(e.sal)
from emp e
group by e.deptno
having max(e.sal) >= 3000;

--9. 각 부서 별 평균 급여가 2000 이상이면 초과, 그렇지 않으면 미만을 출력하시오.
select d.dname, d.deptno, round(avg(e.sal),0), decode(substr(to_char(avg(e.sal)), to_char(avg(e.sal)),1), '2','초과','미만') -- 이건 불완전함, 평균 급여 201도 초과라고나옴 왜냐하면 첫글자의 숫자만 비교하기때문
from emp e, dept d
where e.deptno = d.deptno
group by d.dname, d.deptno
order by d.deptno, avg(e.sal);

select d.dname, d.deptno, length(to_char(round(avg(e.sal),0))) -- length를 이용해서 네자리 이상의 숫자의 첫글자 예를 들면 1234 의 1, 3245의 3 4345의 4를 비교하게 된다.
from emp e, dept d
where e.deptno = d.deptno
group by d.dname, d.deptno
order by d.deptno, avg(e.sal);


select d.dname, d.deptno, round(avg(e.sal),0), decode(    substr    (   to_char(avg(e.sal))  ,  length(to_char(round(avg(e.sal) , 0)))  -3  ,  1  ),    '2'    ,    '초과'    ,    '미만'    )
from emp e, dept d
where e.deptno = d.deptno
group by d.dname, d.deptno
order by d.deptno, avg(e.sal);

--부서번호가 10이면 10번

select d.dname, d.deptno,
(case
  when d.deptno = 10 then '10번'
  when d.deptno = 20 then '20번' -- 또는 else ' '
  when d.deptno = 30 then '30번'
  when d.deptno = 40 then '40번'
end) as 부서번호
from dept d
order by d.deptno;

