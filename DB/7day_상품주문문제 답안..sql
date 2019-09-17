--1.ȸ���� �ֹ� ��ǰ ���
--ȸ�����̵� ��ǰ��ȣ ��ǰ���� ���űݾ�
--(����:�ֹ����� ������ ȸ�����)
SELECT 
  U.USER_ID,
  OG.GOOD_SEQ,
  OG.ORDER_AMOUNT,
  OG.ORDER_PRICE
FROM ORDERS O,
  USERS U,
  ORDERS_GOODS OG
WHERE U.USER_SEQ = O.USER_SEQ(+)
AND O.ORDER_CODE = OG.ORDER_CODE(+)
order by user_id, good_seq;



--2.��ü�� ���� ��ǰ ����Ʈ
--��ü��ȣ ��ü�� ��ǰ��ȣ ��ǰ��
--(����:��ǰ�� ������ ��ü�� ���)
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
SELECT 
  U.USER_SEQ,
  U.USER_NAME,
  'P' as PF,
  p.tsal * 8 * 20 as sal
FROM PARTTIME P, USERS U
WHERE U.USER_SEQ = P.USER_SEQ
    union 
SELECT
  U.USER_SEQ,
  U.USER_NAME,
  'F' as PF,
  f.asal
FROM FULLTIME F, USERS U
WHERE U.USER_SEQ = F.USER_SEQ
;


--4.��ǰ/�ֹ�����
--�ֹ��� ��ǰ�� �Ǹŷ�, �Ǹűݾ� ���
--����:�Ǹŷ��� ���� ������ ����
--��ǰ��ȣ ��ǰ�� ���Ǹŷ� ���Ǹűݾ�
SELECT 
  G.GOOD_SEQ,
  G.GOOD_NAME,
  SUM(OG.ORDER_AMOUNT) AS SUMAMT,
  SUM(OG.ORDER_PRICE) AS SUMPRICE
FROM ORDERS_GOODS OG,
  GOODS G
WHERE G.GOOD_SEQ     = OG.GOOD_SEQ
GROUP BY  G.GOOD_SEQ, G.GOOD_NAME
ORDER BY SUMAMT DESC;


--5. ����ں� ���� ���
--ȸ�����̵�  �ѱ���Ƚ��   �ѱ��űݾ�
--����1 : ���űݾ��� ���� �� ���
SELECT U.USER_SEQ, COUNT(O.USER_SEQ) AS CNT, SUM(O.TOT_PRICE) AS SUMPRICE
FROM USERS U, ORDERS O
WHERE U.USER_SEQ =  O.USER_SEQ
GROUP BY U.USER_SEQ
ORDER BY SUMPRICE DESC;


--6. �޸�ȸ�� ���
--���Ž����� ���� ���� ȸ�� ��� ���
--ȸ�����̵� ȸ����  
  
SELECT USER_ID, USER_NAME
FROM USERS
WHERE USER_SEQ NOT IN (SELECT USER_SEQ FROM ORDERS);


--7. ��ü ȸ�� ��� �� �޸� ȸ���� �����ϴ� ����?
--����1 : ������ ����
--����2: �޸�ȸ���� ���� ������ ���� ���� ȸ��
-- ȸ����   �޸�ȸ������
--------- 
--  1/4      25%       

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

SELECT U.USER_SEQ, U.USER_ID, M.USER_SEQ AS MGR_SEQ,  M.USER_ID AS MGR_ID
FROM USERS U, USERS M
WHERE U.MGR_SEQ = M.USER_SEQ;
  
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
  (select count(1) from userS) AS UCNT ,
  (select count(1) from company) AS CCNT ,
  (select count(1) from goods) AS GCNT
FROM DUAL;


--10.���� �Ǹ� ����....
--  1��   2��   3��   4��  
-- 20000  12000  50000
select
  decode ( to_char(order_date, 'MM'), '01', 1, 0 )) as m01,
  decode ( to_char(order_date, 'MM'), '02', 1, 0 )) as m02,
  decode ( to_char(order_date, 'MM'), '03', 1, 0 )) as m03,
  decode ( to_char(order_date, 'MM'), '04', 1, 0 )) as m04,
  decode ( to_char(order_date, 'MM'), '05', 1, 0 )) as m05,
  decode ( to_char(order_date, 'MM'), '06', 1, 0 )) as m06,
  decode ( to_char(order_date, 'MM'), '07', 1, 0 )) as m07,
  decode ( to_char(order_date, 'MM'), '08', 1, 0 )) as m08,
  decode ( to_char(order_date, 'MM'), '09', 1, 0 )) as m09,
  decode ( to_char(order_date, 'MM'), '10', 1, 0 )) as m10,
  decode ( to_char(order_date, 'MM'), '11', 1, 0 )) as m11,
  decode ( to_char(order_date, 'MM'), '12', 1, 0 )) as m12
from orders;