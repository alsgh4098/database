--�����
--�̸��� �յ� �α��ڸ� �����ϰ� ��ǥ��
select ename, substr(ename,1,1) || lpad('*',length(ename)-2, '*') || substr(ename,1,1) from emp;

--subquery
--������ ������� �̸��� ����ϰ� �޿����� CLARK�� �޿��� �� �޿��� ����϶�.
select ename, sal, sal - (select sal from emp where ename = 'CLARK') sal_clark_s_sal
from emp;


select 