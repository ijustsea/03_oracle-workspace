/*
<함수 FUNCTION>
전달된 컬럼값을 읽어들여서 함수실행한결과를 반환

-단일행 함수 : N개 값을 읽어들여서 N개 결과값 리턴
-그룹 함수 : N개 값을 읽어들여서 1개 결과값 리턴

>>SELECT 절에 단일행함수랑 그룹함수 함꼐 사용 못함 : 결과 행의 개수가 달라서 

>>함수 사용위치 : SELECT, WHERE, ORDER BY, GROUP BY, HAVING
*/

--문자처리함수 
--LENGTH/ LENGHB => 결과값 NUMBER타입
--LENGTH(컬럼| '문자열') : 해당 문자열값의 글자수 반환
--LENGTHB(컬럼| '문자열') : 해당 문자열값의 바이트수 반환
--한글 3BYTE | 영문,숫자 1BYTE

SELECT SYSDATE FROM DUAL;
SELECT LENGTH('안녕'), LENGTHB('안녕')FROM DUAL;
SELECT LENGTH('TREE'), LENGTHB('TREE')FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE;  --매행마다 다 실행되고 있음 : 단일행함수

/*
    *INSTR
    문자열로부터 특정문자의 시작위치를 찾아서 반환
    INSTR(컬럼|'문자열','찾고자하는 문자', ['찾을위치시작값', 순번] : 결과값은 NUBMER    
    찾을 위치 시작값 
    1:앞에서부터, -1: 뒤에서부터
*/

SELECT INSTR('AABAACABBAA', 'B') FROM DUAL;
SELECT INSTR('AABAACABBAA', 'B', 1) FROM DUAL;
SELECT INSTR('AABAACABBAA', 'B', -1) FROM DUAL;
SELECT INSTR('AABAACABBAA', 'B', 1,2) FROM DUAL;


SELECT EMAIL, INSTR(EMAIL, '_', 1, 1) AS "_의 위치 ", INSTR(EMAIL, '@') AS "@의 위치 "
FROM EMPLOYEE;

/*
    "SUBSTR
    문자열에서 특정 문자열을 추출해서 반환
*/

SELECT SUBSTR ('SHOWMETHEMONEY', 5, 2 )FROM DUAL;

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8,1) AS "성별"
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO, 8,1) = '2';
--WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');--여자만
WHERE SUBSTR(EMP_NO, 8, 1) IN (1, 3);--남자만1

--함수중첩

SELECT EMP_NAME, EMAIL, SUBSTR (EMAIL , 1, INSTR(EMAIL, '@')-1)AS 아이디
FROM EMPLOYEE;

/*
    LPAD / RPAD : 문자열 조회시 통일감있게 조회할때 사용(LEFT, RIGHT)
    
    LPAD / RPAD(STRING, 최종적으로 반환할 문자길이 , [덧붙이고자하는 문자])
*/

SELECT EMP_NAME, EMAIL, LPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT EMP_NAME, EMAIL, LPAD(EMAIL, 20, '-')
FROM EMPLOYEE;

SELECT EMP_NAME, EMAIL, RPAD(EMAIL, 20, '-')
FROM EMPLOYEE;

SELECT RPAD(SUBSTR(EMP_NO,1,8), 14 , '*' )AS 주민번호
FROM EMPLOYEE;

/*
    LTRIM RTRIM
    문자열에서 특정문자 제거하고 나머지 반환
    
    LTRIM RTRIM(STRING, [제거할문자들 ] ) --생략하면 공백제거
*/

SELECT LTRIM('    K H ') FROM DUAL;
SELECT RTRIM('    K H ') FROM DUAL;

SELECT LTRIM('ACABACCKH', 'ABC' ) FROM DUAL;
SELECT RTRIM('5782KH123', 0123456789) FROM DUAL;
-- 'ABC' MEAN A OR B OR C 제거
/*
    TRIM (STRING) 문자열 앞뒤 양쪽에있는 지정한 문자들을 제거하고 반환
*/

SELECT TRIM('      BC        DF    ') FROM DUAL;
SELECT TRIM ('Z' FROM 'ZZZZZKHZZZZ') FROM DUAL;
SELECT TRIM (LEADING 'Z' FROM 'ZZZZZKHZZZZ') FROM DUAL;
SELECT TRIM (TRAILING 'Z' FROM 'ZZZZZKHZZZZ') FROM DUAL;
SELECT TRIM (BOTH 'Z' FROM 'ZZZZZKHZZZZ') FROM DUAL;

