--��������
CREATE TABLE TEST(
    TEST_ID NUMBER,
    TEST_NAME VARCHAR(10)
);
--ORA-01031: insufficient privileges
--CREATE TABLE ������ ��� ����.
--3)-1���̺� ���� ���� �ο�
--3)-2 TABLESPACE �Ҵ��ϱ�
-->���̺� ���� �����۵�

SELECT * FROM TEST;
INSERT INTO TEST VALUES('10','�ȳ�');
--CREATE TABLE���� ������ ���̺� �ٷ� ���۰���.

--KH������ �ִ� EMPLOYEE���̺� ���ٿ���
SELECT * FROM KH.EMPLOYEE;
--4)SELECT ON KH.EMPLOYEE ���Ѻο��ޱ�
INSERT INTO KH.DEPARTMENT
VALUES('D0','ȸ���', 'L1');

ROLLBACK;