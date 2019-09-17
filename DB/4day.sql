--1. EMP ���̺��� �μ� �ο��� 4���� ���� �μ��� �μ���ȣ, �ο���, �޿��� ���� ����Ͻÿ�. 
select d.deptno, d.dname, count(d.deptno) �����, sum(e.sal) �޿���
from emp e, dept d
where e.deptno(+) = d.deptno
group by d.deptno, d.dname
having count(d.deptno) > 4
order by d.deptno;

--2.  EMP ���̺��� ���� ���� ����� �����ִ� �μ���ȣ�� ������� ����Ͻÿ�.
select e.deptno, d.dname, count(d.deptno)
from emp e, dept d
where e.deptno = d.deptno
having count(d.deptno) = (select max(count(deptno)) from emp group by deptno) -- �������������� e.deptno�� ����� �ʿ䰡 ���⶧���� max(count(deptno)�� select���ش�.
group by e.deptno, d.dname
order by count(d.deptno);


--3. EMP ���̺��� ���� ���� ����� ���� MGR�� �����ȣ�� ����Ͻÿ�.
-- �ٽ� ���ؼ� �λ���� ���� ���� �������ִ� �����ȣ�� ����Ͻÿ�.
-- ��ƴ� �̰�

--�Ʒ��� emp���̺� �ΰ��� �ҷ��� �ϳ��� mgr�� �ٸ� �ϳ��� empno�� ��ġ�Ѱ͸� ��� 
--group by ������̺��� �����ȣ�� ��� �������� ���� ���� �λ�����ִ� �����ȣ�� ����. 
select max(count(e2.empno)) 
from emp e1, emp e2 
where e1.deptno = e2.deptno 
and e1.mgr = e2.empno 
group by e2.empno;

--
select e2.empno, count(e2.empno)
from emp e1, emp e2 
where e1.deptno = e2.deptno and e1.mgr = e2.empno --���⼭ �ٽ��� el.mgr = e2.empno
having count(e2.empno) = (select max(count(e2.empno)) 
                        from emp e1, emp e2 
                        where e1.deptno = e2.deptno 
                        and e1.mgr = e2.empno 
                        group by e2.empno)
group by e2.empno;




--4. EMP ���̺��� �μ���ȣ�� 10�� ������� �μ���ȣ�� 30�� ������� ���� ����Ͻÿ�.


--5. EMP ���̺��� �����ȣ(EMPNO)�� 7521�� ����� ����(JOB)�� ���� �����ȣ(EMPNO)�� 7934�� ����� �޿�(SAL)���� ���� ����� �����ȣ, �̸�, ����, �޿��� ����Ͻÿ�.


--6. ����(JOB)���� �ּ� �޿��� �޴� ����� ������ �����ȣ, �̸�, ����, �μ����� ����Ͻÿ�. 
--����1 : �������� �������� ����

--7. �� ��� �� �ñ��� ����Ͽ� �μ���ȣ, ����̸�, �ñ��� ����Ͻÿ�.
--����1. �Ѵ� �ٹ��ϼ��� 20��, �Ϸ� �ٹ��ð��� 8�ð��̴�.
--����2. �ñ��� �Ҽ� �� ��° �ڸ����� �ݿø��Ѵ�.
--����3. �μ����� �������� ����
--����4. �ñ��� ���� ������ ���.


--8. �� ��� �� Ŀ�̼�(COMM)�� 0 �Ǵ� NULL�̰� �μ���ġ�� ��GO���� ������ ����� ������ �����ȣ, ����̸�, Ŀ�̼�, �μ���ȣ, �μ���, �μ���ġ�� ����Ͽ���. 
--����1. Ŀ�̼�(COMM)�� NULL�̸� 0���� ���
select  e.empno, e.ename, nvl(e.comm,0), d.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno(+) = d.deptno and (e.comm = 0 or e.comm is null) and d.loc like '%GO'
order by d.deptno;





--9. �� �μ� �� ��� �޿��� 2000 �̻��̸� �ʰ�, �׷��� ������ �̸��� ����Ͻÿ�.
select d.dname, d.deptno, round(avg(e.sal),0), decode(    substr    (   to_char(avg(e.sal))  ,  length(to_char(round(avg(e.sal) , 0)))  -3  ,  1  ),    '2'    ,    '�ʰ�'    ,    '�̸�'    )
from emp e, dept d
where e.deptno = d.deptno
group by d.dname, d.deptno
order by d.deptno, avg(e.sal);


-- case when ~then~ end ������ ����.
select d.dname, d.deptno, round(avg(e.sal),0), 
(case
  when round(avg(e.sal),0) > 2000 then '�ʰ�'
  when round(avg(e.sal),0) <= 2000 then '�̸�' -- �Ǵ� else ' '
end)
from emp e, dept d
where e.deptno = d.deptno
group by d.dname, d.deptno
order by d.deptno, avg(e.sal);

--10. �� �μ� �� �Ի����� ���� ������ ����� �� �� ������ �����ȣ, �����, �μ���ȣ, �Ի����� ����Ͻÿ�.

--11. 1980��~1980�� ���̿� �Ի�� �� �μ��� ������� �μ���ȣ, �μ���, �Ի�1980, �Ի�1981, �Ի�1982�� ����Ͻÿ�. 

--12. 1981�� 5�� 31�� ���� �Ի��� �� Ŀ�̼�(COMM)�� NULL�̰ų� 0�� ����� Ŀ�̼��� 500���� �׷��� ������ ���� COMM�� ����Ͻÿ�.
select e.hiredate, e.ename, decode(e.comm,0,500,null,500,comm)
from emp e
where e.hiredate > to_date('1981-05-31','YYYY-MM--DD')
order by e.hiredate;

----------------------------------------------------------------------------------
select e.hiredate, e.ename, decode(nvl(e.comm,0),0,500,comm)
from emp e
where e.hiredate > to_date('1981-05-31','YYYY-MM-DD')
order by e.hiredate;

select nvl(e.comm,0)
from emp e;

select substr('ascdefg',1,2)
from emp;

select ename, substr(ename, 1,2)||
lpad(substr(ename, -2,2), length(ename)-2, '*')
from emp;

--Q.�� �μ��� �������� ���� �ִ� ������� ����Ͻÿ�.
--����1. �������� �ݵ�� �Ŵ���(mng)�� �ִ�.
--����2. ������ ������� �ּ� 2�� �̻��� ������ ������� �Ѵ�.
--����3. ������ ����� 1981��3������ �Ի��ڸ� ������� �Ѵ�.

select e.deptno, count(deptno) �����
from emp e
where e.mgr != 0 
and e.mgr is not null 
and e.hiredate > to_date('1981-03-01','YYYY-MM-DD')
group by e.deptno
having count(deptno) >= 2
order by e.deptno;

select decode(to_char(1), (2001>2000) ,'�ʰ�','�̸�')
from emp;

--9. �� �μ� �� ��� �޿��� 2000 �̻��̸� �ʰ�, �׷��� ������ �̸��� ����Ͻÿ�.
select d.dname, d.deptno, round(avg(e.sal),0), decode(substr(to_char(avg(e.sal)), to_char(avg(e.sal)),1), '2','�ʰ�','�̸�')
from emp e, dept d
where e.deptno = d.deptno
group by d.dname, d.deptno
order by d.deptno, avg(e.sal);

select d.dname, d.deptno, round(avg(e.sal),0), decode(    substr    (   to_char(avg(e.sal))  ,  length(to_char(round(avg(e.sal) , 0)))-3  ,  1  ),    '2'    ,    '�ʰ�'    ,    '�̸�'    )
from emp e, dept d
where e.deptno = d.deptno
group by d.dname, d.deptno
order by d.deptno, avg(e.sal);

select d.dname, d.deptno, length(to_char(round(avg(e.sal),0)))
from emp e, dept d
where e.deptno = d.deptno
group by d.dname, d.deptno
order by d.deptno, avg(e.sal);


select d.dname, d.deptno, round(avg(e.sal),0), decode( substr ( to_char(avg(e.sal)), length(to_char(round(avg(e.sal),0)))-3,1), '2','�ʰ�','�̸�')
from emp e, dept d
where e.deptno = d.deptno
group by d.dname, d.deptno
order by d.deptno, avg(e.sal);

--13. 1981�� 6�� 1�� ~ 1981�� 12�� 31�� �Ի��� �� �μ���(DNAME)�� SALES�� ����� �μ���ȣ, �����, ����, �Ի����� ����Ͻÿ�.
--����1. �Ի��� �������� ����
select d.dname, e.ename, e.job, e.hiredate
from emp e, dept d
where e.deptno(+) = d.deptno
and e.hiredate between to_date('1981-06-01','YYYY-MM-DD') and to_date('1981-12-31','YYYY-MM-DD')
and d.dname = 'SALES'
order by e.hiredate;