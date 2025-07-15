--CREATE USER DDL IDENTIFIED BY ddl;
--GRANT CONNECT, RESOURCE TO ddl;

/*
    *DDL (DATA DEFINITION LANGUAGE) : ������ ���� ���
    ����Ŭ���� �����ϴ� ��ü(OBJECT)�� ������ �����(CREATE), ������ �����ϰ�(ALTER), ������ ����(DROP)�ϴ� ���
    
    ���������Ͱ��� �ƴ� ���� ��ü�� �����ϴ� ���
    �ַ� DB������, �����ڰ� �̿���
    
    ����Ŭ ������ü : TABLE, VIEW, SEQUENCE, INDEX, PACKAGE, TRIGGER, PROCEDURE, FUNC, USER
    
    < CREATE >
    ��ü�� ������ �����ϴ� ����
*/

-- 1.���̺� ���� ~ ���̺� : ��(����) ��(����) �� �����Ǵ�
-- ���� �⺻���� �����ͺ��̽� : ��絥���͵��� ���̺����� ����
-- DBMS ����� �ϳ���, �����͸� ������ ǥ���·� ǥ���Ѱ�!
/* [ǥ����] CREATE TABLE ���̺��(
                �÷��� �ڷ�����(ũ��)         
                �÷��� �ڷ�����(ũ��)         
                �÷��� �ڷ�����(ũ��)         
                );
    ~�ڷ���
    -����(CHAR ����Ʈũ��)| VARCHAR2(����Ʈũ��) => �ݵ��ũ������
    >CHAR : �ִ� 2000����Ʈ��������, 
    ������ �����ȿ����� �����~��������(������ ũ�⺸�� �������� ���͵� �������� ä����)
    �ַ� ������ ���ڼ��� �����͸��� ����� ���
    >VARCHAR2 : �ִ� 4000����Ʈ��������,���� ���� (��䰪�� ���� ������ ũ�Ⱑ ������)
    ������� �����Ͱ� ������ �𸦰�� ���
    -���� (NUBMER)
    -��¥ (DATE)             
                
*/ 

--ȸ�������� �����͸� ������� ���̺� ����
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
    �÷��� �ּ��ޱ�
    COMMENT ON COLUMN ��9�̺��, �÷��� IS '�ּ�����';
*/

COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ����ȣ';--Ŀ��Ʈ�� �������� ���̺���� �����Ұ���.
COMMENT ON COLUMN MEMBER.MEM_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEM_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEM_NAME IS 'ȸ����';
COMMENT ON COLUMN MEMBER.GENDER IS '����(��/��)';
COMMENT ON COLUMN MEMBER.PHONE IS '��ȭ��ȣ';
COMMENT ON COLUMN MEMBER.EMAIL IS '�̸���';
COMMENT ON COLUMN MEMBER.MEM_DATE IS 'ȸ��������';

--���̺� �����͸� �߰���Ű�� ����(DML: INSERT) �̶� �ڼ��ϰ� ���
--INSERT INTO ���̺�� VALUES(��1, ��2, ..);
SELECT * FROM MEMBER;
INSERT INTO MEMBER VALUES(1, 'user01', 'pass01', '������', '��', '010-1010-1010', 'gyj@naver.com', '25/7/15' ); --�÷�������ŭ ���Է��ؾ���.
INSERT INTO MEMBER VALUES(2, 'user02', 'pass02', '������', '��', '010-2020-2020', NULL , SYSDATE ); --�÷�������ŭ ���Է��ؾ���.

INSERT INTO MEMBER VALUES(NULL, NULL, NULL, NULL, NULL, NULL, NULL , NULL ); --�÷�������ŭ ���Է��ؾ���.
--��ȿ�������� �����Ͱ� ���� ���� �ɾ������

/*
<�������� CONSTRAINT>
-���ϴ� �����Ͱ��� �����ϱ� ���ؼ� Ư���÷��� �����ϴ� �������� 
-������ ���Ἲ �������� �Ѵ�.
*���� : NOT NULL, UNIQUE, PRIMARY KEY, FOREIGN KEY
*/

--���� �������� NOT NULL
--�ش� �÷��� �ݵ�� ���� �����ؾ��Ұ�� (��, �ش��÷��� ���� ������ �ȵǴ°�� 
--���������� �ο��ϴ� ����� ũ�� 2���� ����� ����( �÷� �������/���̺� ���� ���)
-- *NOT NULL ���� ������ ������ �÷� ���߹�Ĺٲ� �ȵ�

--�÷�������� : �÷��� �ڷ��� ��������
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
INSERT INTO MEMBER_NOTNULL VALUES(1, 'user01', 'pass01', '������', '��', '010-1010-1010', 'gyj@naver.com', '25/7/15' ); --�÷�������ŭ ���Է��ؾ���.
INSERT INTO MEMBER_NOTNULL VALUES(2, 'user02', NULL, '����', '��', '010-7777-1010', 'potato@naver.com', SYSDATE ); 
--ORA-01400: cannot insert NULL into ("DDL"."MEMBER_NOTNULL"."MEM_PWD") ~ ���� �������ǿ� �����.
INSERT INTO MEMBER_NOTNULL VALUES(2, 'user01', 'pass03', '����', '��', '010-7777-1010', 'potato@naver.com', SYSDATE ); 
--���̵� �ߺ��������� �ұ��ϰ� �����Ͱ� �߰��Ǳ⶧���� �ߺ��� ������� ���� �������� ����
------------------------------------------------------------------------------

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,--�÷� �� ���.
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);
SELECT * FROM MEM_UNIQUE;
DROP TABLE MEM_UNIQUE;

