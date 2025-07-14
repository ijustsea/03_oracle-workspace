/*
<GROUP BY ��>
�׷� ������ �����Ҽ��ִ� ����(�ش�׷���غ��� ���� �׷��� ����������)
�������� ������ �ϳ��� �׷����� ��� ó���� �������� ���
*/

SELECT SUM(SALARY)
FROM EMPLOYEE;--��ü����� �ϳ��� �׷����� ��� ������ ���� ���.

--�� �� ���� �� �޿���
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC;

--���μ��� �����
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC;

SELECT DEPT_CODE, SUM(SALARY)--(3)
FROM EMPLOYEE--(1)
GROUP BY DEPT_CODE--(2)
ORDER BY DEPT_CODE ASC;--(4)

SELECT JOB_CODE, COUNT(*), SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE ASC;

--�����޺� �ѻ���� , ���ʽ��� �޴� ����� , �޿��հ� , ��ձ޿�, �����޿� , �ִ�޿�
SELECT JOB_CODE, COUNT(*) AS �ѻ����, COUNT(BONUS) AS ���ʽ��޴»����, SUM(SALARY)AS �޿��հ�, FLOOR(SUM(SALARY)/ COUNT(*)) AS �޿����,FLOOR(AVG(SALARY)) AS �޿����, MIN(SALARY) AS �ּұ޿�, MAX(SALARY) AS �ִ�޿�
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE ASC;

--�׷�������� �Լ��� �������.
SELECT DECODE(SUBSTR(EMP_NO, 8,1), '1', '��','2', '��')AS ����, COUNT(*) AS �ο���
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8,1);

--�׷�������� ���� �÷� ���ÿ� �������
SELECT DEPT_CODE, JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE--�����μ��鼭�� ���� ���޳�����
ORDER BY 1;

---------------------------------------------------------

/*
<HAVING ��>
�׷쿡 ���� ������ �����Ҷ� ���Ǵ� ����(�ַ� �׷��Լ��� ������ ���� �����Ҷ� ���
*/

--�μ��� ��ձ޿��� 300���� �̻��� �μ��� �������.
SELECT DEPT_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE
--WHERE AVG(SALARY) >=3000000 -- �׷��Լ� ������ �������ý� WHERE���� �Ұ���. �׷� �Լ��� �ȵǴ°� �ٽ�.
GROUP BY DEPT_CODE
ORDER BY 1;

SELECT DEPT_CODE, FLOOR(AVG(SALARY))--(4)
FROM EMPLOYEE--(1)
GROUP BY DEPT_CODE--(2)
HAVING AVG(SALARY) >=3000000--(3)
ORDER BY 1;--(5)

--���޺� �� �޿���(���׺� �޿����� 1000���� �̻��� ���޸� ��ȸ
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY)>=10000000
ORDER BY 1;

--�μ��� ���ʽ� �޴� ����� ���� �μ����� ��ȸ(�μ��ڵ�, ���ʽ� ��� �޴���?)

SELECT DEPT_CODE, COUNT(0)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) =0;

--------------------------------------------------------
/*
<�������> 
SLECT *|��ȸ�ϰ��� �ϴ� �÷� | ����� "��Ī" |�Լ��� AS "��Ī"--(5)
FROM ��ȸ�ϰ��� �ϴ� ���̺��--(1)
WHERE ���ǽ�(������ Ȱ��)--(2)
GROUP BY �׷������ ���� �÷� | �Լ���--(3)
HAVING ���ǽ� (�׷��Լ������� ���)--(4)
ORDER BY �÷���| ��Ī|���� [ASC|DESC][NULLS FIRST| NULLS LAST];--(6)

*/
--------------------------------------------------------
/*
�׷캰 ����� ����� �� �߰� ���踦 ������ִ� �Լ� 
ROLLUP
*/

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)-- ������ ���.
ORDER BY 1;

------------------------------------------------------------
/*
<���տ�����-SET OPERATOR>~ ���������� �������� �÷������� �����ؾ���.

�������� �������� ������ �ϳ����������� ����� ������
UNION : OR ������ (�� ������ ������ ����� �� ������ �ߺ����� �ѹ���)
INTERSECT : AND ������ (�� ������ ������ �ְܷ��� �ߺе� �����) 
UNION ALL : ������+ ������ (�ߺ��Ǵ� �κ��� �ι� ǥ���ɼ��ֵ�.)
MINUS : ������  (����Ȱ�������� ���� ������� �A ������)

*/

--1.UNION
--�μ��ڵ尡 D5�λ�� �Ǵ� �޿��� 300���� �ʰ��� ����� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE =  'D5';

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >=  3000000 OR DEPT_CODE =  'D5';
--UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE =  'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >=  3000000;

--INTERSECT 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE =  'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >=  3000000;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE =  'D5' AND SALARY >=  3000000;\
--ORDER BY�� �������� ���ѹ��� ����Ѵ�. ���帶������.

--3.UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE =  'D5'
UNION ALL --�ߺ��� �׳� ���� 2����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >=  3000000;

--4. MINUS : ������  ���� SELECT ������� ���� SELECT ����� �A������
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE =  'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >=  3000000;
