/*QUIZ*/

--1--보너스는 안받지만 부서배치는 된 사원 조회
select *
from employee
where bonus is null and dept_code is not null;
--null값에 대해 정상적인 비교안되고있음 null값은 비교연산자루 하는게 아니라 is절 

--2--job_code J7 OR J 6 IN절 SALALRY 200마넌이상
--BONUS 있고 이메일 주소 앞에 3글자만 있는 여자 사원
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS, EMAIL
FROM EMPLOYEE
WHERE JOB_CODE IN ('J7','J6') AND SALARY >= 2000000 AND BONUS IS NOT NULL
AND SUBSTR(EMP_NO, 8, 1) IN ('2','4') AND EMAIL LIKE '___$_%' ESCAPE '$';

--연산자 우선순위에 따라 AND가 OR보다 우선실행된다.
--와일드 카드를 제시해야하고 ESCAPE옵션으로 등록해야함.

--3--
--계정생선구문
--CREATE USER 계정명 IDENTIFEID BY 비밀번호
--계정명 SCOTT 비밀번호 TIGER 계정생성
--이때 일반사용자 계정인 KH계정에 접소
--CREATE USER SCOTT;

--문제점1.사용자 계정생성은 관리자 계정에서만 가능
--문제점2.SQL 문이 잘못되었음 비밀번호도 입력해야함

--조치내용1.관리자 계정에 접속한다.
--조치내용2.CREATE USER SOCTT INDETIFED BY TIGER;

--위의 SQL 문 실행후 접속을 만들어서 접속을 하려고 했더니 실패,
--뿐만아니라 해당계정에 테이블 생성도 되지않음!. 왜그럴까?

--문제점1, 사용자 계정 생성후 최소한의 권한 부여가 안됐따.
--조치내용1.GRANT CONNECT, RESOURCE TO SCOTT




