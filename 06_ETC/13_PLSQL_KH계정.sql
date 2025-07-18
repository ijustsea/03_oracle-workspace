/*
   < PL/SQL ~ JAVA ���� ���� > 
    PROCEDURE LANGUAGE EXTENSION TO SQL 
    SQLȮ���� ���������. ����Ŭ��ü ����Ǿ�����.
    SQL���忡�� ������ ����,����(IF��),�ݺ�(FOR��)ó�� ���� ������
    �ټ��� SQL�� �ѹ��� ���డ��(BLOCK ����) + ����ó�� ����
    
    *PL / SQL ����
    -[�����] : DECLARE�� ����, ����|��� ���� �� �ʱ�ȭ    
    -�����   : BEGIN���� ����, �����Ұ���, SQL�� �Ǵ� ���(����,�ݺ�)���� �������
    -[����ó����] : EXCEPTION���� ����, ���ܹ߻��� �ذ��ϴ� ���� �̸� �ۼ�    
    
*/
--*�����ϰ� ȸ�鿡 HELLO ORACLE ���
SET SERVEROUTPUT ON ;--CONSOLEŰ��


BEGIN 
    --System.out.println("HELLO ORACLE");
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;--END �ʼ�
/
--���� ���ν����� �����ڿ���

/*
1.DECLARE �����
������ ��� �����ϴ� ���� (����� ���ÿ� �ʱ�ȭ�� ����)
�Ϲ�Ÿ�� ����, ���۷��� Ÿ�Ժ���, ROW Ÿ�Ժ���
1-1)�Ϲ�Ÿ�� ���� ����� �ʱ�ȭ
    [ǥ����] ������ [CONSTANT] �ڷ��� =��
*/

DECLARE 
    EID NUMBER;
    ENAME VARCHAR(20);
    PI CONSTANT NUMBER := 3.14;
BEGIN
    --EID := 800;
    --ENAME := '������';
    EID := &��ȣ;
    ENAME := '&�̸�';
    
    DBMS_OUTPUT.PUT_LINE('EID :'||EID);
    DBMS_OUTPUT.PUT_LINE('ENAME :'||ENAME);
    DBMS_OUTPUT.PUT_LINE('PI :'||PI);    
END;
/

-----------------------------------------------------------
--1_2) ���۷��� Ÿ�� ���� ����� �ʱ�ȭ(� ���̺��� � �÷��� ������ž�� �����ؼ� ��Ÿ������ ����) 
    --[ǥ����] ������ ���̺�.�÷���&TYPE;

--���۷���Ÿ�Ժ���

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN 
    --EID := '300';
    --ENAME := '��ÿ�';
    --SAL := 3000000;
    
    --���200���� ��� ����� �޿� ������ ����
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID,ENAME,SAL
    FROM EMPLOYEE
    WHERE EMP_ID= &���;    
    
    DBMS_OUTPUT.PUT_LINE('EID : '||EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : '||SAL);
END;
/

------------------------------�ǽ�����------------------------------
/*
���۷���Ÿ�Ժ��� EID, ENAME, JCODE, SAL, DTITLE�������ϰ�
�����ڷ����� ���۷����� 

����ڰ� �Է��� ����� ����� ���, �����,�����ڵ� �޿�, �μ��� ��ȸ���� �� ������ ��Ƽ� ���

*/
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE JOB.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
    INTO EID, ENAME, JCODE, SAL, DTITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE= DEPT_ID)
    JOIN JOB USING(JOB_CODE)
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('EID : '||EID);
    DBMS_OUTPUT.PUT_LINE('NAME : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('JOB : '||JCODE);
    DBMS_OUTPUT.PUT_LINE('SAL : '||SAL);
    DBMS_OUTPUT.PUT_LINE('DTITLE : '||DTITLE);
END;
/
----------------------------------------------------------------------
--1-3) ROW Ÿ�� ���� ����
--     ���̺��� ���࿡ ���� ��� �÷����� �Ѳ����� �������ִ� ����
--     [ǥ����] ������ ���̺��%ROWTYPE;

DECLARE 
    E EMPLOYEE%ROWTYPE;

BEGIN 
    SELECT *
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID =&���;
    
    DBMS_OUTPUT.PUT_LINE('����� : '||E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||E.SALARY);
    DBMS_OUTPUT.PUT_LINE('���ʽ� : '||NVL(E.BONUS, 0));
    DBMS_OUTPUT.PUT_LINE('�����ڵ� : '||E.JOB_CODE);
