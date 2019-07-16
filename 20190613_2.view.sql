/*
view
1.������ ���̺� : ���̺�� ������ ������� ���ȴ�.
2.�䳻�ο��� sql������ ����(bacth������ ����)
3.����)
	1)����(�����Ѹ�� �ܼ��ϰ� �̿�)
	2)���ȼ�(�߿䵥���͸� ������ִ�)

*/


--������̺��� ���ڸ� ��ȸ
--�����
create or replace view sawon_view_female
as
	select * from sawon where sasex='����'
	
--����
select * from sawon_view_female


--������̺� +�Ի���� �߰�
select
	*,
	�߰��÷�
from sawon  �ȵȴ�(����Ŭ���ȵȴ�.)

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

select * from sawon_view_season
where season =(select season from sawon_view_season where saname='�����')


--������ ����
--1234567
--960310-*******
create or replace view gogek_view_jumin
as
	select gobun,goname,goaddr,godam, 
			substr(gojumin,1,7) || '*******' as gojumin
	from gogek
	
select * from gogek_view_jumin

--����ں��� system �������� ����
create user test9 identified by test9
--������� �ο�
grant connect to test9

--����ں���: test�������� ��ȯ

--test9���� test�� �並 ��ȸ�Ҽ��ִ� �������ش�
grant select on gogek_view_jumin to test9

--inline view: SQL���峻�� ���ԵǾ��ִ� ��(�͸��Ǻ�)

select 
	s.* , to_char(sahire,'YYYY') as hire_year ,
	(select count(*)from sawon) as sa_count
from (select * from sawon) s


--����1) �������� �嵿�ǰ� ������ ��뿡 �Ի��� �������� ȣ��
-- 1993-07-25 -> 1990��� �Ի��� ����
--������� ) sabun saname sahire �Ի���
--			1	  �嵿��	1993-07-23 1990
--			3	  �̹���	1998-03-25 1990	
create or replace view  sawon_view_ipsa
as
select
	sabun,saname,sahire,
	case 
			when to_number(to_char(sahire,'YYYY')) in (1990,1991,1992,1993,1994,1995,1996,1997,1998,1999) then '1990'
			else '�ܿ�'
		end  as �Ի�⵵
from sawon

select * from sawon_view_ipsa
where �Ի�⵵ =(select �Ի�⵵ from sawon_view_ipsa where saname='�嵿��')

--����2)  �����̺��� �̿��ؼ� �Ʒ��� ���� ����� �並 ����
--	�������) gobun goname goaddr gojumin ����⵵ ���� ��
create or replace view gogek_view1
as
select 
	g.*,
	(
		to_number(substr(gojumin,1,2)) +
	  	 case
	 		when to_number(substr(gojumin,8,1)) in(1,2,5,6) then 1900
	   		else 2000
		 end
	) as birth_year
from(select * from gogek)g
--���	
select * from gogek_view1

--��(���̺�) �̿��ؼ� �����
create or replace view gogek_view2
as
select
	gv.*,
	(to_number(to_char(sysdate,'YYYY'))-birth_year+1)as age, 
	case mod(birth_year,12)
		when 0 then '�����̶�'
		when 1 then '�߶�'
		when 2 then '����'
		when 3 then '������'
		when 4 then '���'
		when 5 then '�Ҷ�'
		when 6 then 'ȣ���̶�'
		when 7 then '�䳢��'
		when 8 then '���'
		when 9 then '���'
		when 10 then '����'
		when 11 then '���'
	end as tti
from (select * from gogek_view1) gv

select * from GOGEK_VIEW2

/*
// 4  5  6  7  8   9 10 11 0   1  2  3
// �� �� �� �� �� �� �� �� �� �� �� ��
// �� �� �� �� �� �� �� �� �� �� �� ��
 */
