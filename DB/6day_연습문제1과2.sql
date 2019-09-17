--��������1. ���� 5��
select *
from emp
where job = (select job from emp where empno = 7499)
and deptno = (select deptno from emp where empno = 7499);

--where�� ��Ƽ�÷��񱳰���
select *
from emp
where (job,deptno) = (select job,deptno from emp where empno = 7499);

----------------------------------------------------------------
--��������1. ���� 6��
select ename, sal, deptno
from emp
where sal in (select sal from emp where deptno = 10);

--��������1. ���� 7��
select ename, hiredate
from emp
where deptno = (select deptno from emp where ename = 'BLAKE')
and ename != 'BLAKE';

--��������2. ���� 3��

select ename, empno
from emp
where empno = (select mgr 
                from emp 
                having count(mgr) = (select max(count(mgr)) 
                                      from emp 
                                      group by mgr)
                group by mgr);
--��������1. ����8
select ename, sal, deptno
from emp
where (deptno,sal) in (select deptno,sal from emp where nvl(comm,0) != 0);

--��������2. ����4.
select (select count(deptno) from emp where deptno = 10) as CNT10,
       (select count(deptno) from emp where deptno = 20) as CNT20
from dual;

--��������2. ����5
select empno, ename, job, sal
from emp
where job = (select job from emp where empno = 7521)
and sal > (select sal from emp where empno = 7934);

--��������2. ����6
select empno, ename, job, dname
from emp, dept
where emp.deptno = dept.deptno
and ename in (select ename 
              from emp 
              where sal in (select 
                            min(sal) 
                            from emp 
                            group by(job))
              )
order by job desc;

--��������2. ����10
--�������� ������ �ɷ��ִ� ����,���������� ������ �ʿ��� ������
--�ɰ��� ���� Ǯ���.
--hiredate���� ���� �����Ȱ��� ���Ϸ��� min���� ���ؾ��Ѵ�.
select empno, ename, deptno, hiredate
from emp
where hiredate in (select min(hiredate)
                      from emp
                      group by deptno);  

--�μ��� �Ի����� ���� ������ ����� ���Ͻÿ�.
select min(hiredate)
from emp
group by deptno;

--��������1. ����9
select ename, sal
from emp
where mgr = (select empno from emp where ename = 'KING');

--join�� �̿��ؼ� Ǯ��.
select e1.ename, e1.sal
from emp e1,emp e2
where e1.mgr = e2.empno
and e2.ename = 'KING';

--��������1. ����10
--------------------------------------------------null�� not in�� = ���ε� �񱳺Ұ���.
select ename,sal,nvl(comm,0)
from emp
where (sal,nvl(comm,0)) not in (select sal,nvl(comm,0) from emp where deptno = 30)
and deptno != 30;

select sal
from emp
where comm not in (null,0); --null�� �� �Ұ���. not null�θ� ����.


--������ comm���� �ٸ��Ŷ�� �ߴµ� null�� �ٸ� comm���������� ���� �Ʒ��� ���� ���´�.
select ename,sal,nvl(comm,0)
from emp
where (sal) not in (select sal from emp where deptno = 30)
and (nvl(comm,0)) not in (select nvl(comm,0) from emp where deptno = 30)
and deptno != 30;





--��������2. ����11
--�����.
select deptno, dname, (select count(*) from emp where hiredate in (select hiredate from emp where to_date('19800101','YYYYMMDD') < hiredate and  hiredate < to_date('19810101','YYYYMMDD'))and deptno = d.deptno) as H1980,
                      (select count(*) from emp where hiredate in (select hiredate from emp where to_date('19810101','YYYYMMDD') < hiredate and  hiredate < to_date('19820101','YYYYMMDD'))and deptno = d.deptno) as H1981,
                      (select count(*) from emp where hiredate in (select hiredate from emp where to_date('19820101','YYYYMMDD') < hiredate)and deptno = d.deptno) as H198_
from dept d
order by deptno,dname;

--��������2. ����12
--decode����.
select ename, decode(comm,0,500,null,500,comm)
from emp
where hiredate > to_date('19810531','YYYYMMDD');

--��������2. ����13
select dept.deptno,ename,job,hiredate
from emp, dept
where hiredate between to_date('19810601','YYYYMMDD') and to_date('19811231','YYYYMMDD')
and dept.dname = 'SALES'
and emp.deptno = dept.deptno;

