--각 사원들의 급여와 grade를 출력해라.
--내가 푼 방법.
select distinct ename,empno, sal,grade
from emp e, salgrade s_g
where e.sal between losal and hisal
order by sal;

select ename, empno, sal, grade
from emp e, salgrade
where sal between losal and hisal;


--회원의 포인트와 포인트 등급을 출력해라.
select u.user_name, sum(p.point), g.grade
from users u, point_info p, grade_info g
where u.user_seq = p.user_seq
and p.seq = g.seq
and  between 
group by u.user_name;


--사용자별 포인트
select u.user_name, sum(p.point)
from users u, point_info p
where u.user_seq = p.user_num
group by u.user_name;

--회원의 포인트와 포인트 등급을 출력해라.

--포인트별 포인트 등급
select p.point, g.grade
from point_info p, grade_info g
where p.point between g.gpoint_start and g.gpoint_start+10000;


select u.user_name,(select sum(point)
                    from users, point_info
                    where user_seq = user_num
                    and user_seq = u.user_seq
                    group by u.user_name) as 총포인트
from users u;


select u.user_name, s_p,(select g.grade
                          from point_info p, grade_info g
                          where s_p between g.gpoint_start and g.gpoint_start+10000
                          and u.user_seq = p.user_num)
from users u, (select sum(point) s_p
                    from users, point_info
                    where user_seq = user_num
                    group by user_name);
                    
                    
--------------------------------------------------------
select u.user_name,(select sum(point)
                    from users, point_info
                    where user_seq = user_num
                    and user_seq = u.user_seq
                    group by u.user_name) as 총포인트,
                  (select g.grade
                    from point_info p, grade_info g
                    where p.point between g.gpoint_start and g.gpoint_start+10000
                    and u.user_seq = p.user_num)
from users u;

----------------------------------------------------
select u.user_name,(select sum(point)
                    from users, point_info
                    where user_seq = user_num
                    and user_seq = u.user_seq
                    group by u.user_name) as 총포인트,
                  (select g.grade
                    from point_info p, grade_info g
                    where p.point between g.gpoint_start and g.gpoint_start+10000
                    and u.user_seq = p.user_num)
from users u;


--보너스 등급표시하기.
select g.seq, g.gpoint_start, g.grade
, nvl((select i.gpoint_start-1 from grade_info i  where i.seq = g.seq + 1),9999999999)
from grade_info g;

--적립, 사용구분해서 포인트 합 계산.
select u.user_name,u.user_seq, ((select sum(p.point)
                                  from point_info p
                                  where p.etc = '적립'
                                  and user_num = u.user_seq) - nvl((select sum(p.point)
                                                                      from point_info p
                                                                      where p.etc = '사용'
                                                                      and user_num = u.user_seq),0)) as 포인트
from users u;

--위에 문제에다가 포인트등급까지 표시.
--어려움
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select 이름, 번호,nvl(포인트,0), nvl( (select grade as g_ from grade_info where (nvl(포인트,0) between gpoint_start and gpoint_start+9999) or (30000 < nvl(포인트,0)) ), 'none' ) as 포인트등급
from (select u.user_name 이름 ,u.user_seq 번호, ((select sum(p.point)
                                                from point_info p
                                                where p.etc = '적립'
                                                and user_num = u.user_seq) - nvl((select sum(p.point)
                                                                                    from point_info p
                                                                                    where p.etc = '사용'
                                                                                    and user_num = u.user_seq),0)) as 포인트
      from users u);
      
      
--포인트별 등급기준을 출력하라.
select g.seq, g.grade, g.gpoint_start as 부터, (case when g.grade = 'gold' then 999999999 else g.gpoint_start+9999 end) as 까지
from grade_info g;

--
select 이름, 번호,nvl(포인트,0), 
from (select u.user_name 이름 ,u.user_seq 번호, ((select sum(p.point)
                                                from point_info p
                                                where p.etc = '적립'
                                                and user_num = u.user_seq) - nvl((select sum(p.point)
                                                                                    from point_info p
                                                                                    where p.etc = '사용'
                                                                                    and user_num = u.user_seq),0)) as 포인트
      from users u);
      
--
select user_num, sum(decode(etc,'적립',point,'사용',-point,0)) as 잔여포인트, (case g.grade when 잔여포인트 between g.gpoint_start and g.gpoint_start+9999 else 30000 < 잔여포인트)
from users, point_info, grade_info g
where user_num = user_seq
and user_num = g.user_num;


select 이름, 번호,nvl(포인트,0), nvl( (case when(포인트 between g.gpoint_start and g.gpoint_start+9999) then g.grade (else 30000 < 포인트 )then g.grade end), 'none' ) as 포인트등급
from (select u.user_name 이름 ,u.user_seq 번호, ((select sum(p.point)
                                                from point_info p
                                                where p.etc = '적립'
                                                and user_num = u.user_seq) - nvl((select sum(p.point)
                                                                                    from point_info p
                                                                                    where p.etc = '사용'
                                                                                    and user_num = u.user_seq),0)) as 포인트
      from users u);
      
      

select 이름, 번호,nvl(포인트,0), nvl( (select grade as g from grade_info where ( (nvl(포인트,0) between gpoint_start and gpoint_start+9999) or (30000 < (nvl(포인트,0)) )), 'none' ) )as 포인트등급
from (select u.user_name 이름 ,u.user_seq 번호, ((select sum(p.point+10000000)
                                                from point_info p
                                                where p.etc = '적립'
                                                and user_num = u.user_seq) - nvl((select sum(p.point)
                                                                                    from point_info p
                                                                                    where p.etc = '사용'
                                                                                    and user_num = u.user_seq),0)) as 포인트
      from users u);
      
      
-----
select 이름, 번호,nvl(포인트,0), nvl( (select (case when 포인트 between g.gpoint_start and g.gpoint_start+9999 then g.grade else 'gold' end) from grade_info g, 'none' ) as 포인트등급
from (select u.user_name 이름 ,u.user_seq 번호, (  nvl((select sum(p.point)
                                                       from point_info p
                                                       where p.etc = '적립'
                                                       and user_num = u.user_seq),0) - nvl((select sum(p.point)
                                                                                    from point_info p
                                                                                    where p.etc = '사용'
                                                                                    and user_num = u.user_seq),0)) as 포인트
      from users u);
-----
select (case 
        when 포인트 between g.gpoint_start and g.gpoint_start+9999 then g.grade 
        else 'gold' end) as b
from grade_info g;

select d.dname, d.deptno,
(case
  when d.deptno = 10 then '10번'
  when d.deptno = 20 then '20번' -- 또는 else ' '
  when d.deptno = 30 then '30번'
  when d.deptno = 40 then '40번'
end) as 부서번호
from dept d
order by d.deptno;
      
-----
select 이름, 번호,nvl(포인트,0), nvl( (select grade as g_ from grade_info where (nvl(포인트,0) between gpoint_start and gpoint_start+9999) or (30000 < nvl(포인트,0)) ), 'none' ) as 포인트등급
from (select u.user_name 이름 ,u.user_seq 번호, (  nvl((select sum(p.point)
                                                       from point_info p
                                                       where p.etc = '적립'
                                                       and user_num = u.user_seq),0) - nvl((select sum(p.point)
                                                                                    from point_info p
                                                                                    where p.etc = '사용'
                                                                                    and user_num = u.user_seq),0)) as 포인트
      from users u);
      
select grade 
from grade_info, ( (select sum(p.point)
                          from point_info p
                          where p.etc = '적립'
                          and user_num = u.user_seq) - nvl((select sum(p.point)
                                                            from point_info p
                                                            where p.etc = '사용'
                                                            and user_num = u.user_seq),0) ) as 포인트
where (nvl(포인트,0) between gpoint_start and gpoint_start+9999) 
or (30000 < nvl(포인트,0);


--위에 문제에다가 포인트등급까지 표시.
--어려움, select sum(p.point에다가 gold등급이상을 출력해주기 위해 충분히 큰 값을 넣어주면 single-row subquery returns more than one row 에러가 발생한다.
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select 이름, 번호,nvl(포인트,0), (select grade as g_ from grade_info where (nvl(포인트,0) between gpoint_start and gpoint_start+9999) or (30000 < nvl(포인트,0)) ) as 포인트등급
from (select u.user_name 이름 ,u.user_seq 번호, (  nvl((select sum(p.point+14000)
                                                       from point_info p
                                                       where p.etc = '적립'
                                                       and user_num = u.user_seq),0) - nvl((select sum(p.point)
                                                                                    from point_info p
                                                                                    where p.etc = '사용'
                                                                                    and user_num = u.user_seq),0)) as 포인트
      from users u);
---------------------------------------------------------------------------------------------------

select 이름, 번호,nvl(포인트,0), g_i.grade
from (select u.user_name 이름 ,u.user_seq 번호, (  nvl((select sum(p.point+5000)
                                                       from point_info p
                                                       where p.etc = '적립'
                                                       and user_num = u.user_seq),0) - nvl((select sum(p.point)
                                                                                    from point_info p
                                                                                    where p.etc = '사용'
                                                                                    and user_num = u.user_seq),0)) as 포인트
      from users u), grade_info g_i
where g_i.seq = 번호;


select 이름, 번호,nvl(포인트,0), nvl( (select grade as g_ from grade_info where (nvl(포인트,0) between gpoint_start and gpoint_start+9999) or (30000 < nvl(포인트,0)) ), 'none' ) as 포인트등급
from (select u.user_name 이름 ,u.user_seq 번호, (  nvl((select sum(p.point)
                                                       from point_info p
                                                       where p.etc = '적립'
                                                       and user_num = u.user_seq),0) - nvl((select sum(p.point)
                                                                                    from point_info p
                                                                                    where p.etc = '사용'
                                                                                    and user_num = u.user_seq),0)) as 포인트
      from users u);
----------------------------------------------
      
      

select 이름, 번호, nvl(포인트,0), nvl( (select grade from grade_info where ( nvl(포인트,0) between gpoint_start and gpoint_start + decode(seq,4,9999999,9999) )), 'none' ) as 포인트등급
from ( select u.user_name 이름 ,u.user_seq 번호, (  nvl( (select sum(p.point)+40000
                                                       from point_info p
                                                       where p.etc = '적립'
                                                       and user_num = u.user_seq),0) - nvl((select sum(p.point)
                                                                                    from point_info p
                                                                                    where p.etc = '사용'
                                                                                    and user_num = u.user_seq),0)) as 포인트
     from users u);
     
