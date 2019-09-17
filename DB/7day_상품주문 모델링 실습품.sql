--1.회원별 주문 상품 통계
--회원아이디 상품번호 상품갯수 구매금액
--(조건:주문건이 없더라도 회원출력)
select u.user_id, o_g.good_seq, o_g.order_amount, o_g.order_price
from users u, orders_goods o_g , orders o
where u.user_seq = o.user_seq(+)
and o.order_code = o_g.order_code(+)
order by u.user_id;


--업체별 상품, 상품이 없어도 출력
select c.com_name, g.good_name
from company c, company_goods c_g, goods g
where c.com_;



--2.업체별 공급 상품 리스트
--업체번호 업체명 상품번호 상품명
--(조건:상품이 없더라도 업체명 출력)
select c.com_seq, c.com_name, g.good_seq, g.good_name
from goods g, company c, company_goods c_g
where c.com_seq = c_g.com_seq(+)
and c_g.good_seq = g.good_seq(+)
order by c.com_seq;


/*3.회원관리
정규직/비정규직 구분하여 출력 
조건1:정규직이면A,비정규직이면B로 출력
조건2:급여(1일 8시간 한달:20일 기준으로 계산)
회원번호 회원명 정규/비정규여부 월급여
엄청 어려움, 엄청 어려움
*/





--조건 정규직이면 a, 비정규직이면 b 출력하기.
select u.user_name , (select decode(user_seq,1,'A',2,'A',3,'B') from users where u.user_name = user_name)
from users u;
--이거 아닌것같음.


select u.user_seq, u.user_name , (select decode(user_seq,1,'A',2,'A',3,'B') from users where u.user_name = user_name) as 정규_비정규
                   , (select decode(users.user_seq,1, parttime.tsal*160 ,2, parttime.tsal*160,3,fulltime.asal) from users,fulltime,parttime where u.user_name = user_name
                                                                                                                                          and (users.user_seq = fulltime.user_seq(+))
                                                                                                                                          and users.user_seq = parttime.user_seq(+)
                                                                                                                                          and u.user_name = user_name(+)) as 월급
from users u;
--뭔가 이상함.

--정규직, 비정규직 월급 출력하기
select u.user_name
from users u, fulltime ft, parttime pt
where u.user_seq = ft.user_seq(+)
and ft.user_seq = pt.user_seq(+);




/*4.상품/주문관리
주문된 상품별 판매량, 판매금액 출력
조건:판매량이 높은 순으로 정렬
상품번호 상품명 총판매량 총판매금액*/

--총 상품별 총 판매량 구하기
select sum(order_amount)
from orders_goods
group by good_seq;

select g.good_seq, g.good_name, (select sum(order_amount)
                                  from orders_goods
                                  where g.good_seq = orders_goods.good_seq
                                  group by good_seq) as 총판매량
                                ,(select sum(order_amount)*g.good_price
                                  from orders_goods
                                  where g.good_seq = orders_goods.good_seq
                                  group by good_seq) as 총판매금액
from goods g;

--o_g.good_seq = g.good_seq인 행을 o_g에서 찾아서 개수를 센다.
select count(*)
from goods g, orders_goods o_g
where g.good_seq = o_g.good_seq(+)
group by g.good_name
order by g.good_name;

/*5. 사용자별 구매 통계
회원아이디  총구매횟수   총구매금액
조건1 : 구매금액이 높은 순 출력*/
--orders테이블에서 user_seq를 세서 더한다음 총 구매횟수를 구한다.
--orders테이블에서 user_seq가 같은 tot_price를 구해서 다 더한다.

select u.user_id as 유저아이디, count(ord.user_seq)as 구매횟수, nvl(sum(ord.tot_price),0) as 총구매금액
from users u, orders ord
where u.user_seq = ord.user_seq(+)
group by u.user_id
order by 총구매금액 desc;




/*6. 휴먼회원 통계
구매실적이 전혀 없는 회원 목록 출력
회원아이디 회원명  
lee       이씨     */
select u.user_id, u.user_name
from users u
where u.user_seq not in (select user_seq from orders);




/*7. 전체 회원 목록 중 휴먼 회원이 차지하는 비율?
조건1 : 관리자 제외
조건2: 휴먼회원은 구매 실적이 전혀 없는 회원
 회원수   휴먼회원비율   */
  
select u.user_id, u.user_name
from users u
where u.user_seq not in (select user_seq from orders);




/*8. 각 회원별로 매니저-회원 관계를 출력하시오
조건1: 관리자 제외
조건2: 매니저번호 오름차순 회원번호 오름차순 정렬
매니저  회원  
lee	    kim
lee     park
park    hong
n00005	4	14000
n00011	4	40000*/

select u1.user_name,  u1.user_seq , u2.user_name as 사수, u1.mgr_seq
from users u1, users u2
where u1.mgr_seq = u2.user_seq;

/*9. 주문/상품/업체 대시보드 현황판

 총주문수량 총주문금액  총회원수  총업체수 총상품수
 58         1025000     5         7        12

       AMT      PRICE       UCNT       CCNT       GCNT
---------- ---------- ---------- ---------- ----------
        48     244000          5          7         10*/
select  (select(sum(count(o.order_code))) from orders o group by o.order_code) as AMT,
        (select sum(g.good_price*o_g.order_amount) from goods g, orders_goods o_g where g.good_seq = o_g.good_seq) as PRICE,
        (select(sum(count(c.com_name))) from company c group by c.com_name) as UCNT,
        (select(sum(count(g.good_seq))) from goods g group by g.good_seq)as GCNT
from dual;

--상품별 주문금액
select g.good_name, sum(g.good_price*o_g.order_amount)
from goods g, orders_goods o_g
where g.good_seq = o_g.good_seq
group by g.good_name
order by g.good_name;

--총 주문금액 출력하기.
select sum(g.good_price*o_g.order_amount)
from goods g, orders_goods o_g
where g.good_seq = o_g.good_seq;

/*10.월별 판매 실적....
  1월   2월   3월   4월  
 20000  12000  50000*/
 
select  (select nvl(sum(tot_price),0) from orders where substr(to_char(order_date),7,1) = '1') as M_1월,
        (select nvl(sum(tot_price),0) from orders where substr(to_char(order_date),7,1) = '2') as M_2월,
        (select nvl(sum(tot_price),0) from orders where substr(to_char(order_date),7,1) = '3') as M_3월,
        (select nvl(sum(tot_price),0) from orders where substr(to_char(order_date),7,1) = '4') as M_4월,
        (select nvl(sum(tot_price),0) from orders where substr(to_char(order_date),7,1) = '5') as M_5월,
        (select nvl(sum(tot_price),0) from orders where substr(to_char(order_date),7,1) = '6') as M_6월,
        (select nvl(sum(tot_price),0) from orders where substr(to_char(order_date),7,1) = '7') as M_7월,
        (select nvl(sum(tot_price),0) from orders where substr(to_char(order_date),7,1) = '8') as M_8월,
        (select nvl(sum(tot_price),0) from orders where substr(to_char(order_date),7,1) = '9') as M_9월,
        (select nvl(sum(tot_price),0) from orders where substr(to_char(order_date),7,2) = '10') as M_10월,
        (select nvl(sum(tot_price),0) from orders where substr(to_char(order_date),7,2) = '11') as M_11월,
        (select nvl(sum(tot_price),0) from orders where substr(to_char(order_date),7,2) = '12') as M_12월
from dual;

