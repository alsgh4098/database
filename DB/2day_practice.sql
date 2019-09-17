create table friends(
    seq number(6) primary key,
    fname varchar2(20) not null,
    age number(6) null,
    mid varchar2(10) not null,
    mpw varchar2(10) default'0000'
);

alter table friends add foreign key (seq) references TEST2(seq); -- ����Ű ����.
                                                                 -- ���̺������������ �������� �ʰ�, ������������ ��������.

insert into friends
values(1,'minho',27,'mmmm','1111');

insert into friends
values(2,'hyojune',27,'hhhh','2222');

insert into friends
values(3,'dongmin',27,'dddd','3333');

insert into friends(seq,fname,age,mid)
values(4,'gwangdong',27,'gggg'); -- mpw�� ����Ʈ�� 0000

select *from friends;

delete from friends where seq = 1; -- ���ڵ� �� �� ����

insert into friends
values(1,'jinminho',27,'jjjj','1234');  -- �ǹؿ� ���ڵ� �� �� �߰�

update friends
set fname = 'jinminho2', age = 27
where fname = 'jinminho';

update friends
set fname = 'gywns' where seq = 2;

desc friends;

select distinct fname from friends;

select to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') from dual;

select to_date(to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'),'YYYY-MM-DD HH24:MI:SS')date_of_today from dual; -- �÷��� ������ ���������� ���� ����� �� ����.

select *from friends where 1<=seq and seq<=2;

select *from friends where fname like 'g%';