--1.회원별 주문 상품 통계
--회원아이디 상품번호 상품갯수 구매금액
--(조건:주문건이 없더라도 회원출력)
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



--2.업체별 공급 상품 리스트
--업체번호 업체명 상품번호 상품명
--(조건:상품이 없더라도 업체명 출력)
select c.com_seq, c.com_name, a.good_seq,a.good_name 
from goods a, company_goods b, company c
where a.good_seq(+)=b.good_seq and b.com_seq(+)=c.com_seq 
order by com_seq asc, good_seq asc
;



--3.회원관리
--정규직/비정규직 구분하여 출력 
--조건1:정규직이면A,비정규직이면B로 출력
--조건2:급여(1일 8시간 한달:20일 기준으로 계산)
--회원번호 회원명 정규/비정규여부 월급여
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


--4.상품/주문관리
--주문된 상품별 판매량, 판매금액 출력
--조건:판매량이 높은 순으로 정렬
--상품번호 상품명 총판매량 총판매금액
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


--5. 사용자별 구매 통계
--회원아이디  총구매횟수   총구매금액
--조건1 : 구매금액이 높은 순 출력
SELECT U.USER_SEQ, COUNT(O.USER_SEQ) AS CNT, SUM(O.TOT_PRICE) AS SUMPRICE
FROM USERS U, ORDERS O
WHERE U.USER_SEQ =  O.USER_SEQ
GROUP BY U.USER_SEQ
ORDER BY SUMPRICE DESC;


--6. 휴먼회원 통계
--구매실적이 전혀 없는 회원 목록 출력
--회원아이디 회원명  
  
SELECT USER_ID, USER_NAME
FROM USERS
WHERE USER_SEQ NOT IN (SELECT USER_SEQ FROM ORDERS);


--7. 전체 회원 목록 중 휴먼 회원이 차지하는 비율?
--조건1 : 관리자 제외
--조건2: 휴먼회원은 구매 실적이 전혀 없는 회원
-- 회원수   휴먼회원비율
--------- 
--  1/4      25%       

SELECT HCNT||'/'||UCNT AS 회원수, HCNT/UCNT*100||'%' AS 비율
FROM 
   (SELECT COUNT(1) AS HCNT
    FROM USERS
    WHERE USER_SEQ NOT IN (SELECT USER_SEQ FROM ORDERS)) H,
   (SELECT COUNT(1) UCNT FROM USERS) U;


--8. 각 회원별로 매니저-회원 관계를 출력하시오
--조건1: 관리자 제외
--조건2: 매니저번호 오름차순 회원번호 오름차순 정렬

--매니저  회원  
--lee	kim
--lee     park
--prak    hong

SELECT U.USER_SEQ, U.USER_ID, M.USER_SEQ AS MGR_SEQ,  M.USER_ID AS MGR_ID
FROM USERS U, USERS M
WHERE U.MGR_SEQ = M.USER_SEQ;
  
--n00005	4	14000
--n00011	4	40000


--9. 주문/상품/업체 대시보드 현황판

-- 총주문수량 총주문금액  총회원수  총업체수 총상품수
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


--10.월별 판매 실적....
--  1월   2월   3월   4월  
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