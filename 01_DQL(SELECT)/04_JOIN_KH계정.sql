/*
<JOIN>
 �ΰ��̻��� ���̺��� ���̺��� ��ȸ�ϰ��� �ҋ� ���Ǵ±���.
 ��ȸ����� �ϳ��� �������(RESULT SET)���� ����.
 
 ������ �����ͺ��̽��� �ּ����� �����ͷ� ������ ���̺� �����͸� ������� (�ߺ��� �ּ�ȭ�ϱ�����)
 
 --� ����� � �μ��� ���� �ִ��� �ñ���.
 =>������ �����ͺ��̽����� SQL���� �̿��ؼ� ���̺� ���� �δ¹�
 (������ �� ��ȸ�ϴ°� �ƴ϶�, �����̺� ������ν� �����͸� ��Ī��Ű�¹��)
 
 Joinũ�� ����Ŭ ���뱸���� ansi ���� 
 
                                    [JOIN �������] 
            ����Ŭ ���뱸��                  |                ANSI ����
 -------------------------------------------------------------------------------------           
               �����                     |           ��������(INNER JOIN)
            [EQUAL JOIN]                  |           �ڿ�����(NATURAL JOIN)
 -------------------------------------------------------------------------------------           
               ��������                     |        ���� �ܺ�����(LEFT OUTER JOIN)
            (LEFT OUTER)                  |      ������ �ܺ�����(RIGHT OUTER JOIN)
            (RIGHT OUTER)                 |         ��ü �ܺ�����(FULL OUTER JOIN)
 ------------------------------------------------------------------------------------                       
               ��ü����(SELF JOIN)          |      JOIN ON     
            �� ����(NON EQUAL JOIN)     |
  ------------------------------------------------------------------------------------                       

*/

--��ü������� ���,�����,�μ��ڵ�,�μ�����ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

--��ü������� ���,�����,�����ڵ�,���޸�
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;

SELECT JOB_CODE, JOB_NAME
FROM JOB;
--1.����� (EQUAL JOIN)/��������(INNERJOIN)
--�����Ű�� Į������ ��ġ�ϴ� ��鸸 ���εż� ��ȸ 

-->����Ŭ ���뱸������ ����
-- FROM ���� ��ȸ�ϰ� �ϴ� ���̺��� ���� , �����ڷ�
-- WHERE���� ��Ī��ų �÷�(�����) ������ ������ ������.
--1)������ �� �÷����� �ٸ���� (DEPT_CODE, DEPT_ID)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE= DEPT_ID;
--D��ġ�ϴ� ���� ���� ���� ��ȸ���� ����
--~NULL, D3 ,D5 , D7 ��ȸX

--1)������ �� �÷����� �ٸ���� (JOB_CODE)
--��ü������� ���,�����,�����ڵ�,���޸�
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

--2.���̺� ��Ī �ο����ؼ��Ѵ¹��
--
SELECT  EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE =J.JOB_CODE;                          

-- ANSI����
--FORM ���� ������ �Ǵ� ���̺� �ϳ� ����� 
--JOIN ���� ���� ��ȸ���� �ϴ� ���̺� ��� + ��Ī ��ų �÷��� ���� ���ǵ� ���
--JOIN USING JOIN  ON

--1)������  ���÷����� �ٸ���� ������JOIN������ ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

--1)������  ���÷����� ������� 
--JOIN ON , JOIN USING���� ��밡��
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);

--2) JOIN USING 
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB USING(JOB_CODE);

--�ڿ����� �����̺� ���� ������ �÷����� �Ѱ��� �����ϴ°��
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;

--�߰����� ���� ���� 
--���޸� �븮�� ����� �̸�, ���޸�, �޿���ȸ
--1)����Ŭ ���뱸��
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E ,JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND J.JOB_NAME= '�븮';
--2)ANSI����
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME ='�븮';

--�ǽ�����-------------------------------------------------------------------
--1.�μ��� �λ� �������� ������� ���, �̸�, ���ʽ� ��ȸ
-->>����Ŭ
SELECT EMP_ID, EMP_NAME, BONUS, D.DEPT_TITLE
FROM EMPLOYEE E,DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
AND D.DEPT_TITLE= '�λ������';
-->>ANSI
SELECT EMP_ID, EMP_NAME, BONUS, D.DEPT_TITLE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE D.DEPT_TITLE= '�λ������';

--2.DEPARTMENT�� LOCATION �����Ͽ� ��ü�μ��Ǻμ��ڵ�,�μ���, �����ڵ�, ������ ��ȸ
-->>����Ŭ
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT D, LOCATION L
WHERE D.LOCATION_ID= L.LOCAL_CODE;
-->>ANSI
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT D
JOIN LOCATION L ON ( D.LOCATION_ID= L.LOCAL_CODE);


