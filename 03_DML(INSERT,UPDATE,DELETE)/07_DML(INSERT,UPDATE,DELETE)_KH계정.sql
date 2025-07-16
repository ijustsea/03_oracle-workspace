--DQL (QUEREY ������ ���Ǿ��) : SELECT 

--DML (MANIPULATION ������ ���۾��) : INSERT, UPDATE, DELETE ,[SELECT]
--DDL (DEFINITION ������ ���Ǿ��) : CREATE, ALTER, DROP
--DCL (CONTROL ������ ������) : GRANT, REVOKE, [ROLLBACK]

--TCL (TRANSACTION CONTROL Ʈ����� ���� ���) : ROLLBACK, COMMIT

/*INSERT UPDATE DELETE : DATA MANIPULATION LANGUAGE ������ ���۾��(DML)*/
--���̺� ���� ����, ����, �����ϴ� ����.

--1.INSERT : ���̺� ���ο� ���� �߰��ϴ� ����

--ǥ����1 : INSERT INTO ���̺�� VALUES(��1, ��2, ��N..)  : ���̺� ���Į���� ���� ���� �����ؼ� ����INSERT �Ҷ� ���
--�����ϰ� ���� �����Ұ�� --> NOT ENOUGH VALUES ���� �߻�, ���� ���� �����ϸ� --> TOO MANY VALUES
INSERT INTO EMPLOYEE VALUES(900, '������', '910303-1234567', 'cha_ew@kh.or.kr', '01011117777', 'D1', 'J7', 'S3', 40000000, 0.5 , 200, SYSDATE, NULL, DEFAULT);
SELECT * FROM EMPLOYEE;
--ǥ����2 : INSERT INTO ���̺�� (�÷Ÿ�, �÷���, �÷���) VALUES (��1, ��2, ��3) : ���̺� �������÷��� ���� ���� INSERT�ҋ� ���
--�׷��� ��������� �߰� �Ǳ� ������ ���þ��� Į���� �⺻������ NULL�� ��
--��, DEFAULT���� �ִ°�� NULL�� �ƴ� DEFAULT �� ��.
-->NOT NULL ���������ִ� �÷��� �ݵ�� �����ؼ� ������ �ۼ��ؾ���.

INSERT 
  INTO EMPLOYEE
        (
        EMP_ID
        , EMP_NAME
        , EMP_NO
        , JOB_CODE
        , SAL_LEVEL
        , HIRE_DATE
        ) 
VALUES 
        (901
        , '�ں���'
        , '880101~1111111'
        ,'J1'
        ,'S2'
        , SYSDATE
        );
        
SELECT *fROM EMPLOYEE;

--ǥ����3 : INSERT INTO ���̺�� (��������) : VALUES ���� ��������ϴ°� ���, ���������� ��ȸ�Ȱ���� INSERT
CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(20)
);
SELECT * FROM EMP_01;
INSERT INTO EMP_01(SELECT EMP_ID, EMP_NAME, DEPT_TITLE
                    FROM EMPLOYEE 
                    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)                   
                    );
                    
--2.INSERT ALL :
--�׽�Ʈ�� ���̺� ������ �賢��
CREATE TABLE EMP_DEPT 
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE
    WHERE 1=0;
    
CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
    FROM EMPLOYEE
    WHERE 1=0;
    
SELECT * FROM EMP_DEPT;    
SELECT * FROM EMP_MANAGER ;    

--�μ��ڵ� D1 ������� ���, �̸� �μ��ڵ� �Ի��� ������ ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM EMPLOYEE
WHERE DEPT_CODE='D1';

/*
    ǥ���� INSERT ALL 
          INTO ���̺��1 VALUES(�÷���, �÷���,...)
          INTO ���̺��1 VALUES(�÷���, �÷���,...)
           ��������;
*/
INSERT ALL
INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
    FROM EMPLOYEE
    WHERE DEPT_CODE='D1';
--���� ����ؼ��� �����̺� INSERT ����
--2000�⵵ ���� �Ի��� ���� ���̺� 
CREATE TABLE EMP_OLD 
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1=0;


--2000�⵵ ���� �Ի��� ���� ���̺�
CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1=0;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;
/*
ǥ���� 
INSERT ALL 
WHEN ���� 1 THEN 
    INTO ���̺�1 VLAUES(Į����, Į����, ...)    
WHEN ���� 2 THEN 
    INTO ���̺�1 VLAUES(Į����, Į����, ...)
��������;
*/
    
INSERT ALL 
WHEN HIRE_DATE < '2000/01/01' THEN 
    INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
WHEN HIRE_DATE >= '2000/01/01' THEN
    INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
    SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE;

