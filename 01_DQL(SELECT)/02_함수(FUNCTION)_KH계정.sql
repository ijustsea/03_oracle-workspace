/*
<�Լ� FUNCTION>
���޵� �÷����� �о�鿩�� �Լ������Ѱ���� ��ȯ

-������ �Լ� : N�� ���� �о�鿩�� N�� ����� ����
-�׷� �Լ� : N�� ���� �о�鿩�� 1�� ����� ����

>>SELECT ���� �������Լ��� �׷��Լ� �Բ� ��� ���� : ��� ���� ������ �޶� 

>>�Լ� �����ġ : SELECT, WHERE, ORDER BY, GROUP BY, HAVING
*/

--����ó���Լ� 
--LENGTH/ LENGHB => ����� NUMBERŸ��
--LENGTH(�÷�| '���ڿ�') : �ش� ���ڿ����� ���ڼ� ��ȯ
--LENGTHB(�÷�| '���ڿ�') : �ش� ���ڿ����� ����Ʈ�� ��ȯ
--�ѱ� 3BYTE | ����,���� 1BYTE

SELECT SYSDATE FROM DUAL;
SELECT LENGTH('�ȳ�'), LENGTHB('�ȳ�')FROM DUAL;
SELECT LENGTH('TREE'), LENGTHB('TREE')FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE;  --���ึ�� �� ����ǰ� ���� : �������Լ�

/*
    *INSTR
    ���ڿ��κ��� Ư�������� ������ġ�� ã�Ƽ� ��ȯ
    INSTR(�÷�|'���ڿ�','ã�����ϴ� ����', ['ã����ġ���۰�', ����] : ������� NUBMER    
    ã�� ��ġ ���۰� 
    1:�տ�������, -1: �ڿ�������
*/

SELECT INSTR('AABAACABBAA', 'B') FROM DUAL;
SELECT INSTR('AABAACABBAA', 'B', 1) FROM DUAL;
SELECT INSTR('AABAACABBAA', 'B', -1) FROM DUAL;
SELECT INSTR('AABAACABBAA', 'B', 1,2) FROM DUAL;


SELECT EMAIL, INSTR(EMAIL, '_', 1, 1) AS "_�� ��ġ ", INSTR(EMAIL, '@') AS "@�� ��ġ "
FROM EMPLOYEE;

/*
    "SUBSTR
    ���ڿ����� Ư�� ���ڿ��� �����ؼ� ��ȯ
*/

SELECT SUBSTR ('SHOWMETHEMONEY', 5, 2 )FROM DUAL;

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8,1) AS "����"
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO, 8,1) = '2';
--WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');--���ڸ�
WHERE SUBSTR(EMP_NO, 8, 1) IN (1, 3);--���ڸ�1

--�Լ���ø

SELECT EMP_NAME, EMAIL, SUBSTR (EMAIL , 1, INSTR(EMAIL, '@')-1)AS ���̵�
FROM EMPLOYEE;

/*
    LPAD / RPAD : ���ڿ� ��ȸ�� ���ϰ��ְ� ��ȸ�Ҷ� ���(LEFT, RIGHT)
    
    LPAD / RPAD(STRING, ���������� ��ȯ�� ���ڱ��� , [�����̰����ϴ� ����])
*/

SELECT EMP_NAME, EMAIL, LPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT EMP_NAME, EMAIL, LPAD(EMAIL, 20, '-')
FROM EMPLOYEE;

SELECT EMP_NAME, EMAIL, RPAD(EMAIL, 20, '-')
FROM EMPLOYEE;

SELECT RPAD(SUBSTR(EMP_NO,1,8), 14 , '*' )AS �ֹι�ȣ
FROM EMPLOYEE;

/*
    LTRIM RTRIM
    ���ڿ����� Ư������ �����ϰ� ������ ��ȯ
    
    LTRIM RTRIM(STRING, [�����ҹ��ڵ� ] ) --�����ϸ� ��������
*/

SELECT LTRIM('    K H ') FROM DUAL;
SELECT RTRIM('    K H ') FROM DUAL;

SELECT LTRIM('ACABACCKH', 'ABC' ) FROM DUAL;
SELECT RTRIM('5782KH123', 0123456789) FROM DUAL;
-- 'ABC' MEAN A OR B OR C ����
/*
    TRIM (STRING) ���ڿ� �յ� ���ʿ��ִ� ������ ���ڵ��� �����ϰ� ��ȯ
*/

SELECT TRIM('      BC        DF    ') FROM DUAL;
SELECT TRIM ('Z' FROM 'ZZZZZKHZZZZ') FROM DUAL;
SELECT TRIM (LEADING 'Z' FROM 'ZZZZZKHZZZZ') FROM DUAL;
SELECT TRIM (TRAILING 'Z' FROM 'ZZZZZKHZZZZ') FROM DUAL;
SELECT TRIM (BOTH 'Z' FROM 'ZZZZZKHZZZZ') FROM DUAL;

