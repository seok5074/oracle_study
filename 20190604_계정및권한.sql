-- 1�� �ּ�(--)
/* 
���� �ּ� 
*/

--1. ��������(DDL)
--          ������                 ��й�ȣ
create user test identified by test;

--2. ���Ѻο�(DCL)

grant CONNECT to test; -- �������
--���ҽ��� ����Ҽ��ִ� ����
grant RESOURCE to test;-- ���ҽ�(���̺�/�����Ҽ� �ִ� ����)

--3. ���̺����(DDL):test�������� �����Ͽ� ����Ѵ�

--create table ttt(no int);

--���� :scott
--��ü��� ���Ѻο����Ѵ�.(DCL)
--grant -> 
--����                on ��ü(���̺� ��) to user(���ѹ��� ����);

--��� ������ ���ش�.
--grant all on emp to test;

--��ȸ�� �����ϰ��Ѵ�.
grant select on emp to test;

--����ҷ��� = test�������� �ٽ� �����Ѵ�.

select * from scott.emp;