/*
    LOWER UPPER INITCAP
    LOWER UPPER INITCAP (SPRING) => 반환형 CHARACTER 타입
*/

SELECT LOWER('Welcome To The Show')
FROM DUAL;
SELECT INITCAP('welcome to the show')from dual;--단어앞글자마다 대문자.

/*
    concat 문자열 두개 전달 받아서 합쳐서 반환
    
    CONCAT(STRING1, STRING2) => STRING 반환
*/

SELECT CONCAT('ABC', 'CHOCOLATE') FROM DUAL; 
SELECT 'ABC' || 'CHOCOLATE' FROM DUAL; 

--SELECT CONCAT('ABC', 'CHOCOLATE', 'DELICOUS') FROM DUAL; 2개이상이면 오류발생.
SELECT 'ABC' || 'CHOCOLATE' || 'DELICOUS'FROM DUAL;

/*
    REPLACE
    REPLACE(컬럼명, STR1, STR2)
*/

SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr', 'naver.com') as 이메일
FROM EMPLOYEE;

------------------------------------------------------
/*
    <숫자처리함수>
    ABS :  절대값 반환해줌 
    ABS(NUMBER)
 */   
 
 SELECT ABS(-55) FROM DUAL;
 
 --MOD 두수 나눈 나머지값 반환
 SELECT MOD(10.7, 3) FROM DUAL;
 --ROUND 반올림값 반환
 SELECT ROUND(10.7) FROM DUAL;
 SELECT ROUND(123.456, 2) FROM DUAL;--위치지정가능. 디폴트는 소수점 0번
 --CEIL 올림값 반환
 SELECT CEIL(10.7) FROM DUAL; 
 --FLOOR 버림값 반환
 SELECT FLOOR(10.7) FROM DUAL; 
 --TRUNC 위치지정가능한 버림처리해주는 함수. 생략시 FLOOR처럼됨
 SELECT TRUNC(10.76543 , 2) FROM DUAL;--2번째자리까지만.
 
------------------------------------------------------
/*
    <날짜처리함수>
    SYSDATE : 시스템 날짜및 시간반환     
*/   
 SELECT SYSDATE FROM DUAL;
 
 --MONTHS_BETWEEN (DATE1, DATE2) : 두날짜사이의 개월수 반환
 SELECT EMP_NAME, HIRE_DATE, CEIL(MONTHS_BETWEEN(SYSDATE,HIRE_DATE))||'개월'AS 근무개월수
 FROM EMPLOYEE;
 
 --ADD_MONTHS(DATE, NUMBER) 특정날짜에 해당숫자만큼개월수 더해서 알려줌
 SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 3) AS "수습끝난날"
 FROM EMPLOYEE;
 
 --NEXTDAY(DATE,요일) :  해당날짜이후 가장 가까운 요일의 날짜를 반환
 --SELECT SYSDATE, NEXT_DAY(SYSDATE, '화')  FROM DUAL; --일 1 월2 화3
 SELECT SYSDATE, NEXT_DAY(SYSDATE, 3)  FROM DUAL;
 
 --LAST_DAY(DATE) :해당월 마지막 날짜 구해서 반환
 SELECT LAST_DAY(SYSDATE) FROM DUAL;
 --사원명, 입사일, 입사한달의 마지막날짜.
 SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE), LAST_DAY(HIRE_DATE)-HIRE_DATE AS "입사달 근무일수" 
 FROM EMPLOYEE;
 
 --EXTRACT 특정날짤고부터 년도 월 일 값을 추출해서 반환
 
 --EXTRACT(YEAR FROM DATE) 년도만 추출
 --EXTRACT(MONTH FROM DATE) 월만 추출
 --EXTRACT(DAY FROM DATE) 일만 추출
 
SELECT EMP_NAME, 
EXTRACT (YEAR FROM HIRE_DATE)AS 입사년도, 
EXTRACT (MONTH FROM HIRE_DATE)AS 입사월, 
EXTRACT (DAY FROM HIRE_DATE)AS 입사일 
FROM EMPLOYEE
ORDER BY 입사년도, 입사월, 입사일;
 
 --형변환 함수 
 --TO_CHAR: 숫자 날짜 타입의값을 문자타입으로 변환시켜주는 함수 
 --TO_CHAR(숫자(날짜), 포멧)
 
 SELECT TO_CHAR(1234) FROM DUAL;
 SELECT TO_CHAR(1234, '9999999L') FROM DUAL;
 SELECT TO_CHAR(1234, '9999999$') FROM DUAL;
 SELECT TO_CHAR(1234, 'L99,999') FROM DUAL;--9SMSWKFLFMF SKXKSMSMSROSUA.
 
 SELECT EMP_NAME, TO_CHAR(SALARY, 'L999,999,999') FROM EMPLOYEE;

