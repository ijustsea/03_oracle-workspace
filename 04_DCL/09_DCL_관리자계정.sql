/*
    < DCL : DATA CONTROL LANGUAGE > : 데이터 제어 언어.
    계정에게 시스템 권한 또는 객체접근 권한부여(GRANT)하거나 회수(REVOKE)하는 구문
    
    1)시스템 권한 : DB에접근하는 권한, 객체들을 생성할수있는 권한    
    - CREATE SESSION : 접속할 수 있는 권한
    - CREATE TABLE : 테이블 생성할 수 있는 권한
    - CREATE VIEW : 뷰를 생성할 수 있는 권한
    - CREATE SEQUENCE : SQUENCE 생성 할수있는 권한(순번 부여할때)
    ... 이중 일부는 커넥트(CONNECT) 안에 포함되어잇음 
    
    2)객체접근 권한 : 특정 객체들을 조작할수있는 권한    
      권한종류      특정  객체
    - SELECT  TABLE VIEW SEQUENCE
    - INSERT  TABLE VIEW
    - UPDATE  TABLE VIEW
    - DELETE  TABLE VIEW
    
    [표현식]
    GRANT 권한종류 ON 특정객체 TO 계정   
    
*/

--시스템 권한 예시
--1)SAMPLE / SAMPLE 계정(USER)생성, IDENTIFIED ~ 식별하겠따.
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;
--상태: 실패 -테스트 실패: ORA-01045: user SAMPLE lacks CREATE SESSION privilege; logon denied

--2)접속하기위해, CREATE SESSION 권한부여
GRANT CREATE SESSION TO SAMPLE;

--3)-1테이블 생성 권한 부여
GRANT CREATE TABLE TO SAMPLE;
--ORA-01950: no privileges on tablespace 'SYSTEM'
--아직 테이블이 생성이 안됨.

--3)-2 TABLESPACE 할당하기
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;
----------------------------------------------------------------

--객체접근 권한예시
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE; --선택할수있는 권한
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE; --삽입할수있는 권한

GRANT CONNECT, RESOURCES TO 계정명;
/*
<롤 ROLE>
-특정 권한들을 하나의 집합으로 모아놓은것

CONNECT : 접속할수 있는 권한
RESOURCE :  특정 객체들을 생성할수있는 권한, CREATE TABLE, CREATE SEQUENCE, ...
*/
SELECT * 
FROM ROLE_SYS_PRIVS
WHERE ROLE IN('CONNECT', 'RESOURCE')
ORDER BY 1;
