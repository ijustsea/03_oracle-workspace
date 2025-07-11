/*
    <SELECT>
    ������ ��ȸ �� ����ϴ� ����
    
    >>RESULT SET : SELECT���� ���� ��ȸ�� �����( = ��ȸ�� ����� ����)
        
    [ǥ����]
    SELECT ��ȸ�ϰ��� �ϴ� �÷�1, �÷�2, ...
    FROM ���̺��;
    
    *�ݵ�� �����ϴ� �÷����� ����Ѵ�. �����÷� �����߻�
*/

--EMPLOYEE ���̺� ��� �÷�(*) ��ȸ
--SELECT EMP_ID, EMP_NAME , ...
SELECT * 
FROM EMPLOYEE;

--EMP ���̺��� ���, �̸�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

--JOB ���̺� ��� �÷� ��ȸ
SELECT * 
FROM JOB;

---------------------------------------------------------
--1. JOB ���̺� ���޸� ��ȸ
SELECT JOB_NAME 
FROM JOB;

--2. DEPARTMENT ���̺� ����÷� ��ȸ
SELECT *
FROM DEPARTMENT;

--3. DEPARTMENT ���̺� �μ��ڵ�� �μ��� ��ȸ
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;
         
--04. EMPLOYEE ���̺� �����, �̸���, ��ȭ��ȣ, �Ի���, �޿���ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY
FROM EMPLOYEE;

/*
    <�÷����� ���� �������>
    SELECT�� �÷��� �ۼ��κп� ������� �������(�̶�, �������� �����ȸ)
*/

--EMPLOYEE ���̺� ������ ����� ������ȸ(SALARY *12)
SELECT EMP_NAME, SALARY*12
FROM EMPLOYEE;


--EMPLOYEE ���̺� ������ �޿�, ���ʽ� ��ȸ
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE;

SELECT EMP_NAME, SALARY, BONUS, SALARY*12, (SALARY +SALARY*BONUS)*12
FROM EMPLOYEE;
--������������ NULL���� �����Ұ�� ������� ������ NULL�� ��ȯ��, ��ġ������ϴ� �Լ���Ʈ����.

SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE;

--EMPLOYEE ���̺� �����, �ٹ��ϼ� (���ó�¥ -�Ի���) DATE ���ĳ��� ���갡��
SELECT EMP_NAME, HIRE_DATE, SYSDATE-HIRE_DATE
FROM EMPLOYEE;
--DATE - DATE : ������� �ϴ��� ����
--�� ���� �������� ������ DATE������ ���Ͽ��Ͻú��� ���� �ð����� �ϱ⶧��

/*
    �÷��� ��Ī���ϱ� �÷Ÿ� ��Ī, �÷��� AS ��Ī, �÷��� "��Ī", �÷��� AS "��Ī"
    AS�Ⱥٿ��ִµ� ��ȣ Ȥ�� Ư�������ִ°��� ������  " "���̼�
    �÷Ÿ� ��Ī /
*/
SELECT EMP_NAME �����, SALARY AS �޿�, SALARY*12 "����(��)", (SALARY +SALARY*BONUS)*12 AS "�Ѽҵ�(���ʽ�)"
FROM EMPLOYEE;
-------------------------------------------------------------------
/*
    <���ͷ�>
    ���Ƿ� ������ ���ڿ�('')
    SELECT���� ���ͷ� �����ϸ� ��ġ ���̺� �����ϴ� ������ó�� ��ȸ����
*/
--EMPLOYEE���̺� ���, �����, �޿� ��ȸ

SELECT EMP_ID, EMP_NAME, SALARY, '��' AS "����"
FROM EMPLOYEE;

/*
    <���Ῥ���� : || >
    ���� �÷����� ��ġ �ϳ��� �÷��ΰ�ó�� ����, �÷����� ���ͷ����� ����
*/

SELECT EMP_ID, EMP_NAME, SALARY || '��' AS "����"
FROM EMPLOYEE;

--�÷����� ���ͷ��� ����
--xxx�� ������ xxx���Դϴ�. => �÷Ÿ� ��Ī : �޿����� 

SELECT EMP_NAME || '���� ������ ' || SALARY || '�� �Դϴ�.' AS "�޿�����"
FROM EMPLOYEE;

