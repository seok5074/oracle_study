select 
	* 
from dept;


--select ~ from �� ���̿� ������ �׸� ����
-- : �⺻�ʵ�,�����ʵ�,�ζ��κ䰡 ���ü��ִ�.
select
name,kor,eng,mat,	--�⺻�ʵ�
kor+eng+mat as tot, -- �����ʵ�
rank() over(order by (kor+eng+mat) desc) as rank --�����ʵ� ��ũ�Լ�(������)����.
from SUNGJUK

--deptno as �μ���ȣ heading�̸��� �ٲ۴�
--����� as ���������ϴ�.
-- " " <- �����ϸ� ���⵵ �����̵ȴ� , heading �����ÿ��� ����.
select
	deptno as �μ���ȣ,
	dname   �μ���,
	loc  	"�μ� ��ġ"
from dept;
/*
 detpno dname loc   <-- heading(�ڵ���̸�)
 ------ ----- ---
     10 �ѹ���   101
     20 ������   202
     30 �����   303
     40 ������   404
     50 �渮��   505
*/
--����Ŭ���� ���Ǵ� ������
--��������� : + - * /
--			������ ���ϴ� �Լ� : mod(������,����)

select 2+1,3-1,3*2,round(10/3.1) , mod(10,3) from dual;


-- ���� ������ : > >= < <= =(����) !=, (�����ʳ�)

-- �� ������ : A and B(A,B ��� ��)
--			  A or B (A�Ǵ� B ��)
select * from sawon;

--������̺��� ���� ���� ����
select * from sawon
where sasex ='����'   -- ���ڸ� ��� where sasex <> '����' where sasex != '����'

--������̺��������� 3000�̻��λ��
select * from sawon
where sapay >= 3000

--������̺��� ������ 3000�̸��� ��������
select * from sawon
where sapay < 3000


--������̺��� 10���μ��� ���� ���� �� ����
select * from sawon
where deptno=10 and sasex='����'

--������̺��� ������ ���� �Ǵ� �븮 ����
select * from sawon
where sajob= '����' or sajob='�븮'

--������̺��� ������ 2500~3500�� ��������
select * from SAWON
where sapay >=2500 and sapay <=3500


-- ��Ÿ������ 
--		�ʵ�� between A and B = A~B���̿� �ֳ�?
--		�ʸ�� in(A,B,C,..)
select * from SAWON
where sapay >=2500 and sapay <=3500

union all  -- ������� �ջ��ؼ� �������

select * from SAWON
where sapay between 2500 and 3500

select * from sawon
where sajob in('����','�븮')

--������̺��� �μ��� 10,30�� ����ȣ��
select * from sawon
where deptno in(10,30)


--���ڿ��˻�(����˻�)
--			�ʵ�� like '%_'
--			_: ��繮�� 1��(�ڸ�)
--			%: ��繮�� ���� �������

--����˻��Ŀ� ���� ����
select * from sawon
where saname='�ֺҾ�'


--��� ���̺��� �־� ���ø� ���� ���� ����
select * from sawon
where saname like '��%'

--������̺��� 2��° ���ڰ� �� ������ ����
select *from SAWON
where saname like '_��_'


--�����̺� ���� ���� ����

select * from gogek
where   gojumin like '%-2%'
	 or gojumin like '%-4%'
	 or gojumin like '%-6%'
	 or gojumin like '%-8%'
	 
	 
--������̺��� 10�� �μ� �������� 10%�� �󿩱��� ����
select 
sabun,saname,sajob,deptno,sapay,sapay *0.1 as bonus
from SAWON
where deptno=10

-- ��� ���̺��� �޿����� ���
--���ڿ� ���� ������ : ||
select '"' || saname ||  '"���� ������' || sapay || '�������� ������' from SAWON

	 

