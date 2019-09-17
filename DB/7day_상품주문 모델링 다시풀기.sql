--업체별 공급 상품 리스트
--업체번호 업체명 상품번호 상품명
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


-- union함수
select emp.*
from emp
where deptno = 10
union
select emp.*
from emp
where deptno = 20;

-- union함수 컬럼데이터타입이 다를경우.
select ename,deptno,  sal
from emp
where deptno = 10
union
select ename,deptno, job
from emp
where deptno = 20; -- 안됨.

-- union함수 컬럼 데이터타입은 같지만, 컬럼값이 다를경우.
select ename,deptno,  sal as 급여
from emp
where deptno = 10
union
select ename,deptno, empno as 사원번호
from emp
where deptno = 20; -- 됨.

-- union함수 컬럼 컬럼값이 다를경우2.
select ename,deptno,  1 as N1
from emp
where deptno = 10
union
select ename,deptno, empno as 사원번호
from emp
where deptno = 20; -- 됨.

--intersect 함수
select ename,deptno,job
from emp
intersect
select ename,deptno,job
from emp
where deptno = 20; -- deptno가 20인 테이블의 ename, deptno, job을 출력.

/*3.회원관리
정규직/비정규직 구분하여 출력 
조건1:정규직이면A,비정규직이면B로 출력
조건2:급여(1일 8시간 한달:20일 기준으로 계산)
회원번호 회원명 정규/비정규여부 월급여
엄청 어려움, 엄청 어려움
union하면 쉬움.
*/

select u.user_seq, u.user_name, 'A', f.asal as 급여
from users u, fulltime f
where u.user_seq = f.user_seq
union
select u.user_seq, u.user_name, 'B', p.tsal*160
from users u, parttime p
where u.user_seq = p.user_seq;


--4번. 상품번호 상품명 총판매량 총판매금액
select g.good_seq, g.good_name, sum(o_g.order_amount), sum(o_g.order_price)
from goods g, orders_goods o_g
where g.good_seq = o_g.good_seq
group by g.good_seq, g.good_name
order by sum(o_g.order_price);

--5번. 사용자별 구매 통계
--회원아이디 구매횟수 구매금액
select u.user_seq, count(o.user_seq), sum(o.tot_price)
from users u, orders o
where u.user_seq = o.user_seq
group by u.user_seq;


--6번. 휴먼회원통계.
--회원아이디, 회원명
select u.user_id, u.user_name
from users u
where u.user_seq not in (select o.user_seq
                         from orders o);
                         
--7번. 휴먼회원통계.
--관리자 제외
--회원수, 휴먼회원비율

select (select count(*) from users where user_seq not in (select user_seq from orders)) || '/' || (select count(*) from users where user_id != 'admin') as 회원수,
       (select count(*) from users where user_seq not in (select user_seq from orders)) / (select count(*) from users where user_id != 'admin') *100 || '%'  as 휴먼회원비율
from dual;

--9번.
--총주문수량 총주문금액  총회원수  총업체수 총상품수.
select OC as 총주문수량,OS as 총주문금액,UC as 총회원수,CC as 총업체수,GC as 총상품수
from (select count(*)as OC from orders),
     (select sum(tot_price)as OS from orders),
     (select count(*)as UC from users),
     (select count(*)as CC from company),
     (select count(*)as GC from goods);