--3.���ʽ��� �޴� ������� ���, �����, ���ʽ�, �μ��� ��ȸ
-->>����Ŭ
SELECT EMP_ID, EMP_NAME, BONUS, D.DEPT_TITLE
FROM EMPLOYEE E,DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
AND E.BONUS IS NOT NULL;
-->>ANSI
SELECT EMP_ID, EMP_NAME, BONUS, D.DEPT_TITLE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE E.BONUS IS NOT NULL;
--4.�μ��� �Ѹ�ΰ� �ƴѻ������ ����� �޿� , �μ��� ��ȸ
-->>����Ŭ
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND DEPT_TITLE ^= '�ѹ���';

-->>ANSI
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE ^= '�ѹ���';

/*
    2.�������� / �ܺ����� (OUTER JOIN)
    ��  ���̺� ���� JOIN�� ��ġ���� �ʴ� �൵ ���Խ��Ѽ� ��ȸ����
    ��, �ݵ�� LEFT/ RIGHT �����ؾ��� (���� �Ǵ� ���̺� ����)

*/
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY *12 AS ����
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
--�μ���ġ�� �����ȵ� ��� 2�� ���� ������ ����
-- D3 D4 D7�� �ο���ġ�� ���� �μ��� ��ȸ �ȵ�.

--1)LEFT [OUTER] JOIN  : �����̺� �� ���� ��������̺�������� JOIN
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY *12 AS ����
FROM EMPLOYEE--EMPLOYEE���ִ°� ������ �ٳ���
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
--����Ŭ ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY *12 AS ����
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);--�������� ����� �ϴ� ���̺� �ݴ��� �÷��ڿ� (+)���̱�

--2)RIGHT [OUTER] JOIN  : �����̺� �� ������ ��������̺�������� JOIN
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY *12 AS ����
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
--����Ŭ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY *12 AS ����
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

--3)FULL [OUTER] JOIN : ANSI�� ���� : �����̺� ���� ��� ���� ��ȸ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY *12 AS ����
FROM EMPLOYEE--EMPLOYEE���ִ°� ������ �ٳ���
FULL JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

/*
3.��ü���� : ���� ���̺��� �ٽ��ѹ� �����ϴ°�� (SELF JOIN)
 */
 
 SELECT *FROM EMPLOYEE;
 
 --��ü ����� ��� �����, ����μ��ڵ� EMPLOYEE E
   --  ����� ���, �����, ����μ�ũ�� EMPLOYEE M
--����Ŭ
SELECT E.EMP_ID "������", E.EMP_NAME"�����", E.DEPT_CODE"����μ��ڵ�",
M.EMP_ID"������", M.EMP_NAME"�����", M.DEPT_CODE"����μ��ڵ�"
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID;
--ANSI
SELECT E.EMP_ID "������", E.EMP_NAME"�����", E.DEPT_CODE"����μ��ڵ�",
M.EMP_ID"������", M.EMP_NAME"�����", M.DEPT_CODE"����μ��ڵ�"
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);
------------------------------------------------------------------------
/*
�������� 
2���̻� ���̺� ������ �����Ҷ� ������ �����.
*/

--��� ����� �μ��� ���޸�
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE DEPT_CODE= DEPT_ID AND E.JOB_CODE= J.JOB_CODE;

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (DEPT_CODE= DEPT_ID) 
JOIN JOB J USING (JOB_CODE);

--��� �����, �μ��� ������ 
SELECT * FROM EMPLOYEE; --DEPT CODE
SELECT * FROM DEPARTMENT; --DEPT_ID, LOCATION_ID
SELECT * FROM LOACATION; --LOCAL CODE

-->>����Ŭ ���뱸��
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE DEPT_CODE = DEPT_ID AND LOCATION_ID = LOCAL_CODE;
-->>ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE 
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

--�ǽ�
--1.���, ����� , �μ���, ������ ,������ ��ȸ
-->>����Ŭ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION L,NATIONAL N 
WHERE DEPT_CODE = DEPT_ID AND LOCATION_ID = LOCAL_CODE AND 
L.NATIONAL_CODE=N.NATIONAL_CODE;
-->>ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE);


--2.��� ����� �μ��� ���޸�, ������ �ش�޿� ��޿��� ������ �ִ� �ִ�ݾ� ��ȸ (������̺� ����)
-->>ORACLE
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, NATIONAL_NAME, MAX_SAL
FROM EMPLOYEE E, DEPARTMENT, JOB J, LOCATION L, NATIONAL N, SAL_GRADE S
WHERE DEPT_CODE = DEPT_ID AND E.JOB_CODE= J.JOB_CODE AND LOCATION_ID = LOCAL_CODE 
AND L.NATIONAL_CODE=N.NATIONAL_CODE AND E.SAL_LEVEL = S.SAL_LEVEL;

-->>ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, NATIONAL_NAME, MAX_SAL
FROM EMPLOYEE 
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
JOIN SAL_GRADE USING(SAL_LEVEL);

