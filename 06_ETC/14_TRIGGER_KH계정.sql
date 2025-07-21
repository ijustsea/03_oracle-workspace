/*
    Ʈ����
     ������ ���̺� INSERT, UPDATE, DELETE�� DML�� ���� ������� ���� ��
     ���̺� �̺�Ʈ �߻����� �� �ڵ����� �Ź� ������ ������ ������ �� �ִ� ��ü
     
    EX)
     ȸ��Ż�� �� ���� ȸ�����̺� DELETE�� Ż��ȸ���鸸 ���� �����ϴ� ���̺� �ڵ�INSERT �ؾ���       
     �Ű�Ƚ�� ���� �� �Ѱ��� �� ������(�Ϲ���)���� �ش�ȸ���� ������Ʈ ó�� �ǰ� �� 
     ����� ���� �����Ͱ� ���(INSERT) �� ������ �ش� ��ǰ�� ���� �������� �Ź� ����(UPDATE)�ؾ��Ҷ�
     
    *Ʈ���� ����
    -SQL�� ����ñ⿡ �����з�
    >BEFORE TRIGGER : ���������� ���̺� �̺�Ʈ �߻��Ǳ� ���� Ʈ���� ����
    >AFTER TRIGGER : ���������� ���̺� �̺�Ʈ �߻��Ǳ� �Ŀ� Ʈ���� ����
       
    -SQL���� ���� ����޴� �� �࿡ ���� �з�
    >STATEMENT(����) TRIGGER : �̺�Ʈ�� �߻��� SQL���� ���� �� �ѹ� Ʈ���� ����
    >ROW TRIGGER(�� Ʈ����) : �ش� SQL�� �����ҋ����� �Ź� Ʈ���� ����(FOR EACH ROW �ɼ�)
    (OLD : BEFORE UPDATE (�������ڷ�), BEFORE DELETE(�������ڷ�)/ NEW : AFTER INSERT(�߰����ڷ�), AFTER UPDATE(������ �ڷ�))        
    
    *ǥ����         
        CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ�
        [BEFORE|AFTER] INSERT|UPDATE|DELETE ON ���̺��
        [FOR EACH ROW]
        �ڵ����� ������ ���� : 
            �� [DECLARE]
               ���� ����
               BEGIN
               ���� ���� (�ش����� ������ �̺�Ʈ�߻��� �ڵ������� ����
               [EXCEPTION]
               ����ó������ 
               END;
               /        
*/

SET SERVEROUTPUT ON;
--�����ܼ�Ű��

--EMPLOYEE ���̺� ���ο� ���� INSERT �ɋ����� �ڵ����� �޼�������ϴ� Ʈ����
CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('���Ի���� ȯ���մϴ�.');
END;
/

INSERT INTO EMPLOYEE(EMP_ID,  EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL, HIRE_DATE) 
VALUES (502, 'ȫ����', '111133-1111111', 'D7', 'J7', 'S2', SYSDATE);

--��ǰ �԰� �� ��� ���� ����
-->�׽�Ʈ�� ���� ���̺� �� ������ ����


--1.��ǰ�������̺�
CREATE TABLE TB_PRODUCT(
    PCODE NUMBER PRIMARY KEY,    --��ǰ��ȣ
    PNAME VARCHAR2(30) NOT NULL, --��ǰ��
    BRAND VARCHAR2(30) NOT NULL, --�귣��
    PRICE NUMBER,                --����
    STOCK NUMBER DEFAULT 0       --���
);
--2.��ǰ��ȣ������-�ߺ��ȵǰԲ� ���ο��ȣ �߻�������
CREATE SEQUENCE SEQ_PCODE
START WITH 200
INCREMENT BY 5 
NOCACHE;
--���õ����� �߰� 
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL , '������25', '�Ｚ', 1380000, DEFAULT );
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL , '������15', '����', 1600000, 10 );
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL , '����33', '������', 500000, 30 );

SELECT *FROM TB_PRODUCT;
--Ŀ�� ������ ���ν����� �������
COMMIT ;
--���� �����Ϳ� ����

--2.��ǰ����� ���̷� ���̺� (TB_PRODETAIL)
--� ��ǰ�� ���¥�� � ����� �����͸� ����ϴ� ���̺�
CREATE TABLE TB_PRODETAIL(
    DCODE NUMBER PRIMARY KEY,                  --�̷¹�ȣ
    PCODE NUMBER REFERENCES TB_PRODUCT(PCODE), --��ǰ��ȣ ~�ܷ�Ű
    PDATE DATE NOT NULL,                       --�������
    AMOUNT NUMBER NOT NULL,                    --��������
    STATUS CHAR(6) CHECK(STATUS IN ('�԰�','���')) --����    
);

--�̷¹�ȣ�� �Ź� ���ο��ȣ �߻������ִ� ������
CREATE SEQUENCE SEQ_DCODE
NOCACHE;

--200����ǰ�� ���ó�¥�� 10���԰�
INSERT INTO TB_PRODETAIL 
VALUES(SEQ_DCODE.NEXTVAL, '200', SYSDATE, 10, '�԰�');
-->TB_PRODUCT�� STOCK�� 10�� AMOUNT���� ��ŭ �������Ѿ���.
UPDATE TB_PRODUCT 
SET STOCK = STOCK +10
WHERE PCODE =200;
COMMIT;

--210����ǰ 5�� ��� 
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, '210', SYSDATE, 5, '���');

UPDATE TB_PRODUCT 
SET STOCK = STOCK -5
WHERE PCODE =210;
COMMIT;

INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, '205', SYSDATE, 20, '�԰�');

UPDATE TB_PRODUCT 
SET STOCK = STOCK +20
WHERE PCODE =205;
COMMIT;
/*
    �ڵ����� ��������ŭ ������Ʈ �Ǵ� Ʈ���� ����
    
    -��ǰ�� �԰� �� ��� �ش��ǰ ã�Ƽ� ������ ���� UPDATE
    UPDATE TB_PRODUCT 
    SET STOCK = STOCK + ���� �԰�� ����(INSERT�� �ڷ��� AMOUNT��)
    WHERE PCODE= �԰�� ��ǰ��ȣ (INSERT�� �ڷ���  PCODE)
     
    -��ǰ�� �԰� �� ��� �ش��ǰ ã�Ƽ� ������ ���� UPDATE
    UPDATE TB_PRODUCT 
    SET STOCK = STOCK - ���� �԰�� ����(INSERT�� �ڷ��� AMOUNT��)
    WHERE PCODE= ���� ��ǰ��ȣ (INSERT�� �ڷ���  PCODE)        
    
*/

CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON TB_PRODETAIL
FOR EACH ROW
BEGIN 
    IF(:NEW.STATUS='�԰�')
        THEN 
            UPDATE TB_PRODUCT 
            SET STOCK = STOCK +:NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
    END IF;
    
    IF(:NEW.STATUS='���')
        THEN 
            UPDATE TB_PRODUCT 
            SET STOCK = STOCK -:NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
            
    END IF;
END;
/

INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, '200', SYSDATE, 10, '�԰�');

INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, '205', SYSDATE, 20, '���');

INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, '210', SYSDATE, 5, '�԰�');

