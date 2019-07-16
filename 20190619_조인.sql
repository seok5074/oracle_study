/*
 ����(join)
 :2���̻������̺��� �����ؼ� ��ȸ�ϴ� ���
 
 1.����)
 1.cross join -> ���Ǿ��� ������(����� ���� ����)
 2.inner join -> 1 : 1 ������ �����ϸ� ����(����� ���� ����)
 3.outer join -> 
 		left outer join -> A left outer join B on ��������
 						   A table�� ����� ����
 						   B table�� �������ǿ� �´� �ุ ����
 		right outer join ->
 		full outer join ->
 		
 4.self join -> �ڽ��� ���̺�� ���
  
 */
--cross join
select * from sawonm,dept
--[ANSI-92]
select * from sawon cross join dept

--ex) inner join == 1:1��ġ�ϸ� ����
select * from SAWON s,dept d
where S.deptno = d.deptno
--[ANSI -92]  ���̺�1  inner join ���̺�2��  on ��������
select * from sawon s inner join dept d on s.deptno = d.deptno

--left outer join
--������� + �� ������
select * from sawon s, gogek g
where s.sabun=g.godam(+)
order by sabun

--cf) MS-SQL Server = where s.sabun *=g.godam
-- oracle  ms_sql �ٸ���
--ANSI-92
select * from sawon s left outer join gogek g on s.sabun=g.godam
order by sabun

--���⳻�� �Ʒ��� ���� ��ȸ
-- sabun saname deptno dname gobun goname
-- ���   �����   	�μ���ȣ  �μ���	 ����ȣ	����
-- 		sawon s		dept d		gogek g
--				(1)	-------> 
--							(2)
select 
	sabun,saname,d.deptno,dname,gobun,goname

from (sawon s inner join dept d on s.deptno=d.deptno) --(1)
	left outer join gogek g	on s.sabun=g.godam		--(2)
	order by sabun 

--�Ʒ��� �������

--self join : �ڽ��� ���̺�� ����
--1) ��� ����� �μ��� ����� ����
--	 sawon s1 dept d sawon s2

select 
	s1.sabun ���,
	s1.saname �����,
	s2.sabun �����,
	s2.saname ����
from sawon s1 left outer join sawon s2 on s1.samgr = s2.sabun
order by s1.sabun

select * from dept
--2) ��� ����� �μ��� 		����� ���� 		��������� ��������
--	 sawon s1 dept d 	sawon s2		gogek g2

select 
s1.sabun ���,
s1.saname �����,
d.dname �μ���,
s2.samgr �����,
s2.samgr ����,
g1.godam ���������,
g2.godam ��������
from sawon s1 left outer join dept d on s1.deptno=d.deptno
		 left outer join sawon s2 on s1.samgr = s2.sabun
		 left outer join gogek g1 on s1.sabun = g1.godam
		 left outer join gogek g2 on s2.sabun = g2.godam
order by s1.sabun


select 
	sabun,saname,d.deptno,dname,gobun,goname

from sawon s inner join dept d on s.deptno=d.dname --(1)
	left outer join gogek g	on s.sabun=g.godam		--(2)
	order by sabun 
--right outer join
select * from sawon s, gogek g
where g.godam=s.sabun(+)
order by sabun