SELECT *FROM EMP_OLD;
SELECT *FROM EMP_NEW;


    
--3.UPDATE : ���̺� ������ ��ϵǾ��ִ� �����͸� �����ϴ� ����
--[ǥ����] UPDATE ���̺�� 
--           SET �÷��� = �ٲܰ�,
--               �÷��� = �ٲܰ�,    
--                 .... => �������� Į���� �� ���ÿ� ���氡��
--[WHERE ����]  => �����ϸ� ��ü ���̺� �ִ� ��� ���� ������ �� �����ϰ� �ٲ� ��         

CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM  DEPT_COPY;

UPDATE DEPT_COPY
    SET DEPT_TITLE ='������ȹ��'
WHERE DEPT_ID = 'D9';--���� ������ȹ������ �ٲ� WHERE �� �ʼ� 
ROLLBACK;

--���纻
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE;

SELECT * FROM EMP_SALARY;
--1 ���ö �޿��� 100������ ���� ~ �����͹��
UPDATE EMP_SALARY
    SET SALARY =1000000
--WHERE EMP_NAME = '���ö';--202	���ö	D9	3700000	
WHERE EMP_ID =202;

ROLLBACK;
--2 ������ �޿��� 700������ ���� ���ʽ� 0.25~ �����͹��
UPDATE EMP_SALARY
    SET SALARY =7000000,
        BONUS = 0.25
--WHERE EMP_NAME = '������';--200	������	D9	8000000	0.3
WHERE EMP_ID =200;
--3.��ü��� �޿��� �޿� 10���� �λ�
UPDATE EMP_SALARY
    SET SALARY = SALARY*1.1;
    
/*
    UPDATE ���̺��
        SET �÷��� = (��������)
    WHERE ����;
*/

--���� ����� �޿��� ���ʽ����� ��������� �����ϰ����
SELECT *FROM EMP_SALARY
WHERE EMP_NAME = '����';

--������ ���������� �ٲٴ°�
UPDATE EMP_SALARY
    SET  SALARY = (SELECT SALARY
                    FROM EMP_SALARY
                    WHERE EMP_NAME = '�����'),
        BONUS = (SELECT BONUS
                    FROM EMP_SALARY
                    WHERE EMP_NAME = '�����')
WHERE EMP_ID =214;

--���߿� ���������� �ٲٴ°�
UPDATE EMP_SALARY
    SET (SALARY, BONUS) = (SELECT SALARY, BONUS
                    FROM EMP_SALARY
                    WHERE EMP_NAME = '�����')
 WHERE EMP_ID =214; 


SELECT EMP_ID
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE= DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE LOCAL_NAME LIKE 'ASIA%';

UPDATE EMP_SALARY
    SET BONUS =0.3
WHERE EMP_ID IN (SELECT EMP_ID
                FROM EMPLOYEE
                JOIN DEPARTMENT ON (DEPT_CODE= DEPT_ID)
                JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
                WHERE LOCAL_NAME LIKE 'ASIA%');

SELECT * FROM EMP_SALARY;

UPDATE EMPLOYEE
SET EMP_NAME = NULL
WHERE EMP_ID =200;
--NOT NULL�������� ����

SELECT * FROM JOB;
UPDATE EMPLOYEE
    SET JOB_CODE = 'J9'
WHERE EMP_ID =203;
--FK ���� ���� ���� 
COMMIT;

--4.DELETE : ���̺� ��ϵ� �������͸� �����ϴ� ���� ~ ��������� ������
--ǥ���� DELETE FROM ���̺�� 
--      WHERE ���� ;  ���ǽ� �ʼ�

DELETE FROM EMPLOYEE
WHERE EMP_ID=900;

SELECT * FROM EMPLOYEE;
 
DELETE FROM EMPLOYEE
WHERE EMP_ID=901;   

ROLLBACK;--������ Ŀ�� �������� ���ư� 
COMMIT;

--DEPT_ID D1 �μ��� ���� 
DELETE FROM DEPARTMENT 
WHERE DEPT_ID ='D1';

SELECT * FROM EMPLOYEE;
ROLLBACK;

DELETE FROM DEPARTMENT 
WHERE DEPT_ID ='D3';
ROLLBACK;

--TRUNCATE ���̺� ��ü ���� �����ҋ� ���Ǵ� ���� ~ ����Ʈ���� ����ӵ� ����, ���� ���� ���� �Ұ� ,�ѹ�ȵ�.
-- ǥ���� : TRUNCATE TABLE ���̺��; ������ �α׸� ������. ~ ���������� Ŀ�Ե�.
SELECT * FROM EMP_SALARY;
TRUNCATE TABLE EMP_SALARY;
ROLLBACK;























































