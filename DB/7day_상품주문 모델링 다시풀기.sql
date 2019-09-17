--��ü�� ���� ��ǰ ����Ʈ
--��ü��ȣ ��ü�� ��ǰ��ȣ ��ǰ��
SELECT D.COM_SEQ,
  D.COM_NAME,
  F.GOOD_SEQ,
  F.GOOD_NAME
FROM COMPANY_GOODS E,
  COMPANY D,
  GOODS F
WHERE D.COM_SEQ = E.COM_SEQ(+)
AND F.GOOD_SEQ(+)  = E.GOOD_SEQ
order by D.COM_SEQ;


-- union�Լ�
select emp.*
from emp
where deptno = 10
union
select emp.*
from emp
where deptno = 20;

-- union�Լ� �÷�������Ÿ���� �ٸ����.
select ename,deptno,  sal
from emp
where deptno = 10
union
select ename,deptno, job
from emp
where deptno = 20; -- �ȵ�.

-- union�Լ� �÷� ������Ÿ���� ������, �÷����� �ٸ����.
select ename,deptno,  sal as �޿�
from emp
where deptno = 10
union
select ename,deptno, empno as �����ȣ
from emp
where deptno = 20; -- ��.

-- union�Լ� �÷� �÷����� �ٸ����2.
select ename,deptno,  1 as N1
from emp
where deptno = 10
union
select ename,deptno, empno as �����ȣ
from emp
where deptno = 20; -- ��.

--intersect �Լ�
select ename,deptno,job
from emp
intersect
select ename,deptno,job
from emp
where deptno = 20; -- deptno�� 20�� ���̺��� ename, deptno, job�� ���.

/*3.ȸ������
������/�������� �����Ͽ� ��� 
����1:�������̸�A,���������̸�B�� ���
����2:�޿�(1�� 8�ð� �Ѵ�:20�� �������� ���)
ȸ����ȣ ȸ���� ����/�����Կ��� ���޿�
��û �����, ��û �����
union�ϸ� ����.
*/

select u.user_seq, u.user_name, 'A', f.asal as �޿�
from users u, fulltime f
where u.user_seq = f.user_seq
union
select u.user_seq, u.user_name, 'B', p.tsal*160
from users u, parttime p
where u.user_seq = p.user_seq;


--4��. ��ǰ��ȣ ��ǰ�� ���Ǹŷ� ���Ǹűݾ�
select g.good_seq, g.good_name, sum(o_g.order_amount), sum(o_g.order_price)
from goods g, orders_goods o_g
where g.good_seq = o_g.good_seq
group by g.good_seq, g.good_name
order by sum(o_g.order_price);

--5��. ����ں� ���� ���
--ȸ�����̵� ����Ƚ�� ���űݾ�
select u.user_seq, count(o.user_seq), sum(o.tot_price)
from users u, orders o
where u.user_seq = o.user_seq
group by u.user_seq;


--6��. �޸�ȸ�����.
--ȸ�����̵�, ȸ����
select u.user_id, u.user_name
from users u
where u.user_seq not in (select o.user_seq
                         from orders o);
                         
--7��. �޸�ȸ�����.
--������ ����
--ȸ����, �޸�ȸ������

select (select count(*) from users where user_seq not in (select user_seq from orders)) || '/' || (select count(*) from users where user_id != 'admin') as ȸ����,
       (select count(*) from users where user_seq not in (select user_seq from orders)) / (select count(*) from users where user_id != 'admin') *100 || '%'  as �޸�ȸ������
from dual;

--9��.
--���ֹ����� ���ֹ��ݾ�  ��ȸ����  �Ѿ�ü�� �ѻ�ǰ��.
select OC as ���ֹ�����,OS as ���ֹ��ݾ�,UC as ��ȸ����,CC as �Ѿ�ü��,GC as �ѻ�ǰ��
from (select count(*)as OC from orders),
     (select sum(tot_price)as OS from orders),
     (select count(*)as UC from users),
     (select count(*)as CC from company),
     (select count(*)as GC from goods);
