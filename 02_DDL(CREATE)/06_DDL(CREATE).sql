--CREATE USER DDL IDENTIFIED BY ddl;
--GRANT CONNECT, RESOURCE TO ddl;

/*
    *DDL (DATA DEFINITION LANGUAGE) : 데이터 정의 언어
    오라클에서 제공하는 객체(OBJECT)를 새로이 만들고(CREATE), 구조를 변경하고(ALTER), 구조를 삭제(DROP)하는 언어
    
    실제데이터값이 아닌 구조 자체를 정의하는 언어
    주로 DB관리자, 설계자가 이용함
    
    오라클 제공객체 : TABLE, VIEW, SEQUENCE, INDEX, PACKAGE, TRIGGER, PROCEDURE, FUNC, USER
    
    < CREATE >
    객체를 새로이 생성하는 구문
*/

-- 1.테이블 생성 ~ 테이블 : 행(가로) 열(세로) 로 구성되는
-- 가장 기본적인 데이터베이스 : 모든데이터들은 테이블통해 저장
-- DBMS 요어중 하나로, 데이터를 일종의 표형태로 표한한것!
/* [표현식] CREATE TABLE 테이블명(
                컬럼명 자료형의(크기)         
                컬럼명 자료형의(크기)         
                컬럼명 자료형의(크기)         
                );
    ~자료형
    -문자(CHAR 바이트크기)| VARCHAR2(바이트크기) => 반드시크기지정
    >CHAR : 최대 2000바이트까지지정, 
    지정한 범위안에서만 써야함~고정길이(지정한 크기보다 더적은값 들어와도 공백으로 채워짐)
    주로 고정된 글자수의 데이터만이 담길경우 사용
    >VARCHAR2 : 최대 4000바이트까지지정,가변 길이 (담긴값에 따라서 공간의 크기가 맞춰짐)
    몇글자의 데이터가 들어올지 모를경우 사용
    -숫자 (NUBMER)
    -날짜 (DATE)             
                
*/ 

--회원에대한 데이터를 담기위한 테이블 생성
CREATE TABLE MEMBER(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
);

SELECT *
FROM MEMBER;

-----------------------------------
/*
    컬럼에 주석달기
    COMMENT ON COLUMN 테9이블명, 컬럼명 IS '주석내용';
*/

COMMENT ON COLUMN MEMBER.MEM_NO IS '회원번호';--커맨트는 수정가능 테이블명은 수정불가능.
COMMENT ON COLUMN MEMBER.MEM_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEM_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.MEM_NAME IS '회원명';
COMMENT ON COLUMN MEMBER.GENDER IS '성별(남/여)';
COMMENT ON COLUMN MEMBER.PHONE IS '전화번호';
COMMENT ON COLUMN MEMBER.EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.MEM_DATE IS '회원가입일';

--테이블 데이터를 추가시키는 구문(DML: INSERT) 이때 자세하게 배움
--INSERT INTO 테이블명 VALUES(값1, 값2, ..);
SELECT * FROM MEMBER;
INSERT INTO MEMBER VALUES(1, 'user01', 'pass01', '고윤정', '여', '010-1010-1010', 'gyj@naver.com', '25/7/15' ); --컬럼개수만큼 다입력해야함.
INSERT INTO MEMBER VALUES(2, 'user02', 'pass02', '권은비', '여', '010-2020-2020', NULL , SYSDATE ); --컬럼개수만큼 다입력해야함.

INSERT INTO MEMBER VALUES(NULL, NULL, NULL, NULL, NULL, NULL, NULL , NULL ); --컬럼개수만큼 다입력해야함.
--유효하지않은 데이터가 들어가서 조건 걸어줘야함

/*
<제약조건 CONSTRAINT>
-원하는 데이터값만 유지하기 위해서 특정컬럼에 설정하는 제약조건 
-데이터 무결성 보장으로 한다.
*종류 : NOT NULL, UNIQUE, PRIMARY KEY, FOREIGN KEY
*/

--난널 제약조건 NOT NULL
--해당 컬럼에 반드시 값이 존재해야할경우 (즉, 해당컬럼에 널이 들어오면 안되는경우 
--제약조건을 부여하는 방식은 크게 2가지 방식이 있음( 컬럼 레벨방식/테이블 레벨 방식)
-- *NOT NULL 제약 조건은 오로지 컬럼 레발방식바꼐 안됨

--컬럼레벨방식 : 컬럼명 자료형 제약조건
CREATE TABLE MEMBER_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
);

