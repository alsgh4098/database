--1�� dallas�� �ٹ��ϴ� ����� �̸�, ���� , �μ���ȣ, �μ��̸��� ����϶�.
select e.ename, e.job, e.empno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno and loc = 'DALLAS'
order by e.empno;

--2�� �̸��� 'A'�� ���� ����� �̸��� �μ��� ����϶�.
select e.ename, d.dname
from emp e, dept d
where e.deptno = d.deptno and e.ename like '%A%'
order by d.dname;

--3�� ������ salesman�� ������� ������ �̸� �μ��̸��� ����϶�.
select e.ename, d.dname, e.job
from emp e, dept d
where e.deptno = d.deptno and e.job = 'SALESMAN'
order by d.dname;


--4�� �μ� 10�� 20�������
select d.deptno , d.dname , e.ename, e.sal
from emp e, dept d 
where (e.deptno = d.deptno) and (d.deptno = '10' or d.deptno = '20')
order by e.deptno , e.sal desc;


--5�� �����ȣ�� 7499�� ����� ������ �μ���ȣ�� ��ġ�ϴ� ����� ������ ����ض�.
select *
from emp e, dept d, (select deptno, job from emp where EMPNO = '7499') e2
where (e.deptno = d.deptno) and (e.deptno = e2.deptno and e.job = e2.job);

--6�� 10�� �μ��� ������ ���� ������ ���� ������ �޴� ������� �̸�, ����, �μ�
select e.ename, d.dname, e.sal
from emp e, dept d, (select sal from emp where deptno = '10') e2
where (e.deptno = d.deptno) and (e.sal = e2.sal);

--7�� blake�� ���� �μ��� �ִ� ������� �̸��� ����� ���. ��, blake�� ����.
select e.ename, e.hiredate
from emp e, (select ename,hiredate,deptno from emp where ename = 'BLAKE') e2
where e.deptno = e2.deptno and e.ename != 'BLAKE';


--8�� �������� ����� Ŀ�̼��� �޴� ����� ������. �� Ŀ�̼��� �޴� ������� �μ���ȣ�� ������ ���� ����� �̸��� ����, �μ���ȣ�� ����ض�.
select e.ename, e.sal, e.deptno
from emp e, (select ename, sal, deptno from emp where emp.comm is not null) e2
where e.sal = e2.sal and e.deptno = e2.deptno;

--9��

--10. 30�� �μ� ������ ���ް� Ŀ�̼��� ���� ���� ������� �̸�, ����, Ŀ�̼��� ����϶�.
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
--12�� DEPT�� EMP�� JOIN�Ͽ� �μ���ȣ, �μ���, �̸�, �޿�
select e.deptno, d.dname, e.ename, e.sal
from emp e, dept d
where e.deptno = d.deptno;

--13��
select e.deptno, d.dname, e.ename, e.sal
from emp e, dept d
where e.deptno = d.deptno and e.ename = 'ALLEN';

--14�� DEPT Table�� �ִ� ��� �μ��� ����ϰ�, EMP Table�� �ִ� DATA�� JOIN�Ͽ� ��� ����� �̸�, �μ���ȣ, �μ���, �޿��� ����϶�.
-- �ƿ��� ����/ �ƿ��� ������ null���� �ִ� ���ڵ嵵 ����ϱ� ���ؼ� �����.
select d.dname, e.ename, d.deptno, e.sal
from emp e, dept d
where e.deptno(+) = d.deptno; --(+) �ƿ��� ����, null���� �������. �� ������ ����Ŭ���� �ִ� ����Ŭ �����̴�.

select d.dname, e.ename, d.deptno, e.sal
from emp e, dept d
where e.deptno = d.deptno; -- �⺻ ����. d.deptno�� �ִ� 40�� ��µ��� �ʴ´�.
                            
-- +�� emp���̺��� e�� ������ ������ �������� �ɸ� deptno�� ���� e���� 10,20,30���� d���� 10,20,30,40���� �ֱ⶧���� �� ���� ������ ���� ���̺� �ɾ�����Ѵ�.

select d.dname, e.ename, e.deptno, e.sal
from emp e, dept d
where e.deptno = d.deptno(+);
--and e.deptno(+) = 40;

-- �������� ��� db�� ����� ������ �ִ� '�Ƚ� sql'�̶����.
-- �Ƚ� ǥ�ع��� equal join�� outer join
-- from ~~~ join ~~~ on ~~~~ = ~~~~ ���⼭ on�� ����Ŭ���� ���ο��� where�� ���������� �Ѵ�.


select d.deptno, d.dname
from emp e left join dept d on e.deptno = d.deptno;

