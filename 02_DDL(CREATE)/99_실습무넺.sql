--�ǽ�����--
--�������� ���α׷��� ����� ���� ���̺��� �����
--�̶�, �������ǿ� �̸��� �ο��� ��
-- �� �÷��� �ּ��ޱ�

--1. ���ǻ�鿡 ���� �����͸� ��� ���� ���ǻ� ���̺�(TB_PUBLISHER)
--�÷�: PUB_NO(���ǻ��ȣ) --�⺻Ű(PUBLISHER_PK)
-- PUB_NAME(���ǻ��) --NOT NULL(PUBLICHSER_NN)
-- PHONE(���ǻ���ȭ��ȣ) --�������� ����

CREATE TABLE TB_PUBLISHER(
    PUB_NO NUMBER CONSTRAINT PUBLISHER_PK PRIMARY KEY,
    PUB_NAME VARCHAR2(40) CONSTRAINT PUBLISHER_NN NOT NULL,
    PHONE VARCHAR2(20)
);

--3�� ������ ���� ������ �߰��ϱ�
SELECT * FROM TB_PUBLISHER;
INSERT INTO TB_PUBLISHER VALUES('1', '���������ǻ�', '02-1234-1234');
INSERT INTO TB_PUBLISHER VALUES('2', '�������ǻ�', '02-3333-3333');
INSERT INTO TB_PUBLISHER VALUES('3', '�������ǻ�', '02-8888-8888');



--2. �����鿡 ���� �����͸� ��� ���� ���� ���̺�(TB_BOOK)
--�÷�: BK_NO(������ȣ) --�⺻Ű(BOOK_PK)
-- BK_TITLE(������) --NOT NULL(BOOK_NN_TITLE)
-- BK_AUTHOR(���ڸ�) --NOT NULL(BOOK_NN_AUTHOR)
-- BK_PRICE(����)
-- BK_STOCK(���) --�⺻�� 1�� ����
-- BK_PUB_NO(���ǻ��ȣ) --�ܷ�Ű(BOOK_FK)(TB_PUBLISHER ���̺��� �����ϵ���)
-- �̶� �����ϰ� �ִ� �θ����� ���� �� �ڽĵ����͵� �����ǵ��� ����

CREATE TABLE TB_BOOK(
    BK_NO NUMBER CONSTRAINT BOOK_PK PRIMARY KEY,
    BK_TITLE VARCHAR2(40) CONSTRAINT BOOK_NN_TITLE NOT NULL,
    BK_AUTHOR VARCHAR2(30) CONSTRAINT BOOK_NN_AUTHOR NOT NULL,
    BK_PRICE NUMBER,
    BK_STOCK NUMBER DEFAULT 1,
    BK_PUB_NO NUMBER REFERENCES TB_PUBLISHER ON DELETE CASCADE

);

DROP TABLE TB_BOOK;
--5�� ������ ���� ������ �߰��ϱ�
SELECT * FROM TB_BOOK;
INSERT INTO TB_BOOK VALUES('1','���� ����1', '����Ŭ����', 15000, DEFAULT, 1 );
INSERT INTO TB_BOOK VALUES('2','���� ����2', '����Ŭ����', 15000, DEFAULT, 2 );
INSERT INTO TB_BOOK VALUES('3','���� ����3', '����Ŭ����', 15000, DEFAULT, 2 );
INSERT INTO TB_BOOK VALUES('4','���� ����4', '����Ŀ��', 15000, 20, 3 );
INSERT INTO TB_BOOK VALUES('5','���� ����5', '��������', 15000, 20, 3 );

DELETE FROM TB_PUBLISHER
WHERE PUB_NO =3;

ROLLBACK;

--3. ȸ���� ���� �����͸� ��� ���� ȸ�� ���̺�(TB_MEMBER)
--�÷���: MEMBER_NO(ȸ����ȣ) --�⺻Ű(MEMBER_PK)
--MEMBER_ID(���̵�) --�ߺ�����(MEMBER_UQ)
--MEMBER_PWD(��й�ȣ) NOT NULL(MEMBER_NN_PWD)
--MEMBER_NAME(ȸ����) NOT NULL(MEMBER_NN_NAME)
--GENDER(����) 'M' �Ǵ� 'F'�� �Էµǵ��� ����(MEMBER_CK_GEN)
--ADDRESS(�ּ�)
--PHONE(����ó)
--STATUS(Ż�𿩺�) --�⺻������ 'N' �׸��� 'Y' Ȥ�� 'N'���� �Էµǵ��� ��������(MEMBER_CK_STA)
--ENROLL_DATE(������) --�⺻������ SYSDATE, NOT NULL ����(MEMBER_NN_EN)