SELECT * FROM MEMBER_NOTNULL;
INSERT INTO MEMBER_NOTNULL VALUES(1, 'user01', 'pass01', '고윤정', '여', '010-1010-1010', 'gyj@naver.com', '25/7/15' ); --컬럼개수만큼 다입력해야함.
INSERT INTO MEMBER_NOTNULL VALUES(2, 'user02', NULL, '고구마', '남', '010-7777-1010', 'potato@naver.com', SYSDATE ); 
--ORA-01400: cannot insert NULL into ("DDL"."MEMBER_NOTNULL"."MEM_PWD") ~ 난널 제약조건에 위배됨.
INSERT INTO MEMBER_NOTNULL VALUES(2, 'user01', 'pass03', '고구마', '남', '010-7777-1010', 'potato@naver.com', SYSDATE ); 
--아이디 중복됐음에도 불구하고 데이터가 추가되기때문에 중복을 허용하지 않은 제약조건 ㄱㄱ
------------------------------------------------------------------------------

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,--컬럼 라벨 방식.
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);
SELECT * FROM MEM_UNIQUE;
DROP TABLE MEM_UNIQUE;

--테이블 레벨 방식 : 모든칼럼 다 나열한후 마지막에 제약조건 기술하는방식 

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL ,--컬럼 라벨 방식.
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID)-- 테이블 레벨 방식
); 
SELECT * FROM MEM_UNIQUE;
INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '고윤정', '여', '010-1010-1010', 'gyj@naver.com'); --컬럼개수만큼 다입력해야함.
INSERT INTO MEM_UNIQUE VALUES(2, 'user01', 'pass03', '고구마', '남', '010-7777-1010', 'potato@naver.com'); 
-->ORA-00001: unique constraint (DDL.SYS_C007060) violated
--> 오류  구문을 제약조건명으로 알려줌 (특정컬럼에 어떤문제가 있는지 상세하게 알려주진않음) 
-->쉽게 파악하기 어렵고 제약조건부여시 제약조건명을 지정해주지 않으면 시스템에서 임의의 제약조건명을 부엽해버린다.
/*
제약조건 부여시 제약조건명 지어주는 방법 ~ 오류 확인하기 쉽게
>컬럼레벨방식 ~  테이블안의 컬럼안에 , 컬럼명 자료형 다음에 제약조건 쓰는데 [CONSTRAINT 제약조건명] 제약조건
>테이블레벨방식 ~ 컬럼과 별게로 테이블안에서 CONSTRAINT 제약조건명 제약조건 
*/
DROP TABLE MEM_UNIQUE;
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL ,--컬럼 라벨 방식.
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    CONSTRAINT HUNGRY UNIQUE(MEM_ID)-- 테이블 레벨 방식
); 

SELECT * FROM MEM_UNIQUE;
INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '고윤정', '여', '010-1010-1010', 'gyj@naver.com'); --컬럼개수만큼 다입력해야함.
INSERT INTO MEM_UNIQUE VALUES(2, 'user01', 'pass03', '고구마', '남', '010-7777-1010', 'potato@naver.com'); 
DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER CONSTRAINT MEMNO_NN NOT NULL ,
    MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NN NOT NULL ,--컬럼 라벨 방식.
    MEM_PWD VARCHAR2(20) CONSTRAINT MEMPWD_NN NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEMNAME_NN NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    CONSTRAINT HUNGRY UNIQUE(MEM_ID)-- 테이블 레벨 방식
);

SELECT * FROM MEM_UNIQUE;
INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '고윤정', '여', '010-1010-1010', 'gyj@naver.com'); --컬럼개수만큼 다입력해야함.
INSERT INTO MEM_UNIQUE VALUES(2, 'user01', 'pass03', '고구마', '남', '010-7777-1010', 'potato@naver.com'); 
INSERT INTO MEM_UNIQUE VALUES(3, 'user03', 'pass03', '한돈근', 'ㄴ', '010-5335-1010', 'PIG@naver.com'); 
--성별에 유효한 값이 아니더라도 추가잘됨 -> CHECK  제약조건 ㄱㄱ

--CHECK 제약조건 : 해당 컬럼에 들어올수있는 값에 대한 조건을 제시, 해당 조건 만족하는 값만 담길수있음

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CONSTRAINT GENDER CHECK(GENDER IN ('남','여')), --컬럼래밸방식
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    --CHECK(GENDER IN ('남','여') ) 
); 