END;
/
--2.BEGIN ����� 
--<���ǹ�>
/*
1)IF ���ǽ� THEN ���� ���� END IF; (�ܵ� IF��)
--��� �Է¹��� �� �ش����� ��� �̸� �޿� ���ʽ���(%) ���
--�� ���ʽ��� ���� �ʴ� ����� ���ʽ��� ����� ���ʽ��� ���޹��� �ʴ� ����Դϴ�.���
*/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID =&���;
    
    DBMS_OUTPUT.PUT_LINE('��� : '||EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||SALARY);
   
    
    IF BONUS =0
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹����ʴ� ����Դϴ�.');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('���ʽ��� : '||BONUS*100||'%');
    
END;
/
--2 IF ���ǽ� THEN ���೻�� ELSE ���೻�� END IF;

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID =&���;
    
    DBMS_OUTPUT.PUT_LINE('��� : '||EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||SALARY);
   
    
    IF BONUS =0
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹����ʴ� ����Դϴ�.');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('���ʽ��� : '||BONUS*100||'%');
    END IF;    
    
END;
/
--�ǽ�����
--���۷���Ÿ�� ���� EID,ENAME, DTITLE, NCODE
--���������̺� EMPLOYEE, DEPARTMENT, LOCATION
--�Ϲ�Ÿ�� ����(TEAM���ڿ�) => �̵��� ������ Ȥ�� �ؿ��� ��濹��

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    TEAM VARCHAR(20);    
BEGIN
--����ڰ� �Է��� �纯�� ������ �ִ� ����� ���, �̸� , �μ���, �ٹ������ڵ� ��ȸ�� �������� ���� 
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE= DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID= LOCAL_CODE)
    JOIN NATIONAL USING(NATIONAL_CODE)
    WHERE EMP_ID=&���;

    DBMS_OUTPUT.PUT_LINE('��� : '||EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('�μ��� : '||DTITLE);
    
    IF NCODE='KO'        
        THEN TEAM :='������';        
    ELSE
        TEAM :='�ؿ���';        
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('�Ҽ� : '||TEAM);

--IF NOCODE KO �ϰ�� ������ TEAM�� �װԾƴ� ��� �ؿ���

--��� �̸� �μ��� �Ҽ�, 

END;
/


--3) IF ���ǽ�1 THEN ���೻��1  ELSIF ���ǽ�2 THEN ���೻��2  ELSE ���೻��3 END IF;

--�������� �Է¹޾� SCORE ������ ����
--90�� �̻��� 'A 80�� �̻��� 'B' 70���̻��� 'C'60���̻��� 'D' 60���̸��� F
--GRADE ������9����
--����������� XX���̰� ������ X�Դϴ�.

DECLARE
    SCORE NUMBER;
    GRADE VARCHAR2(1);
    
BEGIN
    SCORE := &����;
    
IF SCORE >=90 THEN GRADE:= 'A';
ELSIF SCORE >=80 THEN GRADE:= 'B';    
ELSIF SCORE >=70 THEN GRADE:= 'C';  
ELSIF SCORE >=60 THEN GRADE:= 'D';  
ELSE GRADE :='F';
END IF;

DBMS_OUTPUT.PUT_LINE('����� ������ '||SCORE||'���̰�,������ '||GRADE||'�Դϴ�.');

END;

/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    GRADE VARCHAR2(20);
BEGIN
    SELECT EMP_ID, SALARY
    INTO EID, SAL
    FROM EMPLOYEE
    WHERE EMP_ID =&���;
    
    IF SAL>=5000000 THEN GRADE := '���';
    ELSIF SAL>=3000000 THEN GRADE := '�߱�';
    ELSE  GRADE := '�ʱ�';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('�ش����� �޿������ '||GRADE||'�Դϴ�.');
END;
/
--4) case �񱳴���� when ����񱳰� then �����1 when ������Ұ� 2 then ����� ....else �����n end;

DECLARE
    EMP EMPLOYEE %ROWTYPE;
    DNAME VARCHAR2(30); --�μ��� �������� 
BEGIN
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID=&���;
    
    DNAME := CASE EMP.DEPT_CODE 
                  WHEN 'D1' THEN '�λ���'
                  WHEN 'D2' THEN 'ȸ����'
                  WHEN 'D3' THEN '��������'
                  WHEN 'D4' THEN '����������'                                
                  WHEN 'D9' THEN '�ѹ���'
                  ELSE '�ؿܿ�����'   
    END;
    
DBMS_OUTPUT.PUT_LINE(EMP.EMP_NAME ||'��(��)'||DNAME||'�Դϴ�');    

END;
/

