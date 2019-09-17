--1.ȸ���� �ֹ� ��ǰ ���
--ȸ�����̵� ��ǰ��ȣ ��ǰ���� ���űݾ�
--(����:�ֹ����� ������ ȸ�����)
select u.user_id, o_g.good_seq, o_g.order_amount, o_g.order_price
from users u, orders_goods o_g , orders o
where u.user_seq = o.user_seq(+)
and o.order_code = o_g.order_code(+)
order by u.user_id;


--��ü�� ��ǰ, ��ǰ�� ��� ���
select c.com_name, g.good_name
from company c, company_goods c_g, goods g
where c.com_;



--2.��ü�� ���� ��ǰ ����Ʈ
--��ü��ȣ ��ü�� ��ǰ��ȣ ��ǰ��
--(����:��ǰ�� ������ ��ü�� ���)
select c.com_seq, c.com_name, g.good_seq, g.good_name
from goods g, company c, company_goods c_g
where c.com_seq = c_g.com_seq(+)
and c_g.good_seq = g.good_seq(+)
order by c.com_seq;


/*3.ȸ������
������/�������� �����Ͽ� ��� 
����1:�������̸�A,���������̸�B�� ���
����2:�޿�(1�� 8�ð� �Ѵ�:20�� �������� ���)
ȸ����ȣ ȸ���� ����/�����Կ��� ���޿�
��û �����, ��û �����
*/





--���� �������̸� a, ���������̸� b ����ϱ�.
select u.user_name , (select decode(user_seq,1,'A',2,'A',3,'B') from users where u.user_name = user_name)
from users u;
--�̰� �ƴѰͰ���.


select u.user_seq, u.user_name , (select decode(user_seq,1,'A',2,'A',3,'B') from users where u.user_name = user_name) as ����_������
                   , (select decode(users.user_seq,1, parttime.tsal*160 ,2, parttime.tsal*160,3,fulltime.asal) from users,fulltime,parttime where u.user_name = user_name
                                                                                                                                          and (users.user_seq = fulltime.user_seq(+))
                                                                                                                                          and users.user_seq = parttime.user_seq(+)
                                                                                                                                          and u.user_name = user_name(+)) as ����
from users u;
--���� �̻���.

--������, �������� ���� ����ϱ�
select u.user_name
from users u, fulltime ft, parttime pt
where u.user_seq = ft.user_seq(+)
and ft.user_seq = pt.user_seq(+);




/*4.��ǰ/�ֹ�����
�ֹ��� ��ǰ�� �Ǹŷ�, �Ǹűݾ� ���
����:�Ǹŷ��� ���� ������ ����
��ǰ��ȣ ��ǰ�� ���Ǹŷ� ���Ǹűݾ�*/

--�� ��ǰ�� �� �Ǹŷ� ���ϱ�
select sum(order_amount)
from orders_goods
group by good_seq;

select g.good_seq, g.good_name, (select sum(order_amount)
                                  from orders_goods
                                  where g.good_seq = orders_goods.good_seq
                                  group by good_seq) as ���Ǹŷ�
                                ,(select sum(order_amount)*g.good_price
                                  from orders_goods
                                  where g.good_seq = orders_goods.good_seq
                                  group by good_seq) as ���Ǹűݾ�
from goods g;

--o_g.good_seq = g.good_seq�� ���� o_g���� ã�Ƽ� ������ ����.
select count(*)
from goods g, orders_goods o_g
where g.good_seq = o_g.good_seq(+)
group by g.good_name
order by g.good_name;

/*5. ����ں� ���� ���
ȸ�����̵�  �ѱ���Ƚ��   �ѱ��űݾ�
����1 : ���űݾ��� ���� �� ���*/
--orders���̺��� user_seq�� ���� ���Ѵ��� �� ����Ƚ���� ���Ѵ�.
--orders���̺��� user_seq�� ���� tot_price�� ���ؼ� �� ���Ѵ�.

