--����1) EMP ���̺��� ������ MANAGER�� ����� �����ȣ, �����, ���(MGR)��ȣ, ������� ����Ͽ���.

select e1.empno �����ȣ, e1.ename �����, e2.empno �����ȣ, e2.ename �����
from emp e1, emp e2
where e1.mgr = e2.empno
and e1.job = 'MANAGER';

--����2) EMP�� DEPT ���̺��� ������ MANAGER�� ����� �̸�, ������, �μ���, �ٹ����� ����Ͽ���.

select e.ename �����, e.job ����, d.dname �μ���,d.loc �ٹ���
from emp e, dept d
where e.deptno = d.deptno
and e.job = 'MANAGER';


--����3) EMP ���̺��� �̸��� ù���ڰ� ��K�� ���� ũ�� ��Y������ ���� ����� ������ �����ȣ, �̸��� ����Ͽ���. �� �̸������� �����Ͽ���.

select empno �����ȣ, ename �����
from emp
where 'K' < substr(ename,1,1) 
and substr(ename,1,1) < 'Y'
order by ename;

--����4) EMP ���̺��� �Ի��Ϻ��� ������� �ٹ��ϼ��� ����Ͽ���. 
--�� �ٹ��ϼ��� �Ҽ��� ���� ����ϵ� �ٹ� �ϼ��� ���� ��� ������ ����Ͽ���.

select ename �����, round(sysdate - hiredate) �ٹ��ϼ�
from emp
order by sysdate - hiredate desc;


--����5) EMP ���̺��� 10�� �μ� ������� �޿��� ������ ����Ͽ� ����Ͽ���.

select sum(sal) DEPT10�޿�����
from emp
where deptno = 10;

--����6) EMP ���̺��� 1981�� 1�� 1�� ���Ŀ� �Ի��� ����� ������ �̸�, ������, �Ի����ڸ� ����Ͽ���.

select ename �����, job ����, hiredate �Ի�����
from emp
where hiredate > to_date('1981-01-01','YYYY-MM-DD') 
order by hiredate;

--����7)  EMP�� DEPT ���̺��� �� �μ��� ������ ������� ����Ͽ���.
--�� ����� ������ �μ� ������ ����Ͽ���.

select d.deptno �μ���ȣ, e.job ����, count(e.job) �����
from emp e, dept d
where e.deptno(+) = d.deptno
group by d.deptno, e.job
order by d.deptno, e.job;

--����8) EMP ���̺��� �μ� �ο��� 4���� ���� �μ��� �μ���ȣ, �ο����� ����Ͽ���.

select e.deptno �μ���ȣ , count(e.deptno) �����
from emp e
having count(e.deptno) > 4
group by e.deptno;


--����9) EMP ���̺��� �������� �޿��� ����5000�� �ʰ��ϴ� �������� �޿��� ���� ����Ͽ���. �� �޿��� �տ� ���� ����(��������)�Ͽ���.

select job ����,  sum(sal) �޿�����
from emp
having sum(sal) > 5000
group by job
order by sum(sal) desc;

--���� 10) EMP ���̺��� �� ����� ���ʽ��� 0 �Ǵ� NULL�̰� �ٹ����� ��GO���� ������ ����� �̸�, ���ʽ�, �μ���ȣ, �μ���, �μ���ġ�� ����Ͽ���. 
--�� ���ʽ��� NULL�̸� 0���� ����Ͽ���.

select e.ename �̸�, nvl(b.bonus,0) ���ʽ�, d.deptno �μ���ȣ, d.dname �μ���, d.loc �μ���ġ
from emp e, bonus b, dept d
where e.deptno(+) = d.deptno
and e.empno = b.empno(+)
and ((b.bonus = 0) or (b.bonus is null))
and d.loc like '%GO'
order by d.deptno;
