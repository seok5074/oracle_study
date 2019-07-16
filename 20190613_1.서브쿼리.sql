/*��������

subquery: ���������� ����� �̿��ؼ� �������� �����ϴ� ��ȸ���(SQL)
*/

--������̺� �ֺҾϰ� ���� �μ� ���� ����

--1. �ֺҾ� �μ� Ȯ��
select deptno from SAWON where saname ='�ֺҾ�'
--2. 10���μ� ���� ����
select * from sawon where deptno=10


--�������� ���
select * from sawon 
where deptno=(select deptno from SAWON where saname ='�ֺҾ�')


--�ֹμ��� ������ �⵵�� �Ի��� ���� ����
--1.�ֹμ��� �Ի�⵵
select to_char(sahire,'YYYY') from SAWON where saname='�ֹμ�'
--2.2005�⵵ �Ի��� ����
select * from SAWON
where to_char(sahire,'YYYY')='2005'



select * from SAWON
where to_char(sahire,'YYYY')=(select to_char(sahire,'YYYY') from SAWON where saname='�ֹμ�')


--����(���)�Լ�
--ī��Ʈ��(�ʵ�) : �ʵ��ǰ��� �� ���Ѵ�.(null ���� �Ƚ�Ŵ)
--count(*) : ��ü ���ڵ� ��
--sum(),avg(),max(),min(),stddev()

select count(*) �����, -- ����� ���(���ڵ��)
	   count(samgr) as �μ����̾ƴѻ����,
	   sum(sapay) as �޿��հ�,
	   avg(sapay) as �޿����,
	   min(sapay) as �����޿�,
	   max(sapay) as �ִ�޿�
from sawon

--��ü�޿���պ��� ���� �޴� ��������
--1.��ü�޿���� ���ϱ�
select avg(sapay) as ��ü�޿���� from sawon
--2.3085 ���� ���� �޴� ���� ����
select * from SAWON
where sapay> (3085)


select * from sawon
where sapay>(select avg(sapay) as ��ü�޿���� from sawon)

--�����ֱٿ� �Ի��� ����� ������ �μ��� ���� �������� ����
--1.���� �ֱٿ� �Ի��� ��¥
select max(sahire)  as �ֱ��Ի��� from sawon
--2.�����ֱٿ� �Ի��� �������
select deptno from SAWON
where sahire=(select max(sahire) from sawon)
--3.������ ����� �ش�μ� ������ ����
select * from SAWON
where deptno =(30)

select * from sawon
where deptno = (select deptno from SAWON where sahire=(select max(sahire) from sawon))



--10�μ��� �ִ�޿��ڸ� ����
--1.10���μ� �� �ְ�޿�
select max(sapay) from sawon where deptno=10

--2.�޿��� 4000�޴� ��������
select * from SAWON 
where sapay =(select max(sapay) from sawon where deptno=10) and deptno =10

-- ���μ��� �ִ�޿�������: �����߻� ���X
--					    �μ��� �����ϰų� �μ����� �ٲ�ų� �Ҷ� �����������.
select * from sawon
where (sapay =(select max(sapay) from sawon where deptno=10) and deptno =10)
	  or
	  (sapay =(select max(sapay) from sawon where deptno=20) and deptno =20)
	  or
	  (sapay =(select max(sapay) from sawon where deptno=30) and deptno =30)
	  or
	  (sapay =(select max(sapay) from sawon where deptno=40) and deptno =40)

--���� query �������� �����Ҽ��ִ¹��
--��� query�� �̿���
-- ���μ��� �ִ�޿������� 
--�� ���query�� �̿�
select * from sawon s1
where sapay =(select max(sapay) from sawon where deptno=s1.deptno)




--����1) ������̺��� �嵿�ǰ� �޿��� ���� ����������
select * from SAWON
where sapay =(select sapay from sawon where saname=(select saname from sawon where saname='�嵿��' ))
--����2) �����̺��� '��ö'����������¤� �� ���� (������»��)
select * from gogek
where goaddr =(select goaddr from gogek where goname=(select goname from gogek where goname='��ö'))
--����3) �큦���̺��� ��¡�� ���� �޿� �¾ �� ����
select gojumin from gogek
where goname ='��¡��'

select * from gogek
where substr(gojumin,3,2) in (select substr(gojumin,3,2)from gogek where goname='��¡��')

--����4) ������̺��� ������� ������ ������ �Ի��� ��������
select saname,sahire,
		to_char(sahire,'YYYY') as ��,
		to_char(sahire,'MM') as ��,
		to_char(sahire,'DD') as ��
from sawon


select saname,sahire,
		case 
			when to_number(to_char(sahire,'MM')) in (3,4,5) then '��'
			when to_number(to_char(sahire,'MM')) in (6,7,8) then '����'
			when to_number(to_char(sahire,'MM')) in (9,10,11) then '����'
			else '�ܿ�'
		end as ipsa
from sawon

select * from sawon
where case 
			when to_number(to_char(sahire,'MM')) in (3,4,5) then '��'
			when to_number(to_char(sahire,'MM')) in (6,7,8) then '����'
			when to_number(to_char(sahire,'MM')) in (9,10,11) then '����'
			else '�ܿ�'
		end 
		=(
			select	
				case 
				when to_number(to_char(sahire,'MM')) in (3,4,5) then '��'
				when to_number(to_char(sahire,'MM')) in (6,7,8) then '����'
				when to_number(to_char(sahire,'MM')) in (9,10,11) then '����'
				else '�ܿ�'
	          end
			from sawon where saname='�����'
			)



--������ ����query : ���������� ����� 2���̻��� �����°��� ����
--�ֺҾ�(10) �Ǵ� �����(20)�� �Ҽӵ� �μ� ���� ����
--ex  �������������� in�� ����Ѵ�.
select * from SAWON
where deptno in (select deptno from sawon where saname='�ֺҾ�' or saname ='�����')
			


			
			