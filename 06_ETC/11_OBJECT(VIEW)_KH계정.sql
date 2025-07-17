/*
    <VIEW 뷰> VIEW ~ 임시(논리)테이블 : 실제 데이터가 담긴건 아니고 그냥 보여주기 용
    SELECT 문을 저장해둘수있는 객체
    (자주쓰는 긴 SELECT문을 저정해주면 그 긴 SELECT문을 매번 기술할 필요없이 만들는것)
    물리적인 테이블 : 실제 있는것
    논리적인 테이블 : 추상적인 것 => 뷰는 논리적인 가상의 테이블이다.
*/ 

--VIEW 생성 쿼리문 작성
--관리자 페이지

--'한국'에서 근무하는 사원들의 사번 이름 부서명 급여 근무국가명 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY , NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID= LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME = '한국';

--'러시아'에서 근무하는 사원들의 사번 이름 부서명 급여 근무국가명 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY , NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID= LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME = '러시아';

--'일본'에서 근무하는 사원들의 사번 이름 부서명 급여 근무국가명 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY , NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID= LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME = '일본';

--깔짝 조금만 달라지는데 이걸 저장해서 쓰려고 뷰를 만든거임.
/* VIEW 생성식
   [표현식]
    CREATE [OR REPLACE] VIEW 뷰명    
    AS 서브쿼리;    
    
    OR REPLACE : 뷰 생성시 기존에 중복된 이름의 뷰가 없다면 새로이 뷰를 생성하고, 
                         기존에 중복된 이름이 있따면 해당 뷰를 변경하는 옵션.
*/

CREATE VIEW VW_EMPLOYEE 
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY , NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID= LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE);
--ORA-01031: insufficient privileges(권한) =>VIEW 생성 권한필요(SYSTEM 권한)
--관리자계정접속헤서 권한 부여
GRANT CREATE VIEW TO KH;

SELECT * 
FROM VW_EMPLOYEE;--가짜! 논리 테이블, 가상테이블 --이것은 실제 테이블이 아니다.

SELECT *
FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY , NATIONAL_NAME
        FROM EMPLOYEE
        JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        JOIN LOCATION ON (LOCATION_ID= LOCAL_CODE)
        JOIN NATIONAL USING(NATIONAL_CODE) );--이건 인라인뷰 /위는 그냥 뷰

SELECT * 
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME='한국';
SELECT * 
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME='러시아';
SELECT * 
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME='일본';

CREATE OR REPLACE VIEW VW_EMPLOYEE --생성하거나 바꾸거나.
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY , NATIONAL_NAME, BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID= LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE);
--name is already used by an existing object
--해당이름 쓰는 뷰가 이미 있어서 에러남

-- 뷰 별칭 붙이기
CREATE OR REPLACE VIEW VW_EMP_JOB
AS SELECT EMP_ID, EMP_NAME, JOB_NAME , DECODE(SUBSTR(EMP_NO,8,1), '1','남','2','여') AS "성별(남\여)", EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM HIRE_DATE) AS"근무년수"
   FROM EMPLOYEE
   JOIN JOB USING(JOB_CODE);--VIEW 샐렉절에 별칭 안지어지면 안만들어짐
--"must name this expression with a column alias" : 칼럼에 별칭지어라잉 
--서브쿼리 SELECT 절에 함수식이나 산술연산식 기술되어있을 경우 별칭 선언 ㄱ 

SELECT * FROM VW_EMP_JOB;--가짜! 가상테이블, 논리 테이블

--별칭지어주는 다른 방법.~ SELECT 할떄 좋음
CREATE OR REPLACE VIEW VW_EMP_JOB(사번, 이름, 직급명, 성별, 근무년수)--단 이런방식으로 별칭지을시 모든 컬럼 다 기술.
AS SELECT EMP_ID, EMP_NAME, JOB_NAME , DECODE(SUBSTR(EMP_NO,8,1), '1','남','2','여'), EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM HIRE_DATE)
   FROM EMPLOYEE
   JOIN JOB USING(JOB_CODE);
   
SELECT * FROM VW_EMP_JOB;

SELECT 이름, 직급명
FROM VW_EMP_JOB
WHERE 성별 = '여';

SELECT * 
FROM VW_EMP_JOB
WHERE 근무년수 >=20;

DROP VIEW VW_EMP_JOB;--VIEW 삭제 
-----------------------------------------------------
--생성된 뷰를 통해서 DML 데이터 조작은 사용가능, 
--뷰를 통해서 조작하더라도 실제테이블에 반영이되긴하나 에러가 되는경우 많아 잘 쓰이진 않음.'

CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE, JOB_NAME
    FROM JOB;

SELECT * FROM VW_JOB;--논리적인 테이블 가짜테이블, 가상테이블

SELECT * FROM JOB; --물리테이블, 실제테이블, 베이스 테이블

