-- SCOTT_연습문제
--1. EMP테이블에서 COMM 의 값이 NULL이 아닌 정보 조회
SELECT *
FROM EMP
WHERE COMM IS NOT NULL;
--2. EMP테이블에서 커미션을 받지 못하는 직원 조회
SELECT ENAME, COMM
FROM EMP
WHERE COMM IS NULL;
--3. EMP테이블에서 관리자가 없는 직원 정보 조회
SELECT *
FROM EMP
WHERE MGR IS NULL;
--4. EMP테이블에서 급여를 많이 받는 직원 순으로 조회
SELECT *
FROM EMP
ORDER BY SAL DESC;
--5. EMP테이블에서 급여가 같을 경우 커미션을 내림차순 정렬 조회
SELECT *
FROM EMP
ORDER BY SAL DESC, COMM DESC;
--6. EMP테이블에서 사원번호, 사원명,직급, 입사일 조회 (단, 입사일을 오름차순 정렬 처리)
SELECT EMPNO, ENAME, JOB, HIREDATE
FROM EMP
ORDER BY HIREDATE ASC;
--7. EMP테이블에서 사원번호, 사원명 조회 (사원번호 기준 내림차순 정렬)
SELECT EMPNO, ENAME
FROM EMP
ORDER BY EMPNO DESC;
--8. EMP테이블에서 사번, 입사일, 사원명, 급여 조회
-- (부서번호가 빠른 순으로, 같은 부서번호일 때는 최근 입사일 순으로 처리)
SELECT EMPNO, HIREDATE, ENAME, SAL, DEPTNO
FROM EMP
ORDER BY DEPTNO ASC, HIREDATE DESC;
--9. 오늘 날짜에 대한 정보 조회
SELECT SYSDATE FROM DUAL;
--10. EMP테이블에서 사번, 사원명, 급여 조회
-- (단, 급여는 100단위까지의 값만 출력 처리하고 급여 기준 내림차순 정렬)
--SELECT EMPNO, ENAME, SUBSTR(TO_CHAR(SAL,'9999'), 1, 2)
SELECT EMPNO, ENAME, TRUNC(SAL, -2)
FROM EMP
ORDER BY SAL DESC;
--11. EMP테이블에서 사원번호가 홀수인 사원들을 조회
SELECT *
FROM EMP
--WHERE (EMPNO % 2) = 1;
WHERE SUBSTR(EMPNO,4,1) IN ('1','3','5','7','9');
--12. EMP테이블에서 사원명, 입사일 조회 (단, 입사일은 년도와 월을 분리 추출해서 출력)
SELECT ENAME, EXTRACT (YEAR FROM HIREDATE)AS 년도, EXTRACT(MONTH FROM HIREDATE) AS 월
FROM EMP;
--13. EMP테이블에서 9월에 입사한 직원의 정보 조회
SELECT *
FROM EMP
WHERE EXTRACT(MONTH FROM HIREDATE) = '9';

--14. EMP테이블에서 81년도에 입사한 직원 조회
SELECT ENAME, HIREDATE
FROM EMP
WHERE EXTRACT(YEAR FROM HIREDATE) = '1981';

--15. EMP테이블에서 이름이 'E'로 끝나는 직원 조회
SELECT *
FROM EMP
WHERE ENAME LIKE '%E'; 

--16. EMP테이블에서 이름의 세 번째 글자가 'R'인 직원의 정보 조회
--16-1. LIKE 사용
SELECT *
FROM EMP
WHERE ENAME LIKE '__R%';
--16-2. SUBSTR() 함수 사용
SELECT *
FROM EMP
WHERE SUBSTR(ENAME,3,1)= 'R'; 


--17. EMP테이블에서 사번, 사원명, 입사일, 입사일로부터 40년 되는 날짜 조회
SELECT EMPNO, ENAME, HIREDATE, ADD_MONTHS(HIREDATE, 40*12)
FROM EMP;

--18. EMP테이블에서 입사일로부터 45년 이상 근무한 직원의 정보 조회
SELECT *
FROM EMP
WHERE MONTHS_BETWEEN(SYSDATE, HIREDATE)>=456;

--19. 오늘 날짜에서 년도만 추출
SELECT EXTRACT(YEAR FROM SYSDATE) AS "오늘 날짜 년도"FROM DUAL;