-------------------------------------------------------------------
--���� �츮ȸ�� ����� �������  �����ϴ��� �ñ�
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;
--DISTINCT Ű����� Ư�� �÷�(��)���� �ߺ��Ǵ� ���� �����ϰ� 
--������ ������ ��ȸ�� �� ���˴ϴ�. ��� ���տ��� �ߺ��� ���� �����Ͽ� ������ ���鸸 ���

SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

--���ǻ��� DISTINCT�� SELECT ���� �ѹ��� �������

SELECT DISTINCT JOB_CODE, DEPT_CODE
FROM EMPLOYEE;
-------------------------------------------------------------------

/*
    <WHERE ��> 
    ��ȸ�ϰ��� �ϴ� ���̺�κ��� Ư�����ǿ� �����ϴ� �����͸� ��ȸ�ϰ��ҋ� ���.
    
    �پ��� ������ ��밡�� 
    SELECT �÷�1, �÷�2
    FROM ���̺��
    WHERE ���ǽ�; 
    
    
*/
--EMPLOYEE���� �μ��ڵ尡 'D9'�� ����� ��ȸ
SELECT * 
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D1';
--WHERE DEPT_CODE ^= 'D1';
WHERE DEPT_CODE <> 'D1';

--����ǥ�� : !=, ^= ,<>

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN ='N';

-------------------------------------------------------------------
--<PRACTICE>

--1.�޿� 300�����̻��λ������ ����� �޿� �Ի��� ����(���ʽ� ������) ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE, SALARY*12 AS "����"
FROM EMPLOYEE
WHERE SALARY >=3000000;


--2.���� 5000�����̻��λ������ ����� �޿� ����, �μ��ڵ� ��ȸ.

SELECT EMP_NAME, SALARY, SALARY*12 AS "����", DEPT_CODE
FROM EMPLOYEE
WHERE SALARY*12 >=50000000;

--����������� FROMW�� -> WHERE�� -> SELECT��

--3.�����ڵ� 'J3' �ƴ� ������� ��� �����, �����ڵ�,��翩�� ��ȸ
SELECT EMP_NO, EMP_NAME, JOB_CODE, ENT_YN, SALARY
FROM EMPLOYEE
WHERE JOB_CODE ^= 'J3' AND SALARY >=3000000;

--�μ��ڵ尡 'D9'�̸鼭 �޿��� 500���� �̻��� ������� ��� ����� �޿� �μ��ڵ�
SELECT EMP_ID,EMP_NAME,SALARY,DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY >=5000000;

SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY >=3500000 AND SALARY <=6000000;
-------------------------------------------------------------------
/*
   < BETWEEN A AND B >
   ���ǽĿ��� ���Ǵ� ����
   �� �̻� �� ���� ������ ���� ������ �����ҋ� ���Ǵ� ������\
   �÷����� A�̻� �̰� B�����ΰ��� üũ����.
*/
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY <3500000 OR SALARY >6000000;

SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE NOT SALARY BETWEEN 3500000 AND 6000000;

SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

-------------------------------------------------------------------
/*
    <LIKE>
    ���ϰ����ϴ� �÷����� ���� ������ Ư�����Ͽ� �����ɰ�� ��ȸ
    
    [ǥ����]
    �񱳴��Į�� LIKE 'Ư������'
    -Ư������ ���ý� '%' '_' ���ϵ�ī��� ��������
    >> '%' : 0�����̻�
    EX) �񱳴�� �÷� LIKE '����%' =>�񱳴�� Į���� �� ���ڷ� "����"�Ǵ°� ��ȸ
    EX) �񱳴�� �÷� LIKE '%����' =>�񱳴�� Į���� �� ���ڷ� "��"���°� ��ȸ
    EX) �񱳴�� �÷� LIKE '%����%' =>�񱳴�� Į������ ���ڰ� "����"�Ǵ°� ��ȸ
    >>'_' : 1�����̻�
    EX)�񱳴�� �÷� LIKE '_����%'=> �񱳴�� �÷����� ���ھտ� ������ �ѱ��� �;���.
    EX)�񱳴�� �÷� LIKE '__����%'=> �񱳴�� �÷����� ���ھտ� ������ �α��� �;���.
    EX)�񱳴�� �÷� LIKE '_����_%'=> �񱳴�� �÷����� ���ھյڿ� ������ �ѱ��ھ� �;���.
*/
                                                                                                                              
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';

SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_��_';

SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '__1%';

--**Ư�����̽�
--�̸����� _�������� �ձ��� 3������ ������� ��� �̸� �̸�����ȸ
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE NOT EMAIL LIKE '___$_%' ESCAPE '$';--���ߴ� ��� �ƴ�
--��� ���̵�ī��� �������� ������ ���ٺ��� �� ���ϵ�ī��� �νĵ�.
--������ ������ ����ϰ��� �ϴ� ���տ� ���� ���ϵ�ī�带 �����ϰ�, ESCAPE OPTION���� ����ؾ���.

----�ǽ�����---------------
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';

SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE NOT PHONE LIKE '__0%';

SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%' AND SALARY >= 2400000;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '�ؿ�%';
-------------------------------------------------------------------
/*
    <IS NULL, IS NOT NULL>
    �÷����� NULL������� NULL���񱳿� ���Ǵ� �����ڵ�
*/
--���ʰ� ���� �����.
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;
--���ʽ� �޴� �����. 
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

--����� ���� �����
SELECT EMP_NAME, EMP_NO, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;
--�μ���ġ�ȵ� �����
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

/*
    <IN>
    �񱳴���÷� ���� ���� ������ ����߿� ��ġ�ϴ� ���� �ִ���
    
    ǥ����
    �񱳴�� �÷� IN('��1', '��2', '��3', ....)
*/
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D6','D8','D5');

-------------------------------------------------------------------
--������ �켱����
/*
    <������ �켱����>
    0. () ��ȣ
    1. ���������
    2. ���Ῥ����  ||
    3. �񱳿����� 
    4. IS��, LIKE��, IN��
    5. BETWEEN
    6. NOT
    7. AND
    8. OR
*/

--���� �ڵ� J7 J2 �λ������ �ޤ��� 200������ ����� ��� �÷���ȸ
SELECT *
FROM EMPLOYEE
--WHERE (JOB_CODE ='J7' OR JOB_CODE= 'J2') AND SALARY >= 2000000; 
--OR�� �켱������ AND���� ���Ƽ� ��ȣ ���������� ������ �ʰ� �����.
WHERE JOB_CODE IN('J7', 'J2') AND SALARY >= 2000000;

SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL AND SALARY*12 >=30000000;

SELECT EMP_ID, EMP_NAME, HIRE_DATE, DEPT_CODE
FROM EMPLOYEE
WHERE HIRE_DATE>='95/01/01' AND DEPT_CODE IS NOT NULL;

SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE, BONUS
FROM EMPLOYEE
WHERE (SALARY BETWEEN 2000000 AND 5000000 ) AND HIRE_DATE>='01/01/01' AND BONUS IS NULL;

SELECT EMP_ID AS "���", EMP_NAME AS "�����" , SALARY AS "�޿�", (SALARY +SALARY*BONUS)*12 AS "���ʽ����Կ���"
FROM EMPLOYEE
WHERE (SALARY +SALARY*BONUS)*12 IS NOT NULL AND EMP_NAME LIKE '%��%';

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT EMP_ID, EMP_NAME, SALARY--3
FROM EMPLOYEE--1
WHERE DEPT_CODE IS NULL;--2
--���� ������ �����ϴ¹��, ������ �����ͻ̰� ������ �Ʒ��� �Ѵ�. ���� �������� ����

/*
    <ORDER BY��>
    ǥ����
    SELECT ��ȸ�� �÷�, �÷�....
    FROM ��ȸ�ϰ����ϴ� ���̺��
    WHERE ���ǽ� 
    ORDER BY ���ı����÷�(�÷���|��Ī|�÷���������) [ASC|DESC] [NULLS FIRST| NULLS LAST]
    ASC ��������,�⺻��, DESC ��������
    NULLS FIRST NULL�Ǿ� (DESC �⺻��), NULL LAST NULL�ǵ� (ASC �⺻��)
*/

SELECT *
FROM EMPLOYEE
--ORDER BY BONUS ASC NULLS FIRST;
ORDER BY BONUS DESC, SALARY ASC;

SELECT EMP_NAME, SALARY*12 AS "����"
FROM EMPLOYEE
--ORDER BY ���� DESC;--������������� ��밡�� ���帶������ ����Ǽ�.
ORDER BY 1 ;
