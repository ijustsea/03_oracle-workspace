/*
    트리거
     지정한 테이블에 INSERT, UPDATE, DELETE등 DML에 의해 변경사항 생길 때
     테이블에 이벤트 발생했을 때 자동으로 매번 실행할 내용을 정의할 수 있는 객체
     
    EX)
     회원탈퇴 시 기존 회원테이블에 DELETE후 탈퇴회원들만 따로 보관하는 테이블에 자동INSERT 해야함       
     신고횟수 일정 수 넘겼을 시 묵시적(암묵적)으로 해당회원을 블랙리스트 처리 되게 끔 
     입출고에 대한 데이터가 기록(INSERT) 될 때마다 해당 상품에 대한 재고수량을 매번 수정(UPDATE)해야할때
     
    *트리거 종류
    -SQL문 실행시기에 따른분류
    >BEFORE TRIGGER : 내가지정한 테이블에 이벤트 발생되기 전에 트리거 실행
    >AFTER TRIGGER : 내가지정한 테이블에 이벤트 발생되기 후에 트리거 실행
       
    -SQL문에 의해 영향받는 각 행에 따른 분류
    >STATEMENT(문장) TRIGGER : 이벤트가 발생한 SQL문에 의해 딱 한번 트리거 실행
    >ROW TRIGGER(행 트리거) : 해당 SQL문 실행할떄마다 매번 트리거 실행(FOR EACH ROW 옵션)
    (OLD : BEFORE UPDATE (수정전자료), BEFORE DELETE(삭제전자료)/ NEW : AFTER INSERT(추가된자료), AFTER UPDATE(수정후 자료))        
    
    *표현식         
        CREATE [OR REPLACE] TRIGGER 트리거명
        [BEFORE|AFTER] INSERT|UPDATE|DELETE ON 테이블명
        [FOR EACH ROW]
        자동으로 실행할 내용 : 
            ㄴ [DECLARE]
               변수 선언
               BEGIN
               실행 내용 (해당위에 지정된 이벤트발생시 자동실행할 구문
               [EXCEPTION]
               예외처리구문 
               END;
               /        
*/

SET SERVEROUTPUT ON;
--서버콘솔키기

--EMPLOYEE 테이블 새로운 행이 INSERT 될떄마다 자동으로 메세지출력하는 트리거
CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('신입사원님 환영합니다.');
END;
/

INSERT INTO EMPLOYEE(EMP_ID,  EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL, HIRE_DATE) 
VALUES (502, '홍순신', '111133-1111111', 'D7', 'J7', 'S2', SYSDATE);

--상품 입고 및 출고 관련 예시
-->테스트를 위한 테이블 및 시퀀스 생성


--1.상품관련테이블
CREATE TABLE TB_PRODUCT(
    PCODE NUMBER PRIMARY KEY,    --상품번호
    PNAME VARCHAR2(30) NOT NULL, --상품명
    BRAND VARCHAR2(30) NOT NULL, --브랜드
    PRICE NUMBER,                --가격
    STOCK NUMBER DEFAULT 0       --재고
);
--2.상품번호시퀀스-중복안되게끔 새로운번호 발생시퀀스
CREATE SEQUENCE SEQ_PCODE
START WITH 200
INCREMENT BY 5 
NOCACHE;
--샘플데이터 추가 
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL , '갤럭시25', '삼성', 1380000, DEFAULT );
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL , '아이폰15', '애플', 1600000, 10 );
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL , '샤오33', '샤오미', 500000, 30 );

SELECT *FROM TB_PRODUCT;
--커밋 전까진 프로시저에 담겨있음
COMMIT ;
--실제 데이터에 삽입

--2.상품입출고 상세이력 테이블 (TB_PRODETAIL)
--어떤 상품이 어떤날짜에 몇개 입출고 데이터를 기록하는 테이블
CREATE TABLE TB_PRODETAIL(
    DCODE NUMBER PRIMARY KEY,                  --이력번호
    PCODE NUMBER REFERENCES TB_PRODUCT(PCODE), --상품번호 ~외래키
    PDATE DATE NOT NULL,                       --입출고일
    AMOUNT NUMBER NOT NULL,                    --입출고수량
    STATUS CHAR(6) CHECK(STATUS IN ('입고','출고')) --상태    
);

--이력번호로 매번 새로우번호 발생시켜주는 시퀀스
CREATE SEQUENCE SEQ_DCODE
NOCACHE;

--200번상품이 오늘날짜로 10개입고
INSERT INTO TB_PRODETAIL 
VALUES(SEQ_DCODE.NEXTVAL, '200', SYSDATE, 10, '입고');
-->TB_PRODUCT의 STOCK을 10을 AMOUNT수량 만큼 증가시켜야함.
UPDATE TB_PRODUCT 
SET STOCK = STOCK +10
WHERE PCODE =200;
COMMIT;

--210번상품 5개 출고 
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, '210', SYSDATE, 5, '출고');

UPDATE TB_PRODUCT 
SET STOCK = STOCK -5
WHERE PCODE =210;
COMMIT;

INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, '205', SYSDATE, 20, '입고');

UPDATE TB_PRODUCT 
SET STOCK = STOCK +20
WHERE PCODE =205;
COMMIT;
/*
    자동으로 재고수량만큼 업데이트 되는 트리거 생성
    
    -상품이 입고 된 경우 해당상품 찾아서 재고수량 증가 UPDATE
    UPDATE TB_PRODUCT 
    SET STOCK = STOCK + 현재 입고된 수량(INSERT된 자료의 AMOUNT값)
    WHERE PCODE= 입고된 상품번호 (INSERT된 자료의  PCODE)
     
    -상품이 입고 된 경우 해당상품 찾아서 재고수량 감소 UPDATE
    UPDATE TB_PRODUCT 
    SET STOCK = STOCK - 현재 입고된 수량(INSERT된 자료의 AMOUNT값)
    WHERE PCODE= 출고된 상품번호 (INSERT된 자료의  PCODE)        
    
*/

CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON TB_PRODETAIL
FOR EACH ROW
BEGIN 
    IF(:NEW.STATUS='입고')
        THEN 
            UPDATE TB_PRODUCT 
            SET STOCK = STOCK +:NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
    END IF;
    
    IF(:NEW.STATUS='출고')
        THEN 
            UPDATE TB_PRODUCT 
            SET STOCK = STOCK -:NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
            
    END IF;
END;
/

INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, '200', SYSDATE, 10, '입고');

INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, '205', SYSDATE, 20, '출고');

INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, '210', SYSDATE, 5, '입고');