--��������2. ����16
select e1.empno, e1.ename, e2.empno, e2.ename
from emp e1, emp e2
where e1.sal > e2.sal
and e1.mgr = e2.empno;

--��������2. ����19
--�μ��� ��������� ������ �μ���ȣ, �μ����� ����ض�.
--������� null���� ������ �װ��� ���������� outer join�� ���־���Ѵ�.
select d.deptno, d.dname, e.empno, e.ename, e.hiredate
from emp e, dept d
where e.hiredate(+) > to_date('19810531','YYYYMMDD')
and e.deptno(+) = d.deptno
order by d.deptno, e.hiredate;

--��������2. 

--��������1. ����12.
select d.deptno, d.dname, e.ename, e.sal
from emp e, dept d
where e.deptno(+) = d.deptno
order by e.deptno;
--��������1. ����16.
select ename, dname, sal, job
from emp ,dept
where emp.deptno = dept.deptno
and emp.job = (select job from emp where ename = 'JONES');

--��������1. ����17.
select empno,ename,hiredate,sal
from emp
where deptno = (select deptno from emp where ename = 'JONES')
order by deptno;

--��������1. ����18.
select empno,ename,dname,hiredate,loc
from emp, dept
where emp.deptno(+) = dept.deptno
and job in (select job from emp where deptno = 20)
and dept.deptno = 10
order by dept.deptno;

--��������2. ����1.
select deptno, count(*), sum(sal)
from emp
having count(*) > 4
group by deptno;

--��������1. ����20.
select emp.deptno,job,empno,ename,dname,hiredate
from emp, dept
where job not in (select job from emp where deptno = 30)
and emp.deptno = 10
and emp.deptno = dept.deptno
order by emp.deptno;


--��������1. ����21.
select empno,ename,dname,loc,sal
from emp, dept
where emp.deptno = dept.deptno
and job in (select job from emp where deptno = 10)
order by dept.deptno;

--��������1. ����22.
select empno, ename, sal
from emp
where sal in (select sal from emp where ename = 'MARTIN' or ename = 'SCOTT')
order by sal;
---------------------------------------�������
--��������1. ����23.
select empno,ename,job,sal
from emp
where job = (select job from emp where empno = 7521)
and sal > (select sal from emp where empno = 7934)
order by sal;

--��������1. ���� 24.
select deptno, ename, round((sal/160),1)
from emp
order by deptno,sal desc;

--��������1. ����25.
select empno, ename,nvl(comm,0), dept.deptno, dname, loc
from emp, dept
where emp.deptno = dept.deptno
and loc like '%GO'
and nvl(comm,0) = 0
order by sal;

--��������1. ���� 29.
select e1.empno, e1.ename, e2.empno, e2.ename
from emp e1, emp e2
where e1.mgr = e2.empno
and e1.sal >= e2.sal;

--��������1. ���� 30.
select d.deptno, d.dname, e.empno, e.ename, e.hiredate
from emp e, dept d
where e.hiredate(+) > to_date('19810531','YYYYMMDD')
and e.deptno(+) = d.deptno
order by d.deptno, e.hiredate;

--��������1. ���� 31.
select empno, ename, hiredate, trunc((sysdate - hiredate)/365)
from emp
where trunc((sysdate - hiredate)/365) >= 30;

--to_char ����
select to_char((sysdate - hiredate),'YYYY-MM-DD')
from emp;
--�̹� ������ ������ ��������.
SELECT TO_CHAR(SYSDATE - hiredate)
FROM emp;

--��������2. ����4.
select count(*)
from emp
group by deptno;

select sum(decode(deptno,10,1,0))as cnt10, sum(decode(deptno,30,1,0)) as cnt30
from emp;

--�ּұ޿��� �޴� ������� ��ȸ 
select *
from emp
where sal = (select min(sal) from emp);

--�ּұ޿��� �޴� ������� ��ȸ �������� ����??????????????????????
select e1.*
from emp e1,emp e2
having e1.sal = min(e2.sal)
group by e2.empno;

--�׷캰 �ּұ޿��� �޴� ������� ��ȸ
select *
from emp
where sal in (select min(sal) from emp group by deptno)
order by deptno;