SELECT * FROM MEM_CHECK;
INSERT INTO MEM_CHECK VALUES(1, 'user01', 'pass01', '고윤정', '여', '010-1010-1010', 'gyj@naver.com'); --컬럼개수만큼 다입력해야함.
INSERT INTO MEM_CHECK VALUES(2, 'user02', 'pass03', '고구마', '남', '010-7777-1010', 'potato@naver.com'); 
INSERT INTO MEM_CHECK VALUES(3, 'user03', 'pass03', '한돈근', 'ㄴ', '010-5335-1010', 'PIG@naver.com'); 
-- GENDER 에 NOTNULL 안적어서 NULL은가능함.  
/*
primary key 기본키 제약조건 
테이블에서 각 행들을 식별하기 위해 사용될 컬럼에 부여하는 제약조건 (식별자의 역할)
primary key 제약 조건 부여하면 그컬럼에 자동으로 not null, unique 제약 조건 가진다.
유의사ㅐ항 한테이블당 오로지 한번만 쓸수있음
*/
CREATE TABLE MEM_PRI(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY,-- 컬럼레벨방식
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3)  CHECK(GENDER IN ('남','여')), 
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    --, CONSTRAINT MEMNO_PK PRIMARY KEY(MEM_NO)--테이블레벨방식
); 
SELECT *FROM MEM_PRI;
INSERT INTO MEM_PRI VALUES(1, 'user01', 'pass01', '고윤정', '여', '010-1010-1010', 'gyj@naver.com'); --컬럼개수만큼 다입력해야함.

INSERT INTO MEM_PRI VALUES(1, 'user02', 'pass03', '고구마', '남', '010-7777-1010', 'potato@naver.com'); 
--ORA-00001: unique constraint (DDL.MEMNO_PK) violated
--기본키에 중복값을 담으려할떄 유니크 제약조건에 위배

--INSERT INTO 테이블명 VALUES()
INSERT INTO MEM_PRI VALUES(NULL, 'user02', 'pass03', '고구마', '남', '010-7777-1010', 'potato@naver.com'); 
--ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI"."MEM_NO")
--기본키에 NULL 담으려고 할떄 난널제약조건에 위배

INSERT INTO MEM_PRI VALUES(2, 'user02', 'pass03', '고구마', '남', '010-7777-1010', 'potato@naver.com'); 

CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY,-- 컬럼레벨방식
    MEM_ID VARCHAR2(20) PRIMARY KEY,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남','여')), 
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)    
); 
--02260. 00000 -  "table can have only one primary key"
--기본키는 하나만 된다.

CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남','여')), 
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),  
    CONSTRAINT PRIKEY PRIMARY KEY(MEM_NO, MEM_ID) -- 복합키
    
); 
SELECT * FROM MEM_PRI2;

INSERT INTO MEM_PRI2 VALUES(2, 'USER01', 'PASS01', '차은우', NULL, NULL, NULL);
INSERT INTO MEM_PRI2 VALUES(2, 'USER02', 'PASS01', '차은우', NULL, NULL, NULL);
INSERT INTO MEM_PRI2 VALUES(2, 'USER01', 'PASS01', '차은우', NULL, NULL, NULL);
--ORA-00001: unique constraint (DDL.PRIKEY) violated


--복합키 사용예시
--찜하기 :한상품은 한번만 찜할수있음.
--어떤 회원이 어떤상품을 찜하는지엗 ㅐ한 데이터를 보관하는 테이블

CREATE TABLE TB_LIKE(
    MEM_NO NUMBER,
    PRODUCT_NAME VARCHAR2(40),
    LIKE_DATE DATE,
    PRIMARY KEY(MEM_NO, PRODUCT_NAME)
);

SELECT * FROM TB_LIKE;
INSERT INTO TB_LIKE VALUES(1, '백도말랑이', SYSDATE );
INSERT INTO TB_LIKE VALUES(1, '백도딱딱이', SYSDATE );
INSERT INTO TB_LIKE VALUES(2, '백도말랑이', SYSDATE );
INSERT INTO TB_LIKE VALUES(1, '백도말랑이', SYSDATE ); --ORA-00001: unique constraint (DDL.SYS_C007098) violated

/*
    FOREIGN KEY 
    
*/
--회원 등급ㄷ에 대한 데이터 따로 보관 하는 테이블
CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY, 
    GRADE_NAME VARCHAR2(30) NOT NULL
);
SELECT * FROM MEM_GRADE;
INSERT INTO MEM_GRADE VALUES(10, '일반회원');
INSERT INTO MEM_GRADE VALUES(20, '우수회원');
INSERT INTO MEM_GRADE VALUES(30, '특별회원');

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남','여')), 
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER --회원등급번호 같이 보관할 컬럼
); 