--날짜타입_>문자타입

SELECT TO_CHAR(SYSDATE) FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL;


SELECT EMP_NAME, HIRE_DATE, LPAD(TO_CHAR(HIRE_DATE, 'YYYY-MM-DD'), 15, ' ')
--SELECT EMP_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'YYYY"년"-MM"월"-DD"일"')
FROM EMPLOYEE;

--년도와 관련된 포맷 
SELECT TO_CHAR(SYSDATE, 'YYYY'),
       TO_CHAR(SYSDATE, 'YY'),      
       TO_CHAR(SYSDATE, 'RRRR'),
       TO_CHAR(SYSDATE, 'RR'),
       TO_CHAR(SYSDATE, 'YEAR')
        FROM DUAL;
 --월과 관련된 포맷
 SELECT TO_CHAR(SYSDATE, 'MM'),
       TO_CHAR(SYSDATE, 'MON'),      
       TO_CHAR(SYSDATE, 'MONTH'),
       TO_CHAR(SYSDATE, 'RM')       
        FROM DUAL;
 --일에 관련된 포맷
 SELECT TO_CHAR(SYSDATE, 'DDD'), --올해기준으로 오늘몇일쨰
       TO_CHAR(SYSDATE, 'DD'), --월 기준으로 오늘 몇일쨰     
       TO_CHAR(SYSDATE, 'D') --주 기준으로 오늘 몇일쨰
       FROM DUAL;
 
 --요일 포맷 
 SELECT TO_CHAR(SYSDATE, 'DAY'),
       TO_CHAR(SYSDATE, 'DY')       
        FROM DUAL;      
    
 --형변환 함수에 숫자나 날짜를 넣어주면 문자로 바꿔줌.     
 
 /*
    TO_DATE : 숫자나 문자를 날짜타입으로 변환
    TO_DATE(숫자|문자 , [포멧])
 */
 SELECT TO_DATE(20100101) FROM DUAL;
 SELECT TO_DATE(100101) FROM DUAL;
 SELECT TO_DATE('070101') FROM DUAL;--에러 첫글자가 0이라서 따옴표로 묵어줘야함

 SELECT TO_DATE('041030 143000', 'YYMMDD HH24MISS') FROM DUAL;
 SELECT TO_DATE('140630', 'YYMMDD') FROM DUAL;--2014
 SELECT TO_DATE('980630', 'YYMMDD') FROM DUAL;--2098 : 무조건 현재세기로 반영
 
 SELECT TO_DATE('140630', 'RRMMDD') FROM DUAL;--2014
 SELECT TO_DATE('980630', 'RRMMDD') FROM DUAL;--1998 
 --RR : 해당 두자리 년도 값이 50미만일경우 현제세기 반영, 50일 이상일 경우 이전세기 반영
 
 --웹상에서 날짜의 데이터를 넘겨도 무조건 문자로 넘어옴!
 
 /*
    TO_NUMBER : 문자타입의 데이터를 숫자탕빕으로 변환시켜주는 함수
    
 */
 
 SELECT TO_NUMBER('014151661344') FROM DUAL;
 SELECT TO_NUMBER('1000000'+ '5500000') FROM DUAL;
 
 SELECT TO_NUMBER('1,000,000', '9,999,999')+ TO_NUMBER('55,000', '99,999') FROM DUAL;
 
 /*
    <널처리함수>
*/

--NVL(컬럼, 해당컬럼값이 NULL일경우 반환될값)
SELECT EMP_NAME, BONUS, NVL(BONUS, 0)
FROM EMPLOYEE;
 
 --이름, 보너스 포함 연봉
SELECT EMP_NAME, BONUS, (SALARY + SALARY*NVL(BONUS,0)) *12
FROM EMPLOYEE;
 
 SELECT EMP_NAME, NVL(DEPT_CODE, '부서없음')
 FROM EMPLOYEE;
  
 -- NVL2(컬럼, 반환값1, 반환값2)
 -- 컬럼값이 존재한경우 반환값1 반환, 
 -- 컬럼값이 NULL이면 반환값2 반환, 삼항연산자와 유사
 
 SELECT EMP_NAME, BONUS, NVL2(BONUS, 0.7, 0.1)
 FROM EMPLOYEE;

 SELECT EMP_NAME, NVL2(DEPT_CODE, '부서있음', '부서없음')
 FROM EMPLOYEE;

