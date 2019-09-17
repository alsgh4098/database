-- 1. 회원별 주문상품 통계
-- 회원아이디, 상품번호, 상품갯수, 구매금액
-- 조건. 주문건이 없더라도 회원출력
select u.user_id, og.good_seq, og.order_amount, og.order_price
from users u, orders o , orders_goods og
where u.user_seq = o.user_seq(+)
  and o.order_code = og.order_code(+);
  
-- 2. 업체별 공급 상품 리스트
-- 업체번호, 업체명, 상품번호, 상품명
-- 조건. 상품이 없더라도 업체명 출력
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
      SELECT  -- Union 풀이
        J.USER_SEQ,
        J.USER_NAME,
        '정규직' as 구분,
        K.ASAL as 월급여
      FROM 
        FULLTIME K,
        USERS J
      WHERE 
        J.USER_SEQ = K.USER_SEQ
Union
      SELECT 
        L.USER_SEQ,
        L.USER_NAME,
        '비정규직' as 구분,
        M.TSAL * 8 * 20 as 월급여
      FROM 
        PARTTIME M,
        USERS L
      WHERE 
        L.USER_SEQ = M.USER_SEQ;


select 
      u.user_seq,
      u.user_name,
      decode(u.user_seq, f.user_seq, '정규직' , p.user_seq, '비정규직', '') as a,
      Case 
        when u.user_seq = f.user_seq then asal
        when u.user_seq = p.user_seq then tsal * 8 * 20
        else null 
      end as 구분
from users u, fulltime f, parttime p
where 
      u.user_seq = f.user_seq(+) 
  and u.user_seq = p.user_seq(+);



--4.상품/주문관리
--주문된 상품별 판매량, 판매금액 출력
--조건:판매량이 높은 순으로 정렬
--상품번호 상품명 총판매량 총판매금액




--5. 사용자별 구매 통계
--회원아이디  총구매횟수   총구매금액
--조건1 : 구매금액이 높은 순 출력
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



--6. 휴먼회원 통계
--구매실적이 전혀 없는 회원 목록 출력

select user_id, user_name
from users
where user_seq not in ( select user_seq from orders) ; 

select count(1) from users where user_id != 'admin';


--7. 전체 회원 목록 중 휴먼 회원이 차지하는 비율?
--조건1 : 관리자 제외
--조건2: 휴먼회원은 구매 실적이 전혀 없는 회원
-- 회원수   휴먼회원비율
--  2/5      40%  
select 
  (select count(1) from users where user_seq not in (select user_seq from orders))||'/'||(select count(1) from users where user_id !='admin') as 회원수,
  ( (select count(1) from users where user_seq not in (select user_seq from orders)) / (select count(1) from users where user_id !='admin') ) * 100||'%' 비율
from dual;


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
  (select count(1) from users) AS UCNT ,
  (select count(1) from company) AS CCNT ,
  (select count(1) from goods) AS GCNT
FROM DUAL;
        
--10.월별 판매 실적....
--  1월   2월   3월   4월  
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

로그인 트랙잭션
회원 아이디 패스워드 조회.
로그기록(몇시에방문했는지), 

select to_char(sysdate, 'YY-MM-DD HH24:MI:SS') from dual;
select sysdate from dual;

--각 사원의  급여와 그레이드를 출력하라. ( not equl join )
select e.ename, e.sal, s.grade 
from emp e, salgrade s
where e.sal between s.losal and s.hisal ;

-- 포인트 등급 구간의 시작과 끝 구간을 구하여라.
select g.seq, g.gpoint_start, g.grade,
       ( 
        select i.gpoint_start-1
        from grade_info i
        where  i.seq = g.seq+1 
        ) as gpoint_end
from grade_info g ;

--유저별로 잔여포인트구하여라.
select user_num,
      sum(decode (etc, '적립', point,-point)) as 잔여포인트      
from point_info
group by user_num;

유저별로 잔여포인트를 구하고 등급을 구하여라.


보정 후
--------------------------------------------------
-- from point_info, (서브쿼리)  t2 형태
--------------------------------------------------
select p.user_num
    , g.grade
      ,sum(decode (etc, '적립', point,-point)) as rpoint      
from point_info p
   ,(select g.gpoint_start, g.grade,
             nvl(( 
              select i.gpoint_start-1
              from grade_info i
              where  i.seq = g.seq+1 
              ),999999999999) as gpoint_end
          from grade_info g) g     
group by p.user_num , g.grade , g.gpoint_start, g.gpoint_end    
having sum(decode (etc, '적립', point,-point)) between g.gpoint_start   and   g.gpoint_end
;



--------------------------------------------------
----from (서브쿼리) t1, (서브쿼리) t2 형태
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
            sum(decode (etc, '적립', point,-point)) as rpoint      
      from point_info
      group by user_num) up
where up.rpoint between g.gpoint_start and g.gpoint_end;