--���̺� ���� ��� : ���Į�� �� �������� �������� �������� ����ϴ¹�� 

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL ,--�÷� �� ���.
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID)-- ���̺� ���� ���
); 
SELECT * FROM MEM_UNIQUE;
INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '������', '��', '010-1010-1010', 'gyj@naver.com'); --�÷�������ŭ ���Է��ؾ���.
INSERT INTO MEM_UNIQUE VALUES(2, 'user01', 'pass03', '����', '��', '010-7777-1010', 'potato@naver.com'); 
-->ORA-00001: unique constraint (DDL.SYS_C007060) violated
--> ����  ������ �������Ǹ����� �˷��� (Ư���÷��� ������� �ִ��� ���ϰ� �˷���������) 
-->���� �ľ��ϱ� ��ư� �������Ǻο��� �������Ǹ��� ���������� ������ �ý��ۿ��� ������ �������Ǹ��� �ο��ع�����.
/*
�������� �ο��� �������Ǹ� �����ִ� ��� ~ ���� Ȯ���ϱ� ����
>�÷�������� ~  ���̺���� �÷��ȿ� , �÷��� �ڷ��� ������ �������� ���µ� [CONSTRAINT �������Ǹ�] ��������
>���̺������ ~ �÷��� ���Է� ���̺�ȿ��� CONSTRAINT �������Ǹ� �������� 
*/
DROP TABLE MEM_UNIQUE;
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL ,--�÷� �� ���.
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    CONSTRAINT HUNGRY UNIQUE(MEM_ID)-- ���̺� ���� ���
); 

SELECT * FROM MEM_UNIQUE;
INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '������', '��', '010-1010-1010', 'gyj@naver.com'); --�÷�������ŭ ���Է��ؾ���.
INSERT INTO MEM_UNIQUE VALUES(2, 'user01', 'pass03', '����', '��', '010-7777-1010', 'potato@naver.com'); 
DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER CONSTRAINT MEMNO_NN NOT NULL ,
    MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NN NOT NULL ,--�÷� �� ���.
    MEM_PWD VARCHAR2(20) CONSTRAINT MEMPWD_NN NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEMNAME_NN NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    CONSTRAINT HUNGRY UNIQUE(MEM_ID)-- ���̺� ���� ���
);

SELECT * FROM MEM_UNIQUE;
INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '������', '��', '010-1010-1010', 'gyj@naver.com'); --�÷�������ŭ ���Է��ؾ���.
INSERT INTO MEM_UNIQUE VALUES(2, 'user01', 'pass03', '����', '��', '010-7777-1010', 'potato@naver.com'); 
INSERT INTO MEM_UNIQUE VALUES(3, 'user03', 'pass03', '�ѵ���', '��', '010-5335-1010', 'PIG@naver.com'); 
--������ ��ȿ�� ���� �ƴϴ��� �߰��ߵ� -> CHECK  �������� ����

--CHECK �������� : �ش� �÷��� ���ü��ִ� ���� ���� ������ ����, �ش� ���� �����ϴ� ���� ��������

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CONSTRAINT GENDER CHECK(GENDER IN ('��','��')), --�÷�������
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    --CHECK(GENDER IN ('��','��') ) 
); 

SELECT * FROM MEM_CHECK;
INSERT INTO MEM_CHECK VALUES(1, 'user01', 'pass01', '������', '��', '010-1010-1010', 'gyj@naver.com'); --�÷�������ŭ ���Է��ؾ���.
INSERT INTO MEM_CHECK VALUES(2, 'user02', 'pass03', '����', '��', '010-7777-1010', 'potato@naver.com'); 
INSERT INTO MEM_CHECK VALUES(3, 'user03', 'pass03', '�ѵ���', '��', '010-5335-1010', 'PIG@naver.com'); 
-- GENDER �� NOTNULL ����� NULL��������.  
/*
primary key �⺻Ű �������� 
���̺��� �� ����� �ĺ��ϱ� ���� ���� �÷��� �ο��ϴ� �������� (�ĺ����� ����)
primary key ���� ���� �ο��ϸ� ���÷��� �ڵ����� not null, unique ���� ���� ������.
���ǻ���� �����̺�� ������ �ѹ��� ��������
*/
CREATE TABLE MEM_PRI(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY,-- �÷��������
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3)  CHECK(GENDER IN ('��','��')), 
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    --, CONSTRAINT MEMNO_PK PRIMARY KEY(MEM_NO)--���̺������
); 
SELECT *FROM MEM_PRI;
INSERT INTO MEM_PRI VALUES(1, 'user01', 'pass01', '������', '��', '010-1010-1010', 'gyj@naver.com'); --�÷�������ŭ ���Է��ؾ���.