SELECT * FROM MEM;
INSERT INTO MEM VALUES(1, 'user01' , 'pass01', '차은우','남' ,null, null, null);
INSERT INTO MEM VALUES(2, 'user02' , 'pass02', '권나라','여' ,null, null, 10);
INSERT INTO MEM VALUES(3, 'user03' , 'pass03', '임정희','여' ,null, null, 90);

----------------------------------   FOREIGN KEY 
/*
포린키 제약조건
다른 테이블 존재하는 값만 들어와야하느 ㄴ특정 컬럼에 부여하는 제약조건
--> 다른 테이블 참조한다고 표현
--> 주로 fk 제약조건에 의해 태이블 관계가 형성됨
>>컬럼방식
컬럼 자료형 [제약조건명 ] REFERENCES 참조할 테이블명 (참조할 컬럼명),, 안적을시 PK기본키
>.테이블 방식
[제약조건명 ] FOREIGN KEY(컬럼명) REFERENCES   참조할 테이블명 ..안적을시 PK기본키
*/

DROP TABLE MEM;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남','여')), 
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) 
    --FOREIGN KEY (GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE)
); 

SELECT * FROM MEM;
INSERT INTO MEM VALUES(1, 'user01' , 'pass01', '차은우','남' ,null, null, null);
INSERT INTO MEM VALUES(2, 'user02' , 'pass02', '권나라','여' ,null, null, 10);
INSERT INTO MEM VALUES(3, 'user03' , 'pass03', '임정희','여' ,null, null, 90);
--ORA-02291: integrity constraint (DDL.SYS_C007113) violated - parent key not found
INSERT INTO MEM VALUES(4, 'user03' , 'pass03', '임정희','여' ,null, null, 30);


--> MEM_GRADE(부모테이블) ------------MEM(자식테이블)
--데이터 삭제 : DELETE FROM 테이블 명 WHERE 조건;
DELETE FROM MEM_GRADE
WHERE GRADE_CODE=10;
--ORA-02292: integrity constraint (DDL.SYS_C007113) violated - child record found
--부모테이블의 데이터 삭제하려고해도 자식테이블이 10이라는 값쓰고있으면 삭제가 안된다.

DELETE FROM MEM_GRADE
WHERE GRADE_CODE=20;--자식중에 20을 쓰고있지않아서 삭제 잘됨

SELECT *FROM MEM_GRADE;
ROLLBACK;
/*
자식테이블 생성시 외래키 제약조건 부여할때 삭제옵션 지정가능
*삭제 옵션 : 부모테이블의 데이터 삭제시 그 데이터를 사용하고있는 자식 테이블 값을 어떻게 처리할껀지 
ON DELETE RESTRICTION(기본값) : 삭제 제한옵션, 자식데이터로 쓰이는 부모데이터는 아예삭제 안되겠금
ON DELETE SET NULL: 부모데이터 삭제시 해당데이터를 쓰고있는 자식 데이터 값을 NULL 변경
ON DELETE CASCADE : 부모데이터 삭제시 해당 데이터를 쓰고있는 자식데이터를 같이 삭제시킴.
*/

DROP TABLE MEM;
--ON DELETE SET NULL
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남','여')), 
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL    
); 

SELECT * FROM MEM;
INSERT INTO MEM VALUES(1, 'user01' , 'pass01', '차은우','남' ,null, null, null);
INSERT INTO MEM VALUES(2, 'user02' , 'pass02', '박보검','남' ,null, null, 10);
INSERT INTO MEM VALUES(3, 'user03' , 'pass03', '장원영','여' ,null, null, 20);
INSERT INTO MEM VALUES(4, 'user04' , 'pass04', '박보영','여' ,null, null, 30);

--10번 삭제
DELETE FROM MEM_GRADE
WHERE GRADE_CODE =10;
--굉장히 잘 삭제가 되지만 , 쓰고있던 자식 데이터값은 NULL로 변경
SELECT * FROM MEM_GRADE;
SELECT * FROM MEM;

ROLLBACK;

DROP TABLE MEM;
--ON DELETE CASCADE
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남','여')), 
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE    
); 

