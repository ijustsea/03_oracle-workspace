/*

*서브쿼리 (SUBQUERY)
-하나의 SQL문안에 포함된 또다른 SELECT문
-메인 SQL문을 위해 보조역할 하는 쿼리문

간단서브쿼리 예시1
노옹철 사원과 같은 부서에 속한 사원들 조회
*/

SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME ='노옹철';

SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE ='D9';

-->위의 두개의 쿼리를 하나의 쿼리로 
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE =(SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME ='노옹철');
--간단서브쿼리 예시2
--전직원의 평균급여보다 더 많은 급여 받는 사원들의 사번 이름 직급코드 급여 조회

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY)
                    FROM EMPLOYEE);

SELECT AVG(SALARY)
FROM EMPLOYEE;
/*서브쿼리의 종류
  서브쿼리 수행결과값이 몇행 멸열인지에 따라 분류 총4개
  1.단일행 서브쿼리~ 서브쿼리 수행결과값이 오로지 한개일때
  2.다중행 서브쿼리~ 서브쿼리 수행결과값이 여러행일때(여러행 한열)
  3.다중열 서브쿼리 ~ 서브쿼리 수행결과값이 여러열일때(여러열 한행)
  4.다중행 다중열 서브쿼리 ~ 서브쿼리 수행결과값이 여러행 여러칼럼일때(여러열 여러행)
  
  >>종류에 따라 서브쿼리 앞에 붙는 연산자가 달라짐.
  
*/
--SINGLE ROW SUBQUERRY
--서브쿼리의 조회결과값의 개수가 오로지 1개일떄 (한행 한열)+비교연산자 사용가능

--1)전 직원의 평균급여보다 급여를 더 적게받는 사원명 직급코드 급여조회

SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY <(SELECT AVG(SALARY)
                 FROM EMPLOYEE);
                 
--2) 최저급여 받는 사원의 사번 이름 급여 입사일

SELECT EMP_ID, EMP_NAME, SALARY , HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                FROM employee);

SELECT EMP_ID, EMP_NAME, DEPT_CODE , SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY
                FROM employee
                WHERE EMP_NAME ='노옹철');
                
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND SALARY >(SELECT SALARY
                FROM employee
                WHERE EMP_NAME ='노옹철');

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE  SALARY >(SELECT SALARY
                FROM employee
                WHERE EMP_NAME ='노옹철');

--부서별 급여합 가장큰 부서 부서코드 , 급여합 조회

SELECT  MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT DEPT_CODE , SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT  MAX(SUM(SALARY))
                        FROM EMPLOYEE
                        GROUP BY DEPT_CODE);


--전지연 제외 전지연과 같은 부서원들의 사번 사원명 전번 입사일 부서명

SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME ='전지연';

SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND DEPT_CODE =(SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME ='전지연')
AND EMP_NAME ^= '전지연';

SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_CODE =(SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME ='전지연')
AND EMP_NAME ^= '전지연';

--------------------------------------------------------------
/* 다중행 서브쿼리
서브쿼리를 수행결과값이 여러행일떄 (칼럼은 한개)
-IN 서브쿼리 : 여러개의 결과값중에서 한개라도 일치하는 값이 있따면
- > ANY 서브쿼리 : 여러개의 결과값 중에서 한개라도 클경우
- < ANY 서브쿼리 : 여러개의 결과값 중에서 한개라도 작을경우

비교대상 > ANY(값1, 값2, 값3)
비교대상 > 값 1 OR 비교대상 > 값 2 OR 비교대상 > 값 3 
*/
--1)유재식 또는 윤은해 사원과 같은 직급인 사번 사원명 직급코드 급여
SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN ('유재식', '윤은해');

--J3,J7조회

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN (SELECT JOB_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME IN ('유재식', '윤은해'));--=으로 쓰면 오류 : 결과값이 여러행이기떄문
                    
---사원 => 대리 => 과장 => 차장 => 부장 ...
--2) 대리직급 임에도 불구하고 과장직급 급여의 최소급여보 더많이 받는 직원(사번이름직급급여)

--과장얼마받음?

SELECT SALARY
FROM EMPLOYEE E , JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND JOB_NAME ='과장';

-- 지급 대리이면서도 급여값이 위의 목록값중에 하나라도 큰 사원?
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME ='대리' 
AND SALARY > ANY  (SELECT SALARY
                FROM EMPLOYEE E , JOB J
                WHERE E.JOB_CODE = J.JOB_CODE
                AND JOB_NAME ='과장');

--과장지급임에도 차장직급 사원들의 급여보다 더 많이 받는 경우
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME ='과장' 
AND SALARY > ALL(SELECT SALARY
                  FROM EMPLOYEE E , JOB J
                  WHERE E.JOB_CODE = J.JOB_CODE
                  AND JOB_NAME ='차장');
                  
/*
다중열 서브쿼리 
결과값은 한행이지만 나열된 칼럼수가 여러개인 경우
--하이유 사원과 같은 부서코드, 같은 직급코드와 해당하는 사우너들 조회

*/

SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE 
                    WHERE EMP_NAME ='하이유')
AND JOB_CODE = (SELECT JOB_CODE
                    FROM EMPLOYEE 
                    WHERE EMP_NAME ='하이유');
-->>다중열 서브쿼리   

SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE 
WHERE (DEPT_CODE, JOB_CODE)= (SELECT DEPT_CODE, JOB_CODE
                                FROM EMPLOYEE 
                                WHERE EMP_NAME ='하이유');

SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE 
WHERE (JOB_CODE, MANAGER_ID)= (SELECT JOB_CODE, MANAGER_ID
                                FROM EMPLOYEE 
                                WHERE EMP_NAME ='박나라')   ;
                                
--4)다짬뽕 다중행다중열 서브쿼리
/*
    서브쿼리 조회결과값이 여러행 여러열인 경우    
*/
--직급별로 ~GROUP BY
--1) 직급별 최소급여를 받는 사원조회 (사번 사원명 직급코드 급여)

SELECT Job_code, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY 
FROM EMPLOYEE
WHERE JOB_CODE = 'J2' AND SALARY =3700000;

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY 
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT Job_code, MIN(SALARY)
                            FROM EMPLOYEE
                            GROUP BY JOB_CODE) ;--한줄아닐 IN 써야함 =불가

SELECT EMP_ID 사번, EMP_NAME 사원명, DEPT_CODE 부서코드, SALARY 최고급여
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, MAX(SALARY)
                            FROM EMPLOYEE
                            GROUP BY DEPT_CODE); --한줄아닐 IN 써야함 =불가