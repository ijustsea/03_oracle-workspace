/*
    <VIEW ��> VIEW ~ �ӽ�(��)���̺� : ���� �����Ͱ� ���� �ƴϰ� �׳� �����ֱ� ��
    SELECT ���� �����صѼ��ִ� ��ü
    (���־��� �� SELECT���� �������ָ� �� �� SELECT���� �Ź� ����� �ʿ���� ����°�)
    �������� ���̺� : ���� �ִ°�
    ������ ���̺� : �߻����� �� => ��� ������ ������ ���̺��̴�.
*/ 

--VIEW ���� ������ �ۼ�
--������ ������

--'�ѱ�'���� �ٹ��ϴ� ������� ��� �̸� �μ��� �޿� �ٹ������� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY , NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID= LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME = '�ѱ�';

--'���þ�'���� �ٹ��ϴ� ������� ��� �̸� �μ��� �޿� �ٹ������� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY , NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID= LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME = '���þ�';

--'�Ϻ�'���� �ٹ��ϴ� ������� ��� �̸� �μ��� �޿� �ٹ������� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY , NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID= LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME = '�Ϻ�';

--��¦ ���ݸ� �޶����µ� �̰� �����ؼ� ������ �並 �������.
/* VIEW ������
   [ǥ����]
    CREATE [OR REPLACE] VIEW ���    
    AS ��������;    
    
    OR REPLACE : �� ������ ������ �ߺ��� �̸��� �䰡 ���ٸ� ������ �並 �����ϰ�, 
                         ������ �ߺ��� �̸��� �ֵ��� �ش� �並 �����ϴ� �ɼ�.
*/

CREATE VIEW VW_EMPLOYEE 
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY , NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID= LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE);
--ORA-01031: insufficient privileges(����) =>VIEW ���� �����ʿ�(SYSTEM ����)
--�����ڰ��������켭 ���� �ο�
GRANT CREATE VIEW TO KH;

SELECT * 
FROM VW_EMPLOYEE;--��¥! �� ���̺�, �������̺� --�̰��� ���� ���̺��� �ƴϴ�.

SELECT *
FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY , NATIONAL_NAME
        FROM EMPLOYEE
        JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        JOIN LOCATION ON (LOCATION_ID= LOCAL_CODE)
        JOIN NATIONAL USING(NATIONAL_CODE) );--�̰� �ζ��κ� /���� �׳� ��

SELECT * 
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME='�ѱ�';
SELECT * 
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME='���þ�';
SELECT * 
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME='�Ϻ�';

CREATE OR REPLACE VIEW VW_EMPLOYEE --�����ϰų� �ٲٰų�.
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY , NATIONAL_NAME, BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID= LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE);
--name is already used by an existing object
--�ش��̸� ���� �䰡 �̹� �־ ������

-- �� ��Ī ���̱�
CREATE OR REPLACE VIEW VW_EMP_JOB
AS SELECT EMP_ID, EMP_NAME, JOB_NAME , DECODE(SUBSTR(EMP_NO,8,1), '1','��','2','��') AS "����(��\��)", EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM HIRE_DATE) AS"�ٹ����"
   FROM EMPLOYEE
   JOIN JOB USING(JOB_CODE);--VIEW �������� ��Ī ���������� �ȸ������
--"must name this expression with a column alias" : Į���� ��Ī������� 
--�������� SELECT ���� �Լ����̳� �������� ����Ǿ����� ��� ��Ī ���� �� 

SELECT * FROM VW_EMP_JOB;--��¥! �������̺�, �� ���̺�

--��Ī�����ִ� �ٸ� ���.~ SELECT �ҋ� ����
CREATE OR REPLACE VIEW VW_EMP_JOB(���, �̸�, ���޸�, ����, �ٹ����)--�� �̷�������� ��Ī������ ��� �÷� �� ���.
AS SELECT EMP_ID, EMP_NAME, JOB_NAME , DECODE(SUBSTR(EMP_NO,8,1), '1','��','2','��'), EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM HIRE_DATE)
   FROM EMPLOYEE
   JOIN JOB USING(JOB_CODE);
   
SELECT * FROM VW_EMP_JOB;

SELECT �̸�, ���޸�
FROM VW_EMP_JOB
WHERE ���� = '��';

SELECT * 
FROM VW_EMP_JOB
WHERE �ٹ���� >=20;

DROP VIEW VW_EMP_JOB;--VIEW ���� 
-----------------------------------------------------
--������ �並 ���ؼ� DML ������ ������ ��밡��, 
--�並 ���ؼ� �����ϴ��� �������̺� �ݿ��̵Ǳ��ϳ� ������ �Ǵ°�� ���� �� ������ ����.'

CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE, JOB_NAME
    FROM JOB;

SELECT * FROM VW_JOB;--������ ���̺� ��¥���̺�, �������̺�

SELECT * FROM JOB; --�������̺�, �������̺�, ���̽� ���̺�

--VW�� ���� INSERT ����
INSERT INTO VW_JOB VALUES('J8','����');
--VW, JOB �Ѵ� INSERT �ߵǾ���. �����ϳ�? 

--VW�� ���� UPDATE ����
UPDATE VW_JOB 
SET JOB_NAME = '�˹�'
WHERE JOB_CODE ='J8';
--VW, JOB �Ѵ� UPDATE �ߵǾ���. �����ϳ�? 

--VW�� ���� DELETE ����
DELETE FROM VW_JOB
WHERE JOB_CODE='J8';
--VW, JOB �Ѵ� DELETE �ߵǾ���. �����ϳ�? 
----------------------------------------------------------------------------------
--VIEW�� ���� DML�� �Ҽ��ֱ��ϴ�. �� ���� �Ұ��� �� ��� �� �ξ� ����. 6���� ���
/*
1)�信 ���ǵ������� �÷� �����ϴ°�� 
2)�信 ���ǵ������� �÷� �� �������̺� �� NOTNULL�������� �����Ȱ��~�������� ����
3)�������� OR �Լ������� ���ǵ� �Լ�
4)GROUP BY, �׷��Լ�(SUM, AVG ..)���Ե� ���
5)DISTINCT ���� ���ԵȰ��
6)JOIN�� �̿��ؼ� �������̺�� ����� ���
*/--����� ��� ��ȸ������ ����ű� ������ DML �����ϴ°� �߱�.
--**����
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE FROM JOB;

SELECT *FROM VW_JOB; --��¥���̺� �����̺�
SELECT *FROM JOB; --�������̺� 
--1)�信 ���ǵ������� �÷� �����ϴ°�� 
--INSERT : �ȵ�
INSERT INTO VW_JOB VALUES('J8', '����');
--"too many values" �信 ���ǵ� �÷��� �ϳ��ۿ� ���� ������ INSERT ��������.
--UDATE : �ȵ�
UPDATE VW_JOB
SET JOB_NAME='����'
WHERE JOB_CODE='J7'; --  invalid identifier" UPDATE������ 
--DELETE : �ȵ�
DELETE FORM VW_JOB
WHERE JOB_NAME ='���';--����

--2)�信 ���ǵ������� �÷� �� �������̺� �� NOTNULL�������� �����Ȱ��~�������� ����
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_NAME FROM JOB;

SELECT *FROM VW_JOB; 
SELECT * FROM JOB;
--INSERT : �ȵ�
INSERT INTO VW_JOB VALUES('����');--cannot insert NULL into ("KH"."JOB"."JOB_CODE")
--UPDATE : ��
UPDATE VW_JOB
SET JOB_NAME ='�˹�'
WHERE JOB_NAME ='���';
ROLLBACK;
--DELETE �����ִ� �ڽ��־ �ȵ� ���� �Ǵ°Ͱ���
DELETE FROM VW_JOB
WHERE JOB_NAME='���';--ORA-02292: integrity constraint (KH.SYS_C007151) violated - child record found

--3)�������� OR �Լ������� ���ǵ� �Լ�
CREATE OR REPLACE VIEW VW_EMP_SAL
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 AS "����"
    FROM EMPLOYEE;

SELECT * FROM VW_EMP_SAL;
SELECT * FROM EMPLOYEE;
--INSERT : �ȵ�
INSERT INTO VW_EMP_SAL VALUES(400,'������',3000000,36000000);
--virtual column not allowed here ���� �÷� ��¿���� �ȵ���
--UPDATE :�Ǵ°� �ְ� �ȵǴ°��ְ� 
UPDATE VW_EMP_SAL
SET ���� =80000000
WHERE EMP_ID =200;-- ���� 

UPDATE VW_EMP_SAL
SET SALARY =7000000
WHERE EMP_ID=200;-- SALARY�� �ȴ�.
ROLLBACK;
--DELETE: ��
DELETE FROM VW_EMP_SAL
WHERE ���� =72000000;--�ȴ�.
ROLLBACK;

--4)GROUP BY, �׷��Լ�(SUM, AVG ..)���Ե� ���
CREATE OR REPLACE VIEW VW_GROUPDEPT
AS SELECT DEPT_CODE, SUM(SALARY) AS "�հ�", FLOOR(AVG(SALARY)) AS "���"
    FROM EMPLOYEE
    GROUP BY DEPT_CODE;
    
SELECT * FROM VW_GROUPDEPT;-- ���� ��¥ �� ���̺�
--INSERT : �ȵ�
INSERT INTO VW_GROUPDEPT VALUES('D3', '8000000', '4000000');
--virtual column not allowed here  �ǰ� ��?
--UPDATE : �ȵ�
UPDATE VW_GROUPDEPT
SET �հ� =8000000
WHERE DEPT_CODE= 'D1';--���� 
--DELETE : �ȵ�
DELETE FROM VW_GROUPDEPT 
WHERE �հ� = 5210000;--���� 

--5)DISTINCT ���� ���ԵȰ��
CREATE OR REPLACE VIEW VW_DT_JOB
AS SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

