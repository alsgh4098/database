
select rowid,rownum, emp.* from emp;

--rownum rowid는 데이터에 붙은 고유번호, 고유아이디.
select rownum, emp.* from emp
order by ename desc;

-- 가장 많은 급여를 받는사람 5명을 뽑아라.

select rownum, e.ename, e.sal
from emp e
order by e.sal desc;


--답
select RN, EN, ES
from (select rownum RN, e.ename EN, e.sal ES
      from emp e
      order by e.sal desc)
where rownum < 6;
-- where절의 rownum과 RN은 다른 값. 

-- 월급별 순서로 사원을 많이 받는 순으로 정리하고 2번째부터 4번째사원까지 출력하라.

select RN, EN, ES
from (select rownum RN, e.ename EN, e.sal ES
      from emp e
      order by e.sal desc)
where rownum > 2
and rownum < 7;
--rownum은 첫번째부터만 센다. 위에문제가 안되는이유.

--페이징  select를 세번사용함.
select  t.RN, t.EN, t.ES
from      (select RN, EN, ES,rownum as sal_row
          from (select rownum RN, e.ename EN, e.sal ES
                from emp e
                order by e.sal desc)) t
where sal_row between 2 and 4;

select t.RN, t.EN, t.ES
from      (select RN, EN, ES,rownum as sal_row
          from (select rownum RN, e.ename EN, e.sal ES
                from emp e
                order by e.sal desc)) t
where sal_row >= 2
and sal_row <= 4;

--rank() over (...) : 통계용순번,  동점처리자 매겨짐.,  번호중복가능(번호건너뛰어짐.)
--row_number() over(...) : 레코드순번, 순서대로 번호를 매김.

select ename, sal, rank() over(order by sal desc) as 랭크오버
from emp;

select ename, sal, row_number() over(order by sal desc) as 로우넘버오버
from emp;

--로우넘버오버를 이용해서 월급별 순서로 사원을 많이 받는 순으로 정리하고 2번째부터 4번째사원까지 출력하기.
select t.EN, t.ES, t.로우넘버오버
from (select ename EN, sal ES, row_number() over(order by ES desc) as 로우넘버오버
              from emp e) t
where 로우넘버오버 >= 2
and 로우넘버오버 <= 4;
--위에가 안되는 이유:
-- 인라인뷰에서
--(select ename EN, sal ES, row_number() over(order by ES desc) order by ES에서 ES가 문제를 일으킴.
-- select에서 가져오는게 아니라 from에서 가져오는것.
select ename EN, sal ES, ES
              from emp e;
--위에 문장을 통해서도 확인할 수가있음.


select *
from
    (select ename, sal, row_number() over(order by sal desc) as 로우넘버오버
    from emp)
where 로우넘버오버 between 2 and 4;


-- select와 alias 한것은 where에서 사용불가.
-- order by에서는 사용가능.
-- from에서 alias 한것은 where에서 사용가능.
select ename, sal sl
from emp
where sl > 2000;

select *
from (select ename, sal, row_number() over(order by sal desc) as 로우넘버오버
      from emp)
where 로우넘버오버 >= 2
and 로우넘버오버 <= 4;

--인덱스

create index idx_emp on emp(ename);
select * from emp where ename = 'SMITH';
create index idx_emp_func on emp(sal*12/3+2-5);

--주의 like는 인덱스적용안됨.
--원본컬럼에 함수를 걸거나 여타 방식으로 변형을가하면 인덱스 적용이 안된다.
--애초에 함수적용인덱스를 만들어야한다.

--복합 함수인덱스
--복합으로 나눠놨으면 사용할때도 나눠서 사용해야함.
--나눠놓은 순서대로 비교해야 인덱스 적용이된다.
--그냥 인덱스를 생성한 그대로 검색하자.
--부분인덱스가 적용되기도한다.

create index idx_emp_func_date on emp( to_char(hiredate, 'YYYY'),
                                        to_char(hiredate, 'MM'),
                                        to_char(hiredate, 'DD')
                                        );
                                        
                                        

select e.ename, e.sal, e.deptno
from emp e, dept d
where e.deptno = d.deptno
order by e.deptno, e.sal;

--VIEW생성.
create view view_emp_dept
as  select e.ename, e.sal, e.deptno
    from emp e, dept d
    where e.deptno = d.deptno
    order by e.deptno, e.sal;

select v1.ename, b.bonus
from view_emp_dept v1, bonus b
where b.bonus is not null;
--view값을 update하면 참조 table에 있는값도 변경된다.

drop view view_emp_dept;

--새로운 테이블이나 뷰를 생성하거나 같은이름의 테이블이나 뷰가 기존에 있으면 업데이트.
create or replace view view_emp_dept
as  select e.ename, e.sal, e.deptno
    from emp e, dept d
    where e.deptno = d.deptno
    order by e.deptno, e.sal;
    
--단순뷰
create or replace view view_emp
as select empno,ename,job,deptno
from emp;

--부서별 사원수

select deptno, count(empno)
from view_emp
group by deptno;

select distinct deptno
from view_emp;

--view에서 force

create or replace force view view_dummy
as select id, pw, name, addr from member;
--force로 가짜 뷰 생성은 되는데 실행이안됨.
select * from view_dummy;
--안됨.

create or replace view view_emp_dept2
as  select e.ename, e.sal,e.job,d.dname,d.loc, e.deptno,e.hiredate
    from emp e, dept d
    where e.deptno = d.deptno
    and d.deptno = 30  with check option; -- 원래는 체크옵션을 준것을 제외하고는 조건을 건 검색을 할 수 없었다. 그러나 이 버전에서는 가능하다. , 그리고 체크옵션이 걸려있으면 수정이 불가하다.
                                          -- 뷰를 불러와서 이용은 하되 참조한 기본테이블의 값의 수정을 불가하게 만들려면 with check option을 사용해주면 된다.
create or replace view view_emp_dept3
as  select e.ename, e.sal,e.job,d.dname,d.loc, e.deptno,e.hiredate
    from emp e, dept d
    where e.deptno = d.deptno 
    and d.deptno = 30  with read only;    --모든 컬럼을 읽기전용으로만.
    
select * from user_views;

--시퀀스 생성.
CREATE SEQUENCE "KOSA"."MYSEQ" 
MINVALUE 1 
MAXVALUE 9999999999999999999999999999 
INCREMENT BY 1 
START WITH 1 
NOCACHE 
NOORDER
NOCYCLE ;
--시퀀스에서 다른 요소들은 변경가능 하지만, 시퀀스 시작번호는 바꿀 수가없다.

alter sequence myseq
increment by 1;

alter sequence myseq
MAXVALUE 9999999999999999999999999999999;

--시퀀스는 nextval가 처음 실행 되고나서 시작된다.
--그전에는 조회불가능.
select myseq.nextval from dual;
select myseq.currval from dual;

create sequence myseq22;

select myseq22.nextval from dual;

alter sequence myseq22
MINVALUE 1
MAXVALUE 9999999999999999999999999999 
INCREMENT BY 1
NOCACHE 
NOORDER
NOCYCLE ;

create table testboard(
  bseq number primary key,
  title varchar2(20)
);

insert into testboard values(myseq.nextval,'aaaaaa');


--시퀀스조회
select *
from user_sequences;
--user_sequences와 같은걸 data dictionary라고 한다.
