/*
    �������� �յ� ~ �߿� : NEXTVAL�� �ѹ� �ؾ����� �����ִ�
    �ڵ����� ��ȣ�߻������ִ� ��ü 
    �������� ���������� �������� ������Ű�鼭 �������� 
    ��ġ�� �ȵǴ� �����͵�
    
    ������ ��ü ����
    
    CREATE SEQUENCE ������
    
    [�� ǥ����]
    CREATE, SEQUENCE ��������
    [START WITH ���ۼ���]  --ó���߻���ų ���۰����� ����Ʈ�� 1
    [INCREMENT BY ����]   --� ������ų���� (�⺻�� 1)
    [MAXVALUE ����]       --�ִ밪 ���� (�⺻�� �̳�ŭ)
    [MINVALUE ����]       --�ּҰ� ���� (�⺻�� 1)=>�ִ밪 ��� ó������ �ٽ� ���ƿͼ� �����ϰ� �Ҽ�����
    [CYCLE|NOCYCLE=DEFAULT] : ����ȯ���� ����
    [NOCACHE|CACHE ����Ʈũ��]-- ĳ�ø޸� �Ҵ� (�⺻�� CACHE 20)
    ĳ�ø޸𸮰� �յ� : �ӽð���
                     �̸� �߻��� ������ �����ؼ� �����صδ� ����
                     �Ź� ȣ��ɶ����� ������ ��ȣ�� �����ϴ°� �ƴ϶�
                     ĳ�ø޸� ������ �̸� �����Ȱ����� ������ ��������=>�ӵ�������
                     ���������Ǹ� ĳ�ø޸𸮿� �̸������ �� ��ȣ���� ����
                     
    ���̺�� : TB_
    ��      : VW_
    ������ :  SEQ_
    Ʈ���� :  TRG_
*/

CREATE SEQUENCE SEQ_TEST;
--���� : ���� ������ �����ϰ��� �� �������� �������� ������ �ҋ�
SELECT * FROM USER_SEQUENCES;

CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

--SEQUECNE ����
/*
2.������ ���
��������, CURRVAL : ����������ǰ� (���������� ���������� ����� NEXTVAL��)
��������, NEXTVAL : ���������� �������� �������Ѽ� �߻��� ��.
                   ���� ������ ������ INCREMENT BY ����ŭ �����Ȱ�
                   
*/
SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
--ORA-08002: sequence SEQ_EMPNO.CURRVAL is not yet defined in this session
--*Action:   select NEXTVAL from the sequence before selecting CURRVAL

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;--����1:300,����2:305,����3:310
SELECT SEQ_EMPNO.CURRVAL FROM DUAL;--300~�������������� ���������� �߻���Ų NEXTVAL��

SELECT *FROM USER_SEQUENCES;
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
--*Cause:    instantiating NEXTVAL would violate one of MAX/MINVALUE
--�ִ밪/�ʼҰ��� �ϳ� �����ؼ� �����߻�
SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
/*
���������� ALTER 
�������� UPDATE

    3.������ ���� ����
    ALTER SEQUENCE ��������
    [INCREMENT BY ����]   --� ������ų���� (�⺻�� 1)
    [MAXVALUE ����]       --�ִ밪 ���� (�⺻�� �̳�ŭ)
    [MINVALUE ����]       --�ּҰ� ���� (�⺻�� 1)=>�ִ밪 ��� ó������ �ٽ� ���ƿͼ� �����ϰ� �Ҽ�����
    [CYCLE|NOCYCLE=DEFAULT] : ����ȯ���� ����
    [NOCACHE|CACHE ����Ʈũ��]-- ĳ�ø޸� �Ҵ� (�⺻�� CACHE 20)

    **START WITH ����Ұ�

*/

ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;--310+10 = 320
/*
4.������ ����
DROP SEQUENCE SEQ_EMPNO;
---------------------------------------------------
�����ȣ�� Ȱ���� ������ ����
*/

CREATE SEQUENCE SEQ_EID
START WITH 400
NOCACHE;

INSERT INTO EMPLOYEE
    (
      EMP_ID
    , EMP_NAME
    , EMP_NO
    , JOB_CODE
    , SAL_LEVEL
    , HIRE_DATE    
    )
    
    VALUES
    (
       SEQ_EID.NEXTVAL
     , 'ȫ�浿'
     , '990101-1111111'
     , 'J7'
     , 'S1'
     ,  SYSDATE   
    
    );
    
SELECT * FROM EMPLOYEE
ORDER BY EMP_ID DESC;

INSERT INTO EMPLOYEE
    (
      EMP_ID
    , EMP_NAME
    , EMP_NO
    , JOB_CODE
    , SAL_LEVEL
    , HIRE_DATE    
    )
    
    VALUES
    (
       SEQ_EID.NEXTVAL
     , 'ȫ���'
     , '990303-2222222'
     , 'J6'
     , 'S1'
     ,  SYSDATE   
    
    );
    
/*    
INSERT INTO EMPLOYEE
    (
      EMP_ID
    , EMP_NAME
    , EMP_NO
    , JOB_CODE
    , SAL_LEVEL
    , HIRE_DATE    
    )
    
    VALUES
    (
       SEQ_EID.NEXTVAL
     , ?
     , ?
     , ?          
     , ?
     ,  SYSDATE   
    
    );
*/

