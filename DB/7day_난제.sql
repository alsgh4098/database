--�� ������� �޿��� grade�� ����ض�.
--���� Ǭ ���.
select distinct ename,empno, sal,grade
from emp e, salgrade s_g
where e.sal between losal and hisal
order by sal;

select ename, empno, sal, grade
from emp e, salgrade
where sal between losal and hisal;


--ȸ���� ����Ʈ�� ����Ʈ ����� ����ض�.
select u.user_name, sum(p.point), g.grade
from users u, point_info p, grade_info g
where u.user_seq = p.user_seq
and p.seq = g.seq
and  between 
group by u.user_name;


--����ں� ����Ʈ
select u.user_name, sum(p.point)
from users u, point_info p
where u.user_seq = p.user_num
group by u.user_name;

--ȸ���� ����Ʈ�� ����Ʈ ����� ����ض�.

--����Ʈ�� ����Ʈ ���
select p.point, g.grade
from point_info p, grade_info g
where p.point between g.gpoint_start and g.gpoint_start+10000;


select u.user_name,(select sum(point)
                    from users, point_info
                    where user_seq = user_num
                    and user_seq = u.user_seq
                    group by u.user_name) as ������Ʈ
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
                    group by u.user_name) as ������Ʈ,
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
                    group by u.user_name) as ������Ʈ,
                  (select g.grade
                    from point_info p, grade_info g
                    where p.point between g.gpoint_start and g.gpoint_start+10000
                    and u.user_seq = p.user_num)
from users u;


--���ʽ� ���ǥ���ϱ�.
select g.seq, g.gpoint_start, g.grade
, nvl((select i.gpoint_start-1 from grade_info i  where i.seq = g.seq + 1),9999999999)
from grade_info g;

--����, ��뱸���ؼ� ����Ʈ �� ���.
select u.user_name,u.user_seq, ((select sum(p.point)
                                  from point_info p
                                  where p.etc = '����'
                                  and user_num = u.user_seq) - nvl((select sum(p.point)
                                                                      from point_info p
                                                                      where p.etc = '���'
                                                                      and user_num = u.user_seq),0)) as ����Ʈ
from users u;

--���� �������ٰ� ����Ʈ��ޱ��� ǥ��.
--�����
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select �̸�, ��ȣ,nvl(����Ʈ,0), nvl( (select grade as g_ from grade_info where (nvl(����Ʈ,0) between gpoint_start and gpoint_start+9999) or (30000 < nvl(����Ʈ,0)) ), 'none' ) as ����Ʈ���
from (select u.user_name �̸� ,u.user_seq ��ȣ, ((select sum(p.point)
                                                from point_info p
                                                where p.etc = '����'
                                                and user_num = u.user_seq) - nvl((select sum(p.point)
                                                                                    from point_info p
                                                                                    where p.etc = '���'
                                                                                    and user_num = u.user_seq),0)) as ����Ʈ
      from users u);
      
      
--����Ʈ�� ��ޱ����� ����϶�.
select g.seq, g.grade, g.gpoint_start as ����, (case when g.grade = 'gold' then 999999999 else g.gpoint_start+9999 end) as ����
from grade_info g;

--
select �̸�, ��ȣ,nvl(����Ʈ,0), 
from (select u.user_name �̸� ,u.user_seq ��ȣ, ((select sum(p.point)
                                                from point_info p
                                                where p.etc = '����'
                                                and user_num = u.user_seq) - nvl((select sum(p.point)
                                                                                    from point_info p
                                                                                    where p.etc = '���'
                                                                                    and user_num = u.user_seq),0)) as ����Ʈ
      from users u);
      
--
select user_num, sum(decode(etc,'����',point,'���',-point,0)) as �ܿ�����Ʈ, (case g.grade when �ܿ�����Ʈ between g.gpoint_start and g.gpoint_start+9999 else 30000 < �ܿ�����Ʈ)
from users, point_info, grade_info g
where user_num = user_seq
and user_num = g.user_num;


select �̸�, ��ȣ,nvl(����Ʈ,0), nvl( (case when(����Ʈ between g.gpoint_start and g.gpoint_start+9999) then g.grade (else 30000 < ����Ʈ )then g.grade end), 'none' ) as ����Ʈ���
from (select u.user_name �̸� ,u.user_seq ��ȣ, ((select sum(p.point)
                                                from point_info p
                                                where p.etc = '����'
                                                and user_num = u.user_seq) - nvl((select sum(p.point)
                                                                                    from point_info p
                                                                                    where p.etc = '���'
                                                                                    and user_num = u.user_seq),0)) as ����Ʈ
      from users u);
      
      

select �̸�, ��ȣ,nvl(����Ʈ,0), nvl( (select grade as g from grade_info where ( (nvl(����Ʈ,0) between gpoint_start and gpoint_start+9999) or (30000 < (nvl(����Ʈ,0)) )), 'none' ) )as ����Ʈ���
from (select u.user_name �̸� ,u.user_seq ��ȣ, ((select sum(p.point+10000000)
                                                from point_info p
                                                where p.etc = '����'
                                                and user_num = u.user_seq) - nvl((select sum(p.point)
                                                                                    from point_info p
                                                                                    where p.etc = '���'
                                                                                    and user_num = u.user_seq),0)) as ����Ʈ
      from users u);
      
      
