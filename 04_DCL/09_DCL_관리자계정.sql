/*
    < DCL : DATA CONTROL LANGUAGE > : ������ ���� ���.
    �������� �ý��� ���� �Ǵ� ��ü���� ���Ѻο�(GRANT)�ϰų� ȸ��(REVOKE)�ϴ� ����
    
    1)�ý��� ���� : DB�������ϴ� ����, ��ü���� �����Ҽ��ִ� ����    
    - CREATE SESSION : ������ �� �ִ� ����
    - CREATE TABLE : ���̺� ������ �� �ִ� ����
    - CREATE VIEW : �並 ������ �� �ִ� ����
    - CREATE SEQUENCE : SQUENCE ���� �Ҽ��ִ� ����(���� �ο��Ҷ�)
    ... ���� �Ϻδ� Ŀ��Ʈ(CONNECT) �ȿ� ���ԵǾ����� 
    
    2)��ü���� ���� : Ư�� ��ü���� �����Ҽ��ִ� ����    
      ��������      Ư��  ��ü
    - SELECT  TABLE VIEW SEQUENCE
    - INSERT  TABLE VIEW
    - UPDATE  TABLE VIEW
    - DELETE  TABLE VIEW
    
    [ǥ����]
    GRANT �������� ON Ư����ü TO ����   
    
*/

--�ý��� ���� ����
--1)SAMPLE / SAMPLE ����(USER)����, IDENTIFIED ~ �ĺ��ϰڵ�.
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;
--����: ���� -�׽�Ʈ ����: ORA-01045: user SAMPLE lacks CREATE SESSION privilege; logon denied

--2)�����ϱ�����, CREATE SESSION ���Ѻο�
GRANT CREATE SESSION TO SAMPLE;

--3)-1���̺� ���� ���� �ο�
GRANT CREATE TABLE TO SAMPLE;
--ORA-01950: no privileges on tablespace 'SYSTEM'
--���� ���̺��� ������ �ȵ�.

--3)-2 TABLESPACE �Ҵ��ϱ�
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;
----------------------------------------------------------------

--��ü���� ���ѿ���
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE; --�����Ҽ��ִ� ����
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE; --�����Ҽ��ִ� ����

GRANT CONNECT, RESOURCES TO ������;
/*
<�� ROLE>
-Ư�� ���ѵ��� �ϳ��� �������� ��Ƴ�����

CONNECT : �����Ҽ� �ִ� ����
RESOURCE :  Ư�� ��ü���� �����Ҽ��ִ� ����, CREATE TABLE, CREATE SEQUENCE, ...
*/
SELECT * 
FROM ROLE_SYS_PRIVS
WHERE ROLE IN('CONNECT', 'RESOURCE')
ORDER BY 1;