/*
    LOWER UPPER INITCAP
    LOWER UPPER INITCAP (SPRING) => ��ȯ�� CHARACTER Ÿ��
*/

SELECT LOWER('Welcome To The Show')
FROM DUAL;
SELECT INITCAP('welcome to the show')from dual;--�ܾ�ձ��ڸ��� �빮��.

/*
    concat ���ڿ� �ΰ� ���� �޾Ƽ� ���ļ� ��ȯ
    
    CONCAT(STRING1, STRING2) => STRING ��ȯ
*/

SELECT CONCAT('ABC', 'CHOCOLATE') FROM DUAL; 
SELECT 'ABC' || 'CHOCOLATE' FROM DUAL; 

--SELECT CONCAT('ABC', 'CHOCOLATE', 'DELICOUS') FROM DUAL; 2���̻��̸� �����߻�.
SELECT 'ABC' || 'CHOCOLATE' || 'DELICOUS'FROM DUAL;

/*
    REPLACE
    REPLACE(�÷���, STR1, STR2)
*/

SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr', 'naver.com') as �̸���
FROM EMPLOYEE;

------------------------------------------------------
/*
    <����ó���Լ�>
    ABS :  ���밪 ��ȯ���� 
    ABS(NUMBER)
 */   
 
 SELECT ABS(-55) FROM DUAL;
 
 --MOD �μ� ���� �������� ��ȯ
 SELECT MOD(10.7, 3) FROM DUAL;
 --ROUND �ݿø��� ��ȯ
 SELECT ROUND(10.7) FROM DUAL;
 SELECT ROUND(123.456, 2) FROM DUAL;--��ġ��������. ����Ʈ�� �Ҽ��� 0��
 --CEIL �ø��� ��ȯ
 SELECT CEIL(10.7) FROM DUAL; 
 --FLOOR ������ ��ȯ
 SELECT FLOOR(10.7) FROM DUAL; 
 --TRUNC ��ġ���������� ����ó�����ִ� �Լ�. ������ FLOORó����
 SELECT TRUNC(10.76543 , 2) FROM DUAL;--2��°�ڸ�������.
 
------------------------------------------------------
/*
    <��¥ó���Լ�>
    SYSDATE : �ý��� ��¥�� �ð���ȯ     
*/   
 SELECT SYSDATE FROM DUAL;
 
 --MONTHS_BETWEEN (DATE1, DATE2) : �γ�¥������ ������ ��ȯ
 SELECT EMP_NAME, HIRE_DATE, CEIL(MONTHS_BETWEEN(SYSDATE,HIRE_DATE))||'����'AS �ٹ�������
 FROM EMPLOYEE;
 
 --ADD_MONTHS(DATE, NUMBER) Ư����¥�� �ش���ڸ�ŭ������ ���ؼ� �˷���
 SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 3) AS "����������"
 FROM EMPLOYEE;
 
 --NEXTDAY(DATE,����) :  �ش糯¥���� ���� ����� ������ ��¥�� ��ȯ
 --SELECT SYSDATE, NEXT_DAY(SYSDATE, 'ȭ')  FROM DUAL; --�� 1 ��2 ȭ3
 SELECT SYSDATE, NEXT_DAY(SYSDATE, 3)  FROM DUAL;
 
 --LAST_DAY(DATE) :�ش�� ������ ��¥ ���ؼ� ��ȯ
 SELECT LAST_DAY(SYSDATE) FROM DUAL;
 --�����, �Ի���, �Ի��Ѵ��� ��������¥.
 SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE), LAST_DAY(HIRE_DATE)-HIRE_DATE AS "�Ի�� �ٹ��ϼ�" 
 FROM EMPLOYEE;
 
 --EXTRACT Ư����©����� �⵵ �� �� ���� �����ؼ� ��ȯ
 
 --EXTRACT(YEAR FROM DATE) �⵵�� ����
 --EXTRACT(MONTH FROM DATE) ���� ����
 --EXTRACT(DAY FROM DATE) �ϸ� ����
 
