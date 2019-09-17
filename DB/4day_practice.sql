--count�Լ� null�� ����� Ȯ��
select comm, count(comm) from emp group by comm;

--30. �� �μ����� 1981�� 5�� 31�� ���� �Ի����� �μ���ȣ, �μ���, �����ȣ, �����, �Ի����� ����Ͻÿ�.
--����1. �μ��� ��������� ������ �μ���ȣ, �μ����� ���
--����2. �μ���ȣ �������� ����
--����3. �Ի��� �������� ����
select d.deptno, d.dname , e.empno, e.ename, e.hiredate
from emp e, dept d
where e.deptno(+) = d.deptno
and hiredate(+) > to_date('1981-06-01','YYYY-MM--DD') -- hiredate���� �ƿ��������� �ɾ null���� ��������. 
order by d.deptno asc, e.hiredate asc;

-- single low function
-- ����, ����, ��¥, ��������� ���õ� �Լ�


select '---'||trim('    aaa   abcde    ')||'----' from dual; -- �Ǿհ� �ǵ� ������ ����.


--����� ���̵� �� �ѱ��� �� �ѱ��ڸ� ������ �������� ��ó���� �ض�.
--����������ȣ���� ���� ���̴� ����.

/*concat('~','~') -- '~~'  // '~'�� '~'�� ��ħ
��ħ

substr('string',1,3)  -- str  // string���� 1��°���� 3���� ���
���ڿ����� �κ� ���

length('string') -- 6
���ڿ� ���� ���

instr('string','r')  -- 3
���ڿ����� ������ġ ���

lpad(sal,10,'*') ---- ******5000
���ڿ���ŭ ����ϰ� �������� ����ä��

trim('s'from'ssmith') ---- mith
���ڿ����� �Ϻι��ڸ� ����.*/

-- length�� �� ����ϸ� �ȴ�.
-- ������ ���ڿ��� �κ����� ������ ��������.

--ward, king�� ��쿣 �յ� �� ���ھ��ϸ� ��ǥ�ð� �ϳ��� ���⶧���� �յ� �� ���ڷ� �����߽��ϴ�.
select ename, substr(ename,1,1) || lpad('*',length(ename)-1,'*') || substr(ename,length(ename),1) from emp;

--�յ� �α��ڷ� �����Ͻǰ�쿣 �̷����Ͻø�˴ϴ�.
select ename, substr(ename,1,2) || lpad('*',length(ename)-4,'*') || substr(ename,length(ename)-1,2) from emp;

--�ٸ� ��� rpad�ȿ� substr�� ���.
--lpad�� ��쿣 substr�� rpad������ �Է�.
--�յ� �ѱ���
select ename, rpad( substr(ename,1,1) ,length(ename)-1, '*') || substr(ename,length(ename),1) from emp;
--�յ� �α���
select ename, rpad( substr(ename,1,2) ,length(ename)-2, '*') || substr(ename,length(ename)-1,2) from emp;


select to_char(123457,'999,999,999,999') from dual; -- ���������� ������ ,�� ���´�.

select to_char(123457,'000,000,000,000') from dual; -- ���ڸ��� 0���� ä��.

select to_char(123457,'$000,000,000,000') from dual; -- ���ڸ��� 0���� ä��. �޷�ǥ���߰�, ��ȭǥ�ô� ����. ���ڿ����ؼ� �ؾ���.

--�� �μ��� ��� �޿�
select d.dname, d.deptno, round(avg(e.sal),0)
from emp e, dept d
where e.deptno(+) = d.deptno
group by d.dname, d.deptno
order by avg(e.sal);



--�ִ�޿� �޴»�� �̱�

select e.ename �̸�, e.sal �޿�
from emp e
group by e.ename, e.sal
having e.sal = (select max(sal) from emp); 

-- �μ��� �ִ�޿�.

select e.deptno, max(e.sal)
from emp e
group by e.deptno;

-- �μ��� �ִ�޿�, �� 3000�̻�

select e.deptno, max(e.sal)
from emp e
group by e.deptno
having max(e.sal) >= 3000;

--9. �� �μ� �� ��� �޿��� 2000 �̻��̸� �ʰ�, �׷��� ������ �̸��� ����Ͻÿ�.
select d.dname, d.deptno, round(avg(e.sal),0), decode(substr(to_char(avg(e.sal)), to_char(avg(e.sal)),1), '2','�ʰ�','�̸�') -- �̰� �ҿ�����, ��� �޿� 201�� �ʰ������ �ֳ��ϸ� ù������ ���ڸ� ���ϱ⶧��
from emp e, dept d
where e.deptno = d.deptno
group by d.dname, d.deptno
order by d.deptno, avg(e.sal);

select d.dname, d.deptno, length(to_char(round(avg(e.sal),0))) -- length�� �̿��ؼ� ���ڸ� �̻��� ������ ù���� ���� ��� 1234 �� 1, 3245�� 3 4345�� 4�� ���ϰ� �ȴ�.
from emp e, dept d
where e.deptno = d.deptno
group by d.dname, d.deptno
order by d.deptno, avg(e.sal);


select d.dname, d.deptno, round(avg(e.sal),0), decode(    substr    (   to_char(avg(e.sal))  ,  length(to_char(round(avg(e.sal) , 0)))  -3  ,  1  ),    '2'    ,    '�ʰ�'    ,    '�̸�'    )
from emp e, dept d
where e.deptno = d.deptno
group by d.dname, d.deptno
order by d.deptno, avg(e.sal);

--�μ���ȣ�� 10�̸� 10��

select d.dname, d.deptno,
(case
  when d.deptno = 10 then '10��'
  when d.deptno = 20 then '20��' -- �Ǵ� else ' '
  when d.deptno = 30 then '30��'
  when d.deptno = 40 then '40��'
end) as �μ���ȣ
from dept d
order by d.deptno;

