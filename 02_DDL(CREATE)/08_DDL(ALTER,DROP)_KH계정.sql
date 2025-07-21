/*DATA DEFINITION LANGUAGE~ ��Ƽ�� ���Ǿ�� : ��ü�� ���� ���� �����ϴ� ����. */
--CREATE ALTER DROP

--<ALTER> : ��ü�� ����
--ALTER TABLE ���̺�� ������ ����;

--������ ���� 
--1)�÷� �߰�/����/�� ��
--1.�÷��߰�(ADD) : ADD �÷��� �ڷ��� ����Ʈ �������� 
--DEPT_COPY�� CNAME �÷� �߰�
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR(20);
SELECT * FROM DEPT_COPY;

ALTER TABLE DEPT_COPY ADD LNAME VARCHAR(20) DEFAULT '�ѱ�';

--2.�÷�����(MODIFY)
-->�ڷ��� ����  : MODIFY  �÷��� �ٲٰ����ϴ� �ڷ���
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUBMER;--�ȵ�
ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR(10);--�̹� �ִ� �����Ͱ��� ������ ũ�⺸�� Ŀ��
-->DEFAULT ����: MODIFY  �÷��� DEFAULT �ٲٰ����ϴ� �⺻��

--DEPT TITLE �÷��� VARCHAR2(50)
ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(50);
--LOCATION_ID �÷��� VARCHAR2(4)
ALTER TABLE DEPT_COPY MODIFY LOCATION_ID VARCHAR2(4);
--LNAME �÷��� �⺻���� '�̱�'���� ����
ALTER TABLE DEPT_COPY MODIFY LNAME DEFAULT '�̱�';
--����Ʈ�� �ٲ۴��ؼ� ���������Ͱ��� �ȹٲ�
ALTER TABLE DEPT_COPY 
    MODIFY DEPT_TITLE VARCHAR2(50)
    MODIFY LOCATION_ID VARCHAR2(4)
    MODIFY LNAME DEFAULT '�̱�';
--3.�÷�����(DROP COLUMN) : DROP COLUMN �����ϰ��� �ϴ� �÷���
CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

SELECT * FROM DEPT_COPY2;
--DEPT_COPY2�κ��� DEPT_ID Į�������
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;--���߻����� �Ұ�
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
--ORA-12983: cannot drop all columns in a table �ּ��Ѱ� �÷� �־����.


--2)�������� �߰�/���� --> ������ �Ұ�(�����ϰ����Ѵٸ� ������ ���� �߰�)
--2-1 �������� �߰�
   -- PRIMARY KEY : ADD PRIMARY KEY(Į����)
   -- FOREIGN KEY : ADD FOREIGN KEY(Į����)  REFFERENCES ���������̺�
   -- UNIQUE : ADD UNIQUE(Į����)    
   -- CHECK : ADD CHEKCK(Į�������� ����)
   -- NOT NUL : MODIFY  �÷Ÿ�  NULL|NOTNULL 
   -- �������� �����ϰ����Ѵٸ� CONSTRAINT �����ϸ��
 
ALTER TABLE DEPT_COPY
    ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID)
    ADD CONSTRAINT DCOPY_UQ UNIQUE(DEPT_TITLE)
    MODIFY LNAME CONSTRAINT DCOPY_NN NOT NULL;    

--2-2 ���� ���� ���� : DROP CONSTRAINT �������Ǹ�
--NOT NULL�� ������ �ȵǼ� MODIFY �� ��������
ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_PK;

ALTER TABLE DEPT_COPY
    DROP CONSTRAINT DCOPY_UQ
    MODIFY LNAME NULL;
--3)�÷���/���̺�� ����
--3-1 �÷��� ���� : RENAME COLUMN �����÷��� TO �ٲ� �÷���
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;
--3-2 �������Ǹ� ���� : RENAME CONSTRAINT 
--SYS_C007194
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007194 TO DOCOPY_LID_NN;
--3-3 ���̺�� ���� RENAME �������̺�� TO �ٲ����̺��
    ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;

------------------------------------------------------------------------

--<DROP> : ��ü�� ����

DROP TABLE DEPT_TEST;

--�� ��� �����ǰ��ִ� �θ����̺��� ���� �߾ȵ� 
--�����ϰ��� �Ѵٸ�
--���1. �ڽ� ���̺� ���� ������ �θ����� ����
--���2. �׳� �θ����̺� �����ϴµ� �������Ǳ��� ���� �����ϴ� ��� 
--        DROP TABLE ���̺�� CASCADE CONSTRAINT




















