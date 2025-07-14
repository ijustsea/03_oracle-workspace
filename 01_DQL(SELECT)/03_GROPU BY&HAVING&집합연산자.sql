/*
<GROUP BY 절>
그룹 기준을 제시할수있는 구문(해당그룹기준별로 여러 그룹을 묶을수있음)
여러개의 값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용
*/

SELECT SUM(SALARY)
FROM EMPLOYEE;--전체사원을 하나의 그룹으로 묶어서 총합을 구한 결과.

--각 부 서별 총 급여합
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC;

--각부서별 사원수
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC;

SELECT DEPT_CODE, SUM(SALARY)--(3)
FROM EMPLOYEE--(1)
GROUP BY DEPT_CODE--(2)
ORDER BY DEPT_CODE ASC;--(4)

SELECT JOB_CODE, COUNT(*), SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE ASC;

--각직급별 총사원수 , 보너스를 받는 사원수 , 급여합게 , 평균급여, 최저급여 , 최대급여
SELECT JOB_CODE, COUNT(*) AS 총사원수, COUNT(BONUS) AS 보너스받는사원수, SUM(SALARY)AS 급여합계, FLOOR(SUM(SALARY)/ COUNT(*)) AS 급여평균,FLOOR(AVG(SALARY)) AS 급여평균, MIN(SALARY) AS 최소급여, MAX(SALARY) AS 최대급여
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE ASC;

--그룹바이절에 함수식 기술가능.
SELECT DECODE(SUBSTR(EMP_NO, 8,1), '1', '남','2', '여')AS 성별, COUNT(*) AS 인원수
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8,1);

--그룹바이절에 여러 컬럼 동시에 기술가능
SELECT DEPT_CODE, JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE--같은부서면서도 같은 직급끼리모여
ORDER BY 1;

---------------------------------------------------------

/*
<HAVING 절>
그룹에 대한 조건을 제시할때 사용되는 구문(주로 그룹함수식 가지고 조건 제시할때 사용
*/

--부서별 평균급여가 300마넌 이상인 부서만 보고싶음.
SELECT DEPT_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE
--WHERE AVG(SALARY) >=3000000 -- 그룹함수 가지고 조건제시시 WHERE절은 불가능. 그룹 함수가 안되는게 핵심.
GROUP BY DEPT_CODE
ORDER BY 1;

SELECT DEPT_CODE, FLOOR(AVG(SALARY))--(4)
FROM EMPLOYEE--(1)
GROUP BY DEPT_CODE--(2)
HAVING AVG(SALARY) >=3000000--(3)
ORDER BY 1;--(5)

--직급별 총 급여함(직그별 급여합이 1000마넌 이상인 직급만 조회
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY)>=10000000
ORDER BY 1;

--부서별 보너스 받는 사원이 없는 부서만을 조회(부서코드, 보너스 몇명 받는지?)

SELECT DEPT_CODE, COUNT(0)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) =0;

--------------------------------------------------------
/*
<실행순서> 
SLECT *|조회하고자 하는 컬럼 | 산술식 "별칭" |함수식 AS "별칭"--(5)
FROM 조회하고자 하는 테이블명--(1)
WHERE 조건식(연산자 활용)--(2)
GROUP BY 그룹기준을 삼을 컬럼 | 함수식--(3)
HAVING 조건식 (그룹함수가지고 기술)--(4)
ORDER BY 컬럼명| 별칭|순번 [ASC|DESC][NULLS FIRST| NULLS LAST];--(6)

*/
--------------------------------------------------------
/*
그룹별 산출된 결과값 에 중간 집계를 계산해주는 함수 
ROLLUP
*/

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)-- 통계산출 기능.
ORDER BY 1;

------------------------------------------------------------
/*
<집합연산자-SET OPERATOR>~ 각쿼리문의 셀렉절의 컬럼개수가 동일해야함.

여러개의 쿼리문을 가지고 하나의쿼리문을 만드는 연산자
UNION : OR 합집합 (두 쿼리문 수행한 결과값 을 더한후 중복값은 한번만)
INTERSECT : AND 교집합 (두 쿼리문 수행한 겨롸값에 중분된 결과값) 
UNION ALL : 합집합+ 교집합 (중복되는 부분이 두번 표현될수있따.)
MINUS : 차집합  (선행된결과값에서 후행 결과값을 뺸 나머지)

*/

--1.UNION
--부서코드가 D5인사원 또는 급여가 300마넌 초과인 사원들 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE =  'D5';

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >=  3000000 OR DEPT_CODE =  'D5';
--UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE =  'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >=  3000000;

--INTERSECT 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE =  'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >=  3000000;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE =  'D5' AND SALARY >=  3000000;\
--ORDER BY는 마지막에 딱한번만 기술한다. 가장마지막에.

--3.UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE =  'D5'
UNION ALL --중복값 그냥 나옴 2번씩
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >=  3000000;

--4. MINUS : 차집합  선행 SELECT 결과에서 후행 SELECT 결과를 뺸나머지
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE =  'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >=  3000000;
