/*
   < PL/SQL ~ JAVA 같은 개념 > 
    PROCEDURE LANGUAGE EXTENSION TO SQL 
    SQL확장한 절차적언어. 오라클자체 내장되어있음.
    SQL문장에서 변수의 정의,조건(IF문),반복(FOR문)처리 등을 지원함
    다수의 SQL문 한번에 실행가능(BLOCK 구조) + 예외처리 가능
    
    *PL / SQL 구조
    -[선언부] : DECLARE로 시작, 변수|상수 선언 및 초기화    
    -실행부   : BEGIN으로 시작, 생략불가능, SQL문 또는 제어문(조건,반복)등의 로직기술
    -[예외처리부] : EXCEPTION으로 시작, 예외발생시 해결하는 구문 미리 작성    
    
*/
--*간단하게 회면에 HELLO ORACLE 출력
SET SERVEROUTPUT ON ;--CONSOLE키기


BEGIN 
    --System.out.println("HELLO ORACLE");
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;--END 필수
/
--다음 프로시저와 구분자역할

/*
1.DECLARE 선언부
변수및 상수 선언하는 공간 (선언과 동시에 초기화도 가능)
일바타입 변수, 레퍼런스 타입변수, ROW 타입변수
1-1)일반타입 변수 선언및 초기화
    [표현식] 변수명 [CONSTANT] 자료형 =값
*/

DECLARE 
    EID NUMBER;
    ENAME VARCHAR(20);
    PI CONSTANT NUMBER := 3.14;
BEGIN
    --EID := 800;
    --ENAME := '주지훈';
    EID := &번호;
    ENAME := '&이름';
    
    DBMS_OUTPUT.PUT_LINE('EID :'||EID);
    DBMS_OUTPUT.PUT_LINE('ENAME :'||ENAME);
    DBMS_OUTPUT.PUT_LINE('PI :'||PI);    
END;
/

-----------------------------------------------------------
--1_2) 레퍼런스 타입 변수 선언및 초기화(어떤 테이블의 어떤 컬럼의 데이터탑을 참조해서 그타입으로 지정) 
    --[표현식] 변수명 테이블.컬러명&TYPE;

--레퍼런스타입변수

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN 
    --EID := '300';
    --ENAME := '김시연';
    --SAL := 3000000;
    
    --사번200번의 사번 사원명 급여 변수에 대입
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID,ENAME,SAL
    FROM EMPLOYEE
    WHERE EMP_ID= &사번;    
    
    DBMS_OUTPUT.PUT_LINE('EID : '||EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : '||SAL);
END;
/

------------------------------실습문제------------------------------
/*
레퍼런스타입변수 EID, ENAME, JCODE, SAL, DTITLE을선언하고
각각자료형은 레퍼런스로 

사용자가 입력한 사번의 사원의 사번, 사원명,직급코드 급여, 부서명 조회한후 각 변수에 담아서 출렬

*/
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE JOB.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
    INTO EID, ENAME, JCODE, SAL, DTITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE= DEPT_ID)
    JOIN JOB USING(JOB_CODE)
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('EID : '||EID);
    DBMS_OUTPUT.PUT_LINE('NAME : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('JOB : '||JCODE);
    DBMS_OUTPUT.PUT_LINE('SAL : '||SAL);
    DBMS_OUTPUT.PUT_LINE('DTITLE : '||DTITLE);
END;
/
----------------------------------------------------------------------
--1-3) ROW 타입 변수 선언
--     테이블의 한행에 대한 모든 컬럼값을 한꺼번에 담을수있는 변수
--     [표현식] 변수명 테이블명%ROWTYPE;

DECLARE 
    E EMPLOYEE%ROWTYPE;