--VW를 통해 INSERT 시전
INSERT INTO VW_JOB VALUES('J8','인턴');
--VW, JOB 둘다 INSERT 잘되었음. 가능하네? 

--VW를 통해 UPDATE 시전
UPDATE VW_JOB 
SET JOB_NAME = '알바'
WHERE JOB_CODE ='J8';
--VW, JOB 둘다 UPDATE 잘되었음. 가능하네? 

--VW를 통해 DELETE 시전
DELETE FROM VW_JOB
WHERE JOB_CODE='J8';
--VW, JOB 둘다 DELETE 잘되었음. 가능하네? 
----------------------------------------------------------------------------------
--VIEW를 통해 DML을 할수있긴하다. 단 조작 불가능 한 경우 가 훨씬 많다. 6가지 경우
/*
1)뷰에 정의되지않은 컬럼 조작하는경우 
2)뷰에 정의되지않은 컬럼 중 원본테이블 상에 NOTNULL제약조건 지정된경우~랜덤으로 실행
3)산술연산식 OR 함수식으로 정의된 함수
4)GROUP BY, 그룹함수(SUM, AVG ..)포함된 경우
5)DISTINCT 구문 포함된경우
6)JOIN을 이용해서 여러테이블과 연결된 경우
*/--결론은 뷰는 조회용으로 만든거기 때문에 DML 지양하는걸 추구.
--**예시
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE FROM JOB;

SELECT *FROM VW_JOB; --가짜테이블 논리테이블
SELECT *FROM JOB; --실제테이블 
--1)뷰에 정의되지않은 컬럼 조작하는경우 
--INSERT : 안됨
INSERT INTO VW_JOB VALUES('J8', '인턴');
--"too many values" 뷰에 정의된 컬럼이 하나밖에 없기 떄문에 INSERT 에러나옴.
--UDATE : 안됨
UPDATE VW_JOB
SET JOB_NAME='인턴'
WHERE JOB_CODE='J7'; --  invalid identifier" UPDATE도에러 
--DELETE : 안됨
DELETE FORM VW_JOB
WHERE JOB_NAME ='사원';--에러

--2)뷰에 정의되지않은 컬럼 중 원본테이블 상에 NOTNULL제약조건 지정된경우~랜덤으로 실행
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_NAME FROM JOB;

SELECT *FROM VW_JOB; 
SELECT * FROM JOB;
--INSERT : 안됨
INSERT INTO VW_JOB VALUES('인턴');--cannot insert NULL into ("KH"."JOB"."JOB_CODE")
--UPDATE : 됨
UPDATE VW_JOB
SET JOB_NAME ='알바'
WHERE JOB_NAME ='사원';
ROLLBACK;
--DELETE 쓰고있는 자식있어서 안됨 원래 되는것같음
DELETE FROM VW_JOB
WHERE JOB_NAME='사원';--ORA-02292: integrity constraint (KH.SYS_C007151) violated - child record found

--3)산술연산식 OR 함수식으로 정의된 함수
CREATE OR REPLACE VIEW VW_EMP_SAL
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 AS "연봉"
    FROM EMPLOYEE;

SELECT * FROM VW_EMP_SAL;
SELECT * FROM EMPLOYEE;
--INSERT : 안됨
INSERT INTO VW_EMP_SAL VALUES(400,'차은우',3000000,36000000);
--virtual column not allowed here 가상 컬럼 어쩔껀데 안도미
--UPDATE :되는거 있고 안되는거있고 
UPDATE VW_EMP_SAL
SET 연봉 =80000000
WHERE EMP_ID =200;-- 에러 

UPDATE VW_EMP_SAL
SET SALARY =7000000
WHERE EMP_ID=200;-- SALARY는 된다.
ROLLBACK;
--DELETE: 됨
DELETE FROM VW_EMP_SAL
WHERE 연봉 =72000000;--된다.
ROLLBACK;

--4)GROUP BY, 그룹함수(SUM, AVG ..)포함된 경우
CREATE OR REPLACE VIEW VW_GROUPDEPT
AS SELECT DEPT_CODE, SUM(SALARY) AS "합계", FLOOR(AVG(SALARY)) AS "평균"
    FROM EMPLOYEE
    GROUP BY DEPT_CODE;
    
SELECT * FROM VW_GROUPDEPT;-- 가상 가짜 논리 테이블
--INSERT : 안됨
INSERT INTO VW_GROUPDEPT VALUES('D3', '8000000', '4000000');
--virtual column not allowed here  되겠 냐?
--UPDATE : 안됨
UPDATE VW_GROUPDEPT
SET 합계 =8000000
WHERE DEPT_CODE= 'D1';--에러 
--DELETE : 안됨
DELETE FROM VW_GROUPDEPT 
WHERE 합계 = 5210000;--에러 

--5)DISTINCT 구문 포함된경우
CREATE OR REPLACE VIEW VW_DT_JOB
AS SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

