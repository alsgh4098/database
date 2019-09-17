--1
SELECT E.ENAME,E.JOB,D.DNAME, D.LOC 
FROM DEPT D,EMP E
WHERE D.LOC = 'DALLAS'
AND D.DEPTNO = E.DEPTNO;

--2
SELECT E.ENAME, D.DNAME
FROM DEPT D, EMP E
WHERE D.DEPTNO = E.DEPTNO
AND E.ENAME LIKE 'A%';

--3
SELECT E.JOB,E.ENAME,D.DEPTNO
FROM DEPT D, EMP E
WHERE D.DEPTNO = E.DEPTNO
AND E.JOB = 'SALESMAN';

--4
SELECT D.DEPTNO,D.DNAME,E.ENAME,E.SAL
FROM DEPT D, EMP E
WHERE D.DEPTNO = E.DEPTNO
AND (E.DEPTNO = 10 OR E.DEPTNO = 20)
ORDER BY DEPTNO ASC,SAL DESC;

--5
SELECT *
FROM EMP E1, (SELECT * FROM EMP WHERE EMPNO = 7499) E2
WHERE E1.DEPTNO = E2.DEPTNO
AND E1.JOB = E2.JOB;

/* 6�� */
SELECT E1.ENAME, E1.SAL, E1.DEPTNO
FROM EMP E1, (SELECT * FROM EMP WHERE DEPTNO = 10) E2
WHERE E1.SAL = E2.SAL
AND E1.DEPTNO = E2.DEPTNO;

/* 7�� */
SELECT E1.ENAME, E1.HIREDATE
FROM EMP E1, (SELECT * FROM EMP WHERE ENAME = 'BLAKE') E2
WHERE E1.DEPTNO = E2.DEPTNO
AND E1.DEPTNO = E2.DEPTNO
AND E1.ENAME != 'BLAKE';

/* 8�� */
SELECT E1.ENAME, E1.SAL, E1.DEPTNO
FROM EMP E1, (SELECT * FROM EMP WHERE COMM IS NOT NULL) E2
WHERE E1.DEPTNO = E2.DEPTNO
AND E1.SAL = E2.SAL;

/* 9�� */
SELECT E1.ENAME,E1.SAL
FROM EMP E1 ,(SELECT * FROM EMP E2 WHERE ENAME = 'KING') E2
WHERE E1.MGR = E2.EMPNO;

/* 10�� */
SELECT E1.ENAME, E1.SAL, E1.COMM
FROM EMP E1, (SELECT * FROM EMP WHERE EMPNO = 30) E2
WHERE E1.SAL != E2.SAL;



/* 10�� */
select sal, nvl(comm,0) as comm from emp
where deptno=30;

select ename ,sal ,nvl(comm,0) as comm
from emp
where (sal,comm) not in (select sal,nvl(comm,0) as comm
                        from emp
                        where deptno=30);
                        
--12. EMP�� DEPT TABLE�� JOIN�Ͽ� �μ� ��ȣ,  �μ���,  �̸�, �޿��� ����϶�.


--13. �̸��� 'ALLEN'�� ����� �μ����� ����϶�.
select d.dname 
from dept d, emp e
where d.deptno = e.deptno
and ename = upper('allen');

select d.deptno, d.dname, e.ename, e.sal
from emp e, dept d
where e.deptno = d.deptno;

--14. DEPT Table�� �ִ� ��� �μ��� ����ϰ�, EMP Table�� �ִ� DATA�� JOIN�Ͽ� ��� ����� �̸�, �μ���ȣ, �μ���, �޿��� ����϶�.
select e1.ename, e1.deptno, d.dname, e1.sal
from emp e1, dept d
where d.deptno = e1.deptno(+)
order by d.deptno;
--15. EMP ���̺��� ��� �����ȣ, �����, �Ŵ�����ȣ, �Ŵ������� ����϶�. 
select e1.empno, e1.ename, e1.mgr, e2.ename
from emp e1, emp e2
where e1.mgr = e2.empno
order by e1.mgr;

--17. 'JONES'�� �����ִ� �μ��� ������� �����ȣ, �̸�, �Ի���, �޿��� ����϶�.
select e1.deptno, e1.empno, e1.ename, e1.hiredate, e1.sal
from emp e1
where e1.deptno = (select deptno from emp where ename = 'JONES')
order by empno;

