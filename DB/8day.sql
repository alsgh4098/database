
select rowid,rownum, emp.* from emp;

--rownum rowid�� �����Ϳ� ���� ������ȣ, �������̵�.
select rownum, emp.* from emp
order by ename desc;

-- ���� ���� �޿��� �޴»�� 5���� �̾ƶ�.

select rownum, e.ename, e.sal
from emp e
order by e.sal desc;


--��
select RN, EN, ES
from (select rownum RN, e.ename EN, e.sal ES
      from emp e
      order by e.sal desc)
where rownum < 6;
-- where���� rownum�� RN�� �ٸ� ��. 

-- ���޺� ������ ����� ���� �޴� ������ �����ϰ� 2��°���� 4��°������� ����϶�.

select RN, EN, ES
from (select rownum RN, e.ename EN, e.sal ES
      from emp e
      order by e.sal desc)
where rownum > 2
and rownum < 7;
--rownum�� ù��°���͸� ����. ���������� �ȵǴ�����.

--����¡  select�� ���������.
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

--rank() over (...) : �������,  ����ó���� �Ű���.,  ��ȣ�ߺ�����(��ȣ�ǳʶپ���.)
--row_number() over(...) : ���ڵ����, ������� ��ȣ�� �ű�.

select ename, sal, rank() over(order by sal desc) as ��ũ����
from emp;

select ename, sal, row_number() over(order by sal desc) as �ο�ѹ�����
from emp;

--�ο�ѹ������� �̿��ؼ� ���޺� ������ ����� ���� �޴� ������ �����ϰ� 2��°���� 4��°������� ����ϱ�.
select t.EN, t.ES, t.�ο�ѹ�����
from (select ename EN, sal ES, row_number() over(order by ES desc) as �ο�ѹ�����
              from emp e) t
where �ο�ѹ����� >= 2
and �ο�ѹ����� <= 4;
--������ �ȵǴ� ����:
-- �ζ��κ信��
--(select ename EN, sal ES, row_number() over(order by ES desc) order by ES���� ES�� ������ ����Ŵ.
-- select���� �������°� �ƴ϶� from���� �������°�.
select ename EN, sal ES, ES
              from emp e;
--���� ������ ���ؼ��� Ȯ���� ��������.


select *
from
    (select ename, sal, row_number() over(order by sal desc) as �ο�ѹ�����
    from emp)
where �ο�ѹ����� between 2 and 4;


-- select�� alias �Ѱ��� where���� ���Ұ�.
-- order by������ ��밡��.
-- from���� alias �Ѱ��� where���� ��밡��.
select ename, sal sl
from emp
where sl > 2000;

select *
from (select ename, sal, row_number() over(order by sal desc) as �ο�ѹ�����
      from emp)
where �ο�ѹ����� >= 2
and �ο�ѹ����� <= 4;

--�ε���

create index idx_emp on emp(ename);
select * from emp where ename = 'SMITH';
create index idx_emp_func on emp(sal*12/3+2-5);

--���� like�� �ε�������ȵ�.
--�����÷��� �Լ��� �ɰų� ��Ÿ ������� ���������ϸ� �ε��� ������ �ȵȴ�.
--���ʿ� �Լ������ε����� �������Ѵ�.

--���� �Լ��ε���
--�������� ���������� ����Ҷ��� ������ ����ؾ���.
--�������� ������� ���ؾ� �ε��� �����̵ȴ�.
--�׳� �ε����� ������ �״�� �˻�����.
--�κ��ε����� ����Ǳ⵵�Ѵ�.

create index idx_emp_func_date on emp( to_char(hiredate, 'YYYY'),
                                        to_char(hiredate, 'MM'),
                                        to_char(hiredate, 'DD')
                                        );
                                        
                                        

select e.ename, e.sal, e.deptno
from emp e, dept d
where e.deptno = d.deptno
order by e.deptno, e.sal;

--VIEW����.
create view view_emp_dept
as  select e.ename, e.sal, e.deptno
    from emp e, dept d
    where e.deptno = d.deptno
    order by e.deptno, e.sal;

select v1.ename, b.bonus
from view_emp_dept v1, bonus b
where b.bonus is not null;
--view���� update�ϸ� ���� table�� �ִ°��� ����ȴ�.

drop view view_emp_dept;

--���ο� ���̺��̳� �並 �����ϰų� �����̸��� ���̺��̳� �䰡 ������ ������ ������Ʈ.
create or replace view view_emp_dept
as  select e.ename, e.sal, e.deptno
    from emp e, dept d
    where e.deptno = d.deptno
    order by e.deptno, e.sal;
    
--�ܼ���
create or replace view view_emp
as select empno,ename,job,deptno
from emp;

--�μ��� �����

select deptno, count(empno)
from view_emp
group by deptno;

select distinct deptno
from view_emp;

--view���� force

create or replace force view view_dummy
as select id, pw, name, addr from member;
--force�� ��¥ �� ������ �Ǵµ� �����̾ȵ�.
select * from view_dummy;
--�ȵ�.

create or replace view view_emp_dept2
as  select e.ename, e.sal,e.job,d.dname,d.loc, e.deptno,e.hiredate
    from emp e, dept d
    where e.deptno = d.deptno
    and d.deptno = 30  with check option; -- ������ üũ�ɼ��� �ذ��� �����ϰ�� ������ �� �˻��� �� �� ������. �׷��� �� ���������� �����ϴ�. , �׸��� üũ�ɼ��� �ɷ������� ������ �Ұ��ϴ�.
                                          -- �並 �ҷ��ͼ� �̿��� �ϵ� ������ �⺻���̺��� ���� ������ �Ұ��ϰ� ������� with check option�� ������ָ� �ȴ�.
create or replace view view_emp_dept3
as  select e.ename, e.sal,e.job,d.dname,d.loc, e.deptno,e.hiredate
    from emp e, dept d
    where e.deptno = d.deptno 
    and d.deptno = 30  with read only;    --��� �÷��� �б��������θ�.
    
select * from user_views;

--������ ����.
CREATE SEQUENCE "KOSA"."MYSEQ" 
MINVALUE 1 
MAXVALUE 9999999999999999999999999999 
INCREMENT BY 1 
START WITH 1 
NOCACHE 
NOORDER
NOCYCLE ;
--���������� �ٸ� ��ҵ��� ���氡�� ������, ������ ���۹�ȣ�� �ٲ� ��������.

alter sequence myseq
increment by 1;

alter sequence myseq
MAXVALUE 9999999999999999999999999999999;

--�������� nextval�� ó�� ���� �ǰ��� ���۵ȴ�.
--�������� ��ȸ�Ұ���.
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


--��������ȸ
select *
from user_sequences;
--user_sequences�� ������ data dictionary��� �Ѵ�.