SELECT * FROM VW_DT_JOB;
--INSERT : ���� 
INSERT INTO VW_DT_JOB VALUES('J8');--�ȵ�
--UPDATE : ���� 
UPDATE VW_DT_JOB
SET JOB_CODE ='J8'
WHERE JOB_CODE='J7';--data manipulation operation not legal on this view
--DELETE : ���� 
DELETE FROM VW_DT_JOB
WHERE JOB_CODE='J4';--data manipulation operation not legal on this view
--6)JOIN�� �̿��ؼ� �������̺�� ����� ���
CREATE OR REPLACE VIEW VW_JOINEMP 
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE= DEPT_ID);

SELECT * FROM VW_JOINEMP;
--INSERT : ����
INSERT INTO VW_JOINEMP VALUES(300, '�����', '�ѹ���' );
--UPDATE : �ǰų� �ȵ�
UPDATE VW_JOINEMP
SET EMP_NAME ='������'
WHERE EMP_ID =200;
ROLLBACK;

UPDATE VW_JOINEMP
SET DEPT=TITLE ='ȸ���'
WHERE EMP_ID =200;--�ȵ�

--DELETE : �ǰų� �ȵ�
DELETE FROM VW_JOINEMP
WHERE EMP_ID=200;
ROLLBACK;--��

DELETE FROM VW_JOINEMP
WHERE DEPT_TITLE;--�ȵ�

--�׳� VIEW DML������
/*
    VIEW �ɼ�~  FORCE|NOFORCE , WITH CHECK OPTION , WITH READ ONLY
    [ǥ����]
    CREATE [OR REPLACE] [FORCE|NOFORCE] VIEW ���
    AS �������� 
    [WITH CHECK OPTION]
    [WITH READ ONLY]
    
    1) OR REPLACE : ������ ������ �䰡 ������� ����, �������������� ���Ӱ� ����  
    2) FORCE  : ���������� ����� ���̺��� �������� �ʾƵ� �䰡 �����ǰ� �ϴ°�
       NOFORCE : ���������� ����� ���̺������ �� �����ȵǰ� : DEFAULT
    3) WITH CHECK OPTION : DML�� ���������� ����� ���ǿ� ������ �����θ� DML�����ϵ��� 
    4) WITH READ ONLY : ������ �ȵǰ� �б⸸ �Ǵ� �ɼ� ~ �信���ؼ� ������ �ȵǰ� ���� ��ȸ�� ���� (DML ����Ұ�)
*/

--2)FORCE|NOFORCE
CREATE OR REPLACE /*NOFORCE*/ VIEW VW_EMP
AS SELECT TCODE, TNAME, TCONTENT
FROM TT;--table or view does not exist

CREATE OR REPLACE FORCE VIEW VW_EMP
AS SELECT TCODE, TNAME, TCONTENT
FROM TT;--���: ������ ������ �Բ� �䰡 �����Ǿ����ϴ�.

SELECT * FROM VW_EMP;--��ȸ�ȵ�.
--TT���̺� ��������� ��� ��ȸ ����
CREATE TABLE TT(
    TCODE NUMBER,
    TNAME VARCHAR2(20),
    TCONTENT VARCHAR2(30)

);
--�÷��� �˰� ���̺��� �̵� ���鶧 ����ϴ� ���

--3)WITH CHECK OPTION : ���������� ����� ���ǿ� �������� �ʴ� ������ ������ ���� �߻�
-- WITH CHECK OPTION �Ⱦ���
 CREATE OR REPLACE VIEW VW_EMP
 AS SELECT *
    FROM EMPLOYEE
    WHERE SALARY>=3000000;
SELECT * FROM VW_EMP;

UPDATE VW_EMP
SET SALARY = 2000000--8000000
WHERE EMP_ID=200;
ROLLBACK;


-- WITH CHECK OPTION ���� 
 CREATE OR REPLACE VIEW VW_EMP
 AS SELECT *
    FROM EMPLOYEE
    WHERE SALARY>=3000000
    WITH CHECK OPTION;
    
SELECT * FROM VW_EMP;

UPDATE VW_EMP
SET SALARY=2000000 
WHERE EMP_ID =200;
--view WITH CHECK OPTION where-clause violation
--���������� ����� ���ǿ� �������� �ʾ� ������ �Ұ�����.

UPDATE VW_EMP
SET SALARY=4000000 
WHERE EMP_ID =200;--���������� ����� ���� >=3000000 �� �����Ͽ� ���氡��
ROLLBACK;

--4)WITH READ ONLY : �߿�! ������ �ȵǰ� �б⸸ �Ǵ� �ɼ�~ ��ȸ�� ����( DML ���� �Ұ�)
CREATE OR REPLACE VIEW VW_EMP
AS SELECT EMP_ID, EMP_NAME, BONUS
    FROM EMPLOYEE
    WHERE BONUS IS NOT NULL
WITH READ ONLY;

SELECT * FROM VW_EMP;
DELETE FROM VW_EMP
WHERE EMP_ID=200;
--cannot perform a DML operation on a read-only view
--�б� ������.