CREATE TABLE TB_MEMBER(
    MEMBER_NO NUMBER CONSTRAINT MEMBER_PK PRIMARY KEY,
    MEMBER_ID VARCHAR2(40) CONSTRAINT MEMBER_UQ UNIQUE,
    MEMBER_PWD VARCHAR2(30) CONSTRAINT MEMBER_NN_PWD NOT NULL,
    MEMBER_NAME VARCHAR2(40) CONSTRAINT MEMBER_NN_NAME NOT NULL,
    GENDER CHAR(3) CONSTRAINT MEMBER_CK_GEN CHECK(GENDER IN ('M','F')), 
    ADDRESS VARCHAR(50),
    PHONE VARCHAR(13),
    STATUS CHAR(3) DEFAULT 'N' CONSTRAINT MEMBER_CK_STA CHECK(STATUS IN ('Y','N')),
    ENROLL_DATE DATE DEFAULT SYSDATE CONSTRAINT MEMEBER_NN_EN NOT NULL
);


--5�� ������ ���� ������ �߰��ϱ�
SELECT * FROM TB_MEMBER;
INSERT INTO TB_MEMBER VALUES('1001', 'user01','pwd01','���1','M','����', null, default, default);
INSERT INTO TB_MEMBER VALUES('1002', 'user02','pwd02','������','M','����', null, default, '25/02/11');
INSERT INTO TB_MEMBER VALUES('1003', 'user03','pwd03','���3','F','���', null, default, '25/01/01');
INSERT INTO TB_MEMBER VALUES('1004', 'user04','pwd04','���4','F','ȫ��', null, default, '25/04/30');
INSERT INTO TB_MEMBER VALUES('1005', 'user05','pwd05','���5','F','���', null, default, '25/06/06');

DELETE FROM TB_MEMBER
WHERE MEMBER_NO =1002;

--4. ������ �뿩�� ȸ���� ���� �����͸� ��� ���� �뿩��� ���̺�(TB_RENT)
--�÷�:
--RENT_NO(�뿩��ȣ) --�⺻Ű(RENT_PK)
--RENT_MEM_NO(�뿩ȸ����ȣ) --�ܷ�Ű(RENT_FK_MEM) TB_MEMBER�� �����ϵ���
--�̶� �θ����� ���� �� NULL���� �ǵ��� �ɼ� ����
--RENT_BOOK_NO(�뿩������ȣ) --�ܷ�Ű(RENT_FK_BOOK) TB_BOOK�� �����ϵ���
--�̶� �θ����� ���� �� NULL���� �ǵ��� �ɼǼ���
--RENT_DATE(�뿩��) --�⺻�� SYSDATE
CREATE TABLE TB_RENT(
    RENT_NO NUMBER CONSTRAINT RENT_PK PRIMARY KEY,
    RENT_MEM_NO NUMBER REFERENCES TB_MEMBER(MEMBER_NO) ON DELETE CASCADE,
    RENT_BOOK_NO NUMBER REFERENCES TB_BOOK(BK_NO) ON DELETE SET NULL,
    RENT_DATE DATE DEFAULT SYSDATE
);

--���õ����� 3������ �߰��ϱ�
SELECT * FROM TB_RENT;
INSERT INTO TB_RENT VALUES(1, 1001, 1, SYSDATE);
INSERT INTO TB_RENT VALUES(2, 1002, 2, '25/05/05');
INSERT INTO TB_RENT VALUES(3, 1003, 3, '25/03/15');


--2�� ������ �뿩�� ȸ���� �̸�, ���̵�, �뿩��, �ݳ�������(�뿩��+7)�� ��ȸ�Ͻÿ�.
SELECT MEMBER_NAME AS �̸� , MEMBER_ID AS ���̵�, RENT_DATE AS �뿩��, (RENT_DATE+7) AS �ݳ�������
FROM TB_RENT
JOIN TB_PUBLISHER ON (RENT_NO = PUB_NO )
JOIN TB_MEMBER ON (RENT_MEM_NO = MEMBER_NO)
JOIN TB_BOOK ON ( RENT_BOOK_NO = BK_NO )
WHERE BK_NO= 2; 

