------------------------------------------test1
create table test(
seq number(6) primary key,
mid varchar2(20) not null,
mpw varchar2(20) default '0000',
name varchar2(10) not null,
regdate date default sysdate
);

insert into test
values (1,'jin','111','Áø¾¾',sysdate);

insert into test(seq,mid,name)
values(2,'kim','±è¾¾');

insert into test
values (3,'lee','222','ÀÌ¾¾','1993-11-03');

update test
set mid ='woo', mpw ='333'
where seq = 2;

delete
from test
where seq = 2;

select *from test;


-----------------------------------test2

create table test2(
  seq number(10) primary key,
  mid varchar2(20) not null,
  mpw varchar2(20) default'0000',
  name varchar2(20)
);

select *from test2;

insert into test2(seq,mid,mpw)
values(1, 'alsgh','1234');

insert into test2(seq,mid,mpw)
values(2, 'engh','3456');

insert into test2(seq,mid,mpw)
values(3, 'rudtnr','6789');

insert into test2
values(4, 'gywns', '12345', 'hyojune');

update test2
set mid = 2, mpw = '456', name = 'kyung suk'
where seq = 2;

delete from test2
where seq = 3;

-------------------------------------------------test3

create table test3(
  seq number(10) primary key,
  mid varchar2(20) not null,
  mpw varchar2(20) default'0000',
  name varchar2(20)
);

select *from test3;