--1. �������ϴ� ���ν���
--���ʽ��ִ� ����� ���ʽ� �����ؼ� ���
--���ʽ� ������ ���ʽ����Կ��� ������ ���ʽ� ������ ����
--�޿�, �̸�, \999,999,999 ����

DECLARE
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;    
BEGIN
    SELECT EMP_NAME, NVL(BONUS,0), SALARY
    INTO ENAME, BONUS, SALARY
    FROM EMPLOYEE
    WHERE EMP_ID = &���;

DBMS_OUTPUT.PUT_LINE(SALARY||', '||ENAME ||', '|| TO_CHAR((SALARY*(1+BONUS)*12), 'L999,999,999')); 

END;
/
-------------------------------------------------------------------------
--<�ݺ���>

/*
 1) BASIC LOOP��
 [ǥ����]
 LOOP 
    �ݺ������� ������ ����
    *�ݺ��� �����������ִ� ����
 END LOOP;
    
    *�ݺ��� ���������� ����
    1)IF ���ǽ� THEN EXIT;
    2)EXIT WHEN ���ǽ�;
    
*/
 
--1~5���� ���������� 1������
DECLARE 
    I NUMBER :=1;    
BEGIN
    LOOP 
        DBMS_OUTPUT.PUT_LINE(I);
        I :=I+1;
        
        --IF I = 6 THEN EXIT; END IF;
        EXIT WHEN I =6;
    END LOOP;
END;
/

/*
    2)FOR LOOP ��
    ǥ����
    FOR ���� IN �ʱⰪ ..������
    LOOP
        �ݺ����౸��
    END LOOP;
*/
BEGIN
    FOR I IN REVERSE 1..5 --REVERSE �ݴ��
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;

END;
/
DROP TABLE TEST;

CREATE TABLE TEST(
    TNO NUMBER PRIMARY KEY,
    TDATE DATE

);

SELECT * FROM TEST;

CREATE SEQUENCE SEQ_TNO
START WITH 1
INCREMENT BY 2
MAXVALUE 100
NOCYCLE
NOCACHE;                                       


BEGIN 
    FOR I IN 1..50
    LOOP
       INSERT INTO TEST VALUES (SEQ_TNO.NEXTVAL, SYSDATE);
    END LOOP;
END; 
/
/*
3) WHILE LOOP��
    [ǥ����]
    WHILE �ݺ����� ����� ����
    LOOP 
        �ݺ������� �����ұ���
    END LOOP;
*/

DECLARE 
    I NUMBER :=1;    
BEGIN 
    WHILE I <6
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        I:=I+1;
    END LOOP;
END;
/
-------------------------------------------------------------------------------------
--3.����ó����
--���� EXCEPTION : ������ �߻��ϴ� ����
--[ǥ����]
/*
EXCEPTION 
    WHEN ���ܸ�1 THEN ����ó������ 1;
    WHEN ���ܸ�2 THEN ����ó������ 2;
    ...
    WHEN ���ܸ�N THEN ����ó������ N;

    ������ ����
    *�ý��� ����(����Ŭ���� �̸������ص�)
    -NO_DATA_FOUND : SELECT ����� ���൵ ���°��
    -TOO_MANY_RESULT : SELECT ����� �������� ���
    -ZERO_DIVIDE : 0���� ������ �Ҷ� 
    -DUP_VAL_ON_INDEX : UNIQUE �������� ���� �ɋ�
*/
--ZERO_DIVIDE
DECLARE 
    RESULT NUMBER;
BEGIN
    RESULT :=10/&����;
    DBMS_OUTPUT.PUT_LINE('��� : '||RESULT);
EXCEPTION 
    --WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('������ ����� 0���� �����������ϴ�.');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('������ ����� 0���� �����������ϴ�.');
    
END;
/
--UNIQUE ��������
BEGIN 
    UPDATE EMPLOYEE
    SET EMP_ID=&�����һ��
    WHERE EMP_NAME ='���ö';
EXCEPTION 
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('�̹������ϴ� ����Դϴ�.');
    --WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('�̹������ϴ� ����Դϴ�.');
END;
/

DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME %TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME
    INTO EID, ENAME
    FROM EMPLOYEE
    WHERE MANAGER_ID =&������; -- 202  NO DATA, 200 TOO MANY, 211 ������
    
    DBMS_OUTPUT.PUT_LINE('��� : '|| EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '|| ENAME);
    
EXCEPTION 
    WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('�ʹ����� ���� ��ȸ�Ǿ����ϴ�.');
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('�ش� ����� ���� ����� �����ϴ�.');

END;
/

