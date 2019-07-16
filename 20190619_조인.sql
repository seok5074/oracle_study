/*
 조인(join)
 :2개이상의테이블을 결합해서 조회하는 방법
 
 1.종류)
 1.cross join -> 조건없이 모드결합(행과행 끼리 결합)
 2.inner join -> 1 : 1 조건이 만족하면 결합(행과행 끼리 결합)
 3.outer join -> 
 		left outer join -> A left outer join B on 조인조건
 						   A table의 모든행 추출
 						   B table은 조인조건에 맞는 행만 추출
 		right outer join ->
 		full outer join ->
 		
 4.self join -> 자신의 테이블과 결과
  
 */
--cross join
select * from sawonm,dept
--[ANSI-92]
select * from sawon cross join dept

--ex) inner join == 1:1일치하면 결합
select * from SAWON s,dept d
where S.deptno = d.deptno
--[ANSI -92]  테이블1  inner join 테이블2가  on 결합조건
select * from sawon s inner join dept d on s.deptno = d.deptno

--left outer join
--사원정보 + 고객 정보를
select * from sawon s, gogek g
where s.sabun=g.godam(+)
order by sabun

--cf) MS-SQL Server = where s.sabun *=g.godam
-- oracle  ms_sql 다르다
--ANSI-92
select * from sawon s left outer join gogek g on s.sabun=g.godam
order by sabun

--추출내용 아래와 같이 조회
-- sabun saname deptno dname gobun goname
-- 사번   사원명   	부서번호  부서명	 고객번호	고객명
-- 		sawon s		dept d		gogek g
--				(1)	-------> 
--							(2)
select 
	sabun,saname,d.deptno,dname,gobun,goname

from (sawon s inner join dept d on s.deptno=d.deptno) --(1)
	left outer join gogek g	on s.sabun=g.godam		--(2)
	order by sabun 

--아래와 같이출력

--self join : 자신의 테이블과 조인
--1) 사번 사원명 부서명 상사사번 상사명
--	 sawon s1 dept d sawon s2

select 
	s1.sabun 사번,
	s1.saname 사원명,
	s2.sabun 상사사번,
	s2.saname 상사명
from sawon s1 left outer join sawon s2 on s1.samgr = s2.sabun
order by s1.sabun

select * from dept
--2) 사번 사원명 부서명 		상사사번 상사명 		사원담당고객명 상사담당고객명
--	 sawon s1 dept d 	sawon s2		gogek g2

select 
s1.sabun 사번,
s1.saname 사원명,
d.dname 부서명,
s2.samgr 상사사번,
s2.samgr 상사명,
g1.godam 사원담당고객명,
g2.godam 상사담당고객명
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

