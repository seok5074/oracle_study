/*
 ����:
 select * from ���̺��
 			1������				2������
 		  �����ʵ�     ���Ĺ��
 order by �ʵ�1 [asc | desc] , �ʵ�2[asc | desc]
  
 */

select * from sawon
order by deptno asc, sasex asc



--�μ��� �ο��� ���ϱ�
select 
	deptno,count(*) �ο���  --ORA-00979: GROUP BY ǥ������ �ƴմϴ�.
from SAWON
group by deptno
order by deptno

--����
select 
	deptno,saname,count(*) �ο���  --ORA-00979: GROUP BY ǥ������ �ƴմϴ�.
from SAWON
group by deptno,saname   --group by �ȿ��� �����Ѵ�
order by deptno

--�μ���,�����ο���

select
	deptno,sasex,count(*) �ο���
from sawon
group by deptno,sasex
order by deptno,sasex

--��� ������ �ο���

select 
	substr(saname,1,1) as ����,
	count(*) �ο���
from SAWON
group by substr(saname,1,1)
order by substr(saname,1,1)

--�Ի�⵵�� �ο���

select to_char(sahire,'YYYY') as �Ի�⵵,
		count(*) as �ο���
from sawon
group by to_char(sahire,'YYYY')
order by to_char(sahire,'YYYY')


--�����̺�
select * from gogek

--�����̺� : ������ �� �ο������ϱ�
select 
	substr(goaddr,1,2) as ��,
	count(*) as �ο���
from gogek
group by substr(goaddr,1,2)
order by substr(goaddr,1,2)


--������̺��� �μ��� �޿��հ谡 10000 �̻��� �����͸� ����
--���1
select
* 
from
(
select
	deptno,sum(sapay) �޿��հ�
from sawon
group by deptno
)
where �޿��հ� >=10000  --����Լ�(����) �� ���� ������

--�Ǵٸ����
select 
	deptno,sum(sapay) �޿��հ�
from sawon
group by deptno
having sum(sapay) >= 10000

select * from GOGEK

--����1) �� ����⵵ �� �ο���
select substr(gojumin,1,2) as ����⵵,
	count(*) �ο���
from gogek
group by substr(gojumin,1,2)
order by substr(gojumin,1,2)

--�ٸ����
create or replace view gogek_view2
as
select
	substr(gojumin,1,2) as ����⵵,
	count(*) as �ο���
from gogek

--����2) 
select substr(gojumin,1,1) as ������,
	count(*) �ο���
from gogek
group by substr(gojumin,1,1)
order by substr(gojumin,1,1)
--���������ʴ¹��
select
	substr(gojumin,1,1) || '0' as ������,
	count(*) as �ο���
from gogek
group by substr(gojumin,1,1)
order by substr(gojumin,1,1)

select * from SAWON
--����3) ��� �Ի������ �ο���
select substr(sahire,6,8) as �Ի��,
	count(*)
from sawon
group by substr(sahire,6,8)
order by substr(sahire,6,8)

create or replace view  sawon_view_season
as
select
	sabun,saname,sajob,sasex,deptno,sahire,samgr,sapay,
	case 
			when to_number(to_char(sahire,'MM')) in (3,4,5) then '��'
			when to_number(to_char(sahire,'MM')) in (6,7,8) then '����'
			when to_number(to_char(sahire,'MM')) in (9,10,11) then '����'
			else '�ܿ�'
		end  as season
from sawon

select 
		season,
		count(*)
from sawon_view_season
group by season
order by season
--����4) ��  ���� �ο���
--		���� ����  13
--		���� ����  2
--		�ܱ� ����  1
--		�ܱ� ����  1
select * from GOGEK
insert into gogek values(16,'����','���� ������','801212-5123456',10);
insert into gogek values(17,'����','���� ���ϱ�','901212-6123456',10);
commit


create or replace view test
as
select
	gobun,goname,goaddr,gojumin,godam,
	case
		when substr(gojumin,8,1) in(1,3) then '��������'
		when substr(gojumin,8,1) in(2,4) then '��������'
		when substr(gojumin,8,1) in(5) then '�ܱ�����'
		when substr(gojumin,8,1) in(6) then '�ܱ�����'
	end as nasex
from gogek

select
	 nasex,
	 count(*) as �ο���
from test
group by nasex
order by nasex

select
	gogender,
	count(*) �ο���
from(
	select
		g.*,
		case
			when substr(gojumin,8,1) in(1,3) then '��������'
			when substr(gojumin,8,1) in(2,4) then '��������'
			when substr(gojumin,8,1) in(5) then '�ܱ�����'
			when substr(gojumin,8,1) in(6) then '�ܱ�����'
		end as gogender
	from 
	(select * from gogek) g
)
group by gogender
order by gogender