select d.deptno, d.dname
from emp e right join dept d on e.deptno = d.deptno; -- ����������(�÷� ������ �� ���� ������) ���� ����Ŭ������ ������ �ݴ��� �����ϸ�ȴ�. ����Ŭ ���������� �����ʿ� +�� �ɾ��ְ� �Ƚù��������� ū������ ������ �����ش�.

select d.deptno, d.dname
from emp e left outer join dept d on e.deptno = d.deptno;

select d.deptno, d.dname
from emp e right outer join dept d on e.deptno = d.deptno;

--�����ȣ, �����, �μ���ȣ, �μ���, ���ʽ��� ����Ͻÿ�. �� �μ��� ����� ������ �μ������� ����ؾ���. ���ʽ��� ���� �ʴ´ٸ� 0���� ���. �μ��� �������� ����.
select nvl(e.empno,0), d.deptno, nvl(e.ename,'none'), d.dname, nvl(b.bonus,0)
from emp e, dept d, bonus b
where e.deptno(+) = d.deptno and e.empno = b.empno(+)
order by d.deptno asc;
--���ʽ��� �ȹ޴� ���. �μ���ȣ�� �����ϰ� �μ����� ���� ���ڵ嵵 ���� ��õȴ�.

--�Ƚù������� Ǭ ���.
select nvl(e.empno,0), d.deptno, nvl(e.ename,'none'), d.dname, nvl(b.bonus,0)
from (emp e right outer join dept d on e.deptno = d.deptno) left outer join bonus b on e.empno = b.empno
order by d.deptno asc;

--15. EMP ���̺��� ��� �����ȣ, ������ �׵���  �Ŵ�����ȣ, �Ŵ������� ����϶�. 
-- self join �ϳ��� ���̺��� ������ �����͸� �����ϴ°�.
-- �Ŵ����� ���� ����(king)�� ����϶�).
select e.ename ����̸� , nvl(e.empno,0) �����ȣ, e2.ename �Ŵ����̸� , nvl(e2.mgr,0) �Ŵ�����ȣ
from emp e, emp e2
where e.mgr = e2.empno(+); -- ����ϰ��� �ϴ� ������ �Ŵ����̸�, �Ŵ�����ȣ�� ��� �� null���� ����ϰ��� �ϴ°��̰� �� ������ �Ŵ����̸�
-- �Ŵ�����ȣ�� ����� ���̺� e2�� �ֱ⶧���� e2�� �ƿ��� ���� ������Ѵ�.

--16.

--24. �� ��� �� �ñ��� ����Ͽ� �μ���ȣ, ����̸�, �ñ��� ����Ͻÿ�.
--����1. �Ѵ� �ٹ��ϼ��� 20��, �Ϸ� �ٹ��ð��� 8�ð��̴�.
--����2. �ñ��� �Ҽ� �� ��° �ڸ����� �ݿø��Ѵ�.
--����3. �μ����� �������� ����
--����4. �ñ��� ���� ������ ���.

select e.deptno, e.ename, round(e.sal/160,1) �ñ�
from emp e
order by deptno, �ñ� desc; -- ALIAS ��밡�� ORDER BY���� ����.

--�������� ������ �׳� order by �ϰ� , , , , , ,�����ϸ��.

--25. �� ��� �� Ŀ�̼�(COMM)�� 0 �Ǵ� NULL�̰� �μ���ġ�� ��GO���� ������ ����� �����ȣ, ����̸�, Ŀ�̼�, �μ���ȣ, �μ���, �μ���ġ�� ����Ͽ���. 
--����1. Ŀ�̼�(COMM)�� NULL�̸� 0���� ���
select e.empno, e.ename, nvl(e.comm,0) , d.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno 
and (comm is null or comm = 0) and d.loc like '%GO';

--26. 1981�� 6�� 1�� ~ 1981�� 12�� 31�� �Ի��� �� �μ���(DNAME)�� SALES�� ����� �μ���ȣ, �����, ����, �Ի����� ����Ͻÿ�.
--����1. �Ի��� �������� ����

select d.deptno, d.dname, e.job, e.hiredate �Ի���
from emp e, dept d
where e.deptno = d.deptno
and d.dname = 'SALES' and e.hiredate between '1981-06-01' and '1981-12-31'  -- �Ϲ������δ� to_date�� �̿��ؼ� ���ؾ� ������Ÿ�԰� �񱳰� �ȴ�. 
order by �Ի��� asc;

--27. ���� �ð��� ���� �ð����κ��� �� �ð� ���� �ð��� ����Ͻÿ�.
--����1. ����ð� ������ ��4�ڸ���-2���Ͽ�-2�ڸ���  24��:2�ڸ���:2�ڸ��ʡ� 
--����2. �ѽð��� ������ ��4�ڸ���-2���Ͽ�-2�ڸ���  24��:2�ڸ���:2�ڸ��ʡ� 

