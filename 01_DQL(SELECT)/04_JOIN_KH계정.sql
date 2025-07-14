/*
<JOIN>
 두개이상의 테이블에서 테이블을 조회하고자 할떄 사용되는구문.
 조회결과는 하나의 결과물로(RESULT SET)으로 나옴.
 
 관계형 데이터베이스는 최소한의 데이터로 각각의 테이블에 데이터를 담고있음 (중복을 최소화하기위해)
 
 --어떤 사원이 어떤 부서에 속해 있는지 궁금함.
 =>관계형 데이터베이스에서 SQL문을 이용해서 테이블간 관계 맺는법
 (무작정 다 조회하는게 아니라, 각테이블간 연결고리로써 데이터를 매칭시키는방법)
 
 Join크게 오라클 전용구문과 ansi 구문 
 
                                    [JOIN 용어정리] 
            오라클 전용구문                  |                ANSI 구문
 -------------------------------------------------------------------------------------           
               등가조인                     |           내부조인(INNER JOIN)
            [EQUAL JOIN]                  |           자연조인(NATURAL JOIN)
 -------------------------------------------------------------------------------------           
               포괄조인                     |        왼족 외부조인(LEFT OUTER JOIN)
            (LEFT OUTER)                  |      오른쪽 외부조인(RIGHT OUTER JOIN)
            (RIGHT OUTER)                 |         전체 외부조인(FULL OUTER JOIN)
 ------------------------------------------------------------------------------------                       
               자체조인(SELF JOIN)          |      JOIN ON     
            비등가 조인(NON EQUAL JOIN)     |
  ------------------------------------------------------------------------------------                       

*/

--전체사원들의 사번,사원명,부서코드,부서명조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

--전체사원들의 사번,사원명,지급코드,직급명
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;

SELECT JOB_CODE, JOB_NAME
FROM JOB;
--1.등가조인 (EQUAL JOIN)/내부조언(INNERJOIN)
--연결시키는 칼럼값이 일치하는 행들만 조인돼서 조회 

-->오라클 전용구문으로 조인
-- FROM 절에 조회하고 하는 테이블을 나열 , 구분자로
-- WHERE절에 매칭시킬 컬럼(연결고리) 에대한 조건을 제시함.
--1)연결할 두 컬럼명이 다른경우 (DEPT_CODE, DEPT_ID)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE= DEPT_ID;
--D일치하는 값이 없는 행은 조회에서 제외
--~NULL, D3 ,D5 , D7 조회X

--1)연결할 두 컬럼명이 다른경우 (JOB_CODE)
--전체사원들의 사번,사원명,지급코드,직급명
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

--2.테이블에 별칭 부여서해서한는방법
--
SELECT  EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE =J.JOB_CODE;                          

-- ANSI구문
--FORM 절에 기준이 되는 테이블 하나 기술후 
--JOIN 절에 같이 조회고자 하는 테이블 기술 + 매칭 시킬 컬럼에 대한 조건도 기술
--JOIN USING JOIN  ON

--1)연결할  두컬럼명이 다른경우 오로지JOIN구문만 가능
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

--1)연결할  두컬럼명이 같은경우 
--JOIN ON , JOIN USING구문 사용가능
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);

--2) JOIN USING 
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB USING(JOB_CODE);

--자연조인 각테이블 마다 동일한 컬러명이 한개만 존재하는경우
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;

--추가적인 조건 제시 
--직급명 대리인 사원의 이름, 직급명, 급여조회
--1)오라클 전용구문
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E ,JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND J.JOB_NAME= '대리';
--2)ANSI구문
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME ='대리';

--실습문제-------------------------------------------------------------------
--1.부서가 인사 관리부인 사원들의 사번, 이름, 보너스 조회
-->>오라클
SELECT EMP_ID, EMP_NAME, BONUS, D.DEPT_TITLE
FROM EMPLOYEE E,DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
AND D.DEPT_TITLE= '인사관리부';
-->>ANSI
SELECT EMP_ID, EMP_NAME, BONUS, D.DEPT_TITLE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE D.DEPT_TITLE= '인사관리부';

--2.DEPARTMENT와 LOCATION 참고하여 전체부서의부서코드,부서명, 지역코드, 지역명 조회
-->>오라클
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT D, LOCATION L
WHERE D.LOCATION_ID= L.LOCAL_CODE;
-->>ANSI
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT D
JOIN LOCATION L ON ( D.LOCATION_ID= L.LOCAL_CODE);


