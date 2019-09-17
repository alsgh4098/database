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

--RANK() OVER ( ... )       : �������
--ROW_NUMBER() OVER ( ... ) : ���ڵ����
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

-- ��߰� : ������ 
select e1.* 
from emp e1 
where (select count(*) from emp e2 where e2.sal>e1.sal) between 0 and 4
order by sal desc;

--�ε��� : ���� �˻��� ����
create index idx_emp on emp(ename);
select * from emp where ename = 'SMITH';
create index idx_emp_func on emp (sal*12/3+2-5);

--where sal*12/3+2-5 > 100;

-- ������!!!! 
-- : like ������ index ������ �ȵȴ�.
-- : ���� �÷��� ������ ���ϸ� index ������ �ȵȴ�.
select *
from emp
--where ename like 'A%';
--where substr(ename,1,1) = 'A';
;

--�Լ� ��� �ε��� ��� ��
create index idx_emp_date on emp 
                        ( to_char(hiredate, 'YYYY'),
                          to_char(hiredate, 'MM'),
                          to_char(hiredate, 'DD')
                        );
where to_char(hiredate, 'YYYY') = '2019' 
    and to_char(hiredate, 'MM') = '08' 
    and to_char(hiredate, 'DD') ='22'


-- �� VIEW : ���� ���̺� �뷮 0K
create or replace view VIEW_EMP_DEPT 
as 
select e.empno, e.ename,e.sal,e.job, d.deptno, d.dname, d.loc, e.hiredate
from emp e, dept d
where e.deptno = d.deptno
  and d.deptno = 30 with read only; --with check option;

-- �信 ������ ���ϸ� ���� ���̺� ���� ����ȴ�.
update VIEW_EMP_DEPT
set sal = 7777;

select * from user_views;

--FORCE �ɼ� : ���� ���̺� ���� �� ���� ����
create or replace FORCE view VIEW_DUMMY
as
select id, pw, name, addr from member;
select * from VIEW_DUMMY;

-- ���Ϻ� : ���̺� 1�� ����� �� ����
-- ���պ� : ���̺� n�� ����� �� ����
-- ���Ϻ�� distinct/group �Լ� ��� ���Ѵ�..---->�ƴϿ�...
--���Ϻ� ���� ��                                ��α׳� ���簡 �߸����� ���� �� ��                                       
create or replace view VIEW_EMP
as 
select empno, ename, job, deptno
from emp;
--���Ϻ信�� �׷��Լ�/distinct �� �˴ϴ�...
select * from VIEW_EMP;
select distinct deptno
from VIEW_EMP_DEPT;



--������ : ������ȣ pk ��ü������ ���
CREATE SEQUENCE MYSEQ 
INCREMENT BY 1 
START WITH 1 
MAXVALUE 9999999999
NOCYCLE;

--MAXVALUE ����???�� �ִ�???
alter sequence myseq
INCREMENT BY 1
MAXVALUE 99999999999999999999999999999999999999999999999999999999999999999999999999999999;

--nextval : ���������ȣ �߱� 
--currval : ��������ȣ ��ȸ
--���� ������ ���� �� currval ��� �Ұ�
--currval�� nextval�� �ѹ��̶� ��� �� ��ȸ ����
select myseq.currval from dual;  --����
select myseq.nextval from dual;  --��ȣ����
select myseq.currval from dual;  --��ȸ���� 


--������ ��ȣ�� insert�� �����غ���
create table test_board2(
bseq number primary key,
title varchar2(20)
);
insert into test_board2 values(myseq.nextval,'ddddd');
select * from user_users;











