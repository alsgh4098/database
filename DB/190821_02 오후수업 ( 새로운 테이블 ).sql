-- 1. ȸ���� �ֹ���ǰ ���
-- ȸ�����̵�, ��ǰ��ȣ, ��ǰ����, ���űݾ�
-- ����. �ֹ����� ������ ȸ�����
select u.user_id, og.good_seq, og.order_amount, og.order_price
from users u, orders o , orders_goods og
where u.user_seq = o.user_seq(+)
  and o.order_code = og.order_code(+);
  
-- 2. ��ü�� ���� ��ǰ ����Ʈ
-- ��ü��ȣ, ��ü��, ��ǰ��ȣ, ��ǰ��
-- ����. ��ǰ�� ������ ��ü�� ���
select c.com_seq, c.com_name, a.good_seq,a.good_name 
from goods a, company_goods b, company c
where a.good_seq(+)=b.good_seq and b.com_seq(+)=c.com_seq 
order by com_seq asc, good_seq asc
;


--3.ȸ������
--������/�������� �����Ͽ� ��� 
--����1:�������̸�A,���������̸�B�� ���
--����2:�޿�(1�� 8�ð� �Ѵ�:20�� �������� ���)
--ȸ����ȣ ȸ���� ����/�����Կ��� ���޿�
      SELECT  -- Union Ǯ��
        J.USER_SEQ,
        J.USER_NAME,
        '������' as ����,
        K.ASAL as ���޿�
      FROM 
        FULLTIME K,
        USERS J
      WHERE 
        J.USER_SEQ = K.USER_SEQ
Union
      SELECT 
        L.USER_SEQ,
        L.USER_NAME,
        '��������' as ����,
        M.TSAL * 8 * 20 as ���޿�
      FROM 
        PARTTIME M,
        USERS L
      WHERE 
        L.USER_SEQ = M.USER_SEQ;


select 
      u.user_seq,
      u.user_name,
      decode(u.user_seq, f.user_seq, '������' , p.user_seq, '��������', '') as a,
      Case 
        when u.user_seq = f.user_seq then asal
        when u.user_seq = p.user_seq then tsal * 8 * 20
        else null 
      end as ����
from users u, fulltime f, parttime p
where 
      u.user_seq = f.user_seq(+) 
  and u.user_seq = p.user_seq(+);



--4.��ǰ/�ֹ�����
--�ֹ��� ��ǰ�� �Ǹŷ�, �Ǹűݾ� ���
--����:�Ǹŷ��� ���� ������ ����
--��ǰ��ȣ ��ǰ�� ���Ǹŷ� ���Ǹűݾ�




--5. ����ں� ���� ���
--ȸ�����̵�  �ѱ���Ƚ��   �ѱ��űݾ�
--����1 : ���űݾ��� ���� �� ���
SELECT
  N.USER_ID,
  count(O.ORDER_CODE) cnt,
  sum(O.TOT_PRICE) sum
FROM 
  ORDERS O,
  USERS N
WHERE N.USER_SEQ = O.USER_SEQ
group by n.user_id
order by sum desc;



--6. �޸�ȸ�� ���
--���Ž����� ���� ���� ȸ�� ��� ���

select user_id, user_name
from users
where user_seq not in ( select user_seq from orders) ; 

select count(1) from users where user_id != 'admin';


--7. ��ü ȸ�� ��� �� �޸� ȸ���� �����ϴ� ����?
--����1 : ������ ����
--����2: �޸�ȸ���� ���� ������ ���� ���� ȸ��
-- ȸ����   �޸�ȸ������
--  2/5      40%  
select 
  (select count(1) from users where user_seq not in (select user_seq from orders))||'/'||(select count(1) from users where user_id !='admin') as ȸ����,
  ( (select count(1) from users where user_seq not in (select user_seq from orders)) / (select count(1) from users where user_id !='admin') ) * 100||'%' ����
from dual;


SELECT HCNT||'/'||UCNT AS ȸ����, HCNT/UCNT*100||'%' AS ����
FROM 
   (SELECT COUNT(1) AS HCNT
    FROM USERS
    WHERE USER_SEQ NOT IN (SELECT USER_SEQ FROM ORDERS)) H,
   (SELECT COUNT(1) UCNT FROM USERS) U;
  
  
--8. �� ȸ������ �Ŵ���-ȸ�� ���踦 ����Ͻÿ�
--����1: ������ ����
--����2: �Ŵ�����ȣ �������� ȸ����ȣ �������� ����



