--DQL (QUEREY 데이터 질의언어) : SELECT 

--DML (MANIPULATION 데이터 조작언어) : INSERT, UPDATE, DELETE ,[SELECT]
--DDL (DEFINITION 데이터 정의언어) : CREATE, ALTER, DROP
--DCL (CONTROL 데이터 제어언어) : GRANT, REVOKE, [ROLLBACK]

--TCL (TRANSACTION CONTROL 트랜잭션 제어 언어) : ROLLBACK, COMMIT

/*INSERT UPDATE DELETE : DATA MANIPULATION LANGUAGE 데이터 조작언어(DML)*/
--테이블 값을 삽입, 수정, 삭제하는 구문.

--1.INSERT : 테이블에 새로운 행을 추가하는 구문

--표현식1 : INSERT INTO 테이블명 VALUES(값1, 값2, 값N..)  : 테이블 모든칼럼에 대한 값을 제시해서 한행INSERT 할때 사용
--부족하게 값을 제시할경우 --> NOT ENOUGH VALUES 오류 발생, 값을 많이 제시하면 --> TOO MANY VALUES
INSERT INTO EMPLOYEE VALUES(900, '차은우', '910303-1234567', 'cha_ew@kh.or.kr', '01011117777', 'D1', 'J7', 'S3', 40000000, 0.5 , 200, SYSDATE, NULL, DEFAULT);
SELECT * FROM EMPLOYEE;
--표현식2 : INSERT INTO 테이블명 (컬렴명, 컬럼명, 컬럼명) VALUES (값1, 값2, 값3) : 테이블에 선택한컬럼의 대한 값만 INSERT할떄 사용
--그래도 한행단위로 추가 되기 때문에 선택안한 칼럼은 기본적으로 NULL이 들어감
--단, DEFAULT값이 있는경우 NULL이 아닌 DEFAULT 값 들어감.
-->NOT NULL 제약조건있는 컬럼은 반드시 선택해서 직접값 작성해야함.

INSERT 
  INTO EMPLOYEE
        (
        EMP_ID
        , EMP_NAME
        , EMP_NO
        , JOB_CODE
        , SAL_LEVEL
        , HIRE_DATE
        ) 
VALUES 
        (901
        , '박보검'
        , '880101~1111111'
        ,'J1'
        ,'S2'
        , SYSDATE
        );
        
SELECT *fROM EMPLOYEE;

--표현식3 : INSERT INTO 테이블명 (서브쿼리) : VALUES 값을 직접명시하는거 대신, 서브쿼리로 조회된결과를 INSERT
CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(20)
);
SELECT * FROM EMP_01;
INSERT INTO EMP_01(SELECT EMP_ID, EMP_NAME, DEPT_TITLE
                    FROM EMPLOYEE 
                    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)                   
                    );
                    
--2.INSERT ALL :
--테스트용 테이블 구조만 배끼기
CREATE TABLE EMP_DEPT 
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE
    WHERE 1=0;
    
CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
    FROM EMPLOYEE
    WHERE 1=0;
    
SELECT * FROM EMP_DEPT;    
SELECT * FROM EMP_MANAGER ;    

--부서코드 D1 사원들의 사번, 이름 부서코드 입사일 사수사번 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM EMPLOYEE
WHERE DEPT_CODE='D1';

/*
    표현식 INSERT ALL 
          INTO 테이블명1 VALUES(컬럼명, 컬럼명,...)
          INTO 테이블명1 VALUES(컬럼명, 컬럼명,...)
           서브쿼리;
*/
INSERT ALL
INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
    FROM EMPLOYEE
    WHERE DEPT_CODE='D1';
--조건 사용해서도 각테이블에 INSERT 가능
--2000년도 전에 입사자 담을 테이블 
CREATE TABLE EMP_OLD 
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1=0;


--2000년도 이후 입사자 담을 테이블
CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1=0;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;
/*
표현식 
INSERT ALL 
WHEN 조건 1 THEN 
    INTO 테이블1 VLAUES(칼럼명, 칼럼명, ...)    
WHEN 조건 2 THEN 
    INTO 테이블1 VLAUES(칼럼명, 칼럼명, ...)
서브쿼리;
*/
    
INSERT ALL 
WHEN HIRE_DATE < '2000/01/01' THEN 
    INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
WHEN HIRE_DATE >= '2000/01/01' THEN
    INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
    SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE;

