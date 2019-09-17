------------------------------------------------------------------------------
--jones�� �޿����� ���� �޴� ����� ���
--join�� �̿��ؼ� ���.
select e1.ename, e1.sal
from emp e1, emp e2
where e2.ename = 'JONES'
and e1.sal > e2.sal
--and e1.ename = e2.ename --�̰� ������ ������ �� ����������? �ֳĸ� e2.ename�� ���� ���ǿ��� JONES��� �̸��� �������� �߱� ������,
--JONES���� �޿��� ���� �̸��� JONES�� �̸��� ���� ����� ���⶧���� ������ ����.
order by e1.sal;
--���������� �̿��ؼ� ���.
select e1.ename, e1.sal
from emp e1
where e1.sal > (select sal from emp where ename = 'JONES') -- ���Ϸ��� ���(�÷�)�� �� ���ڵ�,�÷��� ������ ���ƾ��Ѵ�.
order by e1.sal;
------------------------------------------------------------------------------
--������ ������ ���� �����ȸ
select *
from emp
where job = (select job from emp where ename = 'SCOTT');
--���� ������ join���� Ǯ��
select e1.* -- *�� �̷�������
from emp e1, emp e2
where e2.ename = 'SCOTT'
and e1.job = e2.job;
------------------------------------------------------------------------------
--7900����� �޿����� ���� �޴� ��� ��ȸ
select sal from emp order by sal;

select empno,ename,job,sal
from emp
where sal > (select sal 
              from emp 
              where empno = 7900)
order by sal;

--7900����� �޿����� ���� �޴� ��� ��ȸ
--join���� Ǯ���
-- self join�� ��� �ʿ���µ����Ͱ� ������ ����? ����.
select e1.ename, e1.sal
from emp e1, emp e2;
------------------------------------------------------------------------------
select e1.ename, e1.sal
from emp e1, emp e2
where e2.empno = 7900
and e1.sal > e2.sal
order by e1.sal;
------------------------------------------------------------------------------
--�޿��� 2000�̻��� ������� ������ ����������� �������
select *
from emp
where job = (select job 
                    from emp 
                    where sal > 2000)
order by deptno;
--���� ������ ������ ���� ������ where���������� select�� job�� �����̱⶧���� '=' �����ڿ� ���� �ʴ´�.
-- '='�� �ϳ����� ���ϴ� �������̱� �����̴�. �̷� �����ڸ� single low operator��� �Ѵ�.
-- ������ �Ʒ��� ���� 'in'�� ���� multi low operator�� ������Ѵ�.
select *
from emp
where job in(select job 
                    from emp 
                    where sal > 2000)
order by job;
------------------------------------------------------------------------------
-- CLARK�̶�� ����� ������ �μ���ȣ�� ���� ����� ������ ��ȸ�ض�.
select *
from emp
where job = (select (job) from emp where ename ='CLARK')
and deptno = (select deptno from emp where ename ='CLARK');
--�Ʒ��� ���� where���� �ΰ� �̻��� �÷��� ���ú��� �� �ִ�.
select *
from emp
where (job,deptno) = (select job,deptno from emp where ename ='CLARK');
--����� ���ǿ� ������ ����� ������ CLARK�ڽŹۿ� �ȳ��´�. 
select *
from emp
order by deptno;
------------------------------------------------------------------------------
--7369����� ������ ����, 7876�� ����� �޿����� ���� �޿��� �޴� ����� ������ ����϶�.
select *
from emp
where job = (select job from emp where empno = 7369)
and sal > (select sal from emp where empno = 7876);
------------------------------------------------------------------------------
--�ּ� �޿����
select min(sal)
from emp;

--�ּұ޿��� �޴� ������� ��ȸ �������� ����
select e1.deptno,  e1.sal
from emp e1, emp e2
where e1.deptno = e2.deptno
group by e1.deptno
having e1.sal = min(e2.sal);
--�� �ȵ���
--�翬�� �ȵ�. e2.sal�� group by�� �������� ���� ��Ȳ��.


--�ּұ޿��� �޴� ������� ��ȸ �������� ���
select *
from emp
where sal = (select min(sal) from emp);
------------------------------------------------------------------------------
--�� �μ��� �ּұ޿�
select e.deptno, min(e.sal)
from emp e
group by e.deptno;

select e.deptno, e.sal
from emp e
order by e.deptno;
------------------------------------------------------------------------------
--20�� �μ��� �ּұ޿�
select e.deptno, min(e.sal)
from emp e
where e.deptno = 20
group by e.deptno;

select min(e.sal)
from emp e
where e.deptno = 20;
------------------------------------------------------------------------------
--�� �μ��� �ּұ޿� ��, 20�� �μ��� �ּұ޿����� ���̹޴� �μ��� ��ȣ�� �ּұ޿��� ����϶�.
select e.deptno, min(e.sal)
from emp e
group by e.deptno
having min(e.sal) > (select min(sal) from emp where deptno = 20);

select e.deptno, min(e.sal)
from emp e
group by e.deptno
having min(e.sal) > (select min(e.sal) from emp e where e.deptno = 20);