BEGIN 
    SELECT *
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID =&사번;
    
    DBMS_OUTPUT.PUT_LINE('사원명 : '||E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : '||E.SALARY);
    DBMS_OUTPUT.PUT_LINE('보너스 : '||NVL(E.BONUS, 0));
    DBMS_OUTPUT.PUT_LINE('직업코드 : '||E.JOB_CODE);
END;
/
--2.BEGIN 실행부 
--<조건문>
/*
1)IF 조건식 THEN 실행 내용 END IF; (단독 IF문)
--사번 입력받은 후 해당사원의 사번 이름 급여 보너스율(%) 출력
--단 보너스를 받지 않는 사람은 보너스율 출력전 보너스를 지급받지 않는 사원입니다.출력
*/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID =&사번;
    
    DBMS_OUTPUT.PUT_LINE('사번 : '||EID);
    DBMS_OUTPUT.PUT_LINE('이름 : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('급여 : '||SALARY);
   
    
    IF BONUS =0
        THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지않는 사람입니다.');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('보너스율 : '||BONUS*100||'%');
    
END;
/
--2 IF 조건식 THEN 실행내용 ELSE 실행내용 END IF;

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID =&사번;
    
    DBMS_OUTPUT.PUT_LINE('사번 : '||EID);
    DBMS_OUTPUT.PUT_LINE('이름 : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('급여 : '||SALARY);
   
    
    IF BONUS =0
        THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지않는 사람입니다.');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('보너스율 : '||BONUS*100||'%');
    END IF;    
    
END;
/
--실습문제
--레퍼런스타입 변수 EID,ENAME, DTITLE, NCODE
--참조할테이블 EMPLOYEE, DEPARTMENT, LOCATION
--일반타입 변수(TEAM문자열) => 이따가 국내팀 혹은 해외팀 담길예정

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    TEAM VARCHAR(20);    
BEGIN
--사용자가 입력한 사변이 가지고 있는 사원의 사번, 이름 , 부서명, 근무국가코드 조회후 각변수에 대입 
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE= DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID= LOCAL_CODE)
    JOIN NATIONAL USING(NATIONAL_CODE)
    WHERE EMP_ID=&사번;

    DBMS_OUTPUT.PUT_LINE('사번 : '||EID);
    DBMS_OUTPUT.PUT_LINE('이름 : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('부서명 : '||DTITLE);
    
    IF NCODE='KO'        
        THEN TEAM :='국내팀';        
    ELSE
        TEAM :='해외팀';        
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('소속 : '||TEAM);

--IF NOCODE KO 일경우 국내팀 TEAM에 그게아닐 경우 해외팀

--사번 이름 부서명 소속, 

END;
/


--3) IF 조건식1 THEN 실행내용1  ELSIF 조건식2 THEN 실행내용2  ELSE 실행내용3 END IF;

--점ㅈ수를 입력받아 SCORE 변수에 저장
--90점 이상은 'A 80점 이상은 'B' 70점이상은 'C'60점이상은 'D' 60점미만은 F
--GRADE 변수에9저장
--당신의점수는 XX점이고 학점은 X입니다.

DECLARE
    SCORE NUMBER;
    GRADE VARCHAR2(1);
    
BEGIN
    SCORE := &점수;
    
IF SCORE >=90 THEN GRADE:= 'A';
ELSIF SCORE >=80 THEN GRADE:= 'B';    
ELSIF SCORE >=70 THEN GRADE:= 'C';  
ELSIF SCORE >=60 THEN GRADE:= 'D';  
ELSE GRADE :='F';
END IF;

DBMS_OUTPUT.PUT_LINE('당신의 점수는 '||SCORE||'점이고,학점은 '||GRADE||'입니다.');

END;

/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    GRADE VARCHAR2(20);
BEGIN
    SELECT EMP_ID, SALARY
    INTO EID, SAL
    FROM EMPLOYEE
    WHERE EMP_ID =&사번;
    
    IF SAL>=5000000 THEN GRADE := '고급';
    ELSIF SAL>=3000000 THEN GRADE := '중급';
    ELSE  GRADE := '초급';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('해당사원의 급여등급은 '||GRADE||'입니다.');
END;
/
--4) case 비교대상자 when 동등비교값 then 결과괎1 when 동등비교할값 2 then 결과값 ....else 결과값n end;

DECLARE
    EMP EMPLOYEE %ROWTYPE;
    DNAME VARCHAR2(30); --부서명 보관변수 
BEGIN
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID=&사번;
    
    DNAME := CASE EMP.DEPT_CODE 
                  WHEN 'D1' THEN '인사팀'
                  WHEN 'D2' THEN '회계팀'
                  WHEN 'D3' THEN '마케팅팀'
                  WHEN 'D4' THEN '국내영업팀'                                
                  WHEN 'D9' THEN '총무팀'
                  ELSE '해외영업팀'   
    END;
    
DBMS_OUTPUT.PUT_LINE(EMP.EMP_NAME ||'은(는)'||DNAME||'입니다');    

END;
/

--1. 연봉구하는 프로시저
--보너스있는 사원은 보너스 포함해서 계산
--보너스 있으면 보너스포함연봉 없으면 보너스 미포함 연봉
--급여, 이름, \999,999,999 연봉

DECLARE
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;    
BEGIN
    SELECT EMP_NAME, NVL(BONUS,0), SALARY
    INTO ENAME, BONUS, SALARY
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;

DBMS_OUTPUT.PUT_LINE(SALARY||', '||ENAME ||', '|| TO_CHAR((SALARY*(1+BONUS)*12), 'L999,999,999')); 

END;
/
-------------------------------------------------------------------------
--<반복문>

/*
 1) BASIC LOOP문
 [표현식]
 LOOP 
    반복적으로 실행할 구문
    *반복문 빠져나갈수있는 구문
 END LOOP;
    
    *반복문 빠져나가는 구문
    1)IF 조건식 THEN EXIT;
    2)EXIT WHEN 조건식;
    
*/
 
--1~5까지 순차적으로 1씩증가
DECLARE 
    I NUMBER :=1;    
BEGIN
    LOOP 
        DBMS_OUTPUT.PUT_LINE(I);
        I :=I+1;
        
        --IF I = 6 THEN EXIT; END IF;
        EXIT WHEN I =6;
    END LOOP;
END;
/

/*
    2)FOR LOOP 문
    표현식
    FOR 변수 IN 초기값 ..최종값
    LOOP
        반복실행구문
    END LOOP;
*/
BEGIN
    FOR I IN REVERSE 1..5 --REVERSE 반대로
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;

END;
/
DROP TABLE TEST;

CREATE TABLE TEST(
    TNO NUMBER PRIMARY KEY,
    TDATE DATE

);

SELECT * FROM TEST;

CREATE SEQUENCE SEQ_TNO
START WITH 1
INCREMENT BY 2
MAXVALUE 100
NOCYCLE
NOCACHE;                                       


BEGIN 
    FOR I IN 1..50
    LOOP
       INSERT INTO TEST VALUES (SEQ_TNO.NEXTVAL, SYSDATE);
    END LOOP;
END; 
/
/*
3) WHILE LOOP문
    [표현식]
    WHILE 반복문이 수행될 조건
    LOOP 
        반복적으로 실행할구문
    END LOOP;
*/

DECLARE 
    I NUMBER :=1;    
BEGIN 
    WHILE I <6
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        I:=I+1;
    END LOOP;
END;
/
-------------------------------------------------------------------------------------
--3.예외처리부
--예외 EXCEPTION : 실행중 발생하는 오류
--[표현식]
/*
EXCEPTION 
    WHEN 예외명1 THEN 예외처리구문 1;
    WHEN 예외면2 THEN 예외처리구문 2;
    ...
    WHEN 예외명N THEN 예외처리구문 N;

    예외의 종류
    *시스템 예외(오라클에서 미리정의해둠)
    -NO_DATA_FOUND : SELECT 결과가 한행도 없는경우
    -TOO_MANY_RESULT : SELECT 결과가 여러행인 경우
    -ZERO_DIVIDE : 0으로 나누려 할때 
    -DUP_VAL_ON_INDEX : UNIQUE 제약조건 위배 될떄
*/
--ZERO_DIVIDE
DECLARE 
    RESULT NUMBER;
BEGIN
    RESULT :=10/&숫자;
    DBMS_OUTPUT.PUT_LINE('결과 : '||RESULT);
EXCEPTION 
    --WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('나누기 연산시 0으로 나눌수없습니다.');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('나누기 연산시 0으로 나눌수없습니다.');
    
END;
/
--UNIQUE 제약조건
BEGIN 
    UPDATE EMPLOYEE
    SET EMP_ID=&변경할사번
    WHERE EMP_NAME ='노옹철';
EXCEPTION 
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('이미존재하는 사번입니다.');
    --WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('이미존재하는 사번입니다.');
END;
/

DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME %TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME
    INTO EID, ENAME
    FROM EMPLOYEE
    WHERE MANAGER_ID =&사수사번; -- 202  NO DATA, 200 TOO MANY, 211 장쯔위
    
    DBMS_OUTPUT.PUT_LINE('사번 : '|| EID);
    DBMS_OUTPUT.PUT_LINE('이름 : '|| ENAME);
    
EXCEPTION 
    WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('너무많은 행이 조회되었습니다.');
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('해당 사수를 가진 사원이 없습니다.');

END;
/