SELECT *FROM EMP_OLD;
SELECT *FROM EMP_NEW;


    
--3.UPDATE : 테이블 기존의 기록되어있는 데이터를 수정하는 구문
--[표현식] UPDATE 테이블명 
--           SET 컬럼명 = 바꿀값,
--               컬럼명 = 바꿀값,    
--                 .... => 여러개의 칼ㄹ럼 값 동시에 변경가능
--[WHERE 조건]  => 생략하면 전체 테이블에 있는 모든 행의 데이터 가 동일하게 바뀜 ㅁ         

CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM  DEPT_COPY;

UPDATE DEPT_COPY
    SET DEPT_TITLE ='전략기획팀'
WHERE DEPT_ID = 'D9';--전부 전략기획팀으로 바뀜 WHERE 절 필수 
ROLLBACK;

--복사본
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE;

SELECT * FROM EMP_SALARY;
--1 노옹철 급여를 100마넌을 변경 ~ 데이터백업
UPDATE EMP_SALARY
    SET SALARY =1000000
--WHERE EMP_NAME = '노옹철';--202	노옹철	D9	3700000	
WHERE EMP_ID =202;

ROLLBACK;
--2 선동일 급여를 700마넌을 변경 보너스 0.25~ 데이터백업
UPDATE EMP_SALARY
    SET SALARY =7000000,
        BONUS = 0.25
--WHERE EMP_NAME = '선동일';--200	선동일	D9	8000000	0.3
WHERE EMP_ID =200;
--3.전체사원 급여를 급여 10프로 인상
UPDATE EMP_SALARY
    SET SALARY = SALARY*1.1;
    
/*
    UPDATE 테이블명
        SET 컬럼명 = (서브쿼리)
    WHERE 조건;
*/

--방명수 사원의 급여와 보너스값을 유재식으로 변경하고싶음
SELECT *FROM EMP_SALARY
WHERE EMP_NAME = '방명수';

--단일행 서브쿼리로 바꾸는것
UPDATE EMP_SALARY
    SET  SALARY = (SELECT SALARY
                    FROM EMP_SALARY
                    WHERE EMP_NAME = '유재식'),
        BONUS = (SELECT BONUS
                    FROM EMP_SALARY
                    WHERE EMP_NAME = '유재식')
WHERE EMP_ID =214;

--단중열 서브쿼리로 바꾸는것
UPDATE EMP_SALARY
    SET (SALARY, BONUS) = (SELECT SALARY, BONUS
                    FROM EMP_SALARY
                    WHERE EMP_NAME = '유재식')
 WHERE EMP_ID =214; 


SELECT EMP_ID
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE= DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE LOCAL_NAME LIKE 'ASIA%';

UPDATE EMP_SALARY
    SET BONUS =0.3
WHERE EMP_ID IN (SELECT EMP_ID
                FROM EMPLOYEE
                JOIN DEPARTMENT ON (DEPT_CODE= DEPT_ID)
                JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
                WHERE LOCAL_NAME LIKE 'ASIA%');

SELECT * FROM EMP_SALARY;

UPDATE EMPLOYEE
SET EMP_NAME = NULL
WHERE EMP_ID =200;
--NOT NULL제약조건 위배

SELECT * FROM JOB;
UPDATE EMPLOYEE
    SET JOB_CODE = 'J9'
WHERE EMP_ID =203;
--FK 제약 조건 위배 
COMMIT;

--4.DELETE : 테이블에 기록된 데ㅐ이터를 삭제하는 구문 ~ 한행단위로 삭제됨
--표현식 DELETE FROM 테이블명 
--      WHERE 조건 ;  조건식 필수

DELETE FROM EMPLOYEE
WHERE EMP_ID=900;

SELECT * FROM EMPLOYEE;
 
DELETE FROM EMPLOYEE
WHERE EMP_ID=901;   

ROLLBACK;--마지막 커밋 시점으로 돌아감 
COMMIT;

--DEPT_ID D1 부서를 삭제 
DELETE FROM DEPARTMENT 
WHERE DEPT_ID ='D1';

SELECT * FROM EMPLOYEE;
ROLLBACK;

DELETE FROM DEPARTMENT 
WHERE DEPT_ID ='D3';
ROLLBACK;

--TRUNCATE 테이블 전체 행을 삭제할떄 사용되는 구문 ~ 딜리트보다 수행속도 빠름, 별도 조건 제시 불가 ,롤백안됨.
-- 표현식 : TRUNCATE TABLE 테이블명; 데이터 싸그리 삭제함. ~ 내부적으로 커밋됨.
SELECT * FROM EMP_SALARY;
TRUNCATE TABLE EMP_SALARY;
ROLLBACK;























































