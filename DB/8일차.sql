--rownum rowid
select rowid, rownum, emp.* from emp;

--rownum  top-N
select rownum as sel_rownum, e.*
from 
    (select rownum as ins_rownum, emp.* 
    from emp
    order by sal desc ) e
--where rownum <= 5
--where sel_rownum between 2 and 5;  ERROR~~!!!!
where sel_rownum between 1 and 5;
;


--rownum  paging
select rownum, t.*
from (
      select rownum as sel_rownum, e.*
      from 
          (select rownum as ins_rownum, emp.* 
          from emp
          order by sal desc ) e
      --where rownum <= 5
) t
where sel_rownum between 2 and 5;
;

--RANK() OVER ( ... )       : 통계용순번
--ROW_NUMBER() OVER ( ... ) : 레코드순번
/*
100 1   1
90  2   2
80  3   3
80  3   4
70  5   5
60  6   6 
*/

select ename, sal, RANK() OVER (order by sal desc)  as rank
from emp;
select * from emp;
select e.*
from 
    (select ename, sal, ROW_NUMBER() OVER (order by sal desc)  as rnum
    from emp) e
where rnum between 2 and 4;

-- 대발견 : 정희훈 
select e1.* 
from emp e1 
where (select count(*) from emp e2 where e2.sal>e1.sal) between 0 and 4
order by sal desc;

--인덱스 : 빠른 검색을 위함
create index idx_emp on emp(ename);
select * from emp where ename = 'SMITH';
create index idx_emp_func on emp (sal*12/3+2-5);

--where sal*12/3+2-5 > 100;

-- 주의점!!!! 
-- : like 연산은 index 적용이 안된다.
-- : 원본 컬럼에 변형을 가하면 index 적용이 안된다.
select *
from emp
--where ename like 'A%';
--where substr(ename,1,1) = 'A';
;

--함수 기반 인덱스 사용 예
create index idx_emp_date on emp 
                        ( to_char(hiredate, 'YYYY'),
                          to_char(hiredate, 'MM'),
                          to_char(hiredate, 'DD')
                        );
where to_char(hiredate, 'YYYY') = '2019' 
    and to_char(hiredate, 'MM') = '08' 
    and to_char(hiredate, 'DD') ='22'


-- 뷰 VIEW : 가상 테이블 용량 0K
create or replace view VIEW_EMP_DEPT 
as 
select e.empno, e.ename,e.sal,e.job, d.deptno, d.dname, d.loc, e.hiredate
from emp e, dept d
where e.deptno = d.deptno
  and d.deptno = 30 with read only; --with check option;

-- 뷰에 수정을 가하면 원본 테이블 값이 변경된다.
update VIEW_EMP_DEPT
set sal = 7777;

select * from user_views;

--FORCE 옵션 : 원본 테이블 없이 뷰 생성 가능
create or replace FORCE view VIEW_DUMMY
as
select id, pw, name, addr from member;
select * from VIEW_DUMMY;

-- 단일뷰 : 테이블 1개 사용해 뷰 생성
-- 복합뷰 : 테이블 n개 사용해 뷰 생성
-- 단일뷰는 distinct/group 함수 사용 못한다..---->아니요...
--단일뷰 생성 예                                블로그나 교재가 잘못됬음 이젠 다 됨                                       
create or replace view VIEW_EMP
as 
select empno, ename, job, deptno
from emp;
--단일뷰에서 그룹함수/distinct 잘 됩니다...
select * from VIEW_EMP;
select distinct deptno
from VIEW_EMP_DEPT;



--시퀀스 : 고유번호 pk 대체용으로 사용
CREATE SEQUENCE MYSEQ 
INCREMENT BY 1 
START WITH 1 
MAXVALUE 9999999999
NOCYCLE;

--MAXVALUE 제한???이 있다???
alter sequence myseq
INCREMENT BY 1
MAXVALUE 99999999999999999999999999999999999999999999999999999999999999999999999999999999;

--nextval : 다음발행번호 발급 
--currval : 현재발행번호 조회
--최초 시퀀스 생성 후 currval 사용 불가
--currval는 nextval를 한번이라도 사용 후 조회 가능
select myseq.currval from dual;  --에러
select myseq.nextval from dual;  --번호발행
select myseq.currval from dual;  --조회가능 


--시퀀스 번호를 insert에 적용해보기
create table test_board2(
bseq number primary key,
title varchar2(20)
);
insert into test_board2 values(myseq.nextval,'ddddd');
select * from user_users;