select e.deptno, min(e.sal)
from emp e
group by e.deptno;
------------------------------------------------------------------------------
--�Ʒ��� ������� SMITH�� �̸��� ���� �������� ������� ������ �ֱ� ������
-- where ���� '='��ſ� in�� ������ִ°��� ����.
select ename, job
from emp 
where job = (select job from emp where ename = 'SMITH');
------------------------------------------------------------------------------
-- any
-- ������ CLERK�� ������� �޿��� �ִ�޿����� ���� �޿��� ���� ����� ����.
select empno, ename, job, sal
from emp
where sal < any (select sal from emp where job = 'CLERK')
order by sal;

select sal from emp where job = 'CLERK' order by sal;
--�� �Ʒ� ���̸� ��������
-- all
select empno, ename, job, sal
from emp
where sal <= all(select sal from emp where job = 'CLERK')
order by sal;
------------------------------------------------------------------------------
--from���� subquery����ϱ�
--10�� �μ�����̱�
select emp10.*
from (select * from emp where deptno = 10) emp10;
--���Ʒ� ������
select *
from (select * from emp where deptno = 10) emp10;
------------------------------------------------------------------------------
--������� �̸��� �μ���ȣ�� ����ϵ� �޿��� CLARK����� �޿��� ����ؼ� ����Ѵ�.
--select���� subquery
select ename, deptno, (select sal from emp where ename = 'CLARK') as CLARK_SAL
from emp
order by deptno;

select ename, deptno, 2450 as csal
from emp
order by deptno;

select ename, deptno, sal
from emp
where sal = (select sal from emp where ename = 'CLARK');

------------------------------------------------------------------------------
--from�� subquery���.
--  ������ ������� �̸��� ����ϰ� �޿����� CLARK�� �޿��� �� �޿��� ����϶�.

select e.sal, csal.sal, e.sal- csal.sal
from emp e ,(select sal from emp where ename = 'CLARK') csal;
--���� ��.

select sal,t.csal,sal - t.csal
from ( select sal, (select sal from emp where ename = 'CLARK') as csal from emp) t;
--���� ��. ������ csal�� �÷��̴�. from���� �����Ѱ��� emp���̺��� sal�� (select sal from emp where ename = 'CLARK')�� ������� ���̺�

select sal, csal, sal - csal
from ( select sal, (select sal from emp where ename = 'CLARK') as csal from emp);
--�ٷ�  ���� select���� �ٷ� csal�� �ҷ�����. �����߾Ȱ�.

select ename,deptno, sal, sal - (select sal from emp where ename = 'CLARK')
from emp;
--���� ��. �׷��� from���� 2�� ���� ��ȿ����.
--from�� �ȿ��ִ� from���� ȿ����? ���� ���ذ��ȵ�.

select ename,deptno from emp; 
--emp���� �̸��� �μ���ȣ�÷��� �����ؼ� ���ο� ���̺��������.

select sal, t, sal - t
from ( select sal, (select sal from emp where ename = 'CLARK') as t from emp);

--cnt 10 cnt 20 cnt 30
--�� �μ��� ������� ����Ͻÿ�
--���η� ���.
select distinct (select count(*) from emp where deptno = 10 group by deptno ) as cnt10,
                (select count(*) from emp where deptno = 20 group by deptno ) as cnt20, 
                (select count(*) from emp where deptno = 30 group by deptno ) as cnt30
from emp;
--group by �ȳ־ ��.
--������ ������ group by�� ������ from emp, from dual.
--from emp�ϸ� ���ڵ� ������ŭ ��µǱ� ������ dual�� ������.
select          (select count(deptno) from emp where deptno = 10) as cnt10,
                (select count(deptno) from emp where deptno = 20) as cnt20, 
                (select count(deptno) from emp where deptno = 30) as cnt30
from dual;

select          (select count(*) from emp where deptno = 10) as cnt10,
                (select count(*) from emp where deptno = 20) as cnt20, 
                (select count(*) from emp where deptno = 30) as cnt30
from dual;

--������ ���
--�Ǻ�
--group by �� decode�� �̿��ؼ�.
select e.deptno, count(e.deptno)
from emp e
group by e.deptno
order by e.deptno;
--��ܽ��� decode
--�����Ѱ� group by
select sum(decode(deptno,10,1,0))as cnt10,
       sum(decode(deptno,20,1,0))as cnt20,
       sum(decode(deptno,30,1,0))as cnt30
from emp;

select decode(deptno,10,1,0)as cnt10,
       decode(deptno,20,1,0)as cnt20,
       decode(deptno,30,1,0)as cnt30
from emp;


select deptno,
       decode(deptno,10, count(*),0) as cnt10,
       decode(deptno,20, count(*),0) as cnt20,
       decode(deptno,30, count(*),0) as cnt30
from emp
group by deptno;
-- not a single-group group function
-- group by�� ������Ѵٴ� ����.
select deptno,
       decode(deptno,10, count(*),0) as cnt10
       --decode(deptno,20, count(*),0) as cnt20,
       --decode(deptno,30, count(*),0) as cnt30
from emp
group by deptno;
