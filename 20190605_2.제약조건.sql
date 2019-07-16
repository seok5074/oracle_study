/*
 ��������(constraint)
 :�����͹��Ἲ(data integrity)�� ��Ű������ ���� = ���ʿ� �����͸� �����Ҷ� ����������
 
 1.null or not null : �ʼ��Է¿���
 2.unique			: ������(�ʵ�����)���� ���ϰ� ������(������)
 					  �ߺ�������
 3.check			:���ǿ� �ش���� �ʴ� �����͸� �ԷºҰ�
 					(���� =����(0~100), ����(�� or �� �� �����ϰٴ�.(�ϰ���))
 4.default			: ���� �Է����� ������ ������ �⺻�� �Է�					
 5.primary key		:�⺻Ű(����Ű) �����̵� �ռ�Ű (not null + unique ����+index)
 					 ���ڵ带 ��ǥ(�ĺ�)�ϴ� Ű
 6.foregin key		:�ܷ�Ű(�Է°��� ���� üũ�� �ܺ����̺��� ����)
 */


--1. null or not null����  - ������ �⺻���� null����̴�.
--						 - inline�������θ� ��밡��
create table tb1
(
--						�ڿ��ٰ� ����
	name varchar2(100) not null,   --���ʵ�� not null������ �ɷǴ� .�ʼ��Է��̴�.
	tel varchar2(100) null			--null���
)
insert into tb1 values('�ϱ浿','010-111-1111') -- ������������
insert into tb1(name) values('�̱浿') 		  --�̱浿  NULL
insert into tb1(name,tel) values('��浿',null) -- ���������� null�� �����Ҽ����ִ�.
insert into tb1(tel) values('10104-51515-55')

select * from tb1


--2.unique =�ߺ��Ұ�
-- inline���
create table tb2
(
	id varchar2(100) unique,	--�ߺ��Ұ�
	name varchar2(100) not null --�ʼ��Է�
)

insert into tb2 values('hong','ȫ�浿')
insert into tb2 values('hong','ȫ���')  --���Ἲ ���� ����(TEST.SYS_C003999)�� ����˴ϴ�

select * from tb2

--���̺� ������ ���� �������Ǻο�(�������Ǹ��� ����ڰ� �ο�)
create table tb22
(
	id varchar2(100) not null,
	name varchar2(100) not null
)

--��������
alter table tb22
	add constraint uq_tb22_id id unique(id)
--					�������Ǹ�
insert into tb22 values('hong','ȫ�浿')
insert into tb22 values('hong','ȫ���')

--3.check���� : ���ǿ� ������츸 �Է����
--			check(����)
--			��������(0~100) kor >=0 and kor <=100			or
create table tb3
(
	name varchar2(100) not null,
	kor int check(kor >=0 and kor<=100),   -- inline ���
	eng int,
	mat int,
	--2.�������� �ο� ��
	constraint ck_tb3_eng check(eng>=0 and eng<=100)
)

--���̺� ������ ���� �������� �߰�
alter table tb3
add constraint ck_tb3_mat check(mat>=0 and mat<=100)

insert into tb3 values('�ϱ浿',55,66,77)

--�������� ����
insert into tb3 values('��������',155,66,77)
--�������� ����
insert into tb3 values('��������',55,166,77)
--�������� ����
insert into tb3 values('��������',55,66,-77)

create table tb33
(
	name varchar2(100) not null,
	gender varchar2(100)
)

alter table tb33
	add constraint ck_tb33_gender check(gender ='����' or gender='����')
--����) gender�κп��� ���� ���� �� �Է°����ϵ��� �������� ����
--	�������Ǹ��� : ck_tb33_gender

insert into tb33 values('�̸�1','����')
insert into tb33 values('�̸�2','����')
insert into tb33 values('�̸�3','��')


select * from tb33



--4.default���� : �⺻��
create table tb4
(
	name varchar2(100) not null,
	gender varchar2(100) default '����',
	age	   int			default 1
)

insert into tb4 values('�ϱ浿','����',20);
insert into tb4(name) values('�̱浿');
insert into tb4 values('��浿',default,default);

select *from tb4;

--5.primary key(�⺻Ű) : not null + unique +index
-- 						���ڵ带 ��ǥ�ϴ� �ʵ�(���п뵵)

create table tb5 
(
	seq_no int,
	name varchar2(100) not null
)

alter table tb5
	add constraint pk_tb5_seq_no primary key(seq_no)
	
insert into tb5 values(null,'�α浿') --X
insert into tb5 values(1,'�ϱ浿')


insert into tb5 values(1,'���浿');
--ORA-00001: ���Ἲ ���� ����(TEST.PK_TB5_SEQ_NO)�� ����˴ϴ�

-- �Ϸù�ȣ �����ϴ� ��ü
create sequence seq_tb5_seq_no
	START WITH 1 -- ���۰� (�⺻���� 1�̴�)
	INCREMENT BY 1 --������(�⺻���� 1�̴�)
	
	
--���
--dual == ����Ŭ �ӽÿ����̺�
select seq_tb5_seq_no.nextVal ������, 
	   seq_tb5_seq_no.CurrVal ���簪

from dual;


-- ������ �߿���Ѵ�

select 1+1 from dual;

insert into tb5 values(seq_tb5_seq_no.nextVal,'�ڱ浿')
insert into tb5 values(seq_tb5_seq_no.nextVal,'�ڱ浿2')


select * from tb5;


--primary key ����Ű����

create table tb55
(
	idx int,
	regdate date,
	name varchar2(100) not null
)

alter table tb55
	add constraint pr_tb55_idx_regdate primary key(idx,regdate)
	
--����ý��� ��¥ : sysdate

insert into tb55 values(1,sysdate,'TV');
insert into tb55 values(1,sysdate,'Radio');

select * from tb55;

--6. foreign key :�ܷ�Ű(�Է°��� ���� üũ��  �θ�Ű(�ܷ����̺�)���� ����)

create table �л�
(
	�й� int,
	�̸� varchar2(100) not null,
	��ȭ varchar2(100)not null,
	��ȣ�� varchar2(100) not null,
	��ȣ������ varchar2(100)not null,
	�ּ� 	varchar2(100),
	constraint pk_�л�_�й� primary key(�й�)
)

insert into �л� values(1,'�ϱ浿','111-1111','�Ͼƺ�','�ڿ���','���� ���� �Ÿ�1��');
insert into �л� values(2,'�̱浿','222-1111','�̾ƺ�','ȸ���','���� ���� �Ÿ�2��');

select * from �л�

create table ����
(
	�Ϸù�ȣ int,		--primary key
	�й�		int,	-- foreign key
	����		int,
	����		int,
	����		int,
	�г�		int,
	�б�		int,
	��������  varchar2(100)
)

-- �⺻Ű����(primary key)
alter table ����
	add constraint pk_����_�Ϸù�ȣ primary key(�Ϸù�ȣ)
	
--����Ű����(�ܷ�Ű����)  - foreign key

alter table ����
	add constraint fk_����_�й� foreign key(�й�)
							  references �л�(�й�)     -- <= �л����̺�ȿ��ִ� �й����̺��� �����ҰŴ�
							  
insert into ���� values(1,1,100,100,100,1,1,'�߰����');							 

--����
insert into ���� values(2,10,100,100,100,1,1,'�߰����');				
--ORA-02291: ���Ἲ ��������(TEST.FK_����_�й�)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�
	

select * from ����							  
							  
							  
select * from dept;
							  
select * from gogek;							  
							  
select * from sawon;							 
							  
							  