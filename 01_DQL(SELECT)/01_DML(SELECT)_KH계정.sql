/*
    <SELECT>
    데이터 조회 시 사용하는 구문
    
    >>RESULT SET : SELECT문을 통해 조회된 결과물( = 조회된 행들의 집합)
        
    [표현법]
    SELECT 조회하고자 하는 컬럼1, 컬럼2, ...
    FROM 테이블명;
    
    *반드시 존재하는 컬럼으로 써야한다. 없는컬럼 오류발생
*/

--EMPLOYEE 테이블 모든 컬럼(*) 조회
--SELECT EMP_ID, EMP_NAME , ...
SELECT * 
FROM EMPLOYEE;

--EMP 테이블의 사번, 이름, 급여 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

--JOB 테이블 모든 컬럼 조회
SELECT * 
FROM JOB;

---------------------------------------------------------
--1. JOB 테이블 직급명 조회
SELECT JOB_NAME 
FROM JOB;

--2. DEPARTMENT 테이블 모든컬럼 조회
SELECT *
FROM DEPARTMENT;

--3. DEPARTMENT 테이블 부서코드랑 부서명만 조회
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;
         
--04. EMPLOYEE 테이블 사원명, 이메일, 전화번호, 입사일, 급여조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY
FROM EMPLOYEE;

/*
    <컬럼값을 통한 산술연산>
    SELECT절 컬러명 작성부분에 산술연산 기술가능(이때, 산술연산된 결과조회)
*/

--EMPLOYEE 테이블 사원명과 사원의 연봉조회(SALARY *12)
SELECT EMP_NAME, SALARY*12
FROM EMPLOYEE;


--EMPLOYEE 테이블 사원명과 급여, 보너스 조회
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE;

SELECT EMP_NAME, SALARY, BONUS, SALARY*12, (SALARY +SALARY*BONUS)*12
FROM EMPLOYEE;
--산술연산과정중 NULL값이 존재할경우 결과값이 무조건 NULL로 반환됨, 조치해줘야하는 함수파트에서.

SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE;

--EMPLOYEE 테이블 사원명, 근무일수 (오늘날짜 -입사일) DATE 형식끼리 연산가능
SELECT EMP_NAME, HIRE_DATE, SYSDATE-HIRE_DATE
FROM EMPLOYEE;
--DATE - DATE : 결과값이 일단위 맞음
--단 값이 지저분한 이유는 DATE형식은 년일월일시분초 단위 시관관리 하기때문

/*
    컬럼명에 별칭정하기 컬렴명 별칭, 컬럼명 AS 별칭, 컬럼명 "벌칭", 컬럼명 AS "별칭"
    AS안붙여주는데 기호 혹은 특수문자있는경우는 무조건  " "붙이셈
    컬렴명 별칭 /
*/
SELECT EMP_NAME 사원명, SALARY AS 급여, SALARY*12 "연봉(원)", (SALARY +SALARY*BONUS)*12 AS "총소득(보너스)"
FROM EMPLOYEE;
-------------------------------------------------------------------
/*
    <리터럴>
    임의로 지정한 문자열('')
    SELECT절에 리터럴 제시하면 마치 테이블에 존재하는 데이터처럼 조회가능
*/
--EMPLOYEE테이블 사번, 사원명, 급여 조회

SELECT EMP_ID, EMP_NAME, SALARY, '원' AS "단위"
FROM EMPLOYEE;

/*
    <연결연산자 : || >
    여러 컬럼값을 마치 하나의 컬럼인것처럼 연결, 컬럼값과 리터럴값을 연결
*/

SELECT EMP_ID, EMP_NAME, SALARY || '원' AS "단위"
FROM EMPLOYEE;

--컬럼값과 리터럴을 연결
--xxx의 월급은 xxx원입니다. => 컬렴명 별칭 : 급여정보 

SELECT EMP_NAME || '님의 월급은 ' || SALARY || '원 입니다.' AS "급여정보"
FROM EMPLOYEE;

-------------------------------------------------------------------
--현재 우리회사 어떤직급 사람들이  존재하는지 궁금
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;
--DISTINCT 키워드는 특정 컬럼(열)에서 중복되는 값을 제거하고 
--고유한 값만을 조회할 때 사용됩니다. 결과 집합에서 중복된 행을 제거하여 유일한 값들만 출력

SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

--유의사항 DISTINCT는 SELECT 절에 한번만 기술가능

SELECT DISTINCT JOB_CODE, DEPT_CODE
FROM EMPLOYEE;
-------------------------------------------------------------------

/*
    <WHERE 절> 
    조회하고자 하는 테이블로부터 특정조건에 만족하는 데이터만 조회하고할떄 사용.
    
    다양한 연산자 사용가능 
    SELECT 컬럼1, 컬럼2
    FROM 테이블명
    WHERE 조건식; 
    
    
*/
--EMPLOYEE에서 부서코드가 'D9'인 사원만 조회
SELECT * 
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D1';
--WHERE DEPT_CODE ^= 'D1';
WHERE DEPT_CODE <> 'D1';

--부정표기 : !=, ^= ,<>

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN ='N';

-------------------------------------------------------------------
--<PRACTICE>

--1.급여 300마넌이상인사람들의 사원명 급여 입사일 연봉(보너스 미포함) 조회
SELECT EMP_NAME, SALARY, HIRE_DATE, SALARY*12 AS "연봉"
FROM EMPLOYEE
WHERE SALARY >=3000000;


--2.연봉 5000마넌이상인사람들의 사원명 급여 연봉, 부서코드 조회.

SELECT EMP_NAME, SALARY, SALARY*12 AS "연봉", DEPT_CODE
FROM EMPLOYEE
WHERE SALARY*12 >=50000000;

--쿼리실행순서 FROMW절 -> WHERE절 -> SELECT절

--3.직급코드 'J3' 아닌 사원들의 사번 사원명, 직급코드,퇴사여부 조회
SELECT EMP_NO, EMP_NAME, JOB_CODE, ENT_YN, SALARY
FROM EMPLOYEE
WHERE JOB_CODE ^= 'J3' AND SALARY >=3000000;

--부서코드가 'D9'이면서 급여가 500만원 이상의 사람들의 사번 사원명 급여 부서코드
SELECT EMP_ID,EMP_NAME,SALARY,DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY >=5000000;

SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY >=3500000 AND SALARY <=6000000;
-------------------------------------------------------------------
/*
   < BETWEEN A AND B >
   조건식에서 사용되는 구문
   몇 이상 몇 이하 범위에 대한 조건을 제시할떄 사용되는 연산자\
   컬럼값이 A이상 이고 B이하인가를 체크해줌.
*/
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY <3500000 OR SALARY >6000000;

SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE NOT SALARY BETWEEN 3500000 AND 6000000;

SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

-------------------------------------------------------------------
/*
    <LIKE>
    비교하고자하는 컬럼값이 내가 제시한 특정패턴에 만족될경우 조회
    
    [표현법]
    비교대상칼럼 LIKE '특정패턴'
    -특정패턴 제시시 '%' '_' 와일드카드로 쓸수있음
    >> '%' : 0글자이상
    EX) 비교대상 컬럼 LIKE '문자%' =>비교대상 칼럼값 이 문자로 "시작"되는걸 조회
    EX) 비교대상 컬럼 LIKE '%문자' =>비교대상 칼럼값 이 문자로 "끝"나는걸 조회
    EX) 비교대상 컬럼 LIKE '%문자%' =>비교대상 칼럼값에 문자가 "포함"되는걸 조회
    >>'_' : 1글자이상
    EX)비교대상 컬럼 LIKE '_문자%'=> 비교대상 컬럼값의 문자앞에 무조건 한글자 와야함.
    EX)비교대상 컬럼 LIKE '__문자%'=> 비교대상 컬럼값의 문자앞에 무조건 두글자 와야함.
    EX)비교대상 컬럼 LIKE '_문자_%'=> 비교대상 컬럼값의 문자앞뒤에 무조건 한글자씩 와야함.
*/
                                                                                                                              
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_하_';

SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '__1%';

--**특이케이스
--이메일중 _기준으로 앞글자 3글자인 사원들의 사번 이름 이메일조회
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE NOT EMAIL LIKE '___$_%' ESCAPE '$';--원했던 결과 아님
--어떤게 와이들카드고 문자인지 구분이 없다보니 다 와일드카드로 인식됨.
--데이터 값으로 취급하고자 하는 값앞에 나만 와일드카드를 제시하고, ESCAPE OPTION으로 등록해야함.

----실습문제---------------
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE NOT PHONE LIKE '__0%';

SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%' AND SALARY >= 2400000;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '해외%';