--3.보너스를 받는 사원들의 사번, 사원명, 보너스, 부서명 조회
-->>오라클
SELECT EMP_ID, EMP_NAME, BONUS, D.DEPT_TITLE
FROM EMPLOYEE E,DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
AND E.BONUS IS NOT NULL;
-->>ANSI
SELECT EMP_ID, EMP_NAME, BONUS, D.DEPT_TITLE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE E.BONUS IS NOT NULL;
--4.부서가 총모부가 아닌사원들의 사원명 급여 , 부서명 조회
-->>오라클
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND DEPT_TITLE ^= '총무부';

-->>ANSI
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE ^= '총무부';

/*
    2.포괄조인 / 외부조인 (OUTER JOIN)
    두  테이블 간의 JOIN시 일치하지 않는 행도 포함시켜서 조회가능
    단, 반드시 LEFT/ RIGHT 지정해야함 (기준 되는 테이블 지정)

*/
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY *12 AS 연봉
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
--부서배치가 아직안된 사원 2명에 대한 정보가 빠짐
-- D3 D4 D7도 인원배치가 없는 부서도 조회 안됨.

--1)LEFT [OUTER] JOIN  : 두테이블 중 왼편 기술된테이블기준으로 JOIN
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY *12 AS 연봉
FROM EMPLOYEE--EMPLOYEE에있는거 무조건 다나옴
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
--오라클 버전
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY *12 AS 연봉
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);--기준으로 삼고자 하는 테이블 반대편 컬럼뒤에 (+)붙이기

--2)RIGHT [OUTER] JOIN  : 두테이블 중 오른편 기술된테이블기준으로 JOIN
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY *12 AS 연봉
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
--오라클버전
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY *12 AS 연봉
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

--3)FULL [OUTER] JOIN : ANSI만 가능 : 두테이블 가진 모든 행을 조회가능
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY *12 AS 연봉
FROM EMPLOYEE--EMPLOYEE에있는거 무조건 다나옴
FULL JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

/*
3.자체조인 : 같은 테이블을 다시한번 조인하는경우 (SELF JOIN)
 */
 
 SELECT *FROM EMPLOYEE;
 
 --전체 사원의 사번 사원명, 사원부서코드 EMPLOYEE E
   --  사수의 사번, 사원명, 사수부서크도 EMPLOYEE M
--오라클
SELECT E.EMP_ID "사원사번", E.EMP_NAME"사원명", E.DEPT_CODE"사원부서코드",
M.EMP_ID"사수사번", M.EMP_NAME"사수명", M.DEPT_CODE"사수부서코드"
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID;
--ANSI
SELECT E.EMP_ID "사원사번", E.EMP_NAME"사원명", E.DEPT_CODE"사원부서코드",
M.EMP_ID"사수사번", M.EMP_NAME"사수명", M.DEPT_CODE"사수부서코드"
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);
------------------------------------------------------------------------
/*
다중조인 
2개이상 테이블 가지고 조인할때 무조건 써야함.
*/

--사번 사원명 부서명 직급명
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE DEPT_CODE= DEPT_ID AND E.JOB_CODE= J.JOB_CODE;

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (DEPT_CODE= DEPT_ID) 
JOIN JOB J USING (JOB_CODE);

--사번 사원명, 부서명 지역명 
SELECT * FROM EMPLOYEE; --DEPT CODE
SELECT * FROM DEPARTMENT; --DEPT_ID, LOCATION_ID
SELECT * FROM LOACATION; --LOCAL CODE

-->>오라클 전용구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE DEPT_CODE = DEPT_ID AND LOCATION_ID = LOCAL_CODE;
-->>ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE 
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

--실습
--1.사번, 사원명 , 부서명, 지역명 ,국가명 조회
-->>오라클
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION L,NATIONAL N 
WHERE DEPT_CODE = DEPT_ID AND LOCATION_ID = LOCAL_CODE AND 
L.NATIONAL_CODE=N.NATIONAL_CODE;
-->>ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE);


--2.사번 사원명 부서명 직급명, 국가명 해당급여 등급에서 받을수 있는 최대금액 조회 (모든테이블 조인)
-->>ORACLE
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, NATIONAL_NAME, MAX_SAL
FROM EMPLOYEE E, DEPARTMENT, JOB J, LOCATION L, NATIONAL N, SAL_GRADE S
WHERE DEPT_CODE = DEPT_ID AND E.JOB_CODE= J.JOB_CODE AND LOCATION_ID = LOCAL_CODE 
AND L.NATIONAL_CODE=N.NATIONAL_CODE AND E.SAL_LEVEL = S.SAL_LEVEL;

-->>ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, NATIONAL_NAME, MAX_SAL
FROM EMPLOYEE 
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
JOIN SAL_GRADE USING(SAL_LEVEL);