select to_char(sysdate,'YYYY-MM-DD  HH24:MI:SS') ����ð� ,to_char(sysdate+(1/24),'YYYY-MM-DD  HH24:MI:SS') ��_�ð�_�� from dual;

------------------------------------------------------------------------------------
--�ð� ���ϱ� sysdate���ٰ� 1�� ���ϸ� 1��, 1/24�� ���ϸ� �� �ð� 365�� ���ϸ� 1��
------------------------------------------------------------------------------------

--28. �� �μ��� �����, �μ����� ����Ͻÿ�.
--����1. �μ��� ������� ������ �μ���ȣ
--�μ����� ���
--����2. �μ��� ������� 0�� ��� �������� ���
--����3. �μ���ȣ �������� ����

--Ŀ�̼��� ���̸� ����, ������ �״��

select decode(comm,null,'����',comm)
from emp;


select nvl(to_char(comm),'����')
from emp;

--�μ���ȣ�� 10 20 30�̸� ���� �� �̽� ������� ���
----------------------------------------------------------------------------------
                                        decode
----------------------------------------------------------------------------------
select decode(e.deptno,
10,'��',
20,'�̽�',
30,'���',
to_char(e.deptno)), e.ename
from emp e
order by e.deptno;

select d.deptno, d.dname, nvl(to_char(count(empno)),'����') as ����� -- count�� null���� ������ �ʰ� null���� ��������� �ʴ´� ���� nvl�� �ƿ� ������ �� ����.
from emp e, dept d
where e.deptno(+) = d.deptno
group by d.deptno, d.dname
order by d.deptno asc;


select d.deptno, d.dname, decode(count(empno),0,'����',to_char(count(empno))) as �����
from emp e, dept d
where e.deptno(+) = d.deptno
group by d.deptno, d.dname
order by d.deptno asc;

select e.deptno, d.dname, e.deptno
from emp e, dept d
where e.deptno(+) = d.deptno;



--29. ��� ���̺��� �� ����� �����ȣ, �����, �Ŵ�����ȣ, �Ŵ������� ����Ͻÿ�.
--����1. �� ����� �޿�(SAL)�� �Ŵ��� �޿����� ���ų� ����.

select  nvl(e.empno,0) �����ȣ, e.ename ����̸� , nvl(e2.empno,0) �Ŵ�����ȣ, e2.ename �Ŵ����̸�
from emp e, emp e2
where e.mgr = e2.empno and e.sal >= e2.sal;

--30. �� �μ����� 1981�� 5�� 31�� ���� �Ի����� �μ���ȣ, �μ���, �����ȣ, �����, �Ի����� ����Ͻÿ�.
--����1. �μ��� ��������� ������ �μ���ȣ, �μ����� ���
--����2. �μ���ȣ �������� ����
--����3. �Ի��� �������� ����

--���� Ǭ ���
select d.deptno, d.dname , e.empno, e.ename, e.hiredate
from emp e, dept d
where e.deptno(+) = d.deptno 
and ((e.hiredate >= '1981-06-01') or e.hiredate is null)
order by  d.deptno, d.dname, e.hiredate;

--���� Ǭ ����� �������� Ǭ ����� �������� �������� �� �׷�����
--���� Ǭ ����� hiredate�� null���� where���ǹ����� 
--�������� �˷��ֽ� ���. hiredate�� (+)���̽�.
select d.deptno, d.dname , e.empno, e.ename, e.hiredate
from emp e, dept d
where e.deptno(+) = d.deptno
and e.hiredate(+) > to_date('1981-06-01','YYYY-MM--DD') -- join���� �� ����ϱ⸦ ���ϴ� �÷��� ������ �ɶ����� �÷����� �ƿ��������� �ɾ�����ϴ°Ͱ���.
order by d.deptno asc, e.hiredate asc;


--31�Ի��Ϸκ��� ���ݱ��� �ٹ������ 30�� �̻��� ����� �����ȣ, �����, �Ի���, �ٹ������ ����Ͻÿ�.
--����1. �ٹ������ ���� �������� ����
select e.empno, e.ename, e.hiredate, round((sysdate - e.hiredate)/365,0) �ټӿ���
from emp e
where round(((sysdate - e.hiredate)/365),0) >= 30
order by �ټӿ��� asc;

-- trunc() �����Լ� trunc(����,�����Ҽ�����ġ)
-- round() �ݿø��Լ�
select e.empno, e.ename, e.hiredate, trunc((sysdate - e.hiredate)/365) �ټӿ���
from emp e
where trunc(((sysdate - e.hiredate)/365)) >= 30
order by �ټӿ��� asc;