--18. 10�� �μ��� ������߿��� 20�� �μ��� ����� ���� ������ �ϴ� ����� �����ȣ, �̸�, �μ���, �Ի���, ������ ����϶�.
select *
from emp e1
where e1.deptno = 10
and e1.job in (select job from emp where deptno = 20);

--20. 10�� �μ� �߿��� 30�� �μ����� ���� �ӹ��� �ϴ� ����� �����ȣ, �̸�, �μ���, �Ի���, ������ ����϶�.
select *
from emp e1
where e1.deptno = 10
and e1.job not in(select job from emp where deptno = 30);

--21. 10�� �μ��� ���� ���� �ϴ� ����� �����ȣ, �̸�, �μ���, ����, �޿��� �޿��� ���� ������ ����϶�.
select *
from emp
where job in(select job from emp where deptno = 10);

--22. 'MARTIN'�̳� 'SCOTT'�� �޿��� ���� ����� �����ȣ, �̸�, �޿��� ����϶�.
select empno, ename, sal
from emp
where sal in(select sal from emp where ename = 'MARTIN' or ename = 'SCOTT')
and ename != 'MARTIN' and ename != 'SCOTT';

--23. EMP ���̺��� �����ȣ(EMPNO)�� 7521�� ����� ����(JOB)�� ���� �����ȣ(EMPNO)�� 7934�� ����� �޿�(SAL)���� ���� ����� �����ȣ, �̸�, ����, �޿��� ����Ͻÿ�.
select empno, ename, sal, job
from emp
where job = (select job from emp where empno = 7521)
and sal > (select sal from emp where empno = 7934);

--24. �� ��� �� �ñ��� ����Ͽ� �μ���ȣ, ����̸�, �ñ��� ����Ͻÿ�.
select deptno, ename, round(sal/160,1)
from emp
order by deptno,sal desc;

--25. �� ��� �� Ŀ�̼�(COMM)�� 0 �Ǵ� NULL�̰� �μ���ġ�� ��GO���� ������ ����� ������ �����ȣ, ����̸�, Ŀ�̼�, �μ���ȣ, �μ���, �μ���ġ�� ����Ͽ���. 
select e.empno, e.ename, nvl(e.comm,0), d.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno
and nvl(comm,0) = 0
and loc like '%GO';

--26. 1981�� 6�� 1�� ~ 1981�� 12�� 31�� �Ի��� �� �μ���(DNAME)�� SALES�� ����� �μ���ȣ, �����, ����, �Ի����� ����Ͻÿ�.
select d.deptno, e.ename, e.job, e.hiredate
from emp e, dept d
where e.deptno = d.deptno
and e.hiredate between '1981-06-01' and '1981-12-31'
and dname = 'SALES';

--27. ���� �ð��� ���� �ð����κ��� �� �ð� ���� �ð��� ����Ͻÿ�.
select to_char(sysdate,'YYYY-MM-DD  HH24:MI:SS') ����ð� ,to_char(sysdate+(1/24),'YYYY-MM-DD  HH24:MI:SS') ��_�ð�_�� from dual;

--28. �� �μ��� ������� ����Ͻÿ�.
select d.deptno, d.dname, decode(count(empno),'0','����',to_char(count(empno)) )
from emp e, dept d
where d.deptno = e.deptno(+)
group by d.deptno, d.dname
order by d.deptno;

--29.��� ���̺��� �� ����� �����ȣ, �����, �Ŵ�����ȣ, �Ŵ������� ����Ͻÿ�.
select e1.empno, e1.ename, e2.empno, e2.ename
from emp e1, emp e2
where e1.mgr = e2.empno
and e1.sal >= e2.sal;

--************************************************
--30. �� �μ����� 1981�� 5�� 31�� ���� �Ի����� �μ���ȣ, �μ���, �����ȣ, �����, �Ի����� ����Ͻÿ�.
select d.deptno, d.dname, e.ename, e.hiredate
from emp e, dept d
where e.deptno(+) = d.deptno
and e.hiredate(+) > to_date('1981-05-31','yyyy-mm-dd')
order by d.deptno, e.hiredate asc;

--*************************************************
--31. �Ի��Ϸκ��� ���ݱ��� �ٹ������ 30�� �̻��� ����� �����ȣ, �����, �Ի���, �ٹ������ ����Ͻÿ�.
select empno, ename, hiredate, trunc((sysdate-hiredate)/365) as �ٹ����
from emp
where trunc((sysdate-hiredate)/365) >= 30;