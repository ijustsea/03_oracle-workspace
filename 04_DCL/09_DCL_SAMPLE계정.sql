--먼저저장
CREATE TABLE TEST(
    TEST_ID NUMBER,
    TEST_NAME VARCHAR(10)
);
--ORA-01031: insufficient privileges
--CREATE TABLE 권한이 없어서 에러.
--3)-1테이블 생성 권한 부여
--3)-2 TABLESPACE 할당하기
-->테이블 생성 정상작동

SELECT * FROM TEST;
INSERT INTO TEST VALUES('10','안녕');
--CREATE TABLE권한 받으면 테이블 바로 조작가능.

--KH계정에 있는 EMPLOYEE테이블에 접근원함
SELECT * FROM KH.EMPLOYEE;
--4)SELECT ON KH.EMPLOYEE 권한부여받기
INSERT INTO KH.DEPARTMENT
VALUES('D0','회계부', 'L1');

ROLLBACK;