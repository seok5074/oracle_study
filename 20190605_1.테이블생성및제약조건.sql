--���̺� ����
create table sungjuk
(
	name varchar2(100),
	kor  number(3),
	eng  number,
	mat  int
)

--DML (Data Manipulation Language)
--: insert , update,delete

--�߰�(insert)
--DB������ ���ڿ��� '' ���Ѵ�
-- ; <- �ڹ�sql������ ����ȵȴ�.
insert into sungjuk values('�ϱ浿',80,90,100)
--					���̺�� 			�ڿ�  		���̺����Է°���
--					table��(�Է����ʵ��������)values(�Է��ʵ������������ ���ִ´�.)
insert into sungjuk(kor,eng,mat,name) values(99,77,88,'�̱浿')

insert into sungjuk values('�ϱ浿',80,90,100)

insert into sungjuk values('��浿',180,90,100)
--�������
delete SUNGJUK

--��ȸ���
select 
name,kor,eng,mat, kor+eng+mat as tot ,(kor+eng+mat)/3 as p
from sungjuk

--as tot�� ���(heading) �����ڸ��� ���� �ʵ���� ����
--����ϸ��� ���߿� �����ϰԵǴ� �ʵ���̱� ������ �ٷ� �ڿ� �����Ҽ�����.