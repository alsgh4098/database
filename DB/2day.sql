
------------------------------------------------------------------------------------------------------------------------------- ���̺� ���� ����.
--DROP TABLE DEPT;
CREATE TABLE DEPT  --�μ� ����
  (
  DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY(DEPTNO), -- �μ���ȣ DEPTNO�� PK_DEPT��� ������� �����ְ� TABLE DEPT�� PRIMARY KEY�� �����Ѵ�.
	DNAME VARCHAR2(14),
	LOC VARCHAR2(13) 
  );
--DROP TABLE EMP;
CREATE TABLE EMP  -- EMP�� EMPLOYEE ��, �������
  (
  EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,  -- EMPNO�� PK_EMP��� ������� �����ְ� TABLE EMP�� PRIMARY KEY�� �����Ѵ�.
                                                  -- �� ���忡 PRIMARY KEY�� �������� �ʰ� ���� �������ټ� �ִ�.
                                                  -- EMPNO NUMBER(4),
                                                  -- CONSTRAINT PK_EMP(CONSTRAINT ��������) PRIMARY KEY(EMPNO),
                                                  -- �̷�������, ���������� ����Ű�� ����.
	ENAME VARCHAR2(10), -- EMPLOYEE NAME
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIREDATE DATE, -- DATE ��¥����
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT -- DEPTNO�� FK_DEPTNO�� ������� �����ְ� DEPT TABLE�� DENPTNO FK�� �����Ѵ�.
                                                        -- �ٿ��� ���� ���� FK���� ����.
                                                        -- DEPTNO NUMBER(2),
                                                        -- CONSTRAINT FK_DEPTO(��������) FOREIGN KEY(DEPTNO) REFERENCES DEPT(DEPTNO)
  ); 
  
INSERT INTO DEPT VALUES
	(10,'ACCOUNTING','NEW YORK');

INSERT INTO DEPT VALUES 
  (20,'RESEARCH','DALLAS');
  
INSERT INTO DEPT VALUES
	(30,'SALES','CHICAGO');
  
INSERT INTO DEPT VALUES
	(40,'OPERATIONS','BOSTON');
  
INSERT INTO EMP VALUES
  (7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
  
INSERT INTO EMP VALUES
  (7499,'ALLEN','SALESMAN',7698,to_date('20-2-1981','dd-mm-yyyy'),1600,300,30);
  
INSERT INTO EMP VALUES
  (7521,'WARD','SALESMAN',7698,to_date('22-2-1981','dd-mm-yyyy'),1250,500,30);
  
INSERT INTO EMP VALUES
  (7566,'JONES','MANAGER',7839,to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20);
  
INSERT INTO EMP VALUES
  (7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30);
  
INSERT INTO EMP VALUES
  (7698,'BLAKE','MANAGER',7839,to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30);
  
INSERT INTO EMP VALUES
  (7782,'CLARK','MANAGER',7839,to_date('9-6-1981','dd-mm-yyyy'),2450,NULL,10);
  
INSERT INTO EMP VALUES
  (7788,'SCOTT','ANALYST',7566,to_date('13-7-1987','dd-mm-yyyy'),3000,NULL,20);
  
INSERT INTO EMP VALUES
  (7839,'KING','PRESIDENT',NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
  
INSERT INTO EMP VALUES
  (7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30);
  
INSERT INTO EMP VALUES
  (7876,'ADAMS','CLERK',7788,to_date('13-7-1987','dd-mm-yyyy'),1100,NULL,20);
  
INSERT INTO EMP VALUES
  (7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30);
  
INSERT INTO EMP VALUES
  (7902,'FORD','ANALYST',7566,to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20);
  
INSERT INTO EMP VALUES
  (7934,'MILLER','CLERK',7782,to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10);
--DROP TABLE BONUS;

CREATE TABLE BONUS -- ���ʽ� ����
	(
	EMPNO NUMBER(4)	CONSTRAINT FK_EMPNO REFERENCES EMP, -- EMPNO�� BONUS TABLE�� PK���� EMP TABLE�� FK
	bonus NUMBER
	);
--DROP TABLE SALGRADE;

CREATE TABLE SALGRADE -- �޷� ����
  ( 
  GRADE NUMBER,
	LOSAL NUMBER,
	HISAL NUMBER 
  );
  
INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);
COMMIT;
------------------------------------------------------------------------------------------------------------------------------- ���̺� ���� ��.


select sysdate from emp; -- EMP���̺��� �׳� ������ ���Ŵ�. SYSDATE��� �÷����� EMP�� ���ڵ� ����ŭ �Լ� SYSDATE�� ��µ�.
select to_date('1993-11-03 11:33:00','yyyy-mm-dd/hh24:mi:ss') from dual; -- �ú��ʴ� ����� �ȵ�.
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss')sys_date from dual; -- to_char�� ���ڷ� �ٲ��ִ� �Լ� //sys_date��� Į���� ��������, as�� �����Ȱ�.
select sysdate from dual; -- ���� ���̺� dual ��¥���̺�

select *from emp;
select ENAME,JOB,SAL,DEPTNO from emp;

select *from emp 
where job = 'CLERK'; --���� ����ǥ, ��ҹ��� ǥ�� ����.

select *from emp
where job = 'MANAGER' or job = 'CLERK';  -- job = '~~' or job = '~~'

select *from emp
where sal > 1000;

select *from emp where job in('CLERK','MANAGER'); -- where ~~ in(,,,) ~~�� in(,,,)�� ������ ���.

select *from emp where job = 'CLERK' and sal >= 1000;

select *from emp where job = 'MANAGER' and sal >= 2000;

select sysdate, sysdate + 3 from dual;
select sysdate - HIREDATE from EMP; -- �ټ��ϼ� ���ϴ� ��ɾ�/ �ϼ��� ����� ����.
select ENAME,JOB,ROUND((sysdate - HIREDATE)/365) from EMP; -- �ټӿ��� ���ϴ� ��ɾ�/ �ϼ��� ����� ����.
select ((sysdate - HIREDATE)/365),((sysdate - HIREDATE)%365),((sysdate - HIREDATE)/365) from emp; -- ���� ���� �ϼ��� �����ַ��� ��� �ؾߵǳ�.
select ROUND(12.567, 1) from dual; -- �Ҽ��� ���ڸ����� ����� �����޶�. ��, ��°�ڸ����� �ݿø�. ��� 12.6
select ROUND(12.547, 1) from dual; -- �Ҽ��� ���ڸ����� ����� �����޶�. ��, ��°�ڸ����� �ݿø�. ��� 12.5

select ENAME,JOB from EMP
where COMM is NULL ; -- NULL�Ǻ� IS NULL�Լ� // IS NOT NULL�Լ�

select NVL(COMM,3000)as v1, COMM from EMP;  -- �Լ��� ����� �̿��ؼ� ���ο� �÷��� ����ϴ°�� as�Լ��� �̿��ؼ� �÷��̸��� �����.

select ENAME, SAL+100 as sal_plus_100 from EMP; -- SAL+100�� ���ο� �÷��� �µ����.

select ENAME, NVL(SAL,0)+NVL(COMM,0) as sal_plus_COMM from EMP; -- SAL + COMM�� ���ο� �÷��� ������ֱ����ؼ� COMM�� �ΰ��� 0���� �ٲ����. *****�߿�*****
                                                         -- as�Լ��� ���ο� �÷��̸��� ������� ���� +���� �����ȣ�� ����� �� ����. 
                                                         -- NVL( , )�Լ��� �̿��ϸ� ������� ������ �÷����� ���� ���� ũ���� �÷��� ������ �� �ִ�.
                                                         -- �Ϲ������� �������� ���� ���� ���� ������ NULL���� ������ Ȯ���� ����� ����.
                                                         -- ���� ��� ���꿡�־ NVL()�Լ��� ������ִ°��� �����ϴ�.
                                                         -- as�Լ��� ���������ѵ�, �����ϰ� �ٷ� ���ο� �÷��̸��� ���൵ ��.
                                                         
select ENAME, NVL(SAL+COMM,SAL) as sal_plus_comm from EMP; -- �� ������ �̿��ؼ��� ���Ͱ��� ���� ���� �� ������, �� ����� �޸� SAL���� NULL���� Ȯ���� ����� ����.

select emp.*, ENAME||'JJJJ'ENAME_PLUS_JJJJ from EMP; -- EMP�� �ִ� ���ڵ带 ��� ����ϰ� �ű⿡ ���ؼ� �߰��� ENAME �� ����ڵ��� �̸��� JJJJ�� ���� �÷��� �߰�.

select concat(concat(ENAME,'�� ����:'),JOB) ���� from EMP; -- concat���� concat, concat�� ��ǲ�� �ƿ�ǲ�� ���ڿ�.

select ENAME from EMP where ENAME like '%A%'; -- ���� 'A'�� ���ڰ� ���Ե� ENAME

--���̺� ���� ����.
desc EMP;

--�ߺ������� �÷��� ���.
select distinct job from emp;

-- ! ������
-- != �Ǵ� <>
select ENAME,JOB from EMP where job != 'CLERK'; -- ������ �ƴ� �ǰ������ ����

select ENAME,JOB from EMP where job <> 'CLERK'; -- ������ �ƴ� �ǰ������ ����

select ENAME,JOB,SAL from EMP where 2000<=SAL and SAL <= 3000 order by SAL desc; -- order by �÷� desc,asc asc�� ����Ʈ��.

--BETWEEN A AND B
select ENAME,SAL from EMP where SAL between 2000 and 3000; -- 2000�� ���ų� ũ�� 3000���� �۰ų� ����.

select ENAME,JOB from EMP where ENAME like 'A%' or ENAME like 'B%'; -- 'A%'ù���ڰ� A //  '%A'�����ڰ� A //  '%B' �����ڰ� B//  'B%'ù���ڰ� B

select ENAME,JOB from EMP where ENAME between 'A' and 'BZZZZ';
                                                            -- between 'A' and 'B';�� ������ ���� ���.
                                                            -- 'A'�� ���� ���� AA AB AC AD AE... AAA AAB AAC... ���ڼ��� ������� ����ؼ� B���� ������ ��Ÿ����. ���� ����� BLAKE�� ��Ÿ���� �ʴ´�. B �ڿ� �ֱ⶧��.
                                                            -- and �ڿ� 'BL'�� �־ BLAKE�� ������ ����. BM�� BLAKE ����.
                                                            -- A B C D E F G H I J K L M // M�� L �ڿ� �ֱ� ����.
                                                            -- ���� B�� �����ϴ� ��� ���ĺ����� �̷���� ���ڸ� �����ϱ����ؼ��� BZZZZZZZ....ZZZZ������.
                                                            -- EMP���̺��� ENAME�� ���̰� �ִ� 5���ڷ� ������ �ֱ⶧���� BZZZZ�� ������ ���Ҽ� �ִ�.
                                                            -- �̸��� AASDM, ABDKML, BBDFBDB, BFBGFBF, CDSFSDF�ΰ�츦 ����ؼ� between ~ and ~ �� ����غ���.

-- not ������

select *from  EMP where job not in('CLERK'); --  ! in�� �ƴ϶� not in 

-- ���� order by ASC �������� DESC ��������

select *from EMP order by SAL DESC; -- order by ~~ desc �Ǵ� asc

select *from EMP order by HIREDATE asc; -- order by���� �׻� ���� �������� ���ش�.

