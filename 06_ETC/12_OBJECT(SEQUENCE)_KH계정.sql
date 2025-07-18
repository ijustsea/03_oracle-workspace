/*
    시퀸스가 먼데 ~ 중요 : NEXTVAL을 한번 해야지만 쓸수있다
    자동으로 번호발생시켜주는 객체 
    정수값을 순차적으로 일정값씩 증가시키면서 생성해줌 
    겹치면 안되는 데이터들
    
    시퀀스 객체 생성
    
    CREATE SEQUENCE 시퀀스
    
    [상세 표현식]
    CREATE, SEQUENCE 시퀀스명
    [START WITH 시작숫자]  --처음발생시킬 시작값지정 디폴트는 1
    [INCREMENT BY 숫자]   --몇씩 증가시킬건지 (기본값 1)
    [MAXVALUE 숫자]       --최대값 지정 (기본값 겁나큼)
    [MINVALUE 숫자]       --최소값 지정 (기본값 1)=>최대값 찍고 처음부터 다시 돌아와서 시작하게 할수있음
    [CYCLE|NOCYCLE=DEFAULT] : 값순환여부 지정
    [NOCACHE|CACHE 바이트크기]-- 캐시메모리 할당 (기본값 CACHE 20)
    캐시메모리가 먼데 : 임시공간
                     미리 발생될 값들을 생성해서 저장해두는 공간
                     매번 호출될때마다 새로이 번호를 생성하는게 아니라
                     캐시메모리 공간에 미리 생성된값들을 가져다 쓸수있음=>속도빨라짐
                     접속해제되면 캐시메모리에 미리만들어 둔 번호들은 날라감
                     
    테이블명 : TB_
    뷰      : VW_
    시퀀스 :  SEQ_
    트리거 :  TRG_
*/

CREATE SEQUENCE SEQ_TEST;
--참고 : 현재 계정이 소유하고있 는 시퀀스의 구조들을 보고자 할떄
SELECT * FROM USER_SEQUENCES;

CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

--SEQUECNE 사용법
/*
2.시퀀스 사용
시퀀스명, CURRVAL : 현재시퀀스의값 (마지먹으로 성공적으로 수행된 NEXTVAL값)
시퀀스명, NEXTVAL : 시퀀스값에 일정값을 증가시켜서 발생된 값.
                   현재 시퀀스 값에서 INCREMENT BY 값만큼 증가된값
                   
*/
SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
--ORA-08002: sequence SEQ_EMPNO.CURRVAL is not yet defined in this session
--*Action:   select NEXTVAL from the sequence before selecting CURRVAL

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;--실행1:300,실행2:305,실행3:310
SELECT SEQ_EMPNO.CURRVAL FROM DUAL;--300~내가마지막으로 성공적으로 발생시킨 NEXTVAL값

SELECT *FROM USER_SEQUENCES;
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
--*Cause:    instantiating NEXTVAL would violate one of MAX/MINVALUE
--최대값/초소값중 하나 위배해서 오류발생
SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
/*
구조변경은 ALTER 
값변경은 UPDATE

    3.시퀀스 구조 변경
    ALTER SEQUENCE 시퀀스명
    [INCREMENT BY 숫자]   --몇씩 증가시킬건지 (기본값 1)
    [MAXVALUE 숫자]       --최대값 지정 (기본값 겁나큼)
    [MINVALUE 숫자]       --최소값 지정 (기본값 1)=>최대값 찍고 처음부터 다시 돌아와서 시작하게 할수있음
    [CYCLE|NOCYCLE=DEFAULT] : 값순환여부 지정
    [NOCACHE|CACHE 바이트크기]-- 캐시메모리 할당 (기본값 CACHE 20)

    **START WITH 변경불가

*/

ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;--310+10 = 320
/*
4.시퀀스 삭제
DROP SEQUENCE SEQ_EMPNO;
---------------------------------------------------
사원번호로 활용할 시퀀스 생성
*/

CREATE SEQUENCE SEQ_EID
START WITH 400
NOCACHE;

INSERT INTO EMPLOYEE
    (
      EMP_ID
    , EMP_NAME
    , EMP_NO
    , JOB_CODE
    , SAL_LEVEL
    , HIRE_DATE    
    )
    
    VALUES
    (
       SEQ_EID.NEXTVAL
     , '홍길동'
     , '990101-1111111'
     , 'J7'
     , 'S1'
     ,  SYSDATE   
    
    );
    
SELECT * FROM EMPLOYEE
ORDER BY EMP_ID DESC;

INSERT INTO EMPLOYEE
    (
      EMP_ID
    , EMP_NAME
    , EMP_NO
    , JOB_CODE
    , SAL_LEVEL
    , HIRE_DATE    
    )
    
    VALUES
    (
       SEQ_EID.NEXTVAL
     , '홍길순'
     , '990303-2222222'
     , 'J6'
     , 'S1'
     ,  SYSDATE   
    
    );
    
/*    
INSERT INTO EMPLOYEE
    (
      EMP_ID
    , EMP_NAME
    , EMP_NO
    , JOB_CODE
    , SAL_LEVEL
    , HIRE_DATE    
    )
    
    VALUES
    (
       SEQ_EID.NEXTVAL
     , ?
     , ?
     , ?          
     , ?
     ,  SYSDATE   
    
    );
*/

