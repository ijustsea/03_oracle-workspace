/*QUIZ*/

--1--���ʽ��� �ȹ����� �μ���ġ�� �� ��� ��ȸ
select *
from employee
where bonus is null and dept_code is not null;
--null���� ���� �������� �񱳾ȵǰ����� null���� �񱳿����ڷ� �ϴ°� �ƴ϶� is�� 

--2--job_code J7 OR J 6 IN�� SALALRY 200�����̻�
--BONUS �ְ� �̸��� �ּ� �տ� 3���ڸ� �ִ� ���� ���
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS, EMAIL
FROM EMPLOYEE
WHERE JOB_CODE IN ('J7','J6') AND SALARY >= 2000000 AND BONUS IS NOT NULL
AND SUBSTR(EMP_NO, 8, 1) IN ('2','4') AND EMAIL LIKE '___$_%' ESCAPE '$';

--������ �켱������ ���� AND�� OR���� �켱����ȴ�.
--���ϵ� ī�带 �����ؾ��ϰ� ESCAPE�ɼ����� ����ؾ���.

--3--
--������������
--CREATE USER ������ IDENTIFEID BY ��й�ȣ
--������ SCOTT ��й�ȣ TIGER ��������
--�̶� �Ϲݻ���� ������ KH������ ����
--CREATE USER SCOTT;

--������1.����� ���������� ������ ���������� ����
--������2.SQL ���� �߸��Ǿ��� ��й�ȣ�� �Է��ؾ���

--��ġ����1.������ ������ �����Ѵ�.
--��ġ����2.CREATE USER SOCTT INDETIFED BY TIGER;

--���� SQL �� ������ ������ ���� ������ �Ϸ��� �ߴ��� ����,
--�Ӹ��ƴ϶� �ش������ ���̺� ������ ��������!. �ֱ׷���?

--������1, ����� ���� ������ �ּ����� ���� �ο��� �ȵƵ�.
--��ġ����1.GRANT CONNECT, RESOURCE TO SCOTT




