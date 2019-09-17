
------------------------------------------------------------------------------------------------------------------------------- 테이블 생성 시작.
--DROP TABLE DEPT;
CREATE TABLE DEPT  --부서 정보
  (
  DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY(DEPTNO), -- 부서번호 DEPTNO를 PK_DEPT라는 제약명을 지어주고 TABLE DEPT의 PRIMARY KEY로 선언한다.
	DNAME VARCHAR2(14),
	LOC VARCHAR2(13) 
  );
--DROP TABLE EMP;
CREATE TABLE EMP  -- EMP는 EMPLOYEE 즉, 사원정보
  (
  EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,  -- EMPNO를 PK_EMP라는 제약명을 지어주고 TABLE EMP의 PRIMARY KEY로 선언한다.
                                                  -- 위 문장에 PRIMARY KEY를 선언하지 않고 따로 선언해줄수 있다.
                                                  -- EMPNO NUMBER(4),
                                                  -- CONSTRAINT PK_EMP(CONSTRAINT 생략가능) PRIMARY KEY(EMPNO),
                                                  -- 이런식으로, 마찬가지로 참고키도 가능.
	ENAME VARCHAR2(10), -- EMPLOYEE NAME
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIREDATE DATE, -- DATE 날짜형식
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT -- DEPTNO를 FK_DEPTNO로 제약명을 지어주고 DEPT TABLE의 DENPTNO FK로 참조한다.
                                                        -- 붙여서 말고 따로 FK선언 가능.
                                                        -- DEPTNO NUMBER(2),
                                                        -- CONSTRAINT FK_DEPTO(생략가능) FOREIGN KEY(DEPTNO) REFERENCES DEPT(DEPTNO)
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

CREATE TABLE BONUS -- 보너스 정보
	(
	EMPNO NUMBER(4)	CONSTRAINT FK_EMPNO REFERENCES EMP, -- EMPNO는 BONUS TABLE의 PK이자 EMP TABLE의 FK
	bonus NUMBER
	);
--DROP TABLE SALGRADE;

CREATE TABLE SALGRADE -- 급료 정보
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
------------------------------------------------------------------------------------------------------------------------------- 테이블 생성 끝.


select sysdate from emp; -- EMP테이블은 그냥 가져다 쓴거다. SYSDATE라는 컬럼없음 EMP의 레코드 수만큼 함수 SYSDATE가 출력됨.
select to_date('1993-11-03 11:33:00','yyyy-mm-dd/hh24:mi:ss') from dual; -- 시분초는 출력이 안됨.
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss')sys_date from dual; -- to_char는 글자로 바꿔주는 함수 //sys_date라는 칼럼명도 지정해줌, as가 생략된것.
select sysdate from dual; -- 더미 테이블 dual 가짜테이블

select *from emp;
select ENAME,JOB,SAL,DEPTNO from emp;

select *from emp 
where job = 'CLERK'; --작은 따옴표, 대소문자 표기 주의.

select *from emp
where job = 'MANAGER' or job = 'CLERK';  -- job = '~~' or job = '~~'

select *from emp
where sal > 1000;

select *from emp where job in('CLERK','MANAGER'); -- where ~~ in(,,,) ~~가 in(,,,)에 있으면 출력.

select *from emp where job = 'CLERK' and sal >= 1000;

select *from emp where job = 'MANAGER' and sal >= 2000;

select sysdate, sysdate + 3 from dual;
select sysdate - HIREDATE from EMP; -- 근속일수 구하는 명령어/ 일수로 결과가 나옴.
select ENAME,JOB,ROUND((sysdate - HIREDATE)/365) from EMP; -- 근속연수 구하는 명령어/ 일수로 결과가 나옴.
select ((sysdate - HIREDATE)/365),((sysdate - HIREDATE)%365),((sysdate - HIREDATE)/365) from emp; -- 연수 월수 일수로 보여주려면 어떻게 해야되나.
select ROUND(12.567, 1) from dual; -- 소수점 한자리까지 결과를 보여달라. 즉, 둘째자리에서 반올림. 결과 12.6
select ROUND(12.547, 1) from dual; -- 소수점 한자리까지 결과를 보여달라. 즉, 둘째자리에서 반올림. 결과 12.5

select ENAME,JOB from EMP
where COMM is NULL ; -- NULL판별 IS NULL함수 // IS NOT NULL함수

select NVL(COMM,3000)as v1, COMM from EMP;  -- 함수나 계산을 이용해서 새로운 컬럼을 출력하는경우 as함수를 이용해서 컬럼이름을 만든다.

select ENAME, SAL+100 as sal_plus_100 from EMP; -- SAL+100의 새로운 컬럼을 맞들어줌.

select ENAME, NVL(SAL,0)+NVL(COMM,0) as sal_plus_COMM from EMP; -- SAL + COMM의 새로운 컬럼을 만들어주기위해서 COMM의 널값을 0으로 바꿔야함. *****중요*****
                                                         -- as함수로 새로운 컬럼이름을 만들어줄 때는 +같은 연산기호를 사용할 수 없다. 
                                                         -- NVL( , )함수를 이용하면 결과값이 한줄의 컬럼으로 나와 같은 크기의 컬럼과 연산할 수 있다.
                                                         -- 일반적으로 데이터의 양이 무지 많기 때문에 NULL값을 일일이 확인할 방법이 없다.
                                                         -- 따라서 모든 연산에있어서 NVL()함수를 사용해주는것이 안전하다.
                                                         -- as함수는 생략가능한듯, 생략하고 바로 새로운 컬럼이름을 써줘도 됨.
                                                         
select ENAME, NVL(SAL+COMM,SAL) as sal_plus_comm from EMP; -- 이 문장을 이용해서도 위와같은 값을 얻을 수 있지만, 위 문장과 달리 SAL값이 NULL인지 확인할 방법이 없다.

select emp.*, ENAME||'JJJJ'ENAME_PLUS_JJJJ from EMP; -- EMP에 있는 레코드를 모두 출력하고 거기에 더해서 추가로 ENAME 즉 고용자들의 이름에 JJJJ를 붙인 컬럼을 추가.

select concat(concat(ENAME,'님 직급:'),JOB) 성함 from EMP; -- concat안의 concat, concat의 인풋과 아웃풋은 문자열.

select ENAME from EMP where ENAME like '%A%'; -- 글자 'A'의 글자가 포함된 ENAME

--테이블 구조 보기.
desc EMP;

--중복제거한 컬럼의 목록.
select distinct job from emp;

-- ! 부정형
-- != 또는 <>
select ENAME,JOB from EMP where job != 'CLERK'; -- 점원이 아닌 피고용자의 직업

select ENAME,JOB from EMP where job <> 'CLERK'; -- 점원이 아닌 피고용자의 직업

select ENAME,JOB,SAL from EMP where 2000<=SAL and SAL <= 3000 order by SAL desc; -- order by 컬럼 desc,asc asc는 디폴트값.

--BETWEEN A AND B
select ENAME,SAL from EMP where SAL between 2000 and 3000; -- 2000과 같거나 크고 3000보다 작거나 같은.

select ENAME,JOB from EMP where ENAME like 'A%' or ENAME like 'B%'; -- 'A%'첫글자가 A //  '%A'끝글자가 A //  '%B' 끝글자가 B//  'B%'첫글자가 B

select ENAME,JOB from EMP where ENAME between 'A' and 'BZZZZ';
                                                            -- between 'A' and 'B';로 범위를 정할 경우.
                                                            -- 'A'한 글자 부터 AA AB AC AD AE... AAA AAB AAC... 글자수에 관계없이 계속해서 B사이 까지를 나타낸다. 따라서 사원명 BLAKE는 나타나지 않는다. B 뒤에 있기때문.
                                                            -- and 뒤에 'BL'을 넣어도 BLAKE는 나오지 않음. BM은 BLAKE 나옴.
                                                            -- A B C D E F G H I J K L M // M은 L 뒤에 있기 때문.
                                                            -- 따라서 B로 시작하는 모든 알파벳으로 이루어진 문자를 포괄하기위해서는 BZZZZZZZ....ZZZZ여야함.
                                                            -- EMP테이블에서 ENAME은 길이가 최대 5글자로 정해져 있기때문에 BZZZZ로 범위를 정할수 있다.
                                                            -- 이름이 AASDM, ABDKML, BBDFBDB, BFBGFBF, CDSFSDF인경우를 고려해서 between ~ and ~ 를 고민해보자.

-- not 부정형

select *from  EMP where job not in('CLERK'); --  ! in이 아니라 not in 

-- 정렬 order by ASC 오름차순 DESC 내림차순

select *from EMP order by SAL DESC; -- order by ~~ desc 또는 asc

select *from EMP order by HIREDATE asc; -- order by문은 항상 제일 마지막에 써준다.