--�Ŵ���  ȸ��  
--lee	kim
--lee     park
--prak    hong
	
--n00005	4	14000
--n00011	4	40000



--9. �ֹ�/��ǰ/��ü ��ú��� ��Ȳ��

-- ���ֹ����� ���ֹ��ݾ�  ��ȸ����  �Ѿ�ü�� �ѻ�ǰ��
-- 58         1025000     5         7        12

--       AMT      PRICE       UCNT       CCNT       GCNT
---------- ---------- ---------- ---------- ----------
--        48     244000          5          7         10
SELECT 
  (select count(1) from orders) AS  AMT,
  (select sum(tot_price) from orders) AS PRICE,
  (select count(1) from users) AS UCNT ,
  (select count(1) from company) AS CCNT ,
  (select count(1) from goods) AS GCNT
FROM DUAL;
        
--10.���� �Ǹ� ����....
--  1��   2��   3��   4��  
-- 20000  12000  50000  
select
  sum(decode ( to_char(order_date, 'MM'), '01', tot_price, 0 )) as m01,
  sum(decode ( to_char(order_date, 'MM'), '02', tot_price, 0 )) as m02,
  sum(decode ( to_char(order_date, 'MM'), '03', tot_price, 0 )) as m03,
  sum(decode ( to_char(order_date, 'MM'), '04', tot_price, 0 )) as m04,
  sum(decode ( to_char(order_date, 'MM'), '05', tot_price, 0 )) as m05,
  sum(decode ( to_char(order_date, 'MM'), '06', tot_price, 0 )) as m06,
  sum(decode ( to_char(order_date, 'MM'), '07', tot_price, 0 )) as m07,
  sum(decode ( to_char(order_date, 'MM'), '08', tot_price, 0 )) as m08,
  sum(decode ( to_char(order_date, 'MM'), '09', tot_price, 0 )) as m09,
  sum(decode ( to_char(order_date, 'MM'), '10', tot_price, 0 )) as m10,
  sum(decode ( to_char(order_date, 'MM'), '11', tot_price, 0 )) as m11,
  sum(decode ( to_char(order_date, 'MM'), '12', tot_price, 0 )) as m12
from orders;

�α��� Ʈ�����
ȸ�� ���̵� �н����� ��ȸ.
�αױ��(��ÿ��湮�ߴ���), 

select to_char(sysdate, 'YY-MM-DD HH24:MI:SS') from dual;
select sysdate from dual;

--�� �����  �޿��� �׷��̵带 ����϶�. ( not equl join )
select e.ename, e.sal, s.grade 
from emp e, salgrade s
where e.sal between s.losal and s.hisal ;

-- ����Ʈ ��� ������ ���۰� �� ������ ���Ͽ���.
select g.seq, g.gpoint_start, g.grade,
       ( 
        select i.gpoint_start-1
        from grade_info i
        where  i.seq = g.seq+1 
        ) as gpoint_end
from grade_info g ;

--�������� �ܿ�����Ʈ���Ͽ���.
select user_num,
      sum(decode (etc, '����', point,-point)) as �ܿ�����Ʈ      
from point_info
group by user_num;

�������� �ܿ�����Ʈ�� ���ϰ� ����� ���Ͽ���.


���� ��
--------------------------------------------------
-- from point_info, (��������)  t2 ����
--------------------------------------------------
select p.user_num
    , g.grade
      ,sum(decode (etc, '����', point,-point)) as rpoint      
from point_info p
   ,(select g.gpoint_start, g.grade,
             nvl(( 
              select i.gpoint_start-1
              from grade_info i
              where  i.seq = g.seq+1 
              ),999999999999) as gpoint_end
          from grade_info g) g     
group by p.user_num , g.grade , g.gpoint_start, g.gpoint_end    
having sum(decode (etc, '����', point,-point)) between g.gpoint_start   and   g.gpoint_end
;



--------------------------------------------------
----from (��������) t1, (��������) t2 ����
--------------------------------------------------
select up.user_num, up.rpoint, g.grade
from 
    (select g.seq, g.gpoint_start, g.grade,
               nvl(( 
                select i.gpoint_start-1
                from grade_info i
                where  i.seq = g.seq+1 
                ),999999999999) as gpoint_end
        from grade_info g) g,
     (select user_num,
            sum(decode (etc, '����', point,-point)) as rpoint      
      from point_info
      group by user_num) up
where up.rpoint between g.gpoint_start and g.gpoint_end;