SELECT * FROM VW_DT_JOB;
--INSERT : 에러 
INSERT INTO VW_DT_JOB VALUES('J8');--안됨
--UPDATE : 에러 
UPDATE VW_DT_JOB
SET JOB_CODE ='J8'
WHERE JOB_CODE='J7';--data manipulation operation not legal on this view
--DELETE : 에러 
DELETE FROM VW_DT_JOB
WHERE JOB_CODE='J4';--data manipulation operation not legal on this view
--6)JOIN을 이용해서 여러테이블과 연결된 경우
CREATE OR REPLACE VIEW VW_JOINEMP 
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE= DEPT_ID);

SELECT * FROM VW_JOINEMP;
--INSERT : 에러
INSERT INTO VW_JOINEMP VALUES(300, '장원영', '총무부' );
--UPDATE : 되거나 안됨
UPDATE VW_JOINEMP
SET EMP_NAME ='선동이'
WHERE EMP_ID =200;
ROLLBACK;

UPDATE VW_JOINEMP
SET DEPT=TITLE ='회계부'
WHERE EMP_ID =200;--안됨

--DELETE : 되거나 안됨
DELETE FROM VW_JOINEMP
WHERE EMP_ID=200;
ROLLBACK;--됨

DELETE FROM VW_JOINEMP
WHERE DEPT_TITLE;--안됨

--그냥 VIEW DML하지마
/*
    VIEW 옵션~  FORCE|NOFORCE , WITH CHECK OPTION , WITH READ ONLY
    [표현식]
    CREATE [OR REPLACE] [FORCE|NOFORCE] VIEW 뷰명
    AS 서브쿼리 
    [WITH CHECK OPTION]
    [WITH READ ONLY]
    
    1) OR REPLACE : 기존에 동일한 뷰가 있을경우 갱신, 존재하지않으면 새롭게 생선  
    2) FORCE  : 서브쿼리에 기술된 테이블이 존재하지 않아도 뷰가 생성되게 하는것
       NOFORCE : 서브쿼리에 기술된 테이블없으면 뷰 생성안되게 : DEFAULT
    3) WITH CHECK OPTION : DML시 서브쿼리에 기술된 조건에 부합한 값으로만 DML가능하도록 
    4) WITH READ ONLY : 수정이 안되고 읽기만 되는 옵션 ~ 뷰에대해서 수정이 안되고 오직 조회만 가능 (DML 수행불가)
*/

--2)FORCE|NOFORCE
CREATE OR REPLACE /*NOFORCE*/ VIEW VW_EMP
AS SELECT TCODE, TNAME, TCONTENT
FROM TT;--table or view does not exist

CREATE OR REPLACE FORCE VIEW VW_EMP
AS SELECT TCODE, TNAME, TCONTENT
FROM TT;--경고: 컴파일 오류와 함께 뷰가 생성되었습니다.

SELECT * FROM VW_EMP;--조회안됨.
--TT테이블 만들어지면 사용 조회 가능
CREATE TABLE TT(
    TCODE NUMBER,
    TNAME VARCHAR2(20),
    TCONTENT VARCHAR2(30)

);
--컬럼은 알고 테이블은 이따 만들때 사용하는 기능

--3)WITH CHECK OPTION : 서브쿼리에 기술된 조건에 부합하지 않는 값으로 수정시 오류 발생
-- WITH CHECK OPTION 안쓰고
 CREATE OR REPLACE VIEW VW_EMP
 AS SELECT *
    FROM EMPLOYEE
    WHERE SALARY>=3000000;
SELECT * FROM VW_EMP;

UPDATE VW_EMP
SET SALARY = 2000000--8000000
WHERE EMP_ID=200;
ROLLBACK;


-- WITH CHECK OPTION 쓰고 
 CREATE OR REPLACE VIEW VW_EMP
 AS SELECT *
    FROM EMPLOYEE
    WHERE SALARY>=3000000
    WITH CHECK OPTION;
    
SELECT * FROM VW_EMP;

UPDATE VW_EMP
SET SALARY=2000000 
WHERE EMP_ID =200;
--view WITH CHECK OPTION where-clause violation
--서브쿼리에 기술한 조건에 부합하지 않아 변경이 불가능함.

UPDATE VW_EMP
SET SALARY=4000000 
WHERE EMP_ID =200;--서브쿼리에 기술한 조건 >=3000000 에 부합하여 변경가능
ROLLBACK;

--4)WITH READ ONLY : 중요! 수정이 안되고 읽기만 되는 옵션~ 조회만 가능( DML 수행 불가)
CREATE OR REPLACE VIEW VW_EMP
AS SELECT EMP_ID, EMP_NAME, BONUS
    FROM EMPLOYEE
    WHERE BONUS IS NOT NULL
WITH READ ONLY;

SELECT * FROM VW_EMP;
DELETE FROM VW_EMP
WHERE EMP_ID=200;
--cannot perform a DML operation on a read-only view
--읽기 전용임.