SELECT EMP_NAME, 
EXTRACT (YEAR FROM HIRE_DATE)AS �Ի�⵵, 
EXTRACT (MONTH FROM HIRE_DATE)AS �Ի��, 
EXTRACT (DAY FROM HIRE_DATE)AS �Ի��� 
FROM EMPLOYEE
ORDER BY �Ի�⵵, �Ի��, �Ի���;
 
 --����ȯ �Լ� 
 --TO_CHAR: ���� ��¥ Ÿ���ǰ��� ����Ÿ������ ��ȯ�����ִ� �Լ� 
 --TO_CHAR(����(��¥), ����)
 
 SELECT TO_CHAR(1234) FROM DUAL;
 SELECT TO_CHAR(1234, '9999999L') FROM DUAL;
 SELECT TO_CHAR(1234, '9999999$') FROM DUAL;
 SELECT TO_CHAR(1234, 'L99,999') FROM DUAL;--9SMSWKFLFMF SKXKSMSMSROSUA.
 
 SELECT EMP_NAME, TO_CHAR(SALARY, 'L999,999,999') FROM EMPLOYEE;

--��¥Ÿ��_>����Ÿ��

SELECT TO_CHAR(SYSDATE) FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL;


SELECT EMP_NAME, HIRE_DATE, LPAD(TO_CHAR(HIRE_DATE, 'YYYY-MM-DD'), 15, ' ')
--SELECT EMP_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'YYYY"��"-MM"��"-DD"��"')
FROM EMPLOYEE;

--�⵵�� ���õ� ���� 
SELECT TO_CHAR(SYSDATE, 'YYYY'),
       TO_CHAR(SYSDATE, 'YY'),      
       TO_CHAR(SYSDATE, 'RRRR'),
       TO_CHAR(SYSDATE, 'RR'),
       TO_CHAR(SYSDATE, 'YEAR')
        FROM DUAL;
 --���� ���õ� ����
 SELECT TO_CHAR(SYSDATE, 'MM'),
       TO_CHAR(SYSDATE, 'MON'),      
       TO_CHAR(SYSDATE, 'MONTH'),
       TO_CHAR(SYSDATE, 'RM')       
        FROM DUAL;
 --�Ͽ� ���õ� ����
 SELECT TO_CHAR(SYSDATE, 'DDD'), --���ر������� ���ø��Ϥ�
       TO_CHAR(SYSDATE, 'DD'), --�� �������� ���� ���Ϥ�     
       TO_CHAR(SYSDATE, 'D') --�� �������� ���� ���Ϥ�
       FROM DUAL;
 
 --���� ���� 
 SELECT TO_CHAR(SYSDATE, 'DAY'),
       TO_CHAR(SYSDATE, 'DY')       
        FROM DUAL;      
    
 --����ȯ �Լ��� ���ڳ� ��¥�� �־��ָ� ���ڷ� �ٲ���.     
 
 /*
    TO_DATE : ���ڳ� ���ڸ� ��¥Ÿ������ ��ȯ
    TO_DATE(����|���� , [����])
 */
 SELECT TO_DATE(20100101) FROM DUAL;
 SELECT TO_DATE(100101) FROM DUAL;
 SELECT TO_DATE('070101') FROM DUAL;--���� ù���ڰ� 0�̶� ����ǥ�� ���������

 SELECT TO_DATE('041030 143000', 'YYMMDD HH24MISS') FROM DUAL;
 SELECT TO_DATE('140630', 'YYMMDD') FROM DUAL;--2014
 SELECT TO_DATE('980630', 'YYMMDD') FROM DUAL;--2098 : ������ ���缼��� �ݿ�
 
 SELECT TO_DATE('140630', 'RRMMDD') FROM DUAL;--2014
 SELECT TO_DATE('980630', 'RRMMDD') FROM DUAL;--1998 
 --RR : �ش� ���ڸ� �⵵ ���� 50�̸��ϰ�� �������� �ݿ�, 50�� �̻��� ��� �������� �ݿ�
 
 --���󿡼� ��¥�� �����͸� �Ѱܵ� ������ ���ڷ� �Ѿ��!
 
 /*
    TO_NUMBER : ����Ÿ���� �����͸� ������������ ��ȯ�����ִ� �Լ�
    
 */
 
 SELECT TO_NUMBER('014151661344') FROM DUAL;
 SELECT TO_NUMBER('1000000'+ '5500000') FROM DUAL;
 
 SELECT TO_NUMBER('1,000,000', '9,999,999')+ TO_NUMBER('55,000', '99,999') FROM DUAL;
 
 /*
    <��ó���Լ�>
*/

--NVL(�÷�, �ش��÷����� NULL�ϰ�� ��ȯ�ɰ�)
SELECT EMP_NAME, BONUS, NVL(BONUS, 0)
FROM EMPLOYEE;
 
 --�̸�, ���ʽ� ���� ����
SELECT EMP_NAME, BONUS, (SALARY + SALARY*NVL(BONUS,0)) *12
FROM EMPLOYEE;
 
 SELECT EMP_NAME, NVL(DEPT_CODE, '�μ�����')
 FROM EMPLOYEE;
  
 -- NVL2(�÷�, ��ȯ��1, ��ȯ��2)
 -- �÷����� �����Ѱ�� ��ȯ��1 ��ȯ, 
 -- �÷����� NULL�̸� ��ȯ��2 ��ȯ, ���׿����ڿ� ����
 
 SELECT EMP_NAME, BONUS, NVL2(BONUS, 0.7, 0.1)
 FROM EMPLOYEE;

 SELECT EMP_NAME, NVL2(DEPT_CODE, '�μ�����', '�μ�����')
 FROM EMPLOYEE;

--NULLIF(�񱳴��1, �񱳴��2)
--�ΰ��� ��ġ�� NULL��ȯ , �ΰ��� ��ġ���� ������ �񱳴��1 �� ��ȯ
 
 SELECT NULLIF('123', '123456') FROM DUAL;
 -------------------------------------------------------------------------------------
 --�����Լ� DECODE~ ����ġ���� ����
 
 SELECT EMP_ID, EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1), 
 DECODE (SUBSTR(EMP_NO, 8, 1), '1','��','2','��')AS "����"
 FROM EMPLOYEE;
 
 --������ �޿���ȸ�� �� ���׺��� �λ��ؼ� ��ȸ
 --J7����� �޿��� 10���� �λ� (SALARY *1.1)
 --J6����� �޿��� 15���� �λ� (SALARY *1.15)
 --J5����� �޿��� 20���� �λ� (SALARY *1.2) 
 --�̿��� ������� �޿� 5���� �λ� (SALARY *1.05)
 
 SELECT EMP_NAME, JOB_CODE, SALARY AS "�����޿�", 
        DECODE(JOB_CODE, 'J7', SALARY*1.1, 'J6', SALARY*1.15, 'J5', SALARY*1.2,SALARY*1.105) AS "�λ�ȱ޿�"
        
 FROM EMPLOYEE;
 /*
 CASE WHEN THEN 
 
 CASE   WHEN ���ǽ�1 THEN �����1
        WHEN ���ǽ�2 THEN �����2
        ....
        ELSE ����� N
 END
 
 */
 
 SELECT EMP_NAME, SALARY, 
    CASE WHEN SALARY >= 5000000 THEN '��ް�����'
        WHEN SALARY >= 3500000 THEN '�߱ް�����'
        ELSE '�ʱް����� '
     END AS ����
     FROM EMPLOYEE;
 ------------------------------------
 --1. SUM(����Ÿ���÷�) : �ش� �÷� ������ �� �հ� ���ؼ� ��ȯ ���� (�׷��Լ�)
 
 --��ü ����� �� �޿�
 SELECT SUM(SALARY)
 FROM  EMPLOYEE
 WHERE SUBSTR(EMP_NO, 8, 1)  IN ('1','3');
 
 SELECT SUM(SALARY*12 )
 FROM EMPLOYEE
 WHERE DEPT_CODE ='D5';
 
 --2. AVG(����Ÿ��) : �ش�Į�������� ��հ� ���ؼ���ȯ
 SELECT ROUND(AVG(SALARY))
 FROM EMPLOYEE;
 --3. MIN(����Ÿ�԰���) : �ش� Į������ �� ���� ���� �� ���ؼ� ��ȯ
SELECT MIN(EMP_NAME)
FROM EMPLOYEE;
--4. MAX(����Ÿ�԰���) : �ش� Į������ �� ���� ū �� ���ؼ� ��ȯ

SELECT MAX(EMP_NAME)
FROM EMPLOYEE;

--COUNT (*| �÷� | DISTINCT �÷�) : ��ȸ�� �� ������ ���� ��ȯ
--COUNT(*) : ��ȸ�Ȱ���� ��� �ళ�� ��ȯ
--COUNT(�÷�) : ������ �ش� �÷����� NULL�� �ƴѰ͸� �P�������� ��ȯ

--��ü����� 
SELECT COUNT(*)
FROM EMPLOYEE;


--���ʽ� �޴� ����� 
SELECT COUNT(BONUS)
FROM EMPLOYEE;

--������ ���ʽ� �޴� �����.
SELECT COUNT(BONUS)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO , 8, 1) IN ('1', '3');

--������ ���ʽ� �޴� �����.
SELECT COUNT(BONUS)
FROM EMPLOYEE
WHERE NOT (SUBSTR(EMP_NO , 8, 1) IN ('1', '3'));

--�μ���ġ ��� �������ϴ�
SELECT COUNT(DEPT_CODE)--NULL���ڵ����� ����.
FROM EMPLOYEE;
                                                                     
--COUNT(DISTINCT �÷�) : �÷����� �ߺ��� ������ �� �ళ�� ��ȯ (�÷��� ���� �����˼�����) 
SELECT COUNT(DISTINCT DEPT_CODE)--NULL���ڵ����� ����.
FROM EMPLOYEE;