-----
select �̸�, ��ȣ,nvl(����Ʈ,0), nvl( (select (case when ����Ʈ between g.gpoint_start and g.gpoint_start+9999 then g.grade else 'gold' end) from grade_info g, 'none' ) as ����Ʈ���
from (select u.user_name �̸� ,u.user_seq ��ȣ, (  nvl((select sum(p.point)
                                                       from point_info p
                                                       where p.etc = '����'
                                                       and user_num = u.user_seq),0) - nvl((select sum(p.point)
                                                                                    from point_info p
                                                                                    where p.etc = '���'
                                                                                    and user_num = u.user_seq),0)) as ����Ʈ
      from users u);
-----
select (case 
        when ����Ʈ between g.gpoint_start and g.gpoint_start+9999 then g.grade 
        else 'gold' end) as b
from grade_info g;

select d.dname, d.deptno,
(case
  when d.deptno = 10 then '10��'
  when d.deptno = 20 then '20��' -- �Ǵ� else ' '
  when d.deptno = 30 then '30��'
  when d.deptno = 40 then '40��'
end) as �μ���ȣ
from dept d
order by d.deptno;
      
-----
select �̸�, ��ȣ,nvl(����Ʈ,0), nvl( (select grade as g_ from grade_info where (nvl(����Ʈ,0) between gpoint_start and gpoint_start+9999) or (30000 < nvl(����Ʈ,0)) ), 'none' ) as ����Ʈ���
from (select u.user_name �̸� ,u.user_seq ��ȣ, (  nvl((select sum(p.point)
                                                       from point_info p
                                                       where p.etc = '����'
                                                       and user_num = u.user_seq),0) - nvl((select sum(p.point)
                                                                                    from point_info p
                                                                                    where p.etc = '���'
                                                                                    and user_num = u.user_seq),0)) as ����Ʈ
      from users u);
      
select grade 
from grade_info, ( (select sum(p.point)
                          from point_info p
                          where p.etc = '����'
                          and user_num = u.user_seq) - nvl((select sum(p.point)
                                                            from point_info p
                                                            where p.etc = '���'
                                                            and user_num = u.user_seq),0) ) as ����Ʈ
where (nvl(����Ʈ,0) between gpoint_start and gpoint_start+9999) 
or (30000 < nvl(����Ʈ,0);


--���� �������ٰ� ����Ʈ��ޱ��� ǥ��.
--�����, select sum(p.point���ٰ� gold����̻��� ������ֱ� ���� ����� ū ���� �־��ָ� single-row subquery returns more than one row ������ �߻��Ѵ�.
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select �̸�, ��ȣ,nvl(����Ʈ,0), (select grade as g_ from grade_info where (nvl(����Ʈ,0) between gpoint_start and gpoint_start+9999) or (30000 < nvl(����Ʈ,0)) ) as ����Ʈ���
from (select u.user_name �̸� ,u.user_seq ��ȣ, (  nvl((select sum(p.point+14000)
                                                       from point_info p
                                                       where p.etc = '����'
                                                       and user_num = u.user_seq),0) - nvl((select sum(p.point)
                                                                                    from point_info p
                                                                                    where p.etc = '���'
                                                                                    and user_num = u.user_seq),0)) as ����Ʈ
      from users u);
---------------------------------------------------------------------------------------------------

select �̸�, ��ȣ,nvl(����Ʈ,0), g_i.grade
from (select u.user_name �̸� ,u.user_seq ��ȣ, (  nvl((select sum(p.point+5000)
                                                       from point_info p
                                                       where p.etc = '����'
                                                       and user_num = u.user_seq),0) - nvl((select sum(p.point)
                                                                                    from point_info p
                                                                                    where p.etc = '���'
                                                                                    and user_num = u.user_seq),0)) as ����Ʈ
      from users u), grade_info g_i
where g_i.seq = ��ȣ;


select �̸�, ��ȣ,nvl(����Ʈ,0), nvl( (select grade as g_ from grade_info where (nvl(����Ʈ,0) between gpoint_start and gpoint_start+9999) or (30000 < nvl(����Ʈ,0)) ), 'none' ) as ����Ʈ���
from (select u.user_name �̸� ,u.user_seq ��ȣ, (  nvl((select sum(p.point)
                                                       from point_info p
                                                       where p.etc = '����'
                                                       and user_num = u.user_seq),0) - nvl((select sum(p.point)
                                                                                    from point_info p
                                                                                    where p.etc = '���'
                                                                                    and user_num = u.user_seq),0)) as ����Ʈ
      from users u);
----------------------------------------------
      
      

select �̸�, ��ȣ, nvl(����Ʈ,0), nvl( (select grade from grade_info where ( nvl(����Ʈ,0) between gpoint_start and gpoint_start + decode(seq,4,9999999,9999) )), 'none' ) as ����Ʈ���
from ( select u.user_name �̸� ,u.user_seq ��ȣ, (  nvl( (select sum(p.point)+40000
                                                       from point_info p
                                                       where p.etc = '����'
                                                       and user_num = u.user_seq),0) - nvl((select sum(p.point)
                                                                                    from point_info p
                                                                                    where p.etc = '���'
                                                                                    and user_num = u.user_seq),0)) as ����Ʈ
     from users u);
     
