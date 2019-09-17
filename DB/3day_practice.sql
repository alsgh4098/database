--�� �μ��� ��� �޿�
select d.dname, d.deptno, round(avg(e.sal),0)
from emp e, dept d
where e.deptno(+) = d.deptno
group by d.dname, d.deptno
order by avg(e.sal);


--���� : �� �μ��� ��ձ޿� �� ���� ���� ��ձ޿��� ���� �μ���
select d.deptno �μ���ȣ, d.dname �μ���, round(avg(e.sal),0) ��ձ޿�
from emp e, dept d
where e.deptno = d.deptno   
group by d.deptno, d.dname;
--

--���������� from ���� select���� ����Ҽ� �ֱ���.
select d.deptno �μ���ȣ, d.dname �μ���, round(avg(e.sal),0) as ��ձ޿�
from emp e, dept d
where e.deptno = d.deptno   
group by d.deptno, d.dname
having avg(e.sal) = (select min(avg(sal)) from emp group by deptno)
;                          

--�� �μ��� �ּұ޿��� �޴»���� �μ��̸�, �μ���ȣ, �̸�
select d.dname, d.deptno, e.sal
from emp e, dept d
where e.sal in (select min(sal) from emp group by deptno)
and e.deptno = d.deptno;

--�μ��� �ּұ޿� ���ϱ�.
select min(sal)
from emp
group by deptno;


--����: emp ���̺��� ���� ���� ������?


--�μ��� ��ձ޿�

select d.deptno, round(avg(e.sal))
from emp e, dept d
where e.deptno(+) = d.deptno
group by d.deptno
order by d.deptno;

select d.deptno, round(avg(e.sal))
from emp e, dept d
where e.deptno(+) = d.deptno
group by d.deptno
order by d.deptno;

--�� �μ��� ��ձ޿��� ���� ���� �޿��� ���ºμ� ���.
--��ư� �������� ���� : join�� ����ϴ� ���������� ����ϴ� �ΰ��� ���̺��� �ʿ��ϰ� �� �ΰ��� ���̺� ��� group by�� �ɾ���ϱ⶧����

select e2.deptno, min(e2.avg_sal)
from (select e1.deptno, avg(e1.sal) as avg_sal 
              from emp e1
              group by e1.deptno) e2-- ���̺��� as�Ұ�.

group by e2.deptno;

select e1.deptno, round(avg(e1.sal))
from emp e1
having avg(e1.sal) =  (select min(avg(sal))
              from emp
              group by deptno)
group by e1.deptno;


select e.deptno �μ���ȣ, round(avg(e.sal),0) as ��ձ޿�
from emp e
group by e.deptno
having avg(e.sal) = (select min(avg(sal)) from emp group by deptno);

--�� �μ��� ��ձ޿��� ���� ���� �޿��� ���ºμ� ���.
--��ư� �������� ���� : join�� ����ϴ� ���������� ����ϴ� �ΰ��� ���̺��� �ʿ��ϰ� �� �ΰ��� ���̺� ��� group by�� �ɾ���ϱ⶧����
select e.deptno, d.dname, round(avg(e.sal))
from emp e, dept d
having avg(e.sal) = (select min(avg(sal)) from emp group by deptno)
group by e.deptno, d.dname;
