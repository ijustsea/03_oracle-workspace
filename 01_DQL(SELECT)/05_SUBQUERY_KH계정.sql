/*

*�������� (SUBQUERY)
-�ϳ��� SQL���ȿ� ���Ե� �Ǵٸ� SELECT��
-���� SQL���� ���� �������� �ϴ� ������

���ܼ������� ����1
���ö ����� ���� �μ��� ���� ����� ��ȸ
*/

SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME ='���ö';

SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE ='D9';

-->���� �ΰ��� ������ �ϳ��� ������ 
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE =(SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME ='���ö');
--���ܼ������� ����2
--�������� ��ձ޿����� �� ���� �޿� �޴� ������� ��� �̸� �����ڵ� �޿� ��ȸ

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY)
                    FROM EMPLOYEE);

SELECT AVG(SALARY)
FROM EMPLOYEE;
/*���������� ����
  �������� ���������� ���� �꿭������ ���� �з� ��4��
  1.������ ��������~ �������� ���������� ������ �Ѱ��϶�
  2.������ ��������~ �������� ���������� �������϶�(������ �ѿ�)
  3.���߿� �������� ~ �������� ���������� �������϶�(������ ����)
  4.������ ���߿� �������� ~ �������� ���������� ������ ����Į���϶�(������ ������)
  
  >>������ ���� �������� �տ� �ٴ� �����ڰ� �޶���.
  
*/
--SINGLE ROW SUBQUERRY
--���������� ��ȸ������� ������ ������ 1���ϋ� (���� �ѿ�)+�񱳿����� ��밡��

--1)�� ������ ��ձ޿����� �޿��� �� ���Թ޴� ����� �����ڵ� �޿���ȸ

SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY <(SELECT AVG(SALARY)
                 FROM EMPLOYEE);
                 
--2) �����޿� �޴� ����� ��� �̸� �޿� �Ի���

SELECT EMP_ID, EMP_NAME, SALARY , HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                FROM employee);

SELECT EMP_ID, EMP_NAME, DEPT_CODE , SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY
                FROM employee
                WHERE EMP_NAME ='���ö');
                
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND SALARY >(SELECT SALARY
                FROM employee
                WHERE EMP_NAME ='���ö');

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE  SALARY >(SELECT SALARY
                FROM employee
                WHERE EMP_NAME ='���ö');

--�μ��� �޿��� ����ū �μ� �μ��ڵ� , �޿��� ��ȸ

SELECT  MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT DEPT_CODE , SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT  MAX(SUM(SALARY))
                        FROM EMPLOYEE
                        GROUP BY DEPT_CODE);


--������ ���� �������� ���� �μ������� ��� ����� ���� �Ի��� �μ���

SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME ='������';

SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND DEPT_CODE =(SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME ='������')
AND EMP_NAME ^= '������';

SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_CODE =(SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME ='������')
AND EMP_NAME ^= '������';

--------------------------------------------------------------
/* ������ ��������
���������� ���������� �������ϋ� (Į���� �Ѱ�)
-IN �������� : �������� ������߿��� �Ѱ��� ��ġ�ϴ� ���� �ֵ���
- > ANY �������� : �������� ����� �߿��� �Ѱ��� Ŭ���
- < ANY �������� : �������� ����� �߿��� �Ѱ��� �������

�񱳴�� > ANY(��1, ��2, ��3)
�񱳴�� > �� 1 OR �񱳴�� > �� 2 OR �񱳴�� > �� 3 
*/
--1)����� �Ǵ� ������ ����� ���� ������ ��� ����� �����ڵ� �޿�
SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN ('�����', '������');

--J3,J7��ȸ

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN (SELECT JOB_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME IN ('�����', '������'));--=���� ���� ���� : ������� �������̱⋚��
                    
---��� => �븮 => ���� => ���� => ���� ...
--2) �븮���� �ӿ��� �ұ��ϰ� �������� �޿��� �ּұ޿��� ������ �޴� ����(����̸����ޱ޿�)

--����󸶹���?

SELECT SALARY
FROM EMPLOYEE E , JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND JOB_NAME ='����';

-- ���� �븮�̸鼭�� �޿����� ���� ��ϰ��߿� �ϳ��� ū ���?
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME ='�븮' 
AND SALARY > ANY  (SELECT SALARY
                FROM EMPLOYEE E , JOB J
                WHERE E.JOB_CODE = J.JOB_CODE
                AND JOB_NAME ='����');

--���������ӿ��� �������� ������� �޿����� �� ���� �޴� ���
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME ='����' 
AND SALARY > ALL(SELECT SALARY
                  FROM EMPLOYEE E , JOB J
                  WHERE E.JOB_CODE = J.JOB_CODE
                  AND JOB_NAME ='����');
                  
/*
���߿� �������� 
������� ���������� ������ Į������ �������� ���
--������ ����� ���� �μ��ڵ�, ���� �����ڵ�� �ش��ϴ� ���ʵ� ��ȸ

*/

SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE 
                    WHERE EMP_NAME ='������')
AND JOB_CODE = (SELECT JOB_CODE
                    FROM EMPLOYEE 
                    WHERE EMP_NAME ='������');
-->>���߿� ��������   

SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE 
WHERE (DEPT_CODE, JOB_CODE)= (SELECT DEPT_CODE, JOB_CODE
                                FROM EMPLOYEE 
                                WHERE EMP_NAME ='������');

SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE 
WHERE (JOB_CODE, MANAGER_ID)= (SELECT JOB_CODE, MANAGER_ID
                                FROM EMPLOYEE 
                                WHERE EMP_NAME ='�ڳ���')   ;
                                
--4)��«�� ��������߿� ��������
/*
    �������� ��ȸ������� ������ �������� ���    
*/
--���޺��� ~GROUP BY
--1) ���޺� �ּұ޿��� �޴� �����ȸ (��� ����� �����ڵ� �޿�)

SELECT Job_code, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY 
FROM EMPLOYEE
WHERE JOB_CODE = 'J2' AND SALARY =3700000;

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY 
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT Job_code, MIN(SALARY)
                            FROM EMPLOYEE
                            GROUP BY JOB_CODE) ;--���پƴ� IN ����� =�Ұ�

SELECT EMP_ID ���, EMP_NAME �����, DEPT_CODE �μ��ڵ�, SALARY �ְ�޿�
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, MAX(SALARY)
                            FROM EMPLOYEE
                            GROUP BY DEPT_CODE); --���پƴ� IN ����� =�Ұ