INSERT INTO MEM_PRI VALUES(1, 'user02', 'pass03', '����', '��', '010-7777-1010', 'potato@naver.com'); 
--ORA-00001: unique constraint (DDL.MEMNO_PK) violated
--�⺻Ű�� �ߺ����� �������ҋ� ����ũ �������ǿ� ����

--INSERT INTO ���̺�� VALUES()
INSERT INTO MEM_PRI VALUES(NULL, 'user02', 'pass03', '����', '��', '010-7777-1010', 'potato@naver.com'); 
--ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI"."MEM_NO")
--�⺻Ű�� NULL �������� �ҋ� �����������ǿ� ����

INSERT INTO MEM_PRI VALUES(2, 'user02', 'pass03', '����', '��', '010-7777-1010', 'potato@naver.com'); 

CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY,-- �÷��������
    MEM_ID VARCHAR2(20) PRIMARY KEY,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')), 
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)    
); 
--02260. 00000 -  "table can have only one primary key"
--�⺻Ű�� �ϳ��� �ȴ�.

CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')), 
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),  
    CONSTRAINT PRIKEY PRIMARY KEY(MEM_NO, MEM_ID) -- ����Ű
    
); 
SELECT * FROM MEM_PRI2;

INSERT INTO MEM_PRI2 VALUES(2, 'USER01', 'PASS01', '������', NULL, NULL, NULL);
INSERT INTO MEM_PRI2 VALUES(2, 'USER02', 'PASS01', '������', NULL, NULL, NULL);
INSERT INTO MEM_PRI2 VALUES(2, 'USER01', 'PASS01', '������', NULL, NULL, NULL);
--ORA-00001: unique constraint (DDL.PRIKEY) violated


--����Ű ��뿹��
--���ϱ� :�ѻ�ǰ�� �ѹ��� ���Ҽ�����.
--� ȸ���� ���ǰ�� ���ϴ����o ���� �����͸� �����ϴ� ���̺�

CREATE TABLE TB_LIKE(
    MEM_NO NUMBER,
    PRODUCT_NAME VARCHAR2(40),
    LIKE_DATE DATE,
    PRIMARY KEY(MEM_NO, PRODUCT_NAME)
);

SELECT * FROM TB_LIKE;
INSERT INTO TB_LIKE VALUES(1, '�鵵������', SYSDATE );
INSERT INTO TB_LIKE VALUES(1, '�鵵������', SYSDATE );
INSERT INTO TB_LIKE VALUES(2, '�鵵������', SYSDATE );
INSERT INTO TB_LIKE VALUES(1, '�鵵������', SYSDATE ); --ORA-00001: unique constraint (DDL.SYS_C007098) violated

/*
    FOREIGN KEY 
    
*/
--ȸ�� ��ޤ��� ���� ������ ���� ���� �ϴ� ���̺�
CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY, 
    GRADE_NAME VARCHAR2(30) NOT NULL
);
SELECT * FROM MEM_GRADE;
INSERT INTO MEM_GRADE VALUES(10, '�Ϲ�ȸ��');
INSERT INTO MEM_GRADE VALUES(20, '���ȸ��');
INSERT INTO MEM_GRADE VALUES(30, 'Ư��ȸ��');

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')), 
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER --ȸ����޹�ȣ ���� ������ �÷�
); 

SELECT * FROM MEM;
INSERT INTO MEM VALUES(1, 'user01' , 'pass01', '������','��' ,null, null, null);
INSERT INTO MEM VALUES(2, 'user02' , 'pass02', '�ǳ���','��' ,null, null, 10);
INSERT INTO MEM VALUES(3, 'user03' , 'pass03', '������','��' ,null, null, 90);

----------------------------------   FOREIGN KEY 
/*
����Ű ��������
�ٸ� ���̺� �����ϴ� ���� ���;��ϴ� ��Ư�� �÷��� �ο��ϴ� ��������
--> �ٸ� ���̺� �����Ѵٰ� ǥ��
--> �ַ� fk �������ǿ� ���� ���̺� ���谡 ������
>>�÷����
�÷� �ڷ��� [�������Ǹ� ] REFERENCES ������ ���̺�� (������ �÷���),, �������� PK�⺻Ű
>.���̺� ���
[�������Ǹ� ] FOREIGN KEY(�÷���) REFERENCES   ������ ���̺�� ..�������� PK�⺻Ű
*/

DROP TABLE MEM;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')), 
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) 
    --FOREIGN KEY (GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE)
); 

SELECT * FROM MEM;
INSERT INTO MEM VALUES(1, 'user01' , 'pass01', '������','��' ,null, null, null);
INSERT INTO MEM VALUES(2, 'user02' , 'pass02', '�ǳ���','��' ,null, null, 10);
INSERT INTO MEM VALUES(3, 'user03' , 'pass03', '������','��' ,null, null, 90);
--ORA-02291: integrity constraint (DDL.SYS_C007113) violated - parent key not found