select u.user_id as �������̵�, count(ord.user_seq)as ����Ƚ��, nvl(sum(ord.tot_price),0) as �ѱ��űݾ�
from users u, orders ord
where u.user_seq = ord.user_seq(+)
group by u.user_id
order by �ѱ��űݾ� desc;




/*6. �޸�ȸ�� ���
���Ž����� ���� ���� ȸ�� ��� ���
ȸ�����̵� ȸ����  
lee       �̾�     */
select u.user_id, u.user_name
from users u
where u.user_seq not in (select user_seq from orders);




/*7. ��ü ȸ�� ��� �� �޸� ȸ���� �����ϴ� ����?
����1 : ������ ����
����2: �޸�ȸ���� ���� ������ ���� ���� ȸ��
 ȸ����   �޸�ȸ������   */
  
select u.user_id, u.user_name
from users u
where u.user_seq not in (select user_seq from orders);




/*8. �� ȸ������ �Ŵ���-ȸ�� ���踦 ����Ͻÿ�
����1: ������ ����
����2: �Ŵ�����ȣ �������� ȸ����ȣ �������� ����
�Ŵ���  ȸ��  
lee	    kim
lee     park
park    hong
n00005	4	14000
n00011	4	40000*/

select u1.user_name,  u1.user_seq , u2.user_name as ���, u1.mgr_seq
from users u1, users u2
where u1.mgr_seq = u2.user_seq;

/*9. �ֹ�/��ǰ/��ü ��ú��� ��Ȳ��

 ���ֹ����� ���ֹ��ݾ�  ��ȸ����  �Ѿ�ü�� �ѻ�ǰ��
 58         1025000     5         7        12

       AMT      PRICE       UCNT       CCNT       GCNT
---------- ---------- ---------- ---------- ----------
        48     244000          5          7         10*/
select  (select(sum(count(o.order_code))) from orders o group by o.order_code) as AMT,
        (select sum(g.good_price*o_g.order_amount) from goods g, orders_goods o_g where g.good_seq = o_g.good_seq) as PRICE,
        (select(sum(count(c.com_name))) from company c group by c.com_name) as UCNT,
        (select(sum(count(g.good_seq))) from goods g group by g.good_seq)as GCNT
from dual;

--��ǰ�� �ֹ��ݾ�
select g.good_name, sum(g.good_price*o_g.order_amount)
from goods g, orders_goods o_g
where g.good_seq = o_g.good_seq
group by g.good_name
order by g.good_name;

--�� �ֹ��ݾ� ����ϱ�.
select sum(g.good_price*o_g.order_amount)
from goods g, orders_goods o_g
where g.good_seq = o_g.good_seq;

/*10.���� �Ǹ� ����....
  1��   2��   3��   4��  
 20000  12000  50000*/
 
select  (select nvl(sum(tot_price),0) from orders where substr(to_char(order_date),7,1) = '1') as M_1��,
        (select nvl(sum(tot_price),0) from orders where substr(to_char(order_date),7,1) = '2') as M_2��,
        (select nvl(sum(tot_price),0) from orders where substr(to_char(order_date),7,1) = '3') as M_3��,
        (select nvl(sum(tot_price),0) from orders where substr(to_char(order_date),7,1) = '4') as M_4��,
        (select nvl(sum(tot_price),0) from orders where substr(to_char(order_date),7,1) = '5') as M_5��,
        (select nvl(sum(tot_price),0) from orders where substr(to_char(order_date),7,1) = '6') as M_6��,
        (select nvl(sum(tot_price),0) from orders where substr(to_char(order_date),7,1) = '7') as M_7��,
        (select nvl(sum(tot_price),0) from orders where substr(to_char(order_date),7,1) = '8') as M_8��,
        (select nvl(sum(tot_price),0) from orders where substr(to_char(order_date),7,1) = '9') as M_9��,
        (select nvl(sum(tot_price),0) from orders where substr(to_char(order_date),7,2) = '10') as M_10��,
        (select nvl(sum(tot_price),0) from orders where substr(to_char(order_date),7,2) = '11') as M_11��,
        (select nvl(sum(tot_price),0) from orders where substr(to_char(order_date),7,2) = '12') as M_12��
from dual;

