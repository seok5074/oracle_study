
SELECT SUBSTRB('����ŬŬ��',1) name FROM DUAL
 UNION ALL
SELECT SUBSTRB('����ŬŬ��',3) name FROM DUAL;

--�������Լ�
select floor(10.1),ceil(10.1),floor(-10.1),ceil(-10.1)from dual;

--�������Լ�
--			  1 2 3 4 5 6 7 8 <=oracle�� 1 base��
select substr('�츮������ѹα�',5,2) from dual;
select substr('�츮������ѹα�',5) from dual;



--12345678901234  =��ġ
--911105-2325467

select gojumin, substr(gojumin,8,1 ) from gogek;

--substr �Լ��� �̿��ؼ� ���ڰ��� ����
--to_numer('') ���ڿ� -> ������
select * from gogek
where to_number(substr(gojumin,8,1)) in (2,4,6,8)

--�����̺��� �ܿ￡ �¾ ��������

select * from gogek
where to_number(substr(gojumin,3,2)) in(12,01,02)

--������̺��� '��' �� ������ ����
select * from SAWON
where saname like '��%'

select * from SAWON
where substr(saname,1,1) ='��'


--��¥���Լ�
SELECT TO_CHAR(SYSDATE,'RRRR-MM-DD HH24:MI:SS') "���ݽð�"FROM DUAL ;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH:MI:SS') "���ݽð�"FROM DUAL ;

SELECT TO_CHAR(SYSTIMESTAMP,'RRRR-MM-DD HH24:MI:SS.FF3') FROM DUAL
--10����
select sysdate, sysdate+10 from dual;

--18����
select sysdate �Դ볯¥, add_months(sysdate,18) ���볯¥ from dual;


select to_date('2019-1-1') �Դ볯¥, add_months('2019-1-1',18) ���볯¥ from dual;

-- �Կ��� �����ϱ�
select months_between(sysdate,'1990-1-1') from dual;

--������̺��� �ټӳ� �� ���� ���Ѵ�

select *from SAWON

select sabun,saname,sahire,round(months_between(sysdate,sahire),0) as �ѿ���,
floor(round(months_between(sysdate,sahire),0)/12.1) as �ѳ��,
mod(round(months_between(sysdate,sahire),0),12) as �Ѹ��,
round(sapay/13.0) as ����,
round((round(sapay/13.0)*round(months_between(sysdate,sahire),0))/12.0) as ������
from sawon;

SELECT TO_CHAR(123,'09999') zero FROM DUAL;  				--  00123
SELECT TO_CHAR(12345678,'L999,999,999') local  FROM DUAL; 	--  ��12,345,678


--�����̺��� �������
select gobun,goname,goaddr,gojumin ,
		decode(substr(gojumin,8,1),'1','����',
								   '2','����',
								   '3','����',
								   '4','����',
								   '5','����',
								   '6','����',
								   '7','����',
								   '8','����'						   
								   )as gogender
from gogek


--case�� �̿��� �������
-- case ���� end������

select gobun,goname,goaddr,gojumin,
	case		
		when to_number(substr(gojumin,8,1)) in (1,3,5,7) then '����'
		when to_number(substr(gojumin,8,1)) in (2,4,6,8) then '����'	
		else '����'
	end as gogender
from gogek;




--null�����Լ� �� ������ : nvl , nvl2 (�����ġ) 
--					is null , is not null(check)

--����׺������� �μ���� ����� ���(��簡�������)
select * from sawon
where samgr is null     -- => samgr =null ���ȵȴ�


--������̺��� �μ����� �ƴ� ��� ���(������� is not null)
select * from SAWON
where samgr is not null


--null ��ſ� 0���� ġȯ�Ѵ�.(����)
select sabun,saname,nvl(samgr,0),nvl2(samgr,1,0) from sawon