SELECT * FROM MEM;
INSERT INTO MEM VALUES(1, 'user01' , 'pass01', '차은우','남' ,null, null, null);
INSERT INTO MEM VALUES(2, 'user02' , 'pass02', '박보검','남' ,null, null, 10);
INSERT INTO MEM VALUES(3, 'user03' , 'pass03', '장원영','여' ,null, null, 20);
INSERT INTO MEM VALUES(4, 'user04' , 'pass04', '박보영','여' ,null, null, 30);
--10등급 삭제
DELETE FROM MEM_GRADE
WHERE GRADE_CODE =10;--잘삭제됨

SELECT * FROM MEM_GRADE;

SELECT * FROM MEM;

--기본값을 쓸데 사용하는 것 DEFAULT
/*
디폴트(기본값)
컬럼 선정안하고 인설트시 NULL 이 아닌 기본값을 인설트 하는 것
*/

DROP TABLE MEMBER;
CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_NAME VARCHAR2(20) NOT NULL,
    MMEM_AGE NUMBER, 
    HOBBY VARCHAR2(20) DEFAULT '없음',
    ENROLL_DATE DATE DEFAULT SYSDATE
);

SELECT *FROM MEMBER;
INSERT INTO MEMBER VALUES(1, '차은우', 20, '노래하기', '25/01/01');
INSERT INTO MEMBER VALUES(2, '박보검', NULL, NULL, NULL);
INSERT INTO MEMBER VALUES(3, '박보영', NULL, DEFAULT, DEFAULT);

-- INSERT INTO 테이블명(칼럼명, 컬럼명) VALUES (값1, 값2)
-- NOT NULL인건 꼭 골라야함.

INSERT INTO MEMBER(MEM_NO, MEM_NAME) VALUES(4, '박정민');
--선택되지 않은 컬럼에는 기본적으로 NULL있음
--디폴트값 있는경우 디폴트값  들어감

------------------------------------------------------------------------------
/*
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! KH 계정 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
<SUBQUERY 이용한 테이블 생성>
테이블 복사 뜨는 개념

표현식 
CREATE TABLE 테이블명
AS 서브쿼리;
*/
--EMPLOYEE 테이블 복제한 새로운 테이블 생성
CREATE TABLE EMPLOYEE_COPY
AS SELECT * 
    FROM EMPLOYEE;
--> 제약조건 같은경우에는 NOT NULL만 복사됨

SELECT * FROM EMPLOYEE_COPY;

CREATE TABLE EMPLOYEE_COPY2
AS SELECT *
    FROM EMPLOYEE
    WHERE 1 =0;--무조건 FALSE조건으로 구조만을 복사하고할때 씀
SELECT * FROM EMPLOYEE_COPY2;

CREATE TABLE EMPLOYEE_COPY3
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 AS "연봉"--서브쿼리셀렉절에 연산자나 산술실 함수식 있을경우 별칭지정해야함.
FROM EMPLOYEE;
    
SELECT * FROM EMPLOYEE_COPY3;
----------------------------------------------------------------------------------------
/*
테이블 생성후 제약조건 추가 할경우?
    -PRIMARY KEY :  ALTER TABLE 테이블명 ADD PRIMARY KEY (컬럼명) ;    
    -FOREIGN KEY :  ALTER TABLE 테이블명 ADD FOREIGN KEY (컬럼명) REFERENCES 참조할테이블명 
    -UNIQUE : ALTER TABLE 테이블명 ADD UNIQUE(컬럼명);
    -CHECK :  ALTER TABLE 테이블명 ADD CHECK(컬럼에 대한조건식);
    -NOT NULL :  ALTER TABLE 테이블명 MODIFY 컬럼명 NOT TNULL; **약간특이함.
*/

--서브쿼리를 이용해서 복제한 테이블은 NN제약조건 뺴고 복제안됨
--EMPLOYEE COPY 테이블 PK제약 조건 추가 (EMP_ID)
ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY(EMP_ID); 

--EMPLOYEE 테이블에 DEPT_CODE에 외래키 제약조건 추가 (참조테이블(부모) : DEPARTMENT(DEPT_ID))
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT;--생략하면 부모테이블의 PK로감

--EMPLOYEE 테이블에 JOB_CODE에 외래키 제약조건 추가 (JOB 테이블 참조)
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(JOB_CODE)  REFERENCES JOB;
--EMPLOYEE 테이블에 SAL_LEVEL에 왜래키 조건(SAL _GRADE 테이블참조)
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(SAL_LEVEL) REFERENCES SAL_GRADE;
--DEPARTMENT 테이블에 LOCATION_ID에 외래키 제약조건 (LOCATION 테이블 참조)
ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION;