--NULLIF(비교대상1, 비교대상2)
--두개값 일치시 NULL반환 , 두개값 일치하지 않으면 비교대상1 값 반환
 
 SELECT NULLIF('123', '123456') FROM DUAL;
 -------------------------------------------------------------------------------------
 --선택함수 DECODE~ 스위치문과 유사
 
 SELECT EMP_ID, EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1), 
 DECODE (SUBSTR(EMP_NO, 8, 1), '1','남','2','여')AS "성별"
 FROM EMPLOYEE;
 
 --직원의 급여조회시 각 직그별로 인상해서 조회
 --J7사원은 급여를 10프로 인상 (SALARY *1.1)
 --J6사원은 급여를 15프로 인상 (SALARY *1.15)
 --J5사원은 급여를 20프로 인상 (SALARY *1.2) 
 --이외의 사람들은 급여 5프로 인상 (SALARY *1.05)
 
 SELECT EMP_NAME, JOB_CODE, SALARY AS "기존급여", 
        DECODE(JOB_CODE, 'J7', SALARY*1.1, 'J6', SALARY*1.15, 'J5', SALARY*1.2,SALARY*1.105) AS "인상된급여"
        
 FROM EMPLOYEE;
 /*
 CASE WHEN THEN 
 
 CASE   WHEN 조건식1 THEN 결과값1
        WHEN 조건식2 THEN 결과값2
        ....
        ELSE 결과값 N
 END
 
 */
 
 SELECT EMP_NAME, SALARY, 
    CASE WHEN SALARY >= 5000000 THEN '고급개발자'
        WHEN SALARY >= 3500000 THEN '중급개발자'
        ELSE '초급개발자 '
     END AS 레벨
     FROM EMPLOYEE;
 ------------------------------------
 --1. SUM(숫자타입컬럼) : 해당 컬럼 값들의 총 합계 구해서 반환 해줌 (그룹함수)
 
 --전체 사원의 총 급여
 SELECT SUM(SALARY)
 FROM  EMPLOYEE
 WHERE SUBSTR(EMP_NO, 8, 1)  IN ('1','3');
 
 SELECT SUM(SALARY*12 )
 FROM EMPLOYEE
 WHERE DEPT_CODE ='D5';
 
 --2. AVG(숫자타입) : 해당칼럼값들의 평균값 구해서반환
 SELECT ROUND(AVG(SALARY))
 FROM EMPLOYEE;
 --3. MIN(여러타입가능) : 해당 칼럼값들 중 가장 작은 값 구해서 반환
SELECT MIN(EMP_NAME)
FROM EMPLOYEE;
--4. MAX(여러타입가능) : 해당 칼럼값들 중 가장 큰 값 구해서 반환

SELECT MAX(EMP_NAME)
FROM EMPLOYEE;

--COUNT (*| 컬럼 | DISTINCT 컬럼) : 조회된 행 개수를 세서 반환
--COUNT(*) : 조회된결과의 모든 행개수 반환
--COUNT(컬럼) : 제시한 해당 컬럼값이 NULL이 아닌것만 핻개수세서 반환

--전체사원수 
SELECT COUNT(*)
FROM EMPLOYEE;


--보너스 받는 사원수 
SELECT COUNT(BONUS)
FROM EMPLOYEE;

--남자중 보너스 받는 사원수.
SELECT COUNT(BONUS)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO , 8, 1) IN ('1', '3');

--여자중 보너스 받는 사원수.
SELECT COUNT(BONUS)
FROM EMPLOYEE
WHERE NOT (SUBSTR(EMP_NO , 8, 1) IN ('1', '3'));

--부서배치 몇명 인지구하는
SELECT COUNT(DEPT_CODE)--NULL은자동으로 뺴줌.
FROM EMPLOYEE;
                                                                     
--COUNT(DISTINCT 컬럼) : 컬럼에서 중복값 제거한 후 행개수 반환 (컬럼값 종류 개수알수있음) 
SELECT COUNT(DISTINCT DEPT_CODE)--NULL은자동으로 뺴줌.
FROM EMPLOYEE